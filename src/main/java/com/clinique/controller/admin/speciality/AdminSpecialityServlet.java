package com.clinique.controller.admin.speciality;

import com.clinique.model.Speciality;
import com.clinique.service.SpecialityService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/speciality")
public class AdminSpecialityServlet extends HttpServlet {
    private final SpecialityService specialityService;

    public AdminSpecialityServlet(){
        this.specialityService = new SpecialityService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
        List<Speciality> speciality = specialityService.getAllSpeciality();
        request.setAttribute("speciality",speciality);
        request.getRequestDispatcher("/WEB-INF/views/admin/speciality/speciality.jsp").forward(request,response);
    }

}
