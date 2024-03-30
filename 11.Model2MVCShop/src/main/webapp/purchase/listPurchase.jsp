
<%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.service.domain.Purchase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>

<%--
HashMap<String, Object> map = (HashMap<String, Object>)request.getAttribute("map");
	ArrayList<Purchase> list = (ArrayList<Purchase>)map.get("list");
	int count = (Integer)map.get("Integer");
	Page p = (Page)request.getAttribute("resultPage");
	//int pageUnit = Integer.parseInt(request.getServletContext().getInitParameter("pageSize"));
--%>


<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	function fncGetUserList() {
		document.detailForm.submit();
	}
	
	$(function() {
		
		$($('.ct_list_b')[0]).css('color', 'red');
		$($('.ct_list_b')[1]).css('color', 'red');
		$($('.ct_list_b')[5]).css('color', 'red');
		
		$('.ct_list_pop:even').css('background-color', 'whitesmoke');
		$('.ct_list_pop:odd td.ct_line02').css('background-color', 'whitesmoke');
		
		$($('.ct_list_pop td.getpurchase_btn')).css('color', 'red');
		$($('.ct_list_pop td.getpurchase_btn')).on('click', function() {
			
			self.location = "/purchase/getPurchase?tranNo="+$(this).children().val();
			
		});
		
		$($('.ct_list_pop td.getprod_btn')).css('color', 'red');
		$($('.ct_list_pop td.getprod_btn')).on('click', function() {
			
			self.location = "/product/getProduct?prodNo="+$(this).children().val();
			
		});
		
		$($('.ct_list_pop td.updateortrancode_btn')).css('color', 'red');
		$($('.ct_list_pop td.updateortrancode_btn')).on('click', function() {
			
			//alert($(this).text());
			if($(this).text().trim() == '수정하기'){
				
				//alert($($(this).parent().children()[0]).text());
				self.location = "/purchase/updateTranCode?tranNo="+$($(this).parent().children()[0]).children().val();
				
			}
			
			if($(this).text().trim() == '물건도착'){
				
				alert($($(this).parent().children()[0]).text());
				self.location = "/purchase/updateTranCode?tranNo="+$($(this).parent().children()[0]).children().val();
				
			}
			
		});
		
	});
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000"> 

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/user/listUser" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체 ${map.Integer }<%-- count--%> 건수, 현재 ${resultPage.currentPage } 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No<br/><h7 >(click:상세정보)</h7></td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">물품명<br/><h7 >(click:구매물건정보)</h7></td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품이미지</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<x:set var="i" value="1" />
	<x:forEach var="purchase" items="${map.list }">
	<tr class="ct_list_pop">
		<td align="center" class="getpurchase_btn" >
			<!-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo }"> -->
				${i }
				<input type="hidden" name="tranNo" value="${purchase.tranNo }" >
		</td>
		<x:set var="i" value="${i + 1 }" />
		<td class="ct_line02"></td>
		
		<td align="center" class="getprod_btn" >
			<!-- <a href="/product/getProduct?prodNo=${purchase.purchaseProd.prodNo }"> -->
				${purchase.purchaseProd.prodName }
				<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo }" >
		</td>
		<td class="ct_line02"></td>
		<td align="center"><img src = "/images/uploadFiles/${purchase.purchaseProd.fileName }" width="50" height="50"/></td>
		<td class="ct_line02"></td>
		<td align="center">${purchase.receiverPhone }<%-- purchaseVO.getReceiverPhone() --%></td>
		<td class="ct_line02"></td>
		<td align="center">
		<%-- if(purchaseVO.getTranCode() != null && purchaseVO.getTranCode().trim().equals("0")) {--%>
		<x:choose>
		<x:when test="${!empty purchase.tranCode and purchase.tranCode eq '0' }">
		현재 구매완료 상태입니다.
		</x:when>
		<%-- } else if(purchaseVO.getTranCode() != null && purchaseVO.getTranCode().trim().equals("1")) {--%>
		<x:when test="${!empty purchase.tranCode and purchase.tranCode eq '1' }">
		현재 배송중 상태입니다
		</x:when>
		<%-- }else { --%>
		<x:otherwise>
		배송완료 상태입니다.
		</x:otherwise>
		<%-- } --%>
		</x:choose>
		</td>
		<td class="ct_line02"></td>
		<td align="center" class="updateortrancode_btn" >
		<%-- if(purchaseVO.getTranCode() != null && purchaseVO.getTranCode().trim().equals("1")) {--%>
		<x:choose>
		<x:when test="${!empty purchase.tranCode and purchase.tranCode eq '1' }">
			<!-- <a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}<%-- purchaseVO.getTranNo() --%>&tranCode=2">물건도착</a> -->
			물건도착
		</x:when>
		<%-- }else if(purchaseVO.getTranCode() != null && purchaseVO.getTranCode().trim().equals("2")) { --%>
		<%-- }else { --%>
		<x:when test="${!empty purchase.tranCode and purchase.tranCode eq '2' }">
			
		</x:when>
		<x:otherwise>
			<!-- <a href="/purchase/updatePurchaseView?tranNo=${purchase.tranNo }<%-- purchaseVO.getTranNo() --%>">수정하기</a> -->
			수정하기
		</x:otherwise>
		<%-- } --%>
		</x:choose>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<%-- } --%>
	</x:forEach>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		 <%-- int pageUnit = Integer.parseInt(request.getServletContext().getInitParameter("pageSize"));
		 int totalPage = count / pageUnit;
		 if(count % pageUnit != 0)
			 totalPage += 1;
		 
		 if(p.getBeginUnitPage() == 1){ --%>
		 <x:choose>
		 <x:when test="${resultPage.beginUnitPage == 1 }">
			 ◀ 이전
		</x:when>
		<%-- }else{  --%>
		<x:otherwise>
			 <a href="/purchase/listPurchase?page=${resultPage.beginUnitPage -1 }<%-- p.getBeginUnitPage() - 1 --%>">◀ 이전</a>
		</x:otherwise>
		</x:choose>
		<%-- }
		 
		 for(int i = p.getBeginUnitPage(); i <= p.getEndUnitPage(); i++) { --%>
		<x:forEach var="i" begin="${resultPage.beginUnitPage }" end="${resultPage.endUnitPage }" step="1">
			<a href="/purchase/listPurchase?page=${i }" id="btn${i }" >${i }<%-- i --%></a> 
		</x:forEach>
		<%-- } --%>
		
		<%-- if(p.getEndUnitPage() >= p.getMaxPage()) {--%>
		<x:choose>
		<x:when test="${resultPage.endUnitPage >= resultPage.maxPage }">
				이후 ▶
		</x:when>
		<%-- }else { --%>
		<x:otherwise>
				<a href="/purchase/listPurchase?page=${resultPage.endUnitPage + 1 }<%-- p.getEndUnitPage() + 1 --%>">이후 ▶</a>
		</x:otherwise>
		</x:choose>
		<%-- } --%>
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>