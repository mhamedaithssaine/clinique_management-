package com.clinique.controller.admin;
import com.clinique.model.Patient;
import com.clinique.model.User;
import com.clinique.model.type.BloodeType;
import com.clinique.model.type.Gender;
import com.clinique.model.type.Role;
import com.clinique.service.PatientService;
import com.clinique.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/admin/users/add")

public class AddUserServlet extends HttpServlet {
    private final UserService userService;
    private final PatientService patientService;

    public AddUserServlet() {
        this.userService = new UserService();
        this.patientService = new PatientService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/add_user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Role role = Role.valueOf(request.getParameter("role"));

        try {
            if(role == Role.PATIENT){
                String cin = request.getParameter("cin");
                LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
                Gender gender = Gender.valueOf(request.getParameter("gender"));
                BloodeType bloodType = BloodeType.valueOf(request.getParameter("bloodType"));
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                Patient patient = new Patient(fullName, email, password, cin, dateOfBirth, gender, bloodType, address, phone);
                patientService.registerPatient(patient);
            } else {
                User user = new User(fullName, email, password, role);
                userService.registerUser(user);
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");


        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de l'ajoute de l'utilisateur: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/add_user.jsp").forward(request, response);
        }
    }
}
