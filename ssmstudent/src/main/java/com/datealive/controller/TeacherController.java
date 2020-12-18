package com.datealive.controller;

import com.alibaba.fastjson.JSONObject;
import com.datealive.entity.Teacher;
import com.datealive.service.TeacherService;
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
@RequestMapping("/TeacherServlet")
public class TeacherController {

    @Autowired(required = false)
    TeacherService teacherService;

    @RequestMapping("/TeacherList")
    @ResponseBody
    public String TeacherList(HttpServletRequest request, HttpServletResponse response){

        String name= null;
        if(request.getParameter("name")!=null&& !("".equals(request.getParameter("name")))) {
            name= request.getParameter("name");
        }
        //String name = request.getParameter("teacherName");
        Integer currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        Integer pageSize = request.getParameter("limit") == null ? 999 : Integer.parseInt(request.getParameter("limit"));
       currentPage--;
        Integer clazz;
        if(null==request.getParameter("userid") ||"".equals(request.getParameter("userid"))) clazz=0;
        else clazz=Integer.parseInt(request.getParameter("userid"));
        //Integer clazz = request.getParameter("userid") == null ? 0 : Integer.parseInt(request.getParameter("userid"));
        //获取当前登录用户类型
        int userType = Integer.parseInt(request.getSession().getAttribute("userType").toString());
        Teacher teacher = new Teacher();
        teacher.setName(name);
        teacher.setClazz_id(clazz);
        if(userType == 3){
            //如果是老师，只能查看自己的信息
            Teacher currentUser = (Teacher)request.getSession().getAttribute("user");
            teacher.setId(currentUser.getId());
            System.out.println("该老师的信息为:"+teacher);

        }
        List<Teacher> teacherList = teacherService.getTeacherList(teacher, currentPage, pageSize);
        int total = teacherService.getTeacherListTotal(teacher);
        response.setCharacterEncoding("UTF-8");

        return "{ \"code\":0,\"message\":\"成功\",\"data\":" + JSONObject.toJSONString(teacherList) + ",\"count\" :"+total+"}";



    }

    @RequestMapping("/AddTeacher")
    public void AddTeacher(HttpServletRequest request,HttpServletResponse response){
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String sex = request.getParameter("sex");
        String tposition = request.getParameter("tposition");
        String salary = request.getParameter("salary");
        int clazzId = Integer.parseInt(request.getParameter("userid"));
        Teacher teacher = new Teacher();
        teacher.setClazz_id(clazzId);
        teacher.setTposition(tposition);
        teacher.setName(name);
        teacher.setPassword(password);
        teacher.setSalary(salary);
        teacher.setSex(sex);
        teacher.setSn(SnGenerateUtil.generateTeacherSn(clazzId));
            try {
                teacherService.addTeacher(teacher);
                response.getWriter().write("success");
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

    }

    @RequestMapping("/EditTeacher")
    public void EditTeacher(HttpServletRequest request,HttpServletResponse response){
        String name = request.getParameter("name");
        int id = Integer.parseInt(request.getParameter("id"));
        String sex = request.getParameter("sex");
        String tposition = request.getParameter("tposition");
        String salary = request.getParameter("salary");
        int clazzId = Integer.parseInt(request.getParameter("userid"));
        Teacher teacher = new Teacher();
        teacher.setClazz_id(clazzId);
        teacher.setTposition(tposition);
        teacher.setName(name);
        teacher.setId(id);
        teacher.setSalary(salary);
        teacher.setSex(sex);
            try {
                teacherService.editTeacher(teacher);
                response.getWriter().write("success");
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
    }

    @RequestMapping("/DeleteTeacher")
    public void DeleteClazz(HttpServletRequest request,HttpServletResponse response){
//        String[] str = request.getParameterValues("ids[]");
//        List<Integer> ids = new ArrayList<>();
//        for (String s : str) {
//            Integer id = Integer.parseInt(s);
//            ids.add(id);
//        }
//        System.out.println(ids);
//            try {
//                teacherService.deleteTeacher(ids);
//                response.getWriter().write("success");
//            } catch (IOException e) {
//                // TODO Auto-generated catch block
//                e.printStackTrace();
//            }
        String[] str = request.getParameterValues("ids[]");
        List<Integer> ids = new ArrayList<>();
        for(String string: str){
            //int id = Integer.valueOf(string);
            //System.out.println(id);
            Integer id = Integer.parseInt(string);
            ids.add(id);

        }
        try {
            teacherService.deleteTeacher(ids);
            response.getWriter().write("success");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
}
