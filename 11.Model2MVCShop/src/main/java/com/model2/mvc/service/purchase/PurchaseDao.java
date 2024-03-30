package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

	public void addPurchase(Purchase purchase);
	
	public Purchase getPurchase(int tranNo);
	
	public void updatePurchase(Purchase purchase);
	
	public Map<String, Object> getPurchaseList(Map<String, Object> map);
	
	public void updateTranCode(int tranNo);
	
	public void updateTranCodeByProdAction(int prodNo);
	
}
