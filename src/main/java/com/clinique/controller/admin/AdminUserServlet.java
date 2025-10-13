package com.clinique.controller.admin;

import com.clinique.model.User;
import com.clinique.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private final UserService userService;

    public AdminUserServlet() {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {
        int pageNumber = 4;
        int pageSize = 4;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            pageNumber = Integer.parseInt(pageParam);
        }

        List<User> users = userService.findAll(pageNumber, pageSize);
        long totalUsers = userService.countUsers();

        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
        request.setAttribute("users", users);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }
}
