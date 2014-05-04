<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
<%@ page language="java" import="com.gzgb.epo.controller.knowledgeDictLibManage.*" pageEncoding="utf-8"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>

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
<!-- table content start -->
					<div class="addPoint">
				<form id="knowledge-dict-item-form" action="/knowledgeDictLibManage/addItem" method="post">	
<!-- addPointInput start -->
						<div class="addPointInput modifyIndiv">
						
							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>词条名称：</span>
								<span class="inputDiv inputModifyDiv">
					                 <input name="kdiName" id="KnowledgeDictItem_kdiName" type="text" maxlength="45" value="${kdiName }"/>
					            </span>
                                     <span class="inputPrompt" id="exitName"></span>
					                 <input name="id" type="hidden" id="kdiId" value="${kdiId}"/>
					           
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>所属父词库：</span>
								
								<span class="inputDiv inputModifyDiv">
								    <select name="parentIdLong" id="KnowledgeDictItem_kdlId">
								        <option value="">--</option>												
										<c:forEach var="kdl" items="${parentLib }">
									            <option value="${kdl.id }" <c:if test = "${kdlPId eq kdl.id}"> selected="selected" </c:if>>${kdl.name}</option>	        
									    </c:forEach>
								    </select> 
								</span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle">所属子词库：</span>
								<span class="inputDiv inputModifyDiv">							
							         	<select class="select" id="KnowledgeDictItem_kdlId_child" name="kdlIdLong">
											<option value="">--</option>
											<c:forEach var="kdl" items="${childrenLib }">
											    <option value="${kdl.id }" <c:if test = "${kdlId eq kdl.id}"> selected="selected"  </c:if>>${kdl.name}</option>	        
											</c:forEach>
										</select>
								</span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle">词条拼音：</span>
								<span class="inputDiv inputModifyDiv">
									<input name="kdiPinyin" id="KnowledgeDictItem_kdiPinyin" type="text" maxlength="45" value="${kdiPingyin }"/>
								</span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>词条词性：</span>
								<span class="inputDiv inputModifyDiv">
									<select name="kdqIdLong" id="KnowledgeDictItem_kdqId">
									    <option value="">--</option>
									    <c:forEach var="kdq" items="${listKdq }">
									            <option value="${kdq.id }" <c:if test = "${kdqId eq kdq.id}"> selected="selected" </c:if>>${kdq.name}</option>
									             
									    </c:forEach>
									</select>
								</span> 
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>词条权重：</span>
								<span class="inputDiv inputModifyDiv">
									<input name="kdiWeight" id="KnowledgeDictItem_kdiWeight" type="text" value="${kdiWeight }" />
								</span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle">词条状态：</span>
								<span class="inputDiv inputModifyDiv">
									<select name="kdiStatus" id="KnowledgeDictItem_kdiStatus">
										<option value="0">关闭</option>
										<option value="1" <c:if test = "${kdiStatus eq 1}"> selected="selected" </c:if>>正常</option>
									</select>
								</span>
								
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>是否为中文切分词：</span>
								<span class="inputDiv inputModifyDiv">
									<select name="kdiSegmentation" id="KnowledgeDictItem_kdiSegmentation">
										<option value="0">否</option>
										<option value="1" <c:if test = "${kdiSegmentation eq 1}"> selected="selected" </c:if>>是</option>
									</select>
								</span>
								<span class="inputPrompt"></span>
							</div>

						
						</div>
<!-- addPointInput end -->

<!-- submit start -->
						<div class="submitBox modifyBox">
					
							<span class="submitBnt"><a  onclick="submitForm()"></a></span>
							<span class="returnBnt"><a onclick="window.history.go(-1)" ></a>
						
							</span>
						</div>
<!-- submit end -->

<!-- submit success start -->
						<div class="restate" style="display:none">
							<span ><img src="${ctx}/static/images/loading.gif" /></span>
						</div>
<!-- submit success end -->
			         </form>
				</div>
					

<!-- table content end -->


<input type="hidden" id="getlist" value="/knowledgeDictLibManage/getChildrenLibList" />


<script type="text/javascript">
$('#KnowledgeDictItem_kdlId').change(function() {
	$("#exitName").html('');
	var options = "<option value=\"\">" + "--" + "</option>";
	if($('#KnowledgeDictItem_kdlId').val()==""){
		$("#KnowledgeDictItem_kdlId_child").html(options); // 数据插入到子分类下拉表！
	}else{
		$.ajax({url:$("#getlist").val(),  //获取子分类的URL
				type: 'get',
				async: false,
				data: 'id='+$('#KnowledgeDictItem_kdlId').val(),
				success: function(msg)
				{
					
					for(var n=0; n<msg.length; n++ ){
						options += "<option value=" + msg[n].id+ ">" + msg[n].name + "</option>"; //遍历赋值
					}
					$("#KnowledgeDictItem_kdlId_child").html(options); // 数据插入到子分类下拉表！
				}
         });
	}
 });

</script>
				
		

<script type="text/javascript">


//表单提交
function submitForm(){
	//获取表单数据对象
	var formLabel = $("form").find('input[type="text"],select');
	//获取表单数据
	var dataLabel = requiredLabel(formLabel);
	dataLabel[$("#kdiId").attr("name")] = $("#kdiId").val();
	//如果检测必填数据为空，返回页面
	if(dataLabel==false){
		return false;
	}

	var hasErrors = inputPrompt();
	
	//提交表单
	if(hasErrors==false){
		$(".restate span").html("<img src=\"${ctx}/static/images/loading.gif\" />");
		$.ajax({url:$("form").attr("action"),
		type:'post',
		async:false,
		data:dataLabel,
		dataType:"json",
		success:function(msg){
			if(msg.exit){
				//alert("in exitName");
				$("#exitName").html("<a href=\"/knowledgeDictLibManage/knowledgeDictLibManageToAddItem\">词条已存在，更新失败！");
			}
			else if(msg.errors){			
				$(".importPrompt").html();
				$(".restate span").html("更新词条失败");
				$(".restate").css("display","block");
			}else{
				$(".importPrompt").html();
				$(".restate span").html("更新词条成功");
				$(".restate").css("display","block");
			}

			setInterval("$('.restate').css('display','none')",3000);
		}
	});
	
	}


}

//验证不能为空，若都有值则返回表单数组
function requiredLabel(objLabel){
	
	var data = {};

	var status="";

	for(var i=0;i<objLabel.length;i++){
		data[$(objLabel[i]).attr("name")] = $(objLabel[i]).val();
		var labelText = $(objLabel[i]).parent().prev().text();

		if($(objLabel[i]).parent().prev().find("tt").text()=="*" && $(objLabel[i]).val()==""){
			$(objLabel[i]).parent().next().html(labelText.substr(1,labelText.length-2)+"不能为空");
			status = 1;
		}else{
			$(objLabel[i]).parent().next().html("");
		}
	}

	if(status!=1){
		return data;
	}else{
		return false;
	}
}

function inputPrompt(){
	for(var i=0;i<$(".inputPrompt").length;i++){
			if($($(".inputPrompt")[i]).html()==""){
				return false;
			}else{
				return true;
			}
	}
}



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
