package com.datealive.controller;

import com.datealive.entity.Admin;
import com.datealive.entity.Student;
import com.datealive.entity.Teacher;
import com.datealive.service.AdminService;
import com.datealive.service.StudentService;
import com.datealive.service.TeacherService;
import com.datealive.util.CpachaUtil;
import com.github.pagehelper.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;


@Controller
public class LoginController {


    @Autowired(required = false)
    AdminService adminService;

    @Autowired(required = false)
    StudentService studentService;

    @Autowired(required = false)
    TeacherService teacherService;



    /**
     * 验证码
     * */
    @RequestMapping("/checkCode")
    public void checkCode(HttpServletRequest request, HttpServletResponse response,String a)
            throws ServletException, IOException {
        //设置相应类型,告诉浏览器输出的内容为图片
        response.setContentType("image/jpeg");

        //设置响应头信息，告诉浏览器不要缓存此内容
        response.setHeader("pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);

        CpachaUtil cpachaUtil = new CpachaUtil();
        String generatorVCode = cpachaUtil.generatorVCode();
        request.getSession().setAttribute("loginCapcha", generatorVCode);
        BufferedImage generatorRotateVCodeImage = cpachaUtil.generatorRotateVCodeImage(generatorVCode, true);
        ImageIO.write(generatorRotateVCodeImage, "gif", response.getOutputStream());
        System.out.println("generatorVCode="+generatorVCode);

    }

    //登陆验证
    @RequestMapping("/checkLogin")
    public void checkLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String vcode = request.getParameter("vcode");//验证码
        String name = request.getParameter("account");//账户
        String password = request.getParameter("password");//密码
        int type = Integer.parseInt(request.getParameter("type")); //学生或者老师或者管理员
        String loginCpacha = request.getSession().getAttribute("loginCapcha").toString();

        System.out.println("vcode="+vcode+"\n"+"name="+name+"\n"+"password="+password+"type="+type);


        if(StringUtil.isEmpty(vcode)){
            response.getWriter().write("vcodeError");
            return;
        }
        if(!vcode.toUpperCase().equals(loginCpacha.toUpperCase())){
            response.getWriter().write("vcodeError");
            return;
        }
        //验证码验证通过，对比用户名密码是否正确
        String loginStatus = "loginFaild";
        switch (type) {
            case 1:{

                Admin admin = adminService.queryAdmin(name,password);
//                System.out.println(admin);
                if(admin == null){
                    response.getWriter().write("loginError");
                    return;
                }
                HttpSession session = request.getSession();
                session.setAttribute("user", admin);
                session.setAttribute("userType", type);
                loginStatus = "loginSuccess";
                break;
            }
            case 2:{

                Student student = studentService.queryStudent(name,password);


                if(student == null){
                    response.getWriter().write("loginError");
                    return;
                }
                HttpSession session = request.getSession();
                session.setAttribute("user", student);
                session.setAttribute("userType", type);
                loginStatus = "loginSuccess";
                break;
            }
            case 3:{

                Teacher teacher = teacherService.queryTeacher(name,password);
                if(teacher == null){
                    response.getWriter().write("loginError");
                    return;
                }
                HttpSession session = request.getSession();
                session.setAttribute("user", teacher);
                session.setAttribute("userType", type);
                loginStatus = "loginSuccess";
                break;
            }
            default:
                break;
        }
//        System.out.println("loginStatus="+loginStatus);
        response.getWriter().write(loginStatus);
    }

}
