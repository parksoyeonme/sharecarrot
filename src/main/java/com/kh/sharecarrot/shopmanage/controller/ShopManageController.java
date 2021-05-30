package com.kh.sharecarrot.shopmanage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.output.CloseShieldOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.shopmanage.model.service.ShopManageService;
import com.kh.sharecarrot.utils.model.service.UtilsService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/shopmanage")
@SessionAttributes("loginMember")
public class ShopManageController {
	
	@Autowired
	private ShopManageService shopManageService;
	
	@Autowired
	private UtilsService utilsService;
	
	@RequestMapping(value="")
	public ModelAndView shopManage() {
		ModelAndView mav = new ModelAndView("shopManage/shopManageBase");
		mav.addObject("tab","productManage");
		return mav;
	}
	
	@RequestMapping(value="/enroll.do")
	public ModelAndView productReg() {
		ModelAndView mav = new ModelAndView("shopManage/shopManageBase");
		mav.addObject("tab","productEnroll");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/getCode.do")
	public ModelMap getCode(){
		ModelMap map = new ModelMap();
		map.addAttribute("category",utilsService.selectCategoryList());
		map.addAttribute("location",utilsService.selectLocationList());
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/productEnroll.do", method = RequestMethod.POST)
	public int productEnroll(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multi, Product product) {
		return shopManageService.productEnroll(request, response, product, multi.getFiles("productImage"));
	}
	
	@RequestMapping(value="/manage.do")
	public ModelAndView productManage() {
		ModelAndView mav = new ModelAndView("shopManage/shopManageBase");
		mav.addObject("tab","productManage");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/selectProductList.do")
	public List<Product> selectPoductList(Product product){
		return shopManageService.selectProductList(product);
	}
	
	@ResponseBody
	@RequestMapping(value="/updateProductYnh.do")
	public int updateProductYnh(Product product) {
		return shopManageService.updateProductYnh(product);
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteProduct.do")
	public int deleteProduct(Product product) {
		return shopManageService.deleteProduct(product);
	}
	
	@RequestMapping(value="/transactionHistory.do")
	public ModelAndView transactionHistory() {
		ModelAndView mav = new ModelAndView("shopManage/shopManageBase");
		mav.addObject("tab","transactionHistory");
		return mav;
	}

}
