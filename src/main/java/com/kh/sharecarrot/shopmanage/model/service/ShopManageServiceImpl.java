package com.kh.sharecarrot.shopmanage.model.service;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;
import com.kh.sharecarrot.shop.model.vo.Shop;
import com.kh.sharecarrot.shopmanage.model.dao.ShopManageDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ShopManageServiceImpl implements ShopManageService{
	
	@Autowired
	private ShopManageDao shopManageDao; 

	@Override
	public int productEnroll(HttpServletRequest request, HttpServletResponse response, Product product,
			List<MultipartFile> list) {
		String productId = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
		product.setProductId(productId);
		
		//테스트 shopId
		product.setShopId(getShopInfo().getShopId());
		
		//상품정보 저장
		int rtn = shopManageDao.productEnroll(product);
		if(rtn <= 0) {
			log.error("상품등록오류");
			return 0;
		}
		
		//이미지 업로드 패스 지정
		String path = request.getServletContext().getRealPath("/resources/upload/product/");
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		//이미지 업로드
		for(MultipartFile file:list) {
			String fileName = file.getOriginalFilename();
			String newName = product.getProductId() + "_" + UUID.randomUUID().toString();
			String ext = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
			File imgfile = new File(path + newName + ext);
			
			try {
				file.transferTo(imgfile);
				
				ProductImage imgInfo = new ProductImage();
				imgInfo.setProductId(product.getProductId());
				imgInfo.setProductImgOrigin(fileName);
				imgInfo.setProductImgRenamed(newName + ext);

				int imgRtn = shopManageDao.productImageEnroll(imgInfo);
				if(imgRtn <= 0 ) {
					log.error("이미지 업로드 오류");
					return 0;
				}
			} catch (Exception e) {
				log.error("이미지 저장오류", e);
				e.printStackTrace();
				return 0;
			}
		}
		
		return rtn;
	}

	@Override
	public List<Product> selectProductList(Product product) {
		//샵 조회
		Shop shop = getShopInfo();
		//샵아이디 검색조건
		product.setShopId(shop.getShopId());
		
		//상품리스트
		List<Product> productList = shopManageDao.selectProductList(product);
		
		//이미지 리스트
		for(Product p:productList) {
			p.setProductImageList(shopManageDao.selectProductImageList(p));
		}
		
		return productList;
	}
	
	@Override
	public int updateProductYnh(Product product) {
		return shopManageDao.updateProductYnh(product);
	}
	
	//샵정보
	public Shop getShopInfo() {
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		log.info("member : " +member);
		String memberId = member.getMemberId();
		
		return shopManageDao.selectShopInfo(memberId);
	}

	@Override
	public int deleteProduct(Product product) {
		return shopManageDao.deleteProduct(product);
	}

	

}
