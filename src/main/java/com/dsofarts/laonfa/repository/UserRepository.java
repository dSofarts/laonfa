package com.dsofarts.laonfa.repository;

import com.dsofarts.laonfa.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);

    User findByActivationCode(String code);
}
