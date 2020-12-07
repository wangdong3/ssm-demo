package com.edu.tjdz.geng.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.edu.tjdz.geng.dao.StudentDao;
import com.edu.tjdz.geng.model.Student;
import com.edu.tjdz.geng.service.StudentService;

@Service("studentService")
public class StudentServiceImpl implements StudentService {

    @Autowired
    StudentDao studentDao;

    @Override
    public List<Student> getAllStudents() {
        return studentDao.selectAllStus();
    }

    @Override
    public void saveStudent(Student stu) {
        studentDao.insertStudent(stu);
    }
}