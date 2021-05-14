package com.kh.sharecarrot.mystore.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MystoreDaoImpl implements MystoreDao {

	@Autowired
	private SqlSessionTemplate session;
}
