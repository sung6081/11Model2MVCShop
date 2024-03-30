package com.model2.mvc.service.product.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Category;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

//import mybatis.service.user.test.SqlSessionFactoryBean;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public ProductDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("ProductMapper.addProduct", product);

	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return (Product)sqlSession.selectOne("ProductMapper.findProduct", prodNo);
	}

	@Override
	public List<Product> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ProductMapper.getPageProductListWithSearch", search);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("ProductMapper.updateProudct", product);
		
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProductMapper.selectProductTotalCount", search);
	}

	@Override
	public void addCategory(String cateName) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("CategoryMapper.addCategory", cateName);
	}

	@Override
	public List<Category> getCategoryList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CategoryMapper.listCategory");
	}

	@Override
	public void removeCategory(int cateNo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("CategoryMapper.removeCategory", cateNo);
	}

	@Override
	public void updateProdCategoryNull(int cateNo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("ProductMapper.updateProdCategoryNull", cateNo);
	}

}
