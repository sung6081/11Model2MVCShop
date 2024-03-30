package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public PurchaseDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addPurchase(Purchase purchase) {
		// TODO Auto-generated method stub
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);

	}

	@Override
	public Purchase getPurchase(int tranNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PurchaseMapper.findPurchase", tranNo);
	}

	@Override
	public void updatePurchase(Purchase purchase) {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);

	}

	@Override
	public Map<String, Object> getPurchaseList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.listPurchase", map);
		
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setTranCode(list.get(i).getTranCode().trim());
		}
		
		int totalCount = sqlSession.selectOne("PurchaseMapper.countPurchaseAll", map);
		System.out.println("totalCount : "+totalCount);
		
		result.put("list", list);
		result.put("Integer", new Integer(totalCount));
		
		return result;
	}

	@Override
	public void updateTranCode(int tranNo) {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updateTranCode", tranNo);
	}

	@Override
	public void updateTranCodeByProdAction(int prodNo) {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updateTranCodeByProdAction", prodNo);
	}

}
