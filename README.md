# 数据库课程设计

**数据库课程设计说明：**

**1.** **使用的技术栈：**

**前端：layui** **前端UI ** **框架**

**后端：基于Java** **的Spring+SpringMVC+MyBatis** **框架**

**数据库：MYSQL** **数据库**

**2.** **功能：该学生选课管理系统分为三端：学生端，教师端和管理员端**

**管理员端：**

**管理员可以查看学生，教师，班级，选课列表，并对学生，教师，班级信息进行增删改查，实现了数据分页功能，管理员还可以对学生选修课程可以管理。**

**教师端：**

**教师可以查看选修了自己课程的学生信息，查看个人信息，所在班级信息，对自己所教课程进行编辑，添加课程，查看所教学生的课程信息。**

**学生端：**

**学生可以查看个人信息，所在班级信息，可以查看自己选修的课程信息，如总学分，总分等等，学生还可以对未选修的课程进行选课，并且可以退选课程。**

 

（1）E-R图

![数据库学生选课系统er图.jpg](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image002.png)

（2）关系模式

R1(id，学号，姓名，性别，班级序号，年龄，手机号，密码) ，主码：id和学号 外码：班级序号

R2(id，班级编号，班级名称，班级简介)，主码：id

R3(id，课程名称，教师编号，上课时间，选修人数，最大人数，学分)，主码：id 外码：教师编号

R4(id，教师编号，名称，班级编号，性别，职位，工资，密码) 主码：id 外码：班级编号

R5(id，管理员账号，密码) 主码：id

R6(id，学生id，课程id，教师id，分数) 主码：id 外码：学生id，课程id，教师id

（3）实验截图

1.主界面，实现学生，教师和管理员三端登录，并分别授予不同权限。

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image004.jpg)

2.管理员界面

管理员界面分别有学生管理，班级管理，教师管理，课程管理和选课信息管理模块

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image006.jpg)

（1）学生管理模块：

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image008.jpg)

学生管理模块可以进行指定条件搜索学生信息功能，添加功能，删除功能以及编辑功能。

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image010.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image012.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image014.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image016.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image018.jpg)

 

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image020.jpg)

（2）教师模块：

功能与学生模块类似，就不一一截图

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image022.jpg)

（3）班级管理模块：

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image024.jpg)

（4）课程管理

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image026.jpg)

（5）选课信息管理模块

可以对学生选课进行管理，为学生选课，退课，并且可以为学生添加成绩

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image028.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image030.jpg)

 

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image032.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image034.jpg)

3.教师界面

教师界面可以查看选修了自己课程的学生信息，查看自己的班级，查看自己的信息并编辑相关信息，查看自己的课程并添加，编辑和删除课程。

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image036.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image038.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image040.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image042.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image044.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image046.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image048.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image050.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image052.jpg)

3.学生界面：

学生界面可以查看自己的信息，并且可以编辑指定个人信息，可以查看所在班级信息，也可以查看自己选修课程信息，且可以对课程进行选课，退课

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image054.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image056.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image058.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image060.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image062.jpg)

![img](file:///C:\Users\Lenovo\AppData\Local\Temp\msohtmlclip1\01\clip_image064.jpg)

![img](C:/Users/Lenovo/AppData/Local/Temp/msohtmlclip1/01/clip_image066.jpg)

 

