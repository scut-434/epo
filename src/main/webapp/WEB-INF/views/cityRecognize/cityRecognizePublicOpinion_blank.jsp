<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
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
<style type="text/css">
	body{background:none;}
	.changemonitorCon { height: 1250px; }
	.distop { margin-top:80px; }
	.mergemedia {
	          width:979px;
	          height:675px;
	          margin:0 auto;
	          margin-top:80px;
	          }	     	
</style>
		
				<!-- 页面内容 start -->
				
		      <div class="monitorCon changemonitorCon">
					<!-- top start -->
						<div class="monitorTopBox">
							<div class="monitorTitle">
								<span class="aTitle">城市形象与认识度</span>
								<span class="bTitle">公众评价</span>
							</div>
							
					    </div>
					<!-- top end -->
					<!-- content start -->
				<center>
					 <table>
					   <tr>
					      <td>
					        <img src="http://chart.apis.google.com/chart?chs=400x250&chd=${timeEmotion}&cht=lc&chbh=50&chdl=正面|中立|负面&chtt=情感倾向变化趋势&chco=ff0000,0000ff,00ff00&chf=
									c,ls,90,999999,0.25,CCCCCC,0.25,FFFFFF,0.25&chxt=x,y&chxl=${timeString}"/>
						  </td>		
						  <td> 
							 <img src="http://chart.apis.google.com/chart?chs=400x300&chd=${publicAttention_Y}&cht=bvs&chbh=50&chdl=正面|中立|负面&chtt=公众对广州的关注度&chco=ff0000,0000ff,00ff00&chxt=x,y&chxl=${publicAttention_X}"/>
					     </td>
					   </tr>
					 </table>
					     <div class="mergemedia">
					         <div class="addPointConBnt" float="center">
					                 <c:forEach var="hierarchy" items="${hierarchyList }">
					                     <div class="addPointConBntDiv" ><input type="hidden" name="ss" value="${hierarchy.name }">${hierarchy.name }</div>
					                 </c:forEach>
					          </div>
					            <table>
					             <tr>
					                 <td  id="displayContent">
					                <img  src="http://chart.apis.google.com/chart?chs=250x100&chd=${hierarchy_Y }&cht=p3&chco=00ff00,0000ff,ff0000&chl=${hierarchy_X } "/>
					              
					                 <img src="http://chart.apis.google.com/chart?chs=400x250&chd=${heducation_Y}&cht=bvs&chbh=50&chdl=正面|中立|负面&chtt=学历分布&chco=ff0000,0000ff,00ff00&chxt=x,y&chxl=${heducation_X}"/>
					                 <img src="http://chart.apis.google.com/chart?chs=400x250&chd=${hemotion_Y}&cht=lc&chbh=50&chdl=正面|中立|负面&chtt=情感倾向变化趋势&chco=ff0000,0000ff,00ff00&chf=
									c,ls,90,999999,0.25,CCCCCC,0.25,FFFFFF,0.25&chxt=x,y&chxl=${hemotion_X}"/>
					                 </td>
					             </tr>
					         </table>
					     </div>
				</center>
					<!-- content end -->
			</div>
				
				<!-- 页面内容  end -->
<input type="hidden" id="getHierarchyDetail" value="/cityRecognize/getHierarchyDetail">
<!-- table content end -->
<script type="text/javascript">
$(function()
{	
//执行按钮切换效果
	changeBnt("addPointConBntDiv","basic");
})


//按钮切换效果
function changeBnt(bnt,con)
{
	$("."+bnt).click(function()
	{
		$("."+bnt).removeClass("addPointConBntAct");
		$(this).addClass("addPointConBntAct");
		var option = '';
		var hierarchyName = $(this).find("input[type='hidden']").val();
		$.ajax({url:$("#getHierarchyDetail").val(),  //获取子分类的URL
			type: 'get',
			async: false,
			data: {hierarchyName:hierarchyName},
			success: function(msg)
			{
				alert(msg);
				option='<img  src="http://chart.apis.google.com/chart?chs=250x100&chd='+msg[0].Y+'&cht=p3&chco=00ff00,0000ff,ff0000&chl='+msg[0].X+ '"/>'+
						'<img src="http://chart.apis.google.com/chart?chs=400x250&chd='+msg[1].Y+'&cht=bvs&chbh=50&chdl=正面|中立|负面&chtt=学历分布&chco=ff0000,0000ff,00ff00&chxt=x,y&chxl='+msg[0].X+ '"/>'+
						'<img src="http://chart.apis.google.com/chart?chs=400x250&chd='+msg[2].X+'&cht=lc&chbh=50&chdl=正面|中立|负面&chtt=情感倾向变化趋势&chco=ff0000,0000ff,00ff00&chf=c,ls,90,999999,0.25,CCCCCC,0.25,FFFFFF,0.25&chxt=x,y&chxl='+msg[0].X+ '"/>';
					alert(option);
				$("#displayContent").html(option); // 数据插入到子分类下拉表！
			
				}  
     });

	}) ;
	

}
</script>
</body>
</html>
