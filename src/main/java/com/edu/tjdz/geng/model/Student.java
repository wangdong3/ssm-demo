package com.edu.tjdz.geng.model;

/**
 * Student
 *
 * @author wangdong on 2020/12/7 16:44
 * @version 2.0
 */
public class Student
{
    private int id;
    private String department;
    private String className;
    private String name;
    private int tempreture1;
    private int tempreture2;
    private int tempreture3;

    public int getId()
    {
        return id;
    }
    public void setId(int id)
    {
        this.id = id;
    }
    public String getDepartment()
    {
        return department;
    }
    public void setDepartment(String department)
    {
        this.department = department;
    }
    public String getClassName()
    {
        return className;
    }
    public void setClassName(String className)
    {
        this.className = className;
    }
    public String getName()
    {
        return name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
    public int getTempreture1()
    {
        return tempreture1;
    }
    public void setTempreture1(int tempreture1)
    {
        this.tempreture1 = tempreture1;
    }
    public int getTempreture2()
    {
        return tempreture2;
    }
    public void setTempreture2(int tempreture2)
    {
        this.tempreture2 = tempreture2;
    }
    public int getTempreture3()
    {
        return tempreture3;
    }
    public void setTempreture3(int tempreture3)
    {
        this.tempreture3 = tempreture3;
    }
    @Override
    public String toString()
    {
        return "Student{" + "id=" + id + ", department='" + department + '\'' + ", className='" + className + '\''
                + ", name='" + name + '\'' + ", tempreture1=" + tempreture1 + ", tempreture2=" + tempreture2
                + ", tempreture3=" + tempreture3 + '}';
    }
}
