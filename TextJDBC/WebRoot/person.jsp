<%@page language="java" contentType="text/html;charset=utf-8" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<jsp:directive.page import="java.sql.Date"/>
<jsp:directive.page import="java.sql.Timestamp"/>
<jsp:directive.page import="java.sql.SQLException"/>
<a href="addPerson.jsp">新建人员资料</a>
<%request.setCharacterEncoding("UTF-8");
  response.setCharacterEncoding("UTF-8");
  Connection conn=null;//数据库连接
  Statement stmt=null;//Statement
  ResultSet rs=null;//结果查询
  try{
  DriverManager.registerDriver(new com.mysql.jdbc.Driver());//注册驱动
  //获取数据库连接
  conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/web","root","123456");
  //获取Statement用于执行SQL
  stmt=conn.createStatement();
  //执行SELECT语句，并返回结果集
  rs=stmt.executeQuery("select* from person");
%>
  <form action="operatePerson.jsp" method=get>
  <table bgcolor="#cccccc" cellspacing=1 cellpadding=5 width=100%>
  <tr bgcolor=#DDDDDD>
<th></th>
<th>ID</th>
<th>姓名</th>
<th>英文名</th>
<th>性别</th>
<th>年龄</th>
<th>生日</th>
<th>备注</th>
<th>记录创建时间</th>
<th>操作</th>
</tr>

<%
  //遍历结果集
  while(rs.next()){
  int id=rs.getInt("id");//取id列，整数类型
  int age=rs.getInt("age");//取age列
  String name=rs.getString("name");//取name列，字符串类型
  String englishName=rs.getString("english_name");
  String sex=rs.getString("sex");
  String description=rs.getString("description");
  Date birthday=rs.getDate("birthday");
  Timestamp createTime=rs.getTimestamp("create_time");
  
  out.println("<tr bgcolor=#ffffff>");  
  out.println(" <td><input type=checkbox name=id value"+id+"></td>");
  out.println(" <td>"+id+"</td>");  
  out.println(" <td>"+name+"</td>");  
  out.println(" <td>"+englishName+"</td>");  
  out.println(" <td>"+sex+"</td>");  
  out.println(" <td>"+age+"</td>");  
  out.println(" <td>"+birthday+"</td>");  
  out.println(" <td>"+description+"</td>");  
  out.println(" <td>"+createTime+"</td>");  
  out.println(" <td>");
  out.println("    <a href='operatePerson.jsp?action=del&id="+id+"'onclick='return confirm(\"确定删除该记录？\")'>删除</a>");
  out.println("    <a href='operatePerson.jsp?action=edit&id="+id+"'>修改</a>");
  out.println(" <td>");
  out.println("      <tr>");
 
  }
   %>
   </table>
   <table align=left>
   <tr>
   <td>
   <input type='hidden'value='del' name='action'>

   <input type='submit' onclick="return confirm('即将删除所选记录。是否删除？');" value='删除'>
   </td>
   </tr>
   </table>
   </form>
   <%}
   catch(SQLException e){
  out.println("error"+e.getMessage());
  e.printStackTrace();
   }
   finally{
   if(rs!=null)
   rs.close();
   if(stmt!=null)
   stmt.close();
   if(conn!=null)
   conn.close();
   } %>