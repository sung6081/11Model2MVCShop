<!-- 상품목록조회 -->

<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.model2.mvc.common.Page"%>
<%@page import="java.util.Map"%>
<%@page import="com.model2.mvc.service.domain.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.model2.mvc.common.Search"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%--
 	Map<String, Object> map = (HashMap<String, Object>)request.getAttribute("map");
 	List<Product> list = (List)(map.get("list"));
 	Search searchVO = (Search)request.getAttribute("searchVO");
 	String menu = request.getParameter("menu");
 	System.out.println("menu : " + menu);
 	Page p = (Page)request.getAttribute("resultPage");
 	System.out.println("jsp : "+p);
--%>

<html>
<head>
						

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<!-- 참조 : http://getbootstrap.com/css/   -->
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
function fncGetProductList(currentPage, menu) {
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage);
   	document.detailForm.submit();		
}

function fncGetProductListLow(currentPage){
	
	//console.log(1);
	document.getElementById("currentPage").value = currentPage;
	//$("#currentPage").val(currentPage);
	if(document.getElementById("priceOptionLow").value != null && document.getElementById("priceOptionLow").value != ''){
		document.getElementById("priceOptionLow").value = '';
		//$('#priceOptionLow').val('');
	}else {
		document.getElementById("priceOptionHigh").value = '';
		//$('#priceOptionHigh').val('');
		document.getElementById("priceOptionLow").value = 'high';
		//$('#priceOptionLow').val('high');
	}
	document.detailForm.submit();	
	//$('form').submit();
}

function fncGetProductListHigh(currentPage){
	console.log(2);
	document.getElementById("currentPage").value = currentPage;
	//$('#currentPage').val(currentPage);
	if(document.getElementById("priceOptionHigh").value != null && document.getElementById("priceOptionHigh").value != ''){
		document.getElementById("priceOptionHigh").value = '';
		//$('#priceOptionHigh').val('');
	}else {
		document.getElementById("priceOptionLow").value = '';
		//$('#priceOptionLow').val('');
		document.getElementById("priceOptionHigh").value = 'high';
		//$('#priceOptionHigh').val('high');
	}
	document.detailForm.submit();
	//$('form').submit();
}

function fncChangeSearchCondition(currentPage){
	document.getElementById("currentPage").value = currentPage;
	//$('#currentPage').val(currentPage);
   	document.detailForm.submit();
}
function fncaddCategory() {
	popWin 
		= window.open("/product/addCategory.jsp","popWin", "left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
}
function fncremoveCategory() {
	popWin 
		= window.open("/product/removeCategory.jsp","popWin", "left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
}
function alertFalse() {
	alert("이미 있는 카테고리입니다.");
}

$(function() {
	
	//alert($($('tr.ct_list_pop td')[2]));
	$('tr.ct_list_pop td.getProdNo_btn').on('click', function() {
		
		//alert($(this).children().val());
		self.location = "/product/getProduct?prodNo="+$(this).children().val()+"&menu=${param.menu }";
		
	});
	
	$('#searchCondition').on('change', function() {
		
		if($(this).val() == "2"){
		
			//alert($('input[name="searchCondition"]').html());
			$('input.ct_input_g').remove();
			$('.search_btn').remove();
			
			var append = '<select id="searchRange" name="searchRange" class="ct_input_g" style="width:200px" onChange="fncGetProductList(${resultPage.currentPage})">'
			+'<option value="0" ${searchVO.searchRange eq "0" ? "selected" : ""}>공짜</option>'
			+'<option value="1" ${searchVO.searchRange eq "1" ? "selected" : ""}>1원~10,000원</option>'
			+'<option value="2" ${searchVO.searchRange eq "2" ? "selected" : ""}>10,001원~100,000원</option>'
			+'<option value="3" ${searchVO.searchRange eq "3" ? "selected" : ""}>100,001원~1,000,000원</option>'
			+'<option value="4" ${searchVO.searchRange eq '4' ? "selected" : ""}>백만원~</option>'
		+'</select>';
			
			//alert(append);
			$(this).parent().append(append);
			
		}else{
			
			var append = '<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px"/>';
			var append2 = '<td align="right" width="70" class="search_btn" >'
				+'<table border="0" cellspacing="0" cellpadding="0">'
				+'<tr>'
				+'<td width="17" height="23">'
				+'<img src="/images/ct_btnbg01.gif" width="17" height="23">'
				+'</td>'
				+'<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">'
				+'<a href="javascript:fncGetProductList(1);">검색</a>'
				+'</td>'
				+'<td width="14" height="23">'
				+'<img src="/images/ct_btnbg03.gif" width="14" height="23">'
				+'</td>'
				+'</tr>'
				+'</table>'
				+'</td>';
			//alert(append);
			//alert(append2);
			
			$('input.ct_input_g').remove();
			$('.search_btn').remove();
			$('#searchRange').remove();
			$(this).parent().append(append);
			$(this).parent().parent().append(append2);
			
		}
		
	});
	
	$('tr.ct_list_pop td.getProdNo_btn').css('color', 'red');
	
	//alert($('tr.ct_list_pop td.getProdNo_btn').parent(':nth-child(even)').html());
	$('tr.ct_list_pop td.getProdNo_btn').parent(':nth-child(4n+2)').css('background-color', 'whitesmoke');
	$('tr.ct_list_pop td.getProdNo_btn').parent(':nth-child(4n)').children('td.ct_line02').css('background-color', 'whitesmoke');
	
	$($('tr td.ct_list_b')[1]).css('color', 'red');
	
	//alert($('a.movePage_btn').text());
	for(var i = ${resultPage.beginUnitPage}; i <= ${resultPage.endUnitPage}; i++ ) {
		if($('a.movePage_btn#btn'+i).text() == ${resultPage.currentPage}) {
			$('a.movePage_btn#btn'+i).css('color', 'red');
		}
	}
});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/navigationBar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

<div class="container" style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${param.menu }" method="post">

<f:if test="${!empty duplicationCate }">
	<script type="text/javascript">
		alert("이미 있는 카테고리입니다.");
	</script>
</f:if>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
							<%--if(menu.equals("manage")) { --%>
							${param.menu eq 'manage' ? "상품 관리" : "상품 목록조회" }
							<%--} --%>
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<input type="hidden" id="rmCategory" name="rmCategory" value="0" >
<input type="hidden" id="addCategory" name="addCategory" >

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="left">카테고리
			<select id="cateGoryList" name="category" class="ct_input_g" style="width:120px" onchange="fncGetProductList(${resultPage.currentPage})" > 
				<option value="0" ></option>
				<f:forEach var="item" items="${listCategory }">
					<option value="${item.cateNo }" ${searchVO.cateNo eq item.cateNo ? 'selected' : '' } >
						${item.cateName }
					</option>
				</f:forEach>
			</select>
			<f:if test="${param.menu eq 'manage' }">
			<a href="javascript:fncaddCategory();" id="addCate_btn">추가</a>
			</select>
			<a href="javascript:fncremoveCategory();" id="removeCate_btn">삭제</a>
			</select>
		
		</f:if>
		</td>
		
		<td align="right">
			<select id="searchCondition" name="searchCondition" class="ct_input_g" style="width:80px"> <!--  onChange="fncChangeSearchCondition(${resultPage.currentPage})" --> 
			
			<%-- if(searchVO.getSearchCondition() != null) { --%>
				<f:if test="${!empty searchVO.searchCondition }">
				<option value="0" ${searchVO.searchCondition eq "0" ? 'selected' : '' } >상품번호</option>
				<option value="1" ${searchVO.searchCondition eq "1" ? 'selected' : '' } >상품명</option>
				<option value="2" ${searchVO.searchCondition eq "2" ? 'selected' : '' } >상품가격</option>
				</f:if>
			<%-- }else { --%>
			<f:if test="${empty searchVO.searchCondition }">
				<option value="0" >상품번호</option>
				<option value="1" >상품명</option>
				<option value="2" >상품가격</option>
			</f:if>
			</select>
			<%-- } --%>
			
			<f:choose>
			<%-- if(searchVO.getSearchKeyword() != null) {--%>	
			
			<f:when test="${!empty searchVO.searchCondition and searchVO.searchCondition eq '2'}">
				<select id="searchRange" name="searchRange" class="ct_input_g" style="width:200px" onChange="fncGetProductList(${resultPage.currentPage})">
					<option value="0" ${searchVO.searchRange eq '0' ? 'selected' : ''}>공짜</option>
					<option value="1" ${searchVO.searchRange eq '1' ? 'selected' : ''}>1원~10,000원</option>
					<option value="2" ${searchVO.searchRange eq '2' ? 'selected' : ''}>10,001원~100,000원</option>
					<option value="3" ${searchVO.searchRange eq '3' ? 'selected' : ''}>100,001원~1,000,000원</option>
					<option value="4" ${searchVO.searchRange eq '4' ? 'selected' : ''}>백만원~</option>
				</select>
			</f:when>
																			<%-- <%=searchVO.getSearchKeyword() %> --%>
			<f:when test="${!empty searchVO.searchKeyword }">
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" value=${searchVO.searchKeyword } />
			</f:when>
			<f:otherwise>
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px"  />
			</f:otherwise>
			</f:choose>
		</td>
		
		<f:if test="${searchVO.searchCondition != '2' }">
		<td align="right" width="70" class="search_btn" >
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
				
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList(1);">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				
				</tr>
			</table>
		</td>
		</f:if>
	</tr>
</table>

&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<input type="checkBox" id="priceOptionLow" name="low" value="${searchVO.priceOption eq 'low' ? 'low' : '' }" onClick="fncGetProductListLow(1)" ${!empty searchVO.priceOption and searchVO.priceOption eq 'low' ? 'checked' : '' } >가격 낮은 순
<input type="checkBox" id="priceOptionHigh" name="high" value="${searchVO.priceOption eq 'high' ? 'low' : '' }" onClick="fncGetProductListHigh(1)" ${!empty searchVO.priceOption and searchVO.priceOption eq 'high' ? 'checked' : '' } >가격 높은 순


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${map.totalCount }<%-- map.get("count") --%> 건수, 현재 ${searchVO.currentPage }<%-- searchVO.getCurrentPage() --%> 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명<br/>
		<f:if test="${param.menu eq 'search' }">
			<h7 >(click:상세정보, 구매)</h7>
		</f:if>
		<f:if test="${param.menu eq 'manage' }">
			<h7 >(click:상세정보, 수정)</h7>
		</f:if>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품이미지</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%-- for(int i = 0; i < list.size(); i++) {
			Product productVO = list.get(i);
	--%>
	<f:set var="i" value="1" />
	<f:forEach var ="product" items="${list }">
	<tr class="ct_list_pop">
		<td align="center">${i }<%-- list.size() - i --%></td>
		<f:set var="i" value="${i + 1 }" />
		<td class="ct_line02"></td>
			<f:if test="${empty product.proTranCode }">
				<td align="center" class="getProdNo_btn">
					<!-- <a href="/product/getProduct?prodNo=${product.prodNo }&menu=${param.menu }"/> -->
						${product.prodName }
						<input type="hidden" name="prodNo" value="${product.prodNo }" >
				</td>
			</f:if>
			<f:if test="${!empty product.proTranCode }">
				<td align="center" class="getProdNo_btn">
					${product.prodName }
					<input type="hidden" name="prodNo" value="${product.prodNo }" >
				</td>
			</f:if>
		<td class="ct_line02"></td>
		<td align="center"><img src = "/images/uploadFiles/${product.fileName }" width="50" height="50"/></td>
		<td class="ct_line02"></td>
		<td align="center">${product.price }<%-- productVO.getPrice() --%></td>
		<td class="ct_line02"></td>
		<td align="center">${product.regDate }<%-- productVO.getRegDate() --%></td>
		<td class="ct_line02"></td>
		<td align="center">
		<%-- if(product.getProTranCode() == null){ --%>
		<f:if test="${empty product.proTranCode }">
			판매중
		</f:if>
		<%-- }else if(product.getProTranCode().trim().equals("0") && userVO.getRole().equals("admin"))  { --%>
		<f:if test="${!empty product.proTranCode }">
		<f:choose>
		<f:when test="${user.role eq 'admin' }">
		<f:if test="${product.proTranCode eq '0' }">
			구매완료
		
			<%-- if(request.getParameter("menu").equals("manage")) { --%>
			<f:if test="${param.menu eq 'manage' }">
					<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo }&tranCode=1">배송하기</a>
			</f:if>
			<%-- } --%>
		</f:if>
		<%-- }else if(product.getProTranCode().trim().equals("1") && userVO.getRole().equals("admin")){ --%>
		<f:if test="${product.proTranCode eq '1' }">
			배송중
		</f:if>
		<%-- }else if(productVO.getProTranCode().trim().equals("2") && userVO.getRole().equals("admin")){ --%>
		<f:if test="${product.proTranCode eq '2' }">
			배송완료
		</f:if>
		</f:when>
		<%-- }else { --%>
		<f:otherwise>
			재고없음
		</f:otherwise>
		<%-- } --%>
		</f:choose>
		</f:if>
		</td>	
		</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
		</f:forEach>
		
	<%-- } --%>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name="page" value="${resultPage.currentPage }"/>
		<input type="hidden" id="menu" name="menu" value=""/>
		<%--
			System.out.println(p.getPageSize());
			int cnt = (int)(map.get("totalCount")) / p.getPageSize();
			if((int)(map.get("totalCount")) % p.getPageSize() != 0)
				cnt += 1;
			int left = p.getBeginUnitPage();
			int right = p.getEndUnitPage();
			if(left == 1){--%>
			<f:choose>
			<f:when test ="${resultPage.beginUnitPage == 1 }">
				◀ 이전
			</f:when>
			<%--}else {
			if(searchVO.getSearchCondition() != null && searchVO.getSearchKeyword() != null) {--%>
			<f:otherwise>
			<f:if test="${ !empty searchVO.searchCondition && !empty searchVO.searchKeyword }">
			<a href="javascript:fncGetProductList(${resultPage.beginUnitPage - 1 })">◀ 이전</a>
			
			<!-- <a href="/product/listProduct?page=${resultPage.beginUnitPage - 1 }&menu=${param.menu }&searchCondition=${searchVO.searchCondition }&searchKeyword=${searchVO.searchKeyword }">◀ 이전</a> -->
			</f:if>
		<f:if test="${ empty searchVO.searchCondition || empty searchVO.searchKeyword }">
			<a href="javascript:fncGetProductList(${resultPage.beginUnitPage - 1 })">◀ 이전</a>
			<!-- <a href="/product/listProduct?page=${resultPage.beginUnitPage - 1}&menu=${param.menu }">◀ 이전</a> -->
		</f:if>		
			
			</f:otherwise>
			</f:choose>
		<f:forEach var="i" begin="${resultPage.beginUnitPage }" end="${resultPage.endUnitPage }" step="1">
		<f:choose>
		<f:when test="${!empty searchVO.searchCondition && !empty searchVO.searchKeyword }">
			<a href="javascript:fncGetProductList(${i})" class="movePage_btn" id="btn${i }" >${i }<%-- i --%></a> 
			<!-- <a href="/product/listProduct?page=${i }<%--i --%>&menu=${param.menu }<%--menu--%>&searchCondition=${searchVO.searchCondition }<%--searchVO.getSearchCondition() --%>&searchKeyword=${searchVO.searchKeyword }<%-- searchVO.getSearchKeyword() --%>">${i }<%-- i --%></a> -->
		</f:when>
		
		<f:otherwise>
			<a href="javascript:fncGetProductList(${i})" class="movePage_btn" id="btn${i }" >${i }<%-- i --%></a> 
			<!-- <a href="/product/listProduct?page=${i }<%-- i --%>&menu=${param.menu }<%-- menu --%>">${i }<%-- i --%></a> -->
		</f:otherwise>
		</f:choose>
		</f:forEach>
		<%-- if(right >= p.getMaxPage()) {--%>
		<f:choose>
		<f:when test="${resultPage.endUnitPage == resultPage.maxPage }">
			이후 ▶
		</f:when>
			<%-- }else { --%>
			
				<%-- if(searchVO.getSearchCondition() != null && searchVO.getSearchKeyword() != null) {--%>
		<f:otherwise>
		<f:choose>
		<f:when test="${!empty searchVO.searchCondition && !empty searchVO.searchKeyword }">
			<a href="/product/listProduct?page=${resultPage.endUnitPage + 1 }{<%-- right + 1 --%>&menu=${param.menu }<%-- menu --%>&searchCondition=${searchVO.searchCondition }<%-- searchVO.getSearchCondition() --%>&searchKeyword=${searchVO.searchKeyword }<%-- searchVO.getSearchKeyword() --%>">이후 ▶</a>
		</f:when>
		<%--	}else { --%>
		<f:otherwise>
			<a href="/product/listProduct?page=${resultPage.endUnitPage + 1 }<%-- right + 1 --%>&menu=${param.menu }<%-- menu --%>">이후 ▶</a>
		</f:otherwise>
			</f:choose>
			</f:otherwise>
			</f:choose>
		
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>