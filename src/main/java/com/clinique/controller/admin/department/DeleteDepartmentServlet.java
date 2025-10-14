package com.clinique.controller.admin.department;

import com.clinique.service.DepartmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin/departments/delete")
public class DeleteDepartmentServlet extends HttpServlet {
    private final DepartmentService departmentService;

    public DeleteDepartmentServlet() {
        this.departmentService = new DepartmentService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        departmentService.deleteDepartment(id);
        resp.sendRedirect(req.getContextPath() + "/admin/departments/departments");
    }
}
