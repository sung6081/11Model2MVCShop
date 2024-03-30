package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Category;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	public ProductServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		productDao.addProduct(product);

	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return productDao.getProduct(prodNo);
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<Product> list = productDao.getProductList(search);
		List<Category> listCategory = productDao.getCategoryList();
		
		System.out.println("dao categoryList : "+listCategory);
		
		for(int i = 0; i < list.size(); i++) {
			if(list.get(i).getProTranCode() != null)
				list.get(i).setProTranCode(list.get(i).getProTranCode().trim());
		}
		
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("listCategory", listCategory);
		map.put("totalCount", new Integer(totalCount));
		System.out.println("totalCount in service : "+totalCount);
		
		return map;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		productDao.updateProduct(product);

	}

	@Override
	public void addCategory(String cateName) throws Exception {
		// TODO Auto-generated method stub
		productDao.addCategory(cateName);
	}
	
	@Override
	public List<Category> getCategoryList() throws Exception {
		// TODO Auto-generated method stub
		return productDao.getCategoryList();
	}

	@Override
	public void removeCategory(int cateNo) throws Exception {
		// TODO Auto-generated method stub
		productDao.removeCategory(cateNo);
	}

	@Override
	public void updateProdCategoryNull(int cateNo) throws Exception {
		// TODO Auto-generated method stub
		productDao.updateProdCategoryNull(cateNo);
	}

}
