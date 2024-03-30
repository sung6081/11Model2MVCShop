package com.model2.mvc.controller.product;

import java.io.File;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Category;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@RequestMapping("addPrdouctView")
	public ModelAndView addProductView(HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("addProductView");
		
		ModelAndView modelAndView = new ModelAndView("/product/addProductView.jsp");
		
		if(session.getAttribute("listCategory") == null)
			session.setAttribute("listCategory", productService.getCategoryList());
		
		System.out.println("addProductView");
		
		return modelAndView;
		
	}//end of addProductView

	@RequestMapping("addProduct")
	public ModelAndView addProductAction(HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("addProductAction start");
		
		ModelAndView modelAndView = new ModelAndView("/product/addProduct.jsp");
		
		String filePath=request.getServletContext().getRealPath("/images/uploadFiles");
		int maxFileSize = 1024*1024*4;
		String entype = "euc-kr";
		
		MultipartRequest multipartRequest = new MultipartRequest(request,filePath, maxFileSize, entype,  new DefaultFileRenamePolicy());
		
		File file = multipartRequest.getFile("fileName");
		
		Product product = new Product();
		product.setProdName(multipartRequest.getParameter("prodName"));
		product.setProdDetail(multipartRequest.getParameter("prodDetail"));
		product.setManuDate(multipartRequest.getParameter("manuDate").replaceAll("-", ""));
		product.setPrice(Integer.parseInt(multipartRequest.getParameter("price")));
		if(multipartRequest.getOriginalFileName("fileName") != null)
			product.setFileName(multipartRequest.getOriginalFileName("fileName"));
		else
			product.setFileName("no_image.png");
		if(multipartRequest.getParameter("category") != null && multipartRequest.getParameter("category").split("&").length == 2) {
			product.setCateNo(multipartRequest.getParameter("category").split("&")[0]);
			product.setCateName(multipartRequest.getParameter("category").split("&")[1]);
		}
		System.out.println(multipartRequest.getFilesystemName("fileName"));
		
		productService.addProduct(product);
		modelAndView.addObject("product", product);
		
		System.out.println("addProductAction end");
		
		return modelAndView;
		
	}//end of addProductAction
	
	@RequestMapping("getProduct")
	public ModelAndView getProductAction(HttpSession session, HttpServletRequest request,
										HttpServletResponse response) throws Exception {
		
		System.out.println("getProductAction start");
		
		ModelAndView modelAndView = new ModelAndView("redirect:/user/loginView.jsp");
		
		if(session.getAttribute("user") == null) {
			System.out.println("getProductAction end");
			return modelAndView;
		}
		
		if( request.getParameter("menu") != null && request.getParameter("menu").equals("manage")) {
			modelAndView.setViewName("/product/updateProductView");
			System.out.println("getProductAction end");
			return modelAndView;
		}
		
		Product product = productService.getProduct(Integer.parseInt(request.getParameter("prodNo")));
		product.setProdNo(Integer.parseInt(request.getParameter("prodNo")));
		
		modelAndView.addObject("product", product);
		
		if(request.getParameter("menu") != null && request.getParameter("menu").equals("update")) {
			modelAndView.setViewName("/product/updateProduct.jsp");
			System.out.println("getProductAction end");
			return modelAndView;
		}
		
		Cookie[] cookies = request.getCookies();
		
		String record = "";
		Cookie cookie = null;
		
		for(int i = 0; i < cookies.length; i++) {
			
			if(cookies[i].getName().equals("history")) {
				cookie= cookies[i];
				break;
			}
			
		}
		
		if(cookie != null) {
			String[] history = cookie.getValue().split("and");
			
			for(int i = 0; i < history.length; i++) {
				if(!history[i].equals(""+product.getProdNo()))
					if(i == 0)
						record += history[i];
					else
						record += "and"+history[i];
			}
			if(!record.equals(""))
				record += "and"+product.getProdNo();
			else
				record += product.getProdNo();
			
			cookie.setValue(record);
			
		}else {
			cookie = new Cookie("history", new Integer(product.getProdNo()).toString());
		}
		
		System.out.println("cookie : "+cookie.getName());
		System.out.println("cookie : "+cookie.getValue());
		System.out.println("cookie : "+cookies.length);
		
		//cookie.setMaxAge(3600);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		if(request.getParameter("menu") == null) {
			modelAndView.setViewName("/product/readProduct.jsp");
			System.out.println("getProductAction end");
			return modelAndView;
		}
		
		modelAndView.setViewName("/product/getProduct.jsp");
		
		System.out.println(response.toString());
		
		System.out.println("getProductAction Realend");
		
		return modelAndView;
		
	}//end of getProductAction
	
	@RequestMapping("listProduct")
	public ModelAndView listProductAction(HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("listProductAction start");
		
		ModelAndView modelAndView = new ModelAndView("/product/listProduct.jsp");
		
		Search searchVO = new Search();
		Category category = new Category();
		
		if(request.getParameter("category") != null) {
			searchVO.setCateNo(Integer.parseInt(request.getParameter("category")));
		}
		
		System.out.println("controller search : "+searchVO);
		
		int page = 1;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
			
		searchVO.setCurrentPage(page);
		searchVO.setSearchCondition(request.getParameter("searchCondition"));
		searchVO.setSearchKeyword(request.getParameter("searchKeyword"));
		if(request.getParameter("low") != null && request.getParameter("low") != "")
			searchVO.setPriceOption("low");
		else if(request.getParameter("high") != null && request.getParameter("high") != "")
			searchVO.setPriceOption("high");
		searchVO.setMenu(request.getParameter("menu"));
		searchVO.setSearchRange(request.getParameter("searchRange"));
			
		searchVO.setPageSize(Integer.parseInt(request.getServletContext().getInitParameter("pageSize")));
			
		Map<String, Object> map = productService.getProductList(searchVO);
		System.out.println("getList over");
		
		int pageSize = Integer.parseInt( request.getServletContext().getInitParameter("pageSize"));
		int pageUnit  =  Integer.parseInt(request.getServletContext().getInitParameter("pageUnit"));
		
		Page resultPage	= new Page( page, ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
			
		modelAndView.addObject("map", map);
		modelAndView.addObject("searchVO", searchVO);
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("list", map.get("list"));
		//modelAndView.addObject("listCategory", map.get("listCategory"));
		session.setAttribute("listCategory", map.get("listCategory"));
		request.setAttribute("where", "Product");
		modelAndView.addObject("where", "Product");
		
		System.out.println("listProductAction end");
		
		return modelAndView;
		
	}//end of listProductAction
	
	@RequestMapping("updateProduct")
	public ModelAndView updateProductAction(HttpServletRequest request) throws Exception {
		
		System.out.println("updateProductAction start");
		
		ModelAndView modelAndView = new ModelAndView();
		
		String filePath=request.getServletContext().getRealPath("/images/uploadFiles");
		System.out.println(filePath);
		int maxFileSize = 1024*1024*4;
		String entype = "euc-kr";
		
		MultipartRequest multipartRequest = new MultipartRequest(request,filePath, maxFileSize, entype,  new DefaultFileRenamePolicy());
		
		
		Product product = new Product();
		//System.out.println(product);
		
		product.setProdNo(Integer.parseInt(multipartRequest.getParameter("prodNo")));
		product.setProdName(multipartRequest.getParameter("prodName"));
		product.setProdDetail(multipartRequest.getParameter("prodDetail"));
		product.setManuDate(multipartRequest.getParameter("manuDate"));
		product.setPrice(Integer.parseInt(multipartRequest.getParameter("price")));
		product.setCateNo(multipartRequest.getParameter("category").split("&")[0]);
		product.setCateName(multipartRequest.getParameter("category").split("&")[1]);
		if(multipartRequest.getOriginalFileName("fileName") != null) {
			product.setFileName(multipartRequest.getOriginalFileName("fileName"));
		}
		
		productService.updateProduct(product);
		
		modelAndView.setViewName("/product/getProduct?prodNo="+product.getProdNo()+"&menu=update");
		
		System.out.println("updateProductAction end");
		
		return modelAndView;
		
	}//end of updateProductAction
	
	@RequestMapping("updateProductView")
	public ModelAndView updateProductViewAction(HttpServletRequest request) throws NumberFormatException, Exception {
		
		System.out.println("updateProductViewAction start");
		
		ModelAndView modelAndView = new ModelAndView();
		
		Product product = productService.getProduct(Integer.parseInt(request.getParameter("prodNo")));
		
		request.setAttribute("product", product);
		
		System.out.println(product);
		modelAndView.setViewName("/product/updateProductView.jsp");
		
		System.out.println("updateProductViewAction end");
		
		return modelAndView;
		
	}//updateProductViewAction
	
	@RequestMapping("addCategory")
	public ModelAndView addCategory(@RequestParam("addCategory") String cateName, HttpSession session) throws Exception {
		
		System.out.println("addCategory start");
		
		ModelAndView modelAndView = new ModelAndView("/product/listProduct?memu=manage");
		
		//List<Category> list = (List)session.getAttribute("listCategory");
		
		/*
		 * for(Category cate : list) { if(cate.getCateName().equals(cateName)) {
		 * System.out.println("already exist");
		 * modelAndView.addObject("duplicationCate", new Boolean(true));
		 * System.out.println("addCategory end");
		 * 
		 * return modelAndView; } }
		 */
		
		productService.addCategory(cateName);
		
		System.out.println("addCategory end");
		
		return modelAndView;
		
	}//end of addCategory
	
	@RequestMapping("removeCategory")
	public ModelAndView removeCategory(@RequestParam("rmCategory") int cateNo) throws Exception {
		
		System.out.println("removeCategory start");
		
		ModelAndView modelAndView = new ModelAndView("/product/listProduct.do?memu=manage");
		
		productService.updateProdCategoryNull(cateNo);
		
		productService.removeCategory(cateNo);
		
		System.out.println("removeCategory end");
		
		return modelAndView;
		
	}//end of removeCategory
	
}//end of ProductController












