package com.clinique.service;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.clinique.model.User;
import com.clinique.repository.UserRepository;

import java.util.List;
import java.util.UUID;

public class UserService {

    private final UserRepository userRepository;

    public UserService() {
        this.userRepository = new UserRepository();
    }

    public User authenticate(String email, String rawPassword) {
        User user = userRepository.findByEmail(email);
        if (user != null) {
            BCrypt.Result result = BCrypt.verifyer().verify(rawPassword.toCharArray(), user.getPassword());
            if (result.verified) {
                return user;
            }
        }
        return null;
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public List<User> findAll(int pageNumber, int pageSize){
        return userRepository.findAll( pageNumber, pageSize);
    }

    public long countUsers() {
        return userRepository.countUsers();
    }


    public void registerUser(User user) {
        String hashedPassword = BCrypt.withDefaults().hashToString(12, user.getPassword().toCharArray());
        user.setPassword(hashedPassword);
        userRepository.save(user);
    }

    public void updateUser(User user) {
        if (user.getPassword() != null && !user.getPassword().startsWith("$2a$")) {
            String hashedPassword = BCrypt.withDefaults().hashToString(12, user.getPassword().toCharArray());
            user.setPassword(hashedPassword);
        }
        userRepository.update(user);
    }

    public User  findById(UUID id){
        return userRepository.findById(id);
    }

    public void deleteUser(UUID id) {
        userRepository.delete(id);
    }
}
