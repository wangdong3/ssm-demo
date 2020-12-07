package com.edu.tjdz.geng.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.edu.tjdz.geng.model.Message;
import com.edu.tjdz.geng.model.Student;
import com.edu.tjdz.geng.service.StudentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
@Controller
public class StudentController
{

	@Autowired
	StudentService studentService;

	//负责显示查询页面
	@RequestMapping(value = "/showStudentsListpage", method = RequestMethod.GET)
	public String showStudentListPage() {
		return "studentsList";
	}

	//负责查询所有学生信息，并将学生信息封装到Message类中进行JSON格式的返回
	@RequestMapping(value = "/studentsList", method = RequestMethod.GET)
	@ResponseBody
	public Message getStudentsWithJson(@RequestParam(value = "pageNum", defaultValue = "1")int pageNum) {
		int pageSize = 10;
		int showPages = 5;

		System.out.println("pageNum:" + pageNum);
		PageHelper.startPage(pageNum, pageSize);
		List<Student> stus = studentService.getAllStudents();

		PageInfo<Student> stuPageInfo = new PageInfo<Student>(stus, showPages);

		return Message.success().add("stuPageInfo", stuPageInfo);
	}

	//负责新增信息
	@RequestMapping(value="/studentsList", method = RequestMethod.POST)
	@ResponseBody
	public Message saveStudent(Student stu) {
		studentService.saveStudent(stu);
		return  Message.success();
	}

}
