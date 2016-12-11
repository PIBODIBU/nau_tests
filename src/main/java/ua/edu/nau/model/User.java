package ua.edu.nau.model;

import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "users")
public class User {
    private Integer id;
    private String name;
    private String username;
    private String password;
    private String email;
    private UserRole userRole;
    private Set<TestSession> testSessions;
    private Set<HttpSession> httpSessions;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "username")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @OneToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "user_role")
    public UserRole getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }

    @Cascade(org.hibernate.annotations.CascadeType.PERSIST)
    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "user", fetch = FetchType.EAGER, orphanRemoval = true)
    @OrderBy("id DESC")
    public Set<TestSession> getTestSessions() {
        return testSessions;
    }

    public void setTestSessions(Set<TestSession> testSessions) {
        this.testSessions = testSessions;
    }

    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "user", orphanRemoval = true)
    @OrderBy("id DESC")
    public Set<HttpSession> getHttpSessions() {
        return httpSessions;
    }

    public void setHttpSessions(Set<HttpSession> httpSessions) {
        this.httpSessions = httpSessions;
    }
}
