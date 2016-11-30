package ua.edu.nau.model;

import javax.persistence.*;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "tests")
public class Test {
    private Integer id;
    private String name;
    private String description;
    private User owner;
    private Date time;
    private Set<Question> questions;

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

    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "owner")
    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    @Column(name = "time", columnDefinition = "TIME")
    @Temporal(TemporalType.TIME)
    public Date getTime() {
        return time;
    }

    public void setTime(Date startTime) {
        this.time = startTime;
    }

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "test")
    @OrderBy("id")
    public Set<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(Set<Question> questions) {
        this.questions = questions;
    }
}
