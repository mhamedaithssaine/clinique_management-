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
import java.util.UUID;

@WebServlet("/admin/users/edit")
public class EditUserServlet extends HttpServlet {
    private final UserService userService;
    private final PatientService patientService;

    public EditUserServlet() {
        this.userService = new UserService();
        this.patientService = new PatientService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null) {
            User user = userService.findById(UUID.fromString(id));
            if (user != null) {
                request.setAttribute("user", user);
                if (user instanceof Patient) {
                    request.setAttribute("patient", (Patient) user);
                }
                request.getRequestDispatcher("/WEB-INF/views/admin/edit_user.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Role role = Role.valueOf(request.getParameter("role"));
        boolean active = request.getParameter("active") != null;

        User user = userService.findById(UUID.fromString(id));
        if (user != null) {
            user.setFullName(fullName);
            user.setEmail(email);
            if (password != null && !password.isEmpty()) {
                user.setPassword(password);
            }
            user.setRole(role);
            user.setActive(active);

            try {
                if (role == Role.PATIENT) {
                    String cin = request.getParameter("cin");
                    String dateOfBirth = request.getParameter("dateOfBirth");
                    String gender = request.getParameter("gender");
                    String bloodType = request.getParameter("bloodType");
                    String address = request.getParameter("address");
                    String phone = request.getParameter("phone");

                    Patient patient;

                    if (user instanceof Patient) {
                        patient = (Patient) user;
                    } else {
                        patient = new Patient();
                        patient.setId(user.getId());
                    }
                    patient.setFullName(fullName);
                    patient.setEmail(email);
                    patient.setPassword(user.getPassword());
                    patient.setActive(active);
                    patient.setCin(cin);
                    patient.setDateOfBirth(LocalDate.parse(dateOfBirth));
                    patient.setGender(Gender.valueOf(gender));
                    patient.setBloodType(BloodeType.valueOf(bloodType));
                    patient.setAddress(address);
                    patient.setPhone(phone);

                    patientService.updatePatient(patient);
                } else {
                    userService.updateUser(user);
                }                response.sendRedirect(request.getContextPath() + "/admin/users");
            } catch (Exception e) {
                request.setAttribute("error", "Erreur lors de la mise à jour de l'utilisateur: " + e.getMessage());
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/admin/edit_user.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

}
