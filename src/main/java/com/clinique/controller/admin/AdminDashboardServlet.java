package com.clinique.controller.admin;

import com.clinique.model.User;
import com.clinique.service.DepartmentService;
import com.clinique.service.SpecialityService;
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
    private final SpecialityService specialityService;
    private final DepartmentService departmentService;

    public AdminDashboardServlet(){
        this.userService = new UserService();
        this.specialityService = new SpecialityService();
        this.departmentService = new DepartmentService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            User user = (User) request.getSession().getAttribute("user");
            Long totalUser = userService.countUsers();
            request.setAttribute("totalUser",totalUser);
            Long totalSpeciality = specialityService.getTotalSpecialities();
            request.setAttribute("totalSpeciality",totalSpeciality);
            Long totalDepartment = departmentService.getTotalDepartment();
            request.setAttribute("totalDepartment",totalDepartment);
            if (user != null) {

                request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
        }

}
