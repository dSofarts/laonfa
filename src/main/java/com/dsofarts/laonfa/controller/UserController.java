package com.dsofarts.laonfa.controller;

import com.dsofarts.laonfa.model.User;
import com.dsofarts.laonfa.service.UserService;
import java.io.IOException;
import java.security.Principal;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.Banner.Mode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/login")
    public String login(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "login";
    }

    @GetMapping("/login/error")
    public String loginError(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("message",
                "Имя пользователя или пароль введены неверно. Или аккаунт заблокирован");
        model.addAttribute("messageType", "danger");
        return "login";
    }

    @GetMapping("/signup")
    public String signup(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "signup";
    }

    @PostMapping("/signup")
    public String createUser(User user, Model model, Principal principal) {
        String message = userService.createUser(user);
        if (!message.equals("OK")) {
            model.addAttribute("message", message);
            model.addAttribute("messageType", "danger");
            return "signup";
        }
        model.addAttribute("message",
                "Необходимо подтвердить адрес электронной почты для выхода в аккаунт");
        model.addAttribute("messageType", "warning");
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "signup";
    }

    @GetMapping("/user/{user}")
    public String profile(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        return "user-page";
    }

    @GetMapping("/activate/{code}")
    public String activation(@PathVariable String code, Model model, Principal principal) {
        boolean isActivate = userService.activateUser(code);
        if (isActivate) {
            model.addAttribute("message", "Активация прошла успешно!");
            model.addAttribute("messageType", "success");
        } else {
            model.addAttribute("message", "Код активации недействителен");
            model.addAttribute("messageType", "warning");
        }
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "login";
    }

    @GetMapping("/profile")
    public String profile(Model model, Principal principal) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "profile";
    }

    @GetMapping("/profile/add-product")
    public String addProduct(Model model, Principal principal) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "add-product";
    }

    @GetMapping("/profile/settings")
    public String settings(Model model, Principal principal) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "settings";
    }

    @PostMapping("/profile/settings")
    public String changeSettings(@RequestParam("file1") MultipartFile file1, User changeUser,
            Model model, Principal principal)
            throws IOException {
        User currentUser = userService.getUserByPrincipal(principal);
        userService.changeUserSettings(currentUser, changeUser, file1);
        model.addAttribute("user", currentUser);
        model.addAttribute("message", "Данные успешно изменены");
        model.addAttribute("messageType", "success");
        return "settings";
    }

    @PostMapping("/profile/settings/password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword, Model model,
            Principal principal) {
        User user = userService.getUserByPrincipal(principal);
        if (userService.changePassword(user, oldPassword, password, confirmPassword)) {
            model.addAttribute("message", "Данные успешно изменены");
            model.addAttribute("messageType", "success");
        } else {
            model.addAttribute("message", "Пароль веден неверно или пароли не совпадают!");
            model.addAttribute("messageType", "warning");
        }
        model.addAttribute("user", user);
        return "settings";
    }
}