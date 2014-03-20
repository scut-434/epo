<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>
<script type="text/javascript" src="/static/js/syspurview/account/account.js"></script>
<script type="text/javascript">

//表单提交
function submitForm(){
	//获取表单数据对象
	var formLabel = $("form").find('input[type="text"],input[type="password"],select');
	//获取表单数据
	var dataLabel = requiredLabel(formLabel);
	//如果检测必填数据为空，返回页面
	if(dataLabel==false){
		return false;
	}
	//验证用户名是否唯一
	//validateUnque($(formLabel[0]));
	//是否有错误提示
	var hasErrors = inputPrompt();
	
	//提交表单
	if(hasErrors==false){
		var roles=$("#roleIds option");
		var roleIds="";
		roles.each(function(){
			roleIds =roleIds+$(this).val()+",";
		});
		if(roleIds.length > 0)
		roleIds = roleIds.substring(0, roleIds.length-1);  //拼接的角色ID字符串
		dataLabel['roleIds']=roleIds;
		
		$.ajax({url:$("form").attr("action"),
		type:'post',
		async:false,
		data:dataLabel,
		dataType:"json",
		success:function(msg){
			if(msg.errors){
				$(".restate span").html("<img src=\"/static/images/loading.gif\" />");
				$(".importPrompt").html();
				$(".restate span").append("添加用户失败");
				$(".restate").css("display","block");
			}else{
				$(".restate span").html("<img src=\"/static/images/loading.gif\" />");
				$(".importPrompt").html();
				$(".restate span").append("添加用户成功");
				$(".restate").css("display","block");
			}

			setInterval("$('.restate').css('display','none')",3000);
		}
	});
	
	}


}

//验证不能为空，若都有值则返回表单数组、密码验证、邮箱验证
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

	//邮箱验证
	var temp = $("#email");
	var myreg = /^([a-zA-Z0-9]+[_|\_|\.|\-]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	
	if(temp.val()!=''){
		if(!myreg.test(temp.val()))
		{	status = 1;
			$(temp).parent().next().html("邮箱地址不符合电子邮箱格式");
		}
	}
	
	//确认密码
	if($("#password").val()!=$("#qr_password").val())
	{	status = 1;
		$("#password").parent().next().html("确认密码与用户密码不一致");
	}

	//密码不能少于8位数
	
	if( $("#password").val().length<8)
	{	status = 1;
		$("#password").parent().next().html("密码长度不能少于8位");
	}
	

	//验证用户名是否唯一
	if($("#loginName").val()!=""){
		var unqueName=validateUnque($("#loginName"));
		if(unqueName==false){
			status=1;
		}
	}
	

	if(status!=1){
		return data;
	}else{
		return false;
	}
}

//验证用户名唯一性
function validateUnque(names)
{	
	$.ajax({url:"/user/checkLoginNameIsExits",
		type:'get',
		async:false,
		data:'loginName='+$(names).val(),
		dataType:"json",
		success:function(msg){
			if(msg.data.name){
				$(names).parent().next().html("<a href=\"#\">"+msg.data.name+"</a>已存在，请重新输入");
				return false;
			}else{
				$(names).parent().next().html("");
				return true;
			}
		}
	});
	

}
//是否有错误提示
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
				

				<div class="addPoint">
<!-- addPointInput start -->
					
						<form action="/user/addUser" id="form" name="form" method="post">
						<div class="addPointInput modifyIndiv">
							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>用户名：</span>
								<span class="inputDiv inputModifyDiv"><input id="loginName" type="text" maxlength="16" name="loginName" /></span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle">用户昵称：</span>
								<span class="inputDiv inputModifyDiv"><input id="username" type="text" maxlength="16" name="username" /></span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>用户级别：</span>
								<span class="inputDiv inputModifyDiv"><select id="userType" name="userType">
																		<option value="">--</option>
																		<option value="0">系统用户</option>
																		<option value="1">管理员用户</option>
																		<!--
																		<option value="1">系统管理员</option>
																		<option value="2">部负责人</option>
																		<option value="3">处室负责人</option>
																		<option value="4">处室人员</option>
																		<option value="5">中心负责人</option>
																		<option value="6">中心人员</option>
																		-->
																		</select></span>
								<span class="inputPrompt"></span>
							</div>
							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>电子邮箱：</span>
								<span class="inputDiv inputModifyDiv"><input id="email" type="text" maxlength="64" name="email" /></span>
								<span class="inputPrompt"></span>
							</div>
							
							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>密码：</span>
								<span class="inputDiv inputModifyDiv"><input id="password" type="password" name="password" value="" /></span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>确认密码：</span>
								<span class="inputDiv inputModifyDiv"><input id="qr_password" type="password" name="qr_password" value="" /></span>
								<span class="inputPrompt"></span>
							</div>
							
							
							<div class="addPointInputBox addUserBox">
									<span class="inputTitle inputModifyTitle">登陆ip限制：</span>
									<span class="inputTextarea addUserTextarea">
										<textarea id="umiLoginIp" name="umiLoginIp"></textarea>
									</span>
							</div>
							
							<div class="addPointInputBox addUserBox">
									<span class="inputTitle inputModifyTitle">用户角色：</span>
									<span class="inputTextarea addUserTextarea">
										<table  class="biaoge_3" style="border:none;" >
											<tr>
												<td style="width:131px;">
														<select name="s_roleId" id="s_roleId" size="6" multiple style="width:100px;height:110px;overflow: hidden;overflow-y:scroll; ">
															<c:forEach items="${roleList}" var="s_role">
																<option value="${s_role.id}">${s_role.name}</option>
															</c:forEach>
														</select>
												</td>
												<td></td>
												<td>
													<p><input name="btn01" type="button" class="sort_sub" onclick="addRole()" value="添 加" /></p>
													<p><input name="btn01" type="button" class="sort_sub" onclick="delRole()" value="删 除" /></p>
												</td>
												<td>
													<select name="roleIds" id="roleIds" size="6" multiple style="width:100px;height:110px;overflow: hidden;overflow-y:auto;">
														<c:forEach items="${roles}" var="v_role">
															<option value="${v_role.id}">${v_role.name}</option>
														</c:forEach>
													</select>
												</td>
											</tr>
										</table>
									</span>
							</div>
						

						</div>
<!-- addPointInput end -->

<!-- submit start -->
						<div class="submitBox modifyBox">
							<span class="submitBnt"><a href="###" onclick="submitForm()"></a></span>
							<span class="returnBnt"><a href="#" onclick="window.history.back()"></a></span>
						</div>
<!-- submit end -->

<!-- submit success start -->
						<div class="restate" style="display:none">
							<span ><img src="/static/images/loading.gif" />提交成功</span>
						</div>
<!-- submit success end -->

					</form>
					</div>
					
				
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
