package com.kh.sharecarrot.mystore.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.mystore.model.dao.MystoreDao;

@Service
public class MystoreServiceImpl implements MystoreService {

	@Autowired
	private MystoreDao mystoreDao;
}
