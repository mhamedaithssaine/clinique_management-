package com.clinique.controller.admin.department;

import com.clinique.model.Department;
import com.clinique.service.DepartmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin/departments/edit")
public class EditDepartmentServlet extends HttpServlet {
    private final DepartmentService departmentService;

    public EditDepartmentServlet() {
        this.departmentService = new DepartmentService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        Department department = departmentService.getDepartmentById(id);
        req.setAttribute("department", department);
        req.getRequestDispatcher("/WEB-INF/views/admin/departments/edit_department.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        Department department = new Department(code, name, description);
        department.setId(id);

        departmentService.updateDepartment(id, department);

        resp.sendRedirect(req.getContextPath() + "/admin/departments");
    }
}
