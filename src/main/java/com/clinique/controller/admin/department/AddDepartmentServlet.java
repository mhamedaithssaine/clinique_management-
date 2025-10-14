package com.clinique.controller.admin.department;

import com.clinique.model.Department;
import com.clinique.service.DepartmentService;
import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/departments/add")
public class AddDepartmentServlet extends HttpServlet {
  private final DepartmentService  departmentService;
    public AddDepartmentServlet() {
        this.departmentService = new DepartmentService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/admin/departments/add_department.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        Department department = new Department(code, name, description);

        departmentService.insertDepart(department);

        resp.sendRedirect(req.getContextPath() + "/admin/departments");
    }
}
