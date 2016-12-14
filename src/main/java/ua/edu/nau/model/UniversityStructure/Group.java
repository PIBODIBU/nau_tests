package ua.edu.nau.model.UniversityStructure;

import ua.edu.nau.model.User;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "university_structure_groups")
public class Group {
    private Integer id;
    private String name;
    private Department department;
    private Institute institute;
    private Set<User> users;

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

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "department_id")
    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "institute_id")
    public Institute getInstitute() {
        return institute;
    }

    public void setInstitute(Institute institute) {
        this.institute = institute;
    }

    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "group")
    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }
}
