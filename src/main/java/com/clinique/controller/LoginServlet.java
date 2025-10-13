package com.clinique.controller;

import com.clinique.model.User;
import com.clinique.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value="/login")
public class LoginServlet  extends HttpServlet {
    private final UserService userService;

    public LoginServlet() {
        this.userService = new UserService();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userService.authenticate(email, password);

        if (user != null) {
            request.getSession().setAttribute("user", user);
            switch (user.getRole()) {
                case ADMIN:
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    break;
                case DOCTOR:
                    response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
                    break;
                case PATIENT:
                    response.sendRedirect(request.getContextPath() + "/patient/dashboard");
                    break;
                case STAFF:
                    response.sendRedirect(request.getContextPath() + "/staff/dashboard");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}
