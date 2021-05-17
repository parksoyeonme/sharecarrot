package com.kh.sharecarrot.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/shop")
@SessionAttributes("loginMember")
public class ShopController {
	
	@RequestMapping(value="/enroll.do")
	public ModelAndView productReg() {
		ModelAndView mav = new ModelAndView("products/products");
		mav.addObject("tab","productEnroll");
		return mav;
	}
	
	@RequestMapping(value="/manage.do")
	public ModelAndView productManage() {
		ModelAndView mav = new ModelAndView("products/products");
		mav.addObject("tab","productManage");
		return mav;
	}
	
	@RequestMapping(value="/transactionHistory.do")
	public ModelAndView transactionHistory() {
		ModelAndView mav = new ModelAndView("products/products");
		mav.addObject("tab","transactionHistory");
		return mav;
	}
	
	
}