package com.datealive.controller;

import com.alibaba.fastjson.JSONObject;
import com.datealive.entity.Course;
import com.datealive.entity.SelectedCourse;
import com.datealive.entity.Student;
import com.datealive.entity.Teacher;
import com.datealive.service.CourseService;
import com.datealive.service.SelectedCourseService;
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
@RequestMapping("/SelectedCourseServlet")
public class SelectCourseController {

    @Autowired(required = false)
    CourseService courseService;

    @Autowired(required = false)
    SelectedCourseService selectedCourseService;

    @RequestMapping("/SelectedCourseList")
    @ResponseBody
    public String SelectedCourseList(HttpServletRequest request, HttpServletResponse response){
        Integer studentId;
        if(null==request.getParameter("studentid") ||"".equals(request.getParameter("studentid"))) studentId=0;
        else studentId=Integer.parseInt(request.getParameter("studentid"));

        //int courseId = request.getParameter("courseid") == null ? 0 : Integer.parseInt(request.getParameter("courseid").toString());
        Integer courseId;
        if(null==request.getParameter("courseid") ||"".equals(request.getParameter("courseid"))) courseId=0;
        else courseId=Integer.parseInt(request.getParameter("courseid"));
        Integer currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        Integer pageSize = request.getParameter("limit") == null ? 999 : Integer.parseInt(request.getParameter("limit"));
        SelectedCourse selectedCourse = new SelectedCourse();
        //获取当前登录用户类型
        int userType = Integer.parseInt(request.getSession().getAttribute("userType").toString());

        List<Course> courseList=new ArrayList<>();
        List<SelectedCourse> array=null;
        if(userType == 2){
            //如果是学生，只能查看自己的信息
            Student currentUser = (Student)request.getSession().getAttribute("user");
            studentId = currentUser.getId();
        }
        else if(userType==3) {
            //如果为老师
            Teacher currentUser = (Teacher)request.getSession().getAttribute("user");
            selectedCourse.setTeacher_id(currentUser.getId());

            Course course = new Course();
            course.setTeacher_id(currentUser.getId());
           //获取老师的所授课程表
            courseList = courseService.getCourseList(course, currentPage, pageSize);
        }
        selectedCourse.setCourse_id(courseId);
        selectedCourse.setStudent_id(studentId);
        List<SelectedCourse> selectList = selectedCourseService.getSelectedCourseList(selectedCourse, currentPage, pageSize);
        int total = selectedCourseService.getSelectedCourseListTotal(selectedCourse);
        array = selectList;

        if(userType==3) {
            List<SelectedCourse> ans=new ArrayList<>();
            int sum=0;
            for(SelectedCourse item1:selectList) { //该老师学生的所有选课表

                boolean flag=false;
                for(Course item2:courseList) { //该老师的全部课程
                    if(item1.getCourse_id()==item2.getId()) {
                        flag=true;break;
                    }
                }
                if(flag) {
                    ans.add(item1);
                    sum++;
                }
            }
            total=sum;
            //System.out.println(ans);
            array = ans;
        }


        response.setCharacterEncoding("UTF-8");


            String from = request.getParameter("from");
            if("combox".equals(from)){
                return "{ \"code\":0,\"message\":\"成功\",\"data\":" + JSONObject.toJSONString(array) + ",\"count\" :"+total+"}";
            }else{
                return "{ \"code\":0,\"message\":\"成功\",\"data\":" + JSONObject.toJSONString(array) + ",\"count\" :"+total+"}";
            }

    }


    @RequestMapping("/AddSelectedCourse")
    public void  AddSelectedCourse(HttpServletRequest request,HttpServletResponse response) throws IOException {
        int studentId = request.getParameter("studentid") == null ? 0 : Integer.parseInt(request.getParameter("studentid").toString());
        int courseId = request.getParameter("courseid") == null ? 0 : Integer.parseInt(request.getParameter("courseid").toString());
        String msg = "success";
        if(courseService.isFull(courseId)){
            msg = "courseFull";
            response.getWriter().write(msg);
            return;
        }

        if(selectedCourseService.isSelected(studentId, courseId)){
            msg = "courseSelected";
            response.getWriter().write(msg);
            return;
        }
        SelectedCourse selectedCourse = new SelectedCourse();
        selectedCourse.setStudent_id(studentId);
        selectedCourse.setCourse_id(courseId);

        //获取该选课信息中，课程所受的老师
        Course course = new Course();
        course.setId(courseId);
        List<Course> courseList = courseService.getCourseList(course, 1, 10);
        for(Course pho:courseList){
            selectedCourse.setTeacher_id(pho.getTeacher_id());
        }
        selectedCourseService.addSelectedCourse(selectedCourse);
        msg = "success";

        courseService.updateCourseSelectedNum(courseId);
        response.getWriter().write(msg);
    }

    @RequestMapping("/DeleteSelectedCourse")
    public void DeleteSelectedCourse(HttpServletRequest request,HttpServletResponse response) throws IOException {
//        String[] str = request.getParameterValues("ids[]");
//        List<Integer> ids = new ArrayList<>();
//        for(String string: str){
//            Integer id = Integer.parseInt(string);
//            ids.add(id);
//
//        }
//        try {
//            selectedCourseService.deleteSelectedCourse(ids);
//            response.getWriter().write("success");
//        } catch (IOException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//    }

        String[] ids = request.getParameterValues("ids[]");
        String msg = "success";
        for(String item : ids){
            int id = Integer.parseInt(item);
            SelectedCourse selectedCourse = selectedCourseService.getSelectedCourseById(id);
            selectedCourseService.deleteSelectedCourseById(id);
            courseService.updateCourseSelectedNumDe(selectedCourse.getCourse_id());
        }

        response.getWriter().write(msg);
    }

    @RequestMapping("/EditSelectedCourse")
    public void EditSelectedCourse(HttpServletRequest request,HttpServletResponse response){
        int id = Integer.parseInt(request.getParameter("id"));

        int scoreId = Integer.parseInt(request.getParameter("score_id"));
        SelectedCourse selectedCourse=new SelectedCourse();
        selectedCourse.setId(id);
        selectedCourse.setScore_id(scoreId);

        //System.out.println(selectedCourse);
            try {
                selectedCourseService.editSelectedCourse(selectedCourse);
                response.getWriter().write("success");
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

    }
}
