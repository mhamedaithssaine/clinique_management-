package com.clinique.controller.admin;

import com.clinique.model.User;
import com.clinique.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final UserService userService;

    public AdminDashboardServlet(){
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            User user = (User) request.getSession().getAttribute("user");
            Long totalUser = userService.countUsers();
            request.setAttribute("totalUser",totalUser);

            if (user != null) {

                request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
        }

}
