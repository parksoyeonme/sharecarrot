package com.kh.sharecarrot.shopmanage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

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
	
	@RequestMapping(value="/shopManageBase.do", method = RequestMethod.GET)
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
	@RequestMapping(value="/selectProductInfo.do")
	public ModelMap selectProduct(Product product) {
		ModelMap map = new ModelMap();
		map.addAttribute("product", shopManageService.selectProduct(product));
		map.addAttribute("image", shopManageService.selectProductImageList(product));
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/selectProductList.do")
	public ModelMap selectProductList(Product product){
		System.out.println(product.toString());
		
		ModelMap map = new ModelMap();
		map.addAttribute("paging", shopManageService.getProductListPaging(product));
		map.addAttribute("productList", shopManageService.selectProductList(product));
		return map;
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
	
	@ResponseBody
	@RequestMapping(value="/updateProduct.do", method = RequestMethod.POST)
	public int updateProduct(@RequestBody Product product) {
		return shopManageService.updateProduct(product);
	}
	
	@ResponseBody
	@RequestMapping(value="/updateProductNewImage.do", method = RequestMethod.POST)
	public int updateProductNewImage(HttpServletRequest request
							, MultipartHttpServletRequest multi
							, Product product) {
		
		return shopManageService.updateProductNewImage(request, product, multi.getFiles("productImage"));
	}
	
	@ResponseBody
	@RequestMapping(value="/selectTransactionList.do")
	public ModelMap selectTransactionList(Product product){
		ModelMap map = new ModelMap();
		map.addAttribute("transactionList", shopManageService.selectTransactionList(product));
		map.addAttribute("paging", shopManageService.getTransactionListPaging(product));
		return map;
	}

}
