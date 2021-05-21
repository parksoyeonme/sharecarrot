package com.kh.sharecarrot.main.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.main.model.dao.MainDao;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainDao mainDao;
}
