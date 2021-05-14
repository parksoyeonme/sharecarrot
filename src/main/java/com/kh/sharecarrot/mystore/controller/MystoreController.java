package com.kh.sharecarrot.mystore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.sharecarrot.mystore.model.service.MystoreService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mystore")
public class MystoreController {

	@Autowired
	private MystoreService mystoreService;
	
	
	@GetMapping("/mystore.do")
	public void mystore() {
	}
}
