package com.edu.tjdz.geng.service;

import com.edu.tjdz.geng.model.Student;

import java.util.List;

public interface StudentService {
    public List<Student> getAllStudents();
    public void saveStudent(Student stu);
}