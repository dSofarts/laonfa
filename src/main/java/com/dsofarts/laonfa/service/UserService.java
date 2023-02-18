package com.dsofarts.laonfa.service;

import com.dsofarts.laonfa.enums.Role;
import com.dsofarts.laonfa.model.User;
import com.dsofarts.laonfa.repository.UserRepository;
import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final MailService mailService;

    public String createUser(User user) {
        String email = user.getEmail();
        String errorMessage = "OK";
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            return "Пароли не совпадают.";
        }
        if (userRepository.findByEmail(email) != null) {
            return "Пользователь с email: " + email + " существует.";
        }
        user.setActive(false);
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);
        userRepository.save(user);
        String message = String.format("""
                Привет, %s!
                Для активации вашего аккаунта пожалуйста перейдите по ссылке:
                http://localhost:8080/activate/%s""", user.getName(), user.getActivationCode());
        mailService.send(user.getEmail(), "Код активации", message);
        log.info("Saving new User with email: {}", email);
        return errorMessage;
    }

    public List<User> list() {
        return userRepository.findAll();
    }

    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            if (user.isActive()) {
                user.setActive(false);
                log.info("Ban user with id = {}; email = {}", user.getId(), user.getEmail());
            } else {
                user.setActive(true);
                log.info("Unban user with id = {}; email = {}", user.getId(), user.getEmail());
            }
        }
        if (user != null) {
            userRepository.save(user);
        }
    }

    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }

    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);
        if (user == null) {
            return false;
        }
        user.setActivationCode(null);
        user.setActive(true);
        userRepository.save(user);
        return true;
    }

    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) {
            return new User();
        }
        return userRepository.findByEmail(principal.getName());
    }
}
