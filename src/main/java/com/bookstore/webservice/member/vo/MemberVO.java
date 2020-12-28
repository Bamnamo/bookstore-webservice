package com.bookstore.webservice.member.vo;


import lombok.Data;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Data
@Component("memberVO")
public class MemberVO {
    private String member_id;
    private String member_pw;
    private String member_name;
    private String member_gender;
    private String member_birth_y;
    private String member_birth_m;
    private String member_birth_d;
    private String member_birth_gn;
    private String tel1;
    private String tel2;
    private String tel3;
    private String hp1;
    private String hp2;
    private String hp3;
    private String smssts_yn;
    private String email1;
    private String email2;
    private String emailsts_yn;
    private String zipcode;
    private String roadAddress;
    private String jibunAddress;
    private String namujiAddress;
    private String joinDate;
    private String del_yn;

}
