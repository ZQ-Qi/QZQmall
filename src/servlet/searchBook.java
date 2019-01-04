package servlet;

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
import java.util.HashMap;
import java.util.Map;

import db.DBCPUtils;
import com.alibaba.fastjson.JSON;

@WebServlet("/searchBook")
public class searchBook extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String searchText = request.getParameter("search").toLowerCase();
        String func = request.getParameter("func");
        response.setContentType("text/json; charset=utf-8");
        PrintWriter out = response.getWriter();
        Map<String,Object> resMap = new HashMap<>();
        if(searchText == null || "".equals(searchText)){
            resMap.put("res",-1);
        }else{
            try{
                Connection conn = DBCPUtils.getConnection();
                PreparedStatement pstmt = null;
                if("category".equals(func)){
                    String sql = "select * from book where category = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1,searchText);
                }else{
                    String sql = "select * from book " +
                            "where lower(author) like ? " +
                            "   or lower(bookid) like ? " +
                            "   or lower(bookname) like ? " +
                            "   or lower(pubdate) like ? " +
                            "   or lower(category) like ? " +
                            "   or lower(introduction) like ? " +
                            "   or lower(price) like ? " +
                            "   or lower(picpath) like ?;";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, "%"+searchText+"%");
                    pstmt.setString(2, "%"+searchText+"%");
                    pstmt.setString(3, "%"+searchText+"%");
                    pstmt.setString(4, "%"+searchText+"%");
                    pstmt.setString(5, "%"+searchText+"%");
                    pstmt.setString(6, "%"+searchText+"%");
                    pstmt.setString(7, "%"+searchText+"%");
                    pstmt.setString(8, "%"+searchText+"%");
                }
                ResultSet rs = pstmt.executeQuery();
                int rowCount = 0;
                while(rs.next()){
                    Map<String,Object> map = new HashMap<>();
                    map.put("bookid",rs.getString("bookid"));
                    map.put("bookname",rs.getString("bookname"));
                    map.put("author",rs.getString("author"));
                    map.put("pubdate",rs.getString("pubdate"));
                    map.put("category",rs.getString("category"));
                    map.put("introduction",rs.getString("introduction"));
                    map.put("price",rs.getString("price"));
                    map.put("picpath",rs.getString("picpath"));
                    resMap.put(rs.getString("bookid"),map);
                    rowCount++;
                }
                resMap.put("res",rowCount);
                DBCPUtils.closeAll(rs,pstmt,conn);
            } catch (Exception e){
                e.printStackTrace();
            }
        }
        String resJSON = JSON.toJSONString(resMap);
        out.print(resJSON);
    }
}


//servlet返回json https://blog.csdn.net/wild46cat/article/details/52488211