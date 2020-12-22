package com.bookstore.webservice.member.vo;


import lombok.Data;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Data
@Component("memberVO")
public class MemberVO {
    private String id;
    private String pwd;
    private String name;
    private String email;
    private Date joinDate;

    public MemberVO() {
        System.out.println("MemberVO 생성자 호출");
    }

}
