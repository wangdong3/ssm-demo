package com.edu.tjdz.geng.dao;

import java.util.List;

import com.edu.tjdz.geng.model.Student;

public interface StudentDao {
    public List<Student> selectAllStus();
    public void insertStudent(Student stu);
}