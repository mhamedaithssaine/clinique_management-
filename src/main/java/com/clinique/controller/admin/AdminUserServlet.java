package com.clinique.controller.admin;

import com.clinique.model.User;
import com.clinique.service.DoctorService;
import com.clinique.service.PatientService;
import com.clinique.service.StaffService;
import com.clinique.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private final UserService userService;
    private final DoctorService doctorService;
    private final PatientService patientService;
    private final StaffService staffService;

    public AdminUserServlet() {
        this.userService = new UserService();
        this.doctorService = new DoctorService();
        this.patientService = new PatientService();
        this.staffService = new StaffService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {
        int pageNumber = 4;
        int pageSize = 4;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            pageNumber = Integer.parseInt(pageParam);
        }

        List<User> users = userService.findAll(pageNumber, pageSize);
        long totalUsers = userService.countUsers();
        long totalDoctors = doctorService.getTotalDoctor();
        long totalPatients = patientService.getTotalPatient();
        long totalStaff = staffService.getTotalStaff();

        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
        request.setAttribute("users", users);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalDoctors",totalDoctors);
        request.setAttribute("totalPatients",totalPatients);
        request.setAttribute("totalStaff",totalStaff);
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }
}
