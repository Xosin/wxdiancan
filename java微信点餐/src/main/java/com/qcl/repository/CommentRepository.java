package com.qcl.repository;

import com.qcl.bean.Comment;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * 微信：13850773979
 * desc:
 */
public interface CommentRepository extends JpaRepository<Comment, Integer> {
    List<Comment> findAllByOpenid(String openid);
}
