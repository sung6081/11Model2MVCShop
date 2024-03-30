package com.model2.mvc.service.purchase.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}

	public PurchaseServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addPurchase(Purchase purchase) {
		// TODO Auto-generated method stub
		purchaseDao.addPurchase(purchase);

	}

	@Override
	public Purchase getPurchase(int tranNo) {
		// TODO Auto-generated method stub
		return purchaseDao.getPurchase(tranNo);
	}

	@Override
	public void updatePurchase(Purchase purchase) {
		// TODO Auto-generated method stub
		purchaseDao.updatePurchase(purchase);

	}

	@Override
	public Map<String, Object> getPurchaseList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return purchaseDao.getPurchaseList(map);
	}

	@Override
	public void updateTranCode(int tranNo) {
		// TODO Auto-generated method stub
		purchaseDao.updateTranCode(tranNo);

	}

	@Override
	public void updateTranCodeByProdAction(int prodNo) {
		// TODO Auto-generated method stub
		purchaseDao.updateTranCodeByProdAction(prodNo);

	}

}
