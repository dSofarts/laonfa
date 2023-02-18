package com.dsofarts.laonfa.controller;

import com.dsofarts.laonfa.model.User;
import com.dsofarts.laonfa.service.UserService;
import java.security.Principal;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

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
        model.addAttribute("message", "Имя пользователя или пароль введены неверно. Или аккаунт заблокирован");
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
        model.addAttribute("message", "Необходимо подтвердить адрес электронной почты для выхода в аккаунт");
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
}