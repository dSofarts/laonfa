package com.dsofarts.laonfa.controller;

import com.dsofarts.laonfa.enums.Role;
import com.dsofarts.laonfa.model.User;
import com.dsofarts.laonfa.service.UserService;
import java.security.Principal;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {

    private final UserService userService;

    @GetMapping("/admin")
    public String admin(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("users", userService.list());
        return "admin";
    }

    @PostMapping("/admin/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id) {
        userService.banUser(id);
        return "redirect:/admin";
    }

    @GetMapping("/admin/user/edit/{user}")
    public String userEdit(@PathVariable("user") User user, Model model, Principal principal) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "user-edit";
    }

    @PostMapping("/admin/user/edit")
    public String userEdit(@RequestParam("userId") User user, @RequestParam("roles") String role) {
        userService.changeUserRoles(user, role);
        return "redirect:/admin";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String userDelete(@PathVariable("id") Long id) {
        userService.deleteUser(id);
        return "redirect:/admin";
    }
}
