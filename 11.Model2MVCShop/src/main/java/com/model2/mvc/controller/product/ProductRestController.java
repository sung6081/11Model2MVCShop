package com.model2.mvc.controller.product;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Category;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@RestController
@RequestMapping("/app/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@RequestMapping("addPrdouctView")
	public List<Category> addProductView(HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("addProductView");
		
		List<Category> list = productService.getCategoryList();
		
		if(session.getAttribute("listCategory") == null)
			session.setAttribute("listCategory", list);
		
		System.out.println("addProductView");
		
		return list;
		
	}//end of addProductView

	@RequestMapping("addProduct")
	public Product addProductAction(@RequestBody Product product) throws Exception {
		
		System.out.println("addProductAction start");
		
		productService.addProduct(product);
		
		System.out.println("addProductAction end");
		
		return product;
		
	}//end of addProductAction
	
	@RequestMapping("getProduct/{prodNo}/{menu}")
	public Map getProductAction(@PathVariable("prodNo") int prodNo,
								@PathVariable("menu") String menu ) throws Exception {
		
		System.out.println("getProductAction start");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Product product = productService.getProduct(prodNo);
		
		map.put("product", product);
		map.put("menu", menu);
		
		System.out.println("getProductAction Realend");
		
		return map;
		
	}//end of getProductAction
	
	@RequestMapping(value="listProduct", method=RequestMethod.GET)
	public Map listProductAction(@RequestParam String menu) throws Exception {
		
		System.out.println("listProductAction start");
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setMenu(menu);
		search.setPageSize(pageSize);
		
		Map map = productService.getProductList(search);
		
		System.out.println("listProductAction end");
		
		return map;
		
	}//end of listProductAction
	
	@RequestMapping(value="listProduct", method=RequestMethod.POST)
	public Map listProductAction(@RequestBody Search search) throws Exception {
		
		System.out.println("listProductAction start");
		
		Map map = productService.getProductList(search);
		
		System.out.println("listProductAction end");
		
		return map;
		
	}//end of listProductAction
	
	@RequestMapping("updateProduct")
	public Product updateProductAction(@RequestBody Product product) throws Exception {
		
		System.out.println("updateProductAction start");
		
		productService.updateProduct(product);
		product = productService.getProduct(product.getProdNo());
		
		System.out.println("updateProductAction end");
		
		return product;
		
	}//end of updateProductAction
	
	@RequestMapping("updateProductView/{prodNo}")
	public Product updateProductViewAction(@PathVariable int prodNo) throws NumberFormatException, Exception {
		
		System.out.println("updateProductViewAction start");
		
		Product product = productService.getProduct(prodNo);
		
		System.out.println("updateProductViewAction end");
		
		return product;
		
	}//updateProductViewAction
	
	@RequestMapping(value="checkCategoryExist/{cateName}", method=RequestMethod.GET)
	public Boolean checkCategoryExist(@PathVariable String cateName) throws Exception {
		
		System.out.println("checkCategoryExist start");
		
		List<Category> list = productService.getCategoryList();
		
		for(Category cate : list) {
			
			if(cate.getCateName().equals(cateName)) {
				return new Boolean(false);
			}
			
		}
		
		System.out.println("checkCategoryExist end");
		
		return new Boolean(true);
	}//end of checkCategoryExist
	
}//end of ProductController












