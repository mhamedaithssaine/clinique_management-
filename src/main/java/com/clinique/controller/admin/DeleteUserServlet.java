package com.clinique.controller.admin;

import com.clinique.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin/users/delete")
public class DeleteUserServlet extends HttpServlet {
    private final UserService userService;

    public DeleteUserServlet() {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null) {
            try {
                userService.deleteUser(UUID.fromString(id));
            } catch (Exception e) {
                request.setAttribute("error", "Erreur lors de la suppression de l'utilisateur: " + e.getMessage());
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
