package ua.edu.nau.model.UniversityStructure;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "university_structure_institutes")
public class Institute {
    private Integer id;
    private String name;
    private String shortName;
    private Set<Department> departments;
    private Set<Group> groups;

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

    @Column(name = "short_name")
    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "institute")
    public Set<Department> getDepartments() {
        return departments;
    }

    public void setDepartments(Set<Department> departments) {
        this.departments = departments;
    }

    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "institute")
    public Set<Group> getGroups() {
        return groups;
    }
    
    public void setGroups(Set<Group> groups) {
        this.groups = groups;
    }
}