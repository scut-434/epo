<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>
<script type="text/javascript" src="${ctx }/static/js/medialeader/leader.js"></script>


<style type="text/css">

.tableListDivTable1{width:770px;overflow:hidden;margin-top:5px;padding-bottom:45px;}
.tableListDivTable1 table td.close{font-weight:bold;color:#e27600;}

.tableListDivTable1 div {width: 768px; overflow: hidden;  }
.tableListDivTable1 div table {width: 350px; overflow: hidden;   float: left; margin:10px; border-top:none;border-left:none;background:#e5e5e5;height:25px;line-height:25px;}
.tableListDivTable1 div table td {width: 48%; overflow: hidden;  border:1px solid #cccccc;border-top:none;border-left:none;height:30px;color:#4d4d4d;}
</style>

<script type="text/javascript" >
$(function()
		{
		//鼠标经过列表时，改变列表背景
		$(".tableListDivTable tr").live("mouseover",function()
		{	
			$(this).removeClass("act");
		});

		$(".tableListDivTable tr").live("mouseout",function()
		{	
			$(this).removeClass("act");
		});


		});
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
      	 <form action="/leaderRecognition/getLeaderList">
						<span class="space2">社交账号：</span>
			<!--  将选择框改为输入框
						<span class="systemSearchLeft">
						    <select class="select" id="socialaccount" name="socialaccount">
						       <option value="全部" >全部</option>
						       <c:forEach var="account" items="${accountList}">
						           <option value="${account}">${account}</option>
						       </c:forEach>
						    </select>
						</span>
			-->
			<span class="input"> <input type=text name="socialaccount" /></span>
						<span class="space1">所在省份：</span>
						<span class="systemSearchLeft">
						    <select class="select" id="regionProvince" name="regionProvince">
						       <option value="0" >全部</option>
						       <c:forEach var="province" items="${provinceList}">
						           <option value="${province.id}" >${province.name}</option>
						       </c:forEach>
						    </select>
						</span>

						<span class="space1">所在城市：</span>
						<span class="systemSearchLeft">
							<select class="select" id="regionCity" name="regionCity">
							<option value=0 >全部</option>
							 <c:forEach var="city" items="${cityList}">
						           <option value="${city.id}" >${city.name}</option>
						       </c:forEach>
							</select>
						</span>
						
						<span class="space1">收入阶层：</span>
						<span class="systemSearchLeft">
					       <select class="select" name="hierarchy">
					           <option value="0" >全部</option>
							    <c:forEach var="hierarchy" items="${hierarchyList}">
						           <option value="${hierarchy.mvalue}" >${hierarchy.mkey}</option>
						        </c:forEach>
							</select>
						</span>
						
						<span class="space1">政治倾向：</span>
						<span class="systemSearchLeft">
					       <select class="select" name="political">
					            <option value=0 >全部</option>
							 	<c:forEach var="political" items="${politicalList}">
						           <option value="${political.mvalue}" >${political.mkey}</option>
						       </c:forEach>
							</select>
						</span>
						
						<span class="space1">舆论影响力：</span>
						<span class="systemSearchLeft">
					       <select class="select" name="influence">
					            <option value=0>全部</option>
					            <option value=1>1级</option>
					            <option value=2>2级</option>
					            <option value=3>3级</option>
					            <option value=4>4级</option>
					            <option value=5>5级</option>
					            <option value=6>6级</option>
					            <option value=7>7级</option>
					            <option value=8>8部</option>
					            <option value=9>9级</option>
					       </select>
						</span>
				
						<span class="img"><a href="###" onclick="return getItemList(1)">&nbsp;</a></span>
					
			</form>
	</div>
	
		<div class="clear"></div>

				<div class="tableListDiv">
						<div class="tableListDivNav">
							<div class="tableListDivNavLeft" id="pageInfo"  >
								
							</div>
						</div>
						<div class="tableListDivTable1">
							 
							<div cellpadding="0" cellspacing="0" id="tableContainer">
								
							</div>
							<div class="clear"></div>

						</div>
						
						<!-- 分页 start -->			
						<div class="tablePage" id="pageContainer">
							
						</div>
						<!-- 分页 end -->
					<input type="hidden" id="getCityByProvince" value="/leaderRecognition/getCityByProvince">
						
				</div>
				
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
//省份节点改变，城市节点跟着改变
$('#regionProvince').change(function() {

	var options = "<option value=\"0\">" + "全部" + "</option>";
	if($('#regionProvince').val()=="0"){
		$("#regionCity").html(options); // 数据插入到子分类下拉表！
	}else{
		$.ajax({url:$("#getCityByProvince").val(),  //获取子分类的URL
				type: 'get',
				async: false,
				data: {provinceId:$('#regionProvince').val()},
				success: function(msg)
				{
					for(var n=0; n<msg.length; n++){
						options += "<option value=" + msg[n].id+ ">" + msg[n].name + "</option>"; //遍历赋值
					}
					$("#regionCity").html(options); // 数据插入到子分类下拉表！
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
