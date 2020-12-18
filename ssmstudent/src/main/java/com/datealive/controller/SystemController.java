package com.datealive.controller;

import com.datealive.entity.Admin;
import com.datealive.entity.Student;
import com.datealive.entity.Teacher;
import com.datealive.service.AdminService;
import com.datealive.service.StudentService;
import com.datealive.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@Controller
@RequestMapping("/SystemServlet")
public class SystemController {

    @Autowired(required = false)
    AdminService adminService;

    @Autowired(required = false)
    StudentService studentService;

    @Autowired(required = false)
    TeacherService teacherService;

    //跳转到系统页面
    @RequestMapping("/toAdminView")
    public String toAdminView(Model model){
        return "system";
    }

    @RequestMapping("/toChangePwd")
    public String toChangePwd(Model model) {return "changePwd";}

    //跳转到班级页面
    @RequestMapping("/toClazzList")
    public String toClazzList(Model model){
        return "clazz/clazzList";
    }

    //跳转到编辑班级页面
    @RequestMapping("/toClazzEdit")
    public String toClazzEdit(Model model){
        return "clazz/clazzEdit";
    }

    //跳转到编辑班级页面
    @RequestMapping("/toClazzAdd")
    public String toClazzAdd(Model model){
        return "clazz/clazzAdd";
    }

    //跳转到学生页面
    @RequestMapping("/toStudentList")
    public String toStudentList(Model model){
        return "student/studentList";
    }

    //跳转到学生编辑页面
    @RequestMapping("/toStudentEdit")
    public String toStudentEdit(Model model){ return  "student/studentEdit";};

    //跳转到学生增加页面
    @RequestMapping("/toStudentAdd")
    public String toStudentAdd(Model model){ return  "student/studentAdd";};

    //跳转到老师页面
    @RequestMapping("/toTeacherList")
    public String toTeacherList(Model model){
        return "teacher/teacherList";
    }

    //跳转到编辑老师页面
    @RequestMapping("/toTeacherEdit")
    public String toTeacherEdit(Model model) { return "teacher/teacherEdit";}

    @RequestMapping("/toTeacherAdd")
    public String toTeacherAdd(Model model) {return "teacher/teacherAdd";}

    //跳转到课程页面
    @RequestMapping("/toCourseList")
    public String toCourseList(Model model){
        return "course/courseList";
    }

    //跳转到编辑课程页面
    @RequestMapping("/toCourseEdit")
    public String toCourseEdit(Model model){
        return "course/courseEdit";
    }

    //跳转到编辑课程页面
    @RequestMapping("/toCourseAdd")
    public String toCourseAdd(Model model){
        return "course/courseAdd";
    }

    //跳转到选课页面
    @RequestMapping("/toSelectList")
    public String toSelectList(Model model){
        return "select/selectList";
    }

    @RequestMapping("/toSelectAdd")
    public String toSelectAdd(Model model) { return  "select/selectAdd";}

    @RequestMapping("/EditPasswod")
    public void EditPasswod(HttpServletRequest request, HttpServletResponse response){
        String password = request.getParameter("password");
        String newPassword = request.getParameter("newpassword");
        response.setCharacterEncoding("UTF-8");
        int userType = Integer.parseInt(request.getSession().getAttribute("userType").toString());
        if(userType == 1){
            //管理员
            Admin admin = (Admin)request.getSession().getAttribute("user");
            if(!admin.getPassword().equals(password)){
                try {
                    response.getWriter().write("原密码错误！");
                    return;
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
                try {
                    adminService.editPassword(admin, newPassword);
                    response.getWriter().write("success");
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }

        }
        if(userType == 2){
            //学生
            Student student = (Student)request.getSession().getAttribute("user");
            if(!student.getPassword().equals(password)){
                try {
                    response.getWriter().write("原密码错误！");
                    return;
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            studentService.editPassword(student, newPassword);
                try {
                    response.getWriter().write("success");
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }

        }
        if(userType == 3){
            //教师
            Teacher teacher = (Teacher)request.getSession().getAttribute("user");
            if(!teacher.getPassword().equals(password)){
                try {
                    response.getWriter().write("原密码错误！");
                    return;
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            teacherService.editPassword(teacher, newPassword);
                try {
                    response.getWriter().write("success");
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }


        }
    }




}
