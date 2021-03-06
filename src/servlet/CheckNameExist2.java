package servlet;

import db.DBCPUtils;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/CheckNameExist")
public class CheckNameExist2 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/json; charset=utf-8");
        PrintWriter out = response.getWriter();
        String uid = "";
        boolean res = true;
        JSONObject json_res = new JSONObject();
        try{
            uid = request.getParameter("username");
            Connection con = DBCPUtils.getConnection();
            String sql = "select * from user where uid = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1,uid);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                res = false;
            }
            DBCPUtils.closeAll(rs,pstmt,con);
        } catch(Exception e){
            e.printStackTrace();
        }
        json_res.put("isuseable",res);
        System.out.println("res:"+ res);
        if(res){
            response.setStatus(200);
        }else{
            response.setStatus(400);
        }

        out.println(res);
        out.close();


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);


    }

}
