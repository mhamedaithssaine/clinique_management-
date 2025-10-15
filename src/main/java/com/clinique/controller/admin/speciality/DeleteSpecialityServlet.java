package com.clinique.controller.admin.speciality;

import com.clinique.service.SpecialityService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin/speciality/delete")
public class DeleteSpecialityServlet extends HttpServlet {
    private final SpecialityService specialityService;

    public DeleteSpecialityServlet() {
        this.specialityService = new SpecialityService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        specialityService.deleteSpeciality(id);
        resp.sendRedirect(req.getContextPath() + "/admin/speciality");
    }
}
