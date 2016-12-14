package ua.edu.nau.model.UniversityStructure;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "university_structure_departments")
public class Department {
    private Integer id;
    private String name;
    private String shortName;
    private Institute institute;
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

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "institute_id")
    public Institute getInstitute() {
        return institute;
    }

    public void setInstitute(Institute institute) {
        this.institute = institute;
    }

    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "department")
    public Set<Group> getGroups() {
        return groups;
    }

    public void setGroups(Set<Group> groups) {
        this.groups = groups;
    }
}
