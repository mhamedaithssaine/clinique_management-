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
import java.util.List;

@WebServlet("/admin/departments")
public class AdminDepartmentServlet extends HttpServlet {
  private final DepartmentService departmentService;

  public AdminDepartmentServlet(){
      this.departmentService = new DepartmentService();
  }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Department> departments = departmentService.getAllDepartments();
        req.setAttribute("departments",departments);
        req.getRequestDispatcher("/WEB-INF/views/admin/departments/departments.jsp").forward(req, resp);
    }
}
