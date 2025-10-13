package com.clinique.controller;

import com.clinique.model.Patient;
import com.clinique.model.type.BloodeType;
import com.clinique.model.type.Gender;
import com.clinique.service.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/signin")
public class SignInServlet extends HttpServlet {


    private final PatientService patientService;

    public SignInServlet() {
        this.patientService = new PatientService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/signin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cin = request.getParameter("cin");
        LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
        Gender gender = Gender.valueOf(request.getParameter("gender"));
        BloodeType bloodType = BloodeType.valueOf(request.getParameter("bloodType"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        Patient patient = new Patient(fullName, email, password, cin, dateOfBirth, gender, bloodType, address, phone);

        try {
            patientService.registerPatient(patient);
            response.sendRedirect(request.getContextPath() + "/login");
        }

        catch (Exception e) {
            request.setAttribute("error", "Erreur lors de l'inscription: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/signin.jsp").forward(request, response);
        }
    }

}
