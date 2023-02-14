package com.dsofarts.laonfa.controller;

import com.dsofarts.laonfa.model.User;
import com.dsofarts.laonfa.service.UserService;
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
    public String login() {
        return "login";
    }

    @GetMapping("/signup")
    public String signup() {
        return "signup";
    }

    @PostMapping("/signup")
    public String createUser(User user, Model model) {
        if (!userService.createUser(user)) {
            model.addAttribute("errorMessage", "Пользователь с email " + user.getEmail() + " существует");
            return "signup";
        }
        userService.createUser(user);
        return "redirect:/login";
    }

    @GetMapping("/user/{user}")
    public String profile(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        return "profile";
    }

    @GetMapping("/activate/{code}")
    public String activation(@PathVariable String code, Model model) {
        boolean isActivate = userService.activateUser(code);
        if (isActivate) {
            model.addAttribute("message", "Активация прошла успешно!");
        } else {
            model.addAttribute("message", "Код активации недействителен");
        }
        return "login";
    }
}
