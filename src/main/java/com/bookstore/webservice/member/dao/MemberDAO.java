package com.bookstore.webservice.member.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository("memberDAO")
public interface MemberDAO {
    public List selectAllMemberList() throws DataAccessException;
}
