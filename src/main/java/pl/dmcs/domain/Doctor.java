package pl.dmcs.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.List;
import java.util.Set;

@Entity
@Table(name= "doctor")
public class Doctor {
    @Id
    private Long id;

    @NotNull
    @Column(name="firstName", nullable=false)
    @Size(min=2, max=30, message = "{error.size.firstName}")
    private String firstName;

    @NotNull
    @Size(min=2, max=30)
    private String lastName;

    @NotNull
    @Size(min=2, max=30)
    private String cityName;

    @OneToMany(mappedBy = "doctor", fetch = FetchType.EAGER)
    private Set<Appointment> appointments;

    public Doctor() {
        this.firstName = "";
        this.lastName = "";
        this.cityName = "";
    }

    public Doctor(String firstName, String lastName, String cityName) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.cityName = cityName;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }
}
