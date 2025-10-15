package com.clinique.controller.admin.speciality;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

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
import java.util.UUID;
@WebServlet("/admin/speciality/edit")
public class EditSpecialityServlet extends HttpServlet {

    private final SpecialityService specialityService;
    private final DepartmentService departmentService;

    public EditSpecialityServlet() {
        this.specialityService = new SpecialityService();
        this.departmentService = new DepartmentService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        Speciality speciality = specialityService.getSpecialityById(id);
        req.setAttribute("speciality", speciality);
        req.setAttribute("departments", departmentService.getAllDepartments());
        req.getRequestDispatcher("/WEB-INF/views/admin/speciality/edit_speciality.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        Speciality speciality = specialityService.getSpecialityById(id);
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        UUID departmentId = UUID.fromString(req.getParameter("departmentId"));

        Department department = departmentService.getDepartmentById(departmentId);

        speciality.setCode(code);
        speciality.setName(name);
        speciality.setDescription(description);
        speciality.setDepartment(department);

        specialityService.updateSpeciality(speciality);
        resp.sendRedirect(req.getContextPath() + "/admin/speciality");
    }


}
