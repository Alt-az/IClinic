package pl.dmcs.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@Entity
@Table(name= "appointment")
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    long id;

    @NotNull
    @ManyToOne
    private AppUser patient;

    @NotNull
    @ManyToOne
    private Doctor doctor;

    @NotNull
    private Date date;

    private Boolean paymentStatus;

    public Appointment() {
        this.date = new Date();
        this.doctor = new Doctor();
        this.patient = new AppUser();
        this.paymentStatus = false;
    }

    public Appointment(AppUser patient,Doctor doctor,Date date, Boolean paymentStatus) {
        this.patient = patient;
        this.doctor = doctor;
        this.date = date;
        this.paymentStatus = paymentStatus;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public @NotNull Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(@NotNull Doctor doctor) {
        this.doctor = doctor;
    }

    public @NotNull Date getDate() {
        return date;
    }

    public void setDate(@NotNull Date date) {
        this.date = date;
    }

    public @NotNull AppUser getPatient() {
        return patient;
    }

    public void setPatient(@NotNull AppUser patient) {
        this.patient = patient;
    }

    public Boolean getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(Boolean paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

}
