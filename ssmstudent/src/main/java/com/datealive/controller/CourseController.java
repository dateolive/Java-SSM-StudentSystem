package com.datealive.controller;

import com.alibaba.fastjson.JSONObject;
import com.datealive.entity.Course;
import com.datealive.entity.Teacher;
import com.datealive.service.CourseService;
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
@RequestMapping("/CourseServlet")
public class CourseController {

    @Autowired(required = false)
    CourseService courseService;

    @RequestMapping("/CourseList")
    @ResponseBody
    public String CourseList(HttpServletRequest request, HttpServletResponse response){
        String name= null;
        if(request.getParameter("name")!=null && !("".equals(request.getParameter("name")))) {
            name= request.getParameter("name");
        }
        //String name = request.getParameter("name");
        //int teacherId = request.getParameter("userid") == null ? 0 : Integer.parseInt(request.getParameter("teacherid").toString());
        Integer teacherId;
        if(null==request.getParameter("userid") ||"".equals(request.getParameter("userid"))) teacherId=0;
        else teacherId=Integer.parseInt(request.getParameter("userid"));
        Integer currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        Integer pageSize = request.getParameter("rows") == null ? 999 : Integer.parseInt(request.getParameter("rows"));
        currentPage--;//因为mysql是从0开始算起的
        Course course = new Course();
        course.setName(name);
        course.setTeacher_id(teacherId);
        int userType = Integer.parseInt(request.getSession().getAttribute("userType").toString());

        if(userType == 3){
            //如果是老师，只能查看自己的信息
            Teacher currentUser = (Teacher)request.getSession().getAttribute("user");
            course.setTeacher_id(currentUser.getId());
        }
        List<Course> courseList = courseService.getCourseList(course, currentPage, pageSize);
        int total = courseService.getCourseListTotal(course);
        response.setCharacterEncoding("UTF-8");

        String from = request.getParameter("from");
        if("combox".equals(from)){
            return "{ \"code\":0,\"message\":\"成功\",\"data\":" + JSONObject.toJSONString(courseList) + ",\"count\" :"+total+"}";
        }else{
            return "{ \"code\":0,\"message\":\"成功\",\"data\":" + JSONObject.toJSONString(courseList) + ",\"count\" :"+total+"}";
        }

    }


    @RequestMapping("/AddCourse")
    public void AddCourse(HttpServletRequest request,HttpServletResponse response){
        String name = request.getParameter("name");
        int teacherId = Integer.parseInt(request.getParameter("userid").toString());
        int maxNum = Integer.parseInt(request.getParameter("maxnum").toString());
        String courseDate = request.getParameter("course_date");
        Integer cgrade = Integer.parseInt(request.getParameter("cgrade"));
        Course course = new Course();
        course.setName(name);
        course.setTeacher_id(teacherId);
        course.setCgrade(cgrade);
        course.setMax_num(maxNum);
        course.setCourse_date(courseDate);
        String msg = "error";


        try {
            courseService.addCourse(course);
            msg = "success";
            response.getWriter().write(msg);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @RequestMapping("/EditCourse")
    public void EditCourse(HttpServletRequest request,HttpServletResponse response){
        String name = request.getParameter("name");
        int teacherId = Integer.parseInt(request.getParameter("userid").toString());
        int maxNum = Integer.parseInt(request.getParameter("maxnum").toString());
        int id = Integer.parseInt(request.getParameter("id").toString());
        String courseDate = request.getParameter("course_date");
        Integer cgrade = Integer.parseInt(request.getParameter("cgrade"));
        Course course = new Course();
        course.setId(id);
        course.setName(name);
        course.setTeacher_id(teacherId);
        course.setCgrade(cgrade);
        course.setCourse_date(courseDate);
        course.setMax_num(maxNum);


        try {
            courseService.editCourse(course);
            response.getWriter().write("success");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    @RequestMapping("/DeleteCourse")
    public void DeleteCourse(HttpServletRequest request,HttpServletResponse response){
        String[] str = request.getParameterValues("ids[]");
        List<Integer> ids = new ArrayList<>();
        for(String string: str){
            //int id = Integer.valueOf(string);
            //System.out.println(id);
            Integer id = Integer.parseInt(string);
            ids.add(id);

        }
        try {
            courseService.deleteCourse(ids);
            response.getWriter().write("success");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
}
