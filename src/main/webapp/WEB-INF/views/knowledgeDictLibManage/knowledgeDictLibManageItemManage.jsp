<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>
<script type="text/javascript" src="${ctx }/static/js/knowledge/item.js"></script>
<script type="text/javascript"> 
function todo(url){
	parent.document.getElementById("middleFrame").src = url;
}
</script>

</head>
<body>
<div class="con">
<!-- topNav start -->
	<div class="topNav">
		<c:forEach items="${menuList}" var="one_menu">
				<c:if test="${one_menu.status eq 1}">
					<div <c:choose>
					       <c:when test="${one_menu.id eq pMenuId}">
					       	class="navDiv act"
					       </c:when>
					       <c:otherwise>
					       	class="navDiv"
					       </c:otherwise>
						</c:choose>
					>
					<a href="${one_menu.menuUrl}/${one_menu.id}" >${one_menu.menuName}</a>
					</div>
				</c:if>
		</c:forEach>
	</div>
<!-- topNav end -->

<!-- table content start -->
	<div class="tableContent">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top">
				<div class="tableContentLeft">
					<c:forEach items="${menu.subMenuList}" var="fir_menu">
						<c:if test="${fir_menu.status eq 1}">
							<div class="navSubTitle">
								<a <c:choose>
								       <c:when test="${fir_menu.id eq sMenuId}">
								       	class="act"
								       </c:when>
								       <c:otherwise>
								       	class=""
								       </c:otherwise>
									</c:choose>
								href="${fir_menu.menuUrl}/${fir_menu.id}" >
								${fir_menu.menuName}
								</a>
							</div>
							<c:forEach items="${fir_menu.subMenuList}" var="sec_menu">
								<c:if test="${sec_menu.status eq 1}">
									<div class="navSupTitle">
										<a <c:choose>
										       <c:when test="${sec_menu.id eq sMenuId}">
										       	class="act"
										       </c:when>
										       <c:otherwise>
										       	class=""
										       </c:otherwise>
											</c:choose>
										href="${sec_menu.menuUrl}/${sec_menu.id}" >
										${sec_menu.menuName}
										</a>
									</div>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</div>
			</td>
			<td class="tdBak" valign="top">
				<div class="tableContentRight">
					<div class="currentPosition">
					&nbsp;&nbsp;&nbsp;&nbsp;当前位置：&nbsp;&nbsp;<a href="${fUrl }" >${fMenu }</a>
					&nbsp;>&nbsp;<a href="${sUrl }" >${sMenu }</a>
					<c:if test="${not empty tMenu}">&nbsp;>&nbsp;<a href="${tUrl }" >${tMenu }</a></c:if>
					</div>
				
				<!-- 页面内容 start -->
				
<div class="systemSearch systemSearchBataCase">
      	<form action="/knowledgeDictLibManage/getItemList">
						<span class="space2">所属词库：</span>
						<span class="systemSearchLeft">
						    <select class="select" id="KnowledgeDictItem_kdlId" name="parentLibId">
						       <option value="" >--</option>
						       <c:forEach var="lib" items="${listIdandName}">
						           <option value="${lib.id}" <c:if test="${parentId eq lib.id }"> selected="selected" </c:if>>${lib.name}</option>
						       </c:forEach>
						    </select>
						</span>

						<span class="space1">所属子词库：</span>
						<span class="systemSearchLeft">
							<select class="select" id="KnowledgeDictLib_kdlId_child" name="childrenLibId">
							<option value="" >--</option>
							 <c:forEach var="lib" items="${childrenlib}">
						           <option value="${lib.id}" <c:if test="${id eq lib.id }"> selected="selected" </c:if>>${lib.name}</option>
						       </c:forEach>
							</select>
						</span>
						
						<span class="space1">词性：</span>
						<span class="systemSearchRight">
					       <select class="select" name="itemQuality">
					           
					           <c:forEach var="itemqualityName" items="${itemQualityList}">
					               <option value="${itemqualityName.id }">${itemqualityName.name}</option>
					           </c:forEach>
					       </select>
						</span>
						<span class="input"> <input type=text name="fuzzySearch" /></span>
						<span class="img"><a href="###" onclick="return getItemList(1)">&nbsp;</a></span>
					
			</form>
		</div>
					<div class="clear"></div>

					<div class="tableListDiv">
						<div class="tableListDivNav">
							<div class="tableListDivNavLeft" id="pageInfo"  >
								
							</div>
							<shiro:user>
								<shiro:hasPermission name="30">
								<div class="tableListDivCaseRight2">
									<a href="/knowledgeDictLibManage/knowledgeDictLibManageUploadItem"></a>
								</div>
								</shiro:hasPermission>
							</shiro:user>
							<shiro:user>
								<shiro:hasPermission name="29">
								<div class="tableListDivCaseRight1">
									<a href="/knowledgeDictLibManage/knowledgeDictLibManageToAddItem"></a>
								</div>
								</shiro:hasPermission>
							</shiro:user>
						</div>
						<div class="tableListDivTable">
							<table cellpadding="0" cellspacing="0" id="tableContainer">
								
							</table>
<!-- 分页 start -->
							<div class="tablePage" id="pageContainer">

								<div class="tablePageLeft">
									<span class="position1"><input type="checkbox" /></span>
									<span class="position">全选</span>
									<span class="systemSearchRight space2">
									<select class="select" name="many" id="many">
										<option value="">--</option>
										<option value="1">删除词条</option>
										<option value="2">开启词条</option>
										<option value="3">关闭词条</option>
									</select>
									</span>
									
								</div>

								<div id="pageNumber"></div>

								
							</div>
<!-- 分页 end -->
						</div>
					</div>

					<input type="hidden" id="openUrl" value="/knowledgeDictLibManage/openItem" />
					<input type="hidden" id="closeUrl" value="/knowledgeDictLibManage/closeItem" />
					<input type="hidden" id="deleteUrl" value="/knowledgeDictLibManage/deleteItemById" />
					<input type="hidden" id="getlist" value="/knowledgeDictLibManage/getChildrenLibList">


<script type="text/javascript">

//初始化请求
$(function(){
	var initPageInfo = window.location.toString().match(/page(=|\/)([0-9]+)/);
	getItemList(initPageInfo ? initPageInfo[2] : 0);
});

var floor;
var selectID;
//弹出框居中
function coveDiv(info)
{
	info !=='' ? $('.popupBoxCon').html(info) : '';
	
	$(".popupBoxCove").css({opacity:'0.5',width:$(document).width(),height:$(document).height(),display:'block'});
	$(".popupBox").css({left:($(window).width()-308)/2+'px',top:($(window).height()-188)/2+$(document).scrollTop()+'px',display:'block'});
}

//关闭弹出框
function coveColse()
{
	$(".popupBoxCove").css({display:'none'});
	$(".popupBox").css({display:'none'});
	floor='';
}

//queding
function trueColse()
{
	floor = 'true';
	coveColse();
	onDelete(selectID,'',true);
}

$('#KnowledgeDictItem_kdlId').change(function() {
	
	var options = "<option value=\"\">" + "--" + "</option>";
	if($('#KnowledgeDictItem_kdlId').val()==""){
		$("#KnowledgeDictLib_kdlId_child").html(options); // 数据插入到子分类下拉表！
	}else{
		$.ajax({url:$("#getlist").val(),  //获取子分类的URL
				type: 'get',
				async: false,
				data: {id:$('#KnowledgeDictItem_kdlId').val()},
				success: function(msg)
				{
					for(var n=0;n<msg.length;n++){
						options += "<option value=" + msg[n].id+ ">" + msg[n].name + "</option>"; //遍历赋值
					}
					$("#KnowledgeDictLib_kdlId_child").html(options); // 数据插入到子分类下拉表！
				}
         });
	}
 });
</script>



				
				<!-- 页面内容  end -->
				</div>
			</td>
		</tr>
	</table>
	</div>
<!-- table content end -->
</div>

<%@include file="../bottom.jsp"%>
</body>
</html>
