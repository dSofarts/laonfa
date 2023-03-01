package com.dsofarts.laonfa.service;

import com.dsofarts.laonfa.enums.Role;
import com.dsofarts.laonfa.model.Image;
import com.dsofarts.laonfa.model.User;
import com.dsofarts.laonfa.repository.UserRepository;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

    public void changeUserSettings(User currentUser, User changeUser, MultipartFile avatar)
            throws IOException {
        if (avatar.getSize() != 0) {
            Image image = toImageEntity(avatar);
            currentUser.addImageToUser(image);
        }
        if (!changeUser.getName().equals("")) {
            currentUser.setName(changeUser.getName());
        }
        if (!changeUser.getPhoneNumber().equals("")) {
            currentUser.setPhoneNumber(changeUser.getPhoneNumber());
        }
        userRepository.save(currentUser);
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
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

    public void changeUserRoles(User user, String role) {
        user.getRoles().clear();
        user.getRoles().add(Role.valueOf(role));
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
