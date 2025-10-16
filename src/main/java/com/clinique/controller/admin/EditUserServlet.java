package com.clinique.controller.admin;
import com.clinique.model.*;
import com.clinique.model.type.BloodeType;
import com.clinique.model.type.Gender;
import com.clinique.model.type.Role;
import com.clinique.service.*;
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
    private final DoctorService doctorService;
    private final StaffService staffService;
    private final SpecialityService specialityService;

    public EditUserServlet() {
        this.userService = new UserService();
        this.patientService = new PatientService();
        this.doctorService = new DoctorService();
        this.staffService = new StaffService();
        this.specialityService = new SpecialityService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null) {
            User user = userService.findById(UUID.fromString(id));
            request.setAttribute("specialities", specialityService.getAllSpeciality());

            if (user != null) {
                request.setAttribute("user", user);
                if (user instanceof Patient) {
                    request.setAttribute("patient", (Patient) user);
                }else if (user instanceof Doctor) {
                    request.setAttribute("doctor", (Doctor) user);
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
                }  else if (role == Role.DOCTOR) {
                    String matricule = request.getParameter("matricule");
                    String titre = request.getParameter("titre");
                    UUID specialityId = UUID.fromString(request.getParameter("specialityId"));
                    Speciality speciality = specialityService.getSpecialityById(specialityId);
                    Doctor doctor;
                    if (user instanceof Doctor) {
                        doctor = (Doctor) user;
                    } else {
                        doctor = new Doctor();
                        doctor.setId(user.getId());
                    }
                    doctor.setFullName(fullName);
                    doctor.setEmail(email);
                    doctor.setPassword(user.getPassword());
                    doctor.setActive(active);
                    doctor.setMatricule(matricule);
                    doctor.setTitre(titre);
                    doctor.setSpeciality(speciality);
                    doctorService.updateDoctor(doctor);
                }else if (role == Role.STAFF) {
                    Staff staff;
                    if (user instanceof Staff) {
                        staff = (Staff) user;
                    } else {
                        staff = new Staff();
                        staff.setId(user.getId());
                    }
                    staff.setFullName(fullName);
                    staff.setEmail(email);
                    staff.setPassword(user.getPassword());
                    staff.setActive(active);
                    staffService.updateStaff(staff);
                } else {
                    userService.updateUser(user);
                }
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } catch (Exception e) {
                request.setAttribute("error", "Erreur lors de la mise à jour de l'utilisateur: " + e.getMessage());
                request.setAttribute("user", user);
                if (user instanceof Patient) {
                    request.setAttribute("patient", (Patient) user);
                } else if (user instanceof Doctor) {
                    request.setAttribute("doctor", (Doctor) user);
                }
                request.getRequestDispatcher("/WEB-INF/views/admin/edit_user.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

}
