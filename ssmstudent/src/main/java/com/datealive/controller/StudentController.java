package com.datealive.controller;

import com.alibaba.fastjson.JSONObject;
import com.datealive.entity.SelectedCourse;
import com.datealive.entity.Student;
import com.datealive.entity.Teacher;
import com.datealive.service.SelectedCourseService;
import com.datealive.service.StudentService;
import com.datealive.util.SnGenerateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/StudentServlet")
public class StudentController {

    @Autowired(required = false)
    StudentService studentService;

    @Autowired(required = false)
    SelectedCourseService selectedCourseService;

    @RequestMapping("/StudentList")
    @ResponseBody
    public String StudentList(HttpServletRequest request, HttpServletResponse response){

        String name= null;
        if(request.getParameter("name")!=null && !("".equals(request.getParameter("name")))) {
            name= request.getParameter("name");
            System.out.println("不为空"+name);
        }
        Integer currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        Integer pageSize = request.getParameter("limit") == null ? 999 : Integer.parseInt(request.getParameter("limit"));
       currentPage--;
        Integer clazz;
        if(null==request.getParameter("userid") ||"".equals(request.getParameter("userid"))) clazz=0;
        else clazz=Integer.parseInt(request.getParameter("userid"));

        System.out.println("name="+name+"\n"+"calzz="+clazz);
        //Integer clazz = request.getParameter("userid") == null ? 0 : Integer.parseInt(request.getParameter("userid"));
        //获取当前登录用户类型
        int userType = Integer.parseInt(request.getSession().getAttribute("userType").toString());

        Student student = new Student();
        student.setName(name);
        student.setClazz_id(clazz);

        List<Student> array=null;
        if(userType == 2){
            //如果是学生，只能查看自己的信息
            Student currentUser = (Student)request.getSession().getAttribute("user");
            student.setId(currentUser.getId());
            //System.out.println("学生取:\n");
            //System.out.println(currentUser);

        }

        List<Student> studentList = studentService.getStudentList(student, currentPage, pageSize);
        int total = studentService.getStudentListTotal(student);
        array = studentList;


        if(userType==3) {
            //为老师,要返回选了该老师课的学生，我们在选课表与总学生表筛出来。
            Teacher currentUser = (Teacher)request.getSession().getAttribute("user");
            //student.setClazzId(currentUser.getClazzId());
            SelectedCourse selectedCourse = new SelectedCourse();
            selectedCourse.setTeacher_id(currentUser.getId()); //设置老师ID

            List<SelectedCourse> selectList = selectedCourseService.getSelectedCourseList(selectedCourse, currentPage, pageSize);
            System.out.println(selectList);
            total = selectedCourseService.getSelectedCourseListTotal(selectedCourse);

            List<Student> ans=new ArrayList<>();
            int sum=0;
            for(Student item1:studentList ) {//学生表
                boolean flag=false;
                for(SelectedCourse item2:selectList) {
                    if(item1.getId()==item2.getStudent_id()) { //选课表
//						System.out.println(item1.getId()+" "+item2.getStudentId()+"\n");
                        flag=true;
                        break;
                    }
                }

                if(flag) {
                    ans.add(item1);
                    sum++;
                }
            }

            array = ans;
            total=sum;
        }
        response.setCharacterEncoding("UTF-8");



        return "{ \"code\":0,\"message\":\"成功\",\"data\":" + JSONObject.toJSONString(array) + ",\"count\" :"+total+"}";



    }

    @RequestMapping("/AddStudent")
    public void AddStudent(HttpServletRequest request,HttpServletResponse response){
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String sex = request.getParameter("sex");
        String mobile = request.getParameter("mobile");
        int age = Integer.parseInt(request.getParameter("age"));
        int clazzId = Integer.parseInt(request.getParameter("userid"));

        Student student = new Student();

        student.setClazz_id(clazzId);
        student.setMobile(mobile);
        student.setName(name);
        student.setPassword(password);
        student.setAge(age);
        student.setSex(sex);
        student.setSn(SnGenerateUtil.generateSn(clazzId));
        System.out.println(student);
            try {
                studentService.addStudent(student);
                response.getWriter().write("success");
                System.out.println("success");
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }


    }

    @RequestMapping("/EditStudent")
    public void toStudentAdd(HttpServletRequest request,HttpServletResponse response){
        String name = request.getParameter("name");
        int id = Integer.parseInt(request.getParameter("id"));
        String sex = request.getParameter("sex");
        String mobile = request.getParameter("mobile");
        int age = Integer.parseInt(request.getParameter("age"));
        int clazzId = Integer.parseInt(request.getParameter("userid"));
        Student student = new Student();
        student.setClazz_id(clazzId);
        student.setMobile(mobile);
        student.setName(name);
        student.setId(id);
        student.setAge(age);
        student.setSex(sex);
        //System.out.println(student);
            try {
                studentService.editStudent(student);
                response.getWriter().write("success");
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }finally{
            }


    }

    @RequestMapping("/DeleteStudent")
    public void DeleteStudent(HttpServletRequest request,HttpServletResponse response){
        String[] str = request.getParameterValues("ids[]");
        List<Integer> ids = new ArrayList<>();
        for(String string: str){
            //int id = Integer.valueOf(string);
            //System.out.println(id);
            Integer id = Integer.parseInt(string);
            System.out.println("id====>"+id);
            ids.add(id);

        }
            try {
                studentService.deleteStudent(ids);
                response.getWriter().write("success");
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }


    }
}
