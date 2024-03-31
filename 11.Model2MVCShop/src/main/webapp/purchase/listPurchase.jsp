
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
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
            margin-top: 100px;
        }
    </style>
<script type="text/javascript">

	function fncGetUserList() {
		document.detailForm.submit();
	}
	
	$(function() {
		
		$($('.ct_list_b')[0]).css('color', 'red');
		$($('.ct_list_b')[1]).css('color', 'red');
		$($('.ct_list_b')[5]).css('color', 'red');
		
		//$('.ct_list_pop:even').css('background-color', 'whitesmoke');
		//$('.ct_list_pop:odd td.ct_line02').css('background-color', 'whitesmoke');
		
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
			if($(this).text().trim() == '�����ϱ�'){
				
				//alert($($(this).parent().children()[0]).text());
				self.location = "/purchase/updatePurchaseView?tranNo="+$($(this).parent().children()[0]).children().val();
				
			}
			
			if($(this).text().trim() == '���ǵ���'){
				
				alert($($(this).parent().children()[0]).children().val());
				self.location = "/purchase/updateTranCode?tranNo="+$($(this).parent().children()[0]).children().val();
				
			}
			
		});
		
		//���� ������ �� ����������
		//alert($('a.movePage_btn').text());
		for(var i = ${resultPage.beginUnitPage}; i <= ${resultPage.endUnitPage}; i++ ) {
			if($('a#btn'+i).text() == ${resultPage.currentPage}) {
				$('a#btn'+i).css('color', 'red');
			}
		}
		
	});
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000"> 

<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/navigationBar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

<div class="container" style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/user/listUser" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table class="table">
	<tr>
		<td colspan="11">��ü ${map.Integer }<%-- count--%> �Ǽ�, ���� ${resultPage.currentPage } ������</td>
	</tr>
	<tr class="success">
		<td class="ct_list_b" width="100">No<br/><h7 >(click:������)</h7></td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��<br/><h7 >(click:���Ź�������)</h7></td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ�̹���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
		<td class="ct_line02"></td>
	</tr>
	<!-- <tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr> -->
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
		���� ���ſϷ� �����Դϴ�.
		</x:when>
		<%-- } else if(purchaseVO.getTranCode() != null && purchaseVO.getTranCode().trim().equals("1")) {--%>
		<x:when test="${!empty purchase.tranCode and purchase.tranCode eq '1' }">
		���� ����� �����Դϴ�
		</x:when>
		<%-- }else { --%>
		<x:otherwise>
		��ۿϷ� �����Դϴ�.
		</x:otherwise>
		<%-- } --%>
		</x:choose>
		</td>
		<td class="ct_line02"></td>
		<td align="center" class="updateortrancode_btn" >
		<%-- if(purchaseVO.getTranCode() != null && purchaseVO.getTranCode().trim().equals("1")) {--%>
		<x:choose>
		<x:when test="${!empty purchase.tranCode and purchase.tranCode eq '1' }">
			<!-- <a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}<%-- purchaseVO.getTranNo() --%>&tranCode=2">���ǵ���</a> -->
			���ǵ���
			<input type="hidden" name="tranNo" value="${purchase.tranNo }">
		</x:when>
		<%-- }else if(purchaseVO.getTranCode() != null && purchaseVO.getTranCode().trim().equals("2")) { --%>
		<%-- }else { --%>
		<x:when test="${!empty purchase.tranCode and purchase.tranCode eq '2' }">
			
		</x:when>
		<x:otherwise>
			<!-- <a href="/purchase/updatePurchaseView?tranNo=${purchase.tranNo }<%-- purchaseVO.getTranNo() --%>">�����ϱ�</a> -->
			�����ϱ�
		</x:otherwise>
		<%-- } --%>
		</x:choose>
		</td>
	</tr>
	<!-- <tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr> -->
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
			 �� ����
		</x:when>
		<%-- }else{  --%>
		<x:otherwise>
			 <a href="/purchase/listPurchase?page=${resultPage.beginUnitPage -1 }<%-- p.getBeginUnitPage() - 1 --%>">�� ����</a>
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
				���� ��
		</x:when>
		<%-- }else { --%>
		<x:otherwise>
				<a href="/purchase/listPurchase?page=${resultPage.endUnitPage + 1 }<%-- p.getEndUnitPage() + 1 --%>">���� ��</a>
		</x:otherwise>
		</x:choose>
		<%-- } --%>
		</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>