package com.clinique.controller.admin.speciality;

import com.clinique.model.Department;
import com.clinique.model.Speciality;
import com.clinique.service.DepartmentService;
import com.clinique.service.SpecialityService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/speciality/add")
public class AddSpecialityServlet extends HttpServlet {
    private final SpecialityService specialityService;
    private final DepartmentService departmentService;

    public AddSpecialityServlet(){
        this.departmentService = new DepartmentService();
        this.specialityService = new SpecialityService();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException , IOException {
        List<Department> departments = departmentService.getAllDepartments();
        request.setAttribute("departments",departments);
        request.getRequestDispatcher("/WEB-INF/views/admin/speciality/add_speciality.jsp").forward(request,response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException,IOException{
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        UUID departmentId = UUID.fromString(request.getParameter("departmentId"));

        Department department = departmentService.getDepartmentById(departmentId);
        Speciality speciality = new Speciality(code,name,description,department);
        specialityService.insertSpeciality(speciality);
        response.sendRedirect(request.getContextPath() + "/admin/speciality");
    }

}
