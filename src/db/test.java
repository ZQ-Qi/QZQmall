package db;

import org.json.JSONArray;
import org.json.JSONObject;

public class test {
    public static void main(String[] args) {
        JSONObject my_json=new JSONObject();
        my_json.put("class", "二年级");
        my_json.put("total", 2);
        JSONArray members=new JSONArray();
        JSONObject member1=new JSONObject();
        member1.put("name", "李小红");
        member1.put("age", 18);
        member1.put("score", 95);
        members.put(member1);
        my_json.put("members", members);
        System.out.println(my_json.toString());
    }
}
