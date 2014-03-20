<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@include file="../top.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>
<script type="text/javascript" src="${ctx }/static/js/jsapi"></script>
<script type="text/javascript" src="${ctx }/static/js/format+zh_CN,default,corechart.I.js"></script>
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
				<!-- right nav start -->
<div class="rightNavBox">
	<shiro:user>
		<shiro:hasPermission name="4">
			<span><a href="#hot_top">热点涉穗新闻</a></span>
		</shiro:hasPermission>
	</shiro:user>
	<shiro:user>
		<shiro:hasPermission name="9">
			<span><a href="#hot_top">热点涉穗评论</a></span>
		</shiro:hasPermission>
	</shiro:user>
	<shiro:user>
		<shiro:hasPermission name="11">
			<span><a href="#map_top">实时新闻舆情</a></span>
		</shiro:hasPermission>
	</shiro:user>

	<div class="hoverTop"><a href="#top">&nbsp;</a></div>
</div>
<!-- right nav end -->
				<!-- right nav end -->
					<div class="mainstream">
<!-- 数据 start -->
						<div class="basic">
							<div class="informationDiv">
								<div class="lconBox marginTop">
									<shiro:user>
										<shiro:hasPermission name="4">
									<div class="lconDiv knowledgeWidth1">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">今天涉穗新闻</div>
											<div class="lconNumber"><tt>${news }</tt>篇</div>
										</div>
										<div class="lconbak3"></div>
									</div>
										</shiro:hasPermission>
									</shiro:user>

									<shiro:user>
										<shiro:hasPermission name="9">
									<div class="lconDiv knowledgeWidth1">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">今天涉穗评论</div>
											<div class="lconNumber"><tt>${comments }</tt>篇</div>
										</div>
										<div class="lconbak3"></div>
									</div>
										</shiro:hasPermission>
									</shiro:user>
									
									<shiro:user>
										<shiro:hasPermission name="10">
									<div class="lconDiv knowledgeWidth1">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">今天热点话题</div>
											<div class="lconNumber"><tt>${topics }</tt>篇</div>
										</div>
										<div class="lconbak3"></div>
									</div>
										</shiro:hasPermission>
									</shiro:user>
									<!--  
									<div class="lconDiv knowledgeWidth1">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">今天县区关注</div>
											<div class="lconNumber"><tt></tt>篇</div>
										</div>
										<div class="lconbak3"></div>
									</div>
									-->
								</div>
							</div>
						</div>
<!-- 数据 end -->

<!-- 线性图表 start -->
<!--  
						<div class="informationSourceTitle" id="new_top">
							<span class="sourceLeft">境内外舆情信息概览</span>
						</div>

						<div class="clumnTBox">
						<form action="/mainMedia/lastWeek" id="lastWeek">
							<div class="Choice">
								<span><input type="radio" id="news" name="news" checked="checked" onclick="changeUrl(this)" /></span>
								<span>新闻</span>
								<span><input type="radio" id="comment" name="news" onclick="changeUrl(this)"/></span>
								<span>评论</span>
								<span class="space1">来源：</span>
								<span><input type="radio" id="all" name="anews" checked="checked" /></span>
								<span>所有</span>
								<span><input type="radio" id="home" name="anews"/></span>
								<span>境内</span>
								<span><input type="radio" id="abroad" name="anews"/></span>
								<span>境外</span>
								<span class="amplification" id="inout"><a href="###" target="_blank"></a></span>
							</div>
						</form>
-->
							<!--<div class="marginTop2" id="columnChart"></div>-->
							<!--  
							<div class="centerImg" id="columnChart" style="overflow:hidden;height:328px;"><img src="/static/images/loadingBig.gif" /></div>
							<div class="loading"></div>
						</div>
-->
<!-- 线性图表 end -->



<!-- 涉穗新闻TOP10 涉穗评论TOP10 start -->
						<div class="newsCommentaryTop" id="hot_top">
<!-- 涉穗新闻TOP10 start -->
									<shiro:user>
										<shiro:hasPermission name="4">
						<div class="newsTop tableListBoxHHHHHH">
							<div class="newsTopTitle">	
								<span class="name">今天热点涉穂新闻</span>
								<span class="detail"><a href="/mainMedia/mainMediaHotNews" target="_blank">详细</a></span>
							</div>
							
							<c:choose>
							  <c:when test="${newsCount ge 0}">
							    <div class="newsTopBnt">
								<span class="oneFive act" onmousemove='changeValue1(this,"act")'>1-5</span>
								<c:if test="${newsCount ge 5}"><span class="sixTen" onmousemove='changeValue2(this,"act")'>6-10</span></c:if>
							</div>
							<div class="newsTopTable">
								<c:forEach items="${newslist}" var="types" varStatus="j">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td valign="bottom"><div class="newsCount">${j.count}</div></td>
										<td class="newsBorder">
											<div class="newsDocket newsTopDocket newsDocketH"><a href="${types.url }" target="_blank" title='${types.title }'>${types.title }</a></div>
											<div class="sumTime">
												<span class="reprint newsTopReprint PeopleTimeMbn">转载量：<tt>${types.Reserved }</tt></span>
												<span class="soucre PeopleTimeMbn">网站：${types.wsmName }</span>
												<div class="clear"></div>
												<span class="time PeopleTime">时间：${types.date }</span>
											</div>
										</td>
									</tr>
								</table>
								</c:forEach>
								</div>
							  </c:when>
							  <c:otherwise>
							        <img class="nonum" src="/static/images/nonum.jpg" />
							  </c:otherwise>
							</c:choose> 
							</div>
													</shiro:hasPermission>
									</shiro:user>
						
<!-- 涉穗新闻TOP10 end -->

<!-- 涉穗评论TOP10 start -->
						<shiro:user>
						<shiro:hasPermission name="9">
						<div class="newsTop commentaryTop tableListBoxHHHHHH">
							<div class="newsTopTitle">	
								<span class="name" style="color:#437501">今天热点涉穂评论</span>
								<span class="detail"><a href="/mainMedia/mainMediaHotComments" target="_blank">详细</a></span>
							</div>
							
							<c:choose>
							  <c:when test="${commentCount ge 0}">
							<div class="newsTopBnt commentaryTopBnt">
								<span class="oneFive hact" onmousemove='changeValue1(this,"hact")'>1-5</span>
								<c:if test="${commentCount ge 5}"><span class="sixTen" onmousemove='changeValue2(this,"hact")'>6-10</span></c:if>
							</div>
							<div class="newsTopTable">

								<c:forEach items="${commentlist}" var="types" varStatus="j">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td valign="bottom"><div class="newsCount newsCount2">${j.count}</div></td>
										<td class="newsBorder1">
											<div class="newsDocket newsTopDocket1 newsDocketH"><a href="${types.url }" target="_blank" title='${types.title }'>${types.title }</a></div>
											<div class="sumTime">
												<span class="reprint commentaryTopReprint PeopleTimeMbn">转载量：<tt>${types.Reserved }</tt></span>
												<span class="soucre PeopleTimeMbn">网站：${types.wsmName }</span>
												<div class="clear"></div>
												<span class="time PeopleTime">时间：${types.date }</span>
											</div>
										</td>
									</tr>
								</table>
								</c:forEach>
							</div>
							  </c:when>
							  <c:otherwise>
							        <img class="nonum" src="/static/images/nonum.jpg" />
							  </c:otherwise>
							</c:choose> 
						</div>
						</shiro:hasPermission>
						</shiro:user>
						</div>
												
<!-- 涉穗评论TOP10 end -->
						<div class="clear"></div>
<!-- 涉穗新闻TOP10 涉穗评论TOP10 end -->
						
<!-- 新闻舆情地图 start -->
						<shiro:user>
						<shiro:hasPermission name="11">
						<div class="newsMap marginTop1">
<!-- 线性图表 start -->						
						<div class="nineBig">
						<div class="informationSourceTitle" id="map_top">
							<span class="sourceLeft">实时新闻舆情</span>
						</div>
							<div class="clumnTBox">
								<div class="Choice">
									<span class="amplification"><a href="/mainMedia/mainMediaNowNews" target="_blank"></a></span>
								</div>
								<div class="marginTop2" id="columnChart2"></div>
							</div>
						</div>

						<div class="clomeMap">
<!-- 越秀区 start -->
						<div class="point yxPoint"></div>
<!-- 越秀区 end -->
<!-- 荔湾区 start -->
						<div class="point lwPoint"></div>
<!-- 荔湾区 end -->
<!-- 海珠区 start -->
						<div class="point hzPoint"></div>
<!-- 海珠区 end -->
<!-- 天河区 start -->
						<div class="point thPoint"></div>
<!-- 天河区 end -->
<!-- 白云区 start -->
						<div class="point byPoint"></div>
<!-- 白云区 end -->
<!-- 黄埔区 start -->
						<div class="point hpPoint"></div>
<!-- 黄埔区 end -->
<!-- 萝岗区 start -->
						<div class="point lgPoint"></div>
<!-- 萝岗区 end -->
<!-- 番禺区 start -->
						<div class="point pyPoint"></div>
<!-- 番禺区 end -->
<!-- 花都区 start -->
						<div class="point hdPoint"></div>
<!-- 花都区 end -->
<!-- 南沙区 start -->
						<div class="point nsPoint"></div>
<!-- 南沙区 end -->
<!-- 从化市 start -->
						<div class="point chPoint"></div>
<!-- 从化市 end -->
<!-- 增城市 start -->
						<div class="point zcPoint"></div>
<!-- 增城市 end -->
<!-- 内容展示区 start -->
						<div class="mapContent" style="display:block;opacity:1">
							<!-- <div class="mapContentDiv">
								<div class="mapTitle">从化市</div>
								<div class="mapTitleP"><a href="###" target="_blank">内容展示区内容展示区内容展示区内容展示区内容展示区内容展示区</a></div>
								<div class="mapDocket">	我打电话，说先到附近龙口东路见面，时间不够看电影那就逛逛街。然后见面后就在龙口东路上随便走走，我说对那不熟，她说她也不是很熟，走走她就说找个地方先坐下聊天，我说好。结果走走
								</div>
							</div> -->
						</div>
<!-- 内容展示区 end -->
                        </div>
						
<!-- 线性图表 end -->	
						</div>
							</shiro:hasPermission>
						</shiro:user>				
<!-- 新闻舆情地图 end -->

					<input type="hidden" id="newsmap" value="/mainMedia/newsMap" />

<script type="text/javascript"><!--

//移除“回到顶部”样式
$(".backTop").removeClass();

//返回顶部效果
function rightToTop()
{
	var top = ($(window).height() - $(".rightNavBox").height())/2 + $(document).scrollTop() +'px';
	$(".rightNavBox").css({top:top,display:'block'});
}


//执行返回顶部效果
setInterval("rightToTop()",100);

	var webStatus='';//记录当前选中网站的下标
	var regionStatus='';//记录当前选中区县的下标
	var RegionID=new Array();
	var HYList = new Array();
	var webList = new Array();
	google.load("visualization", "1", {packages:["corechart"]});
	google.setOnLoadCallback(drawChart);
  function drawChart() {

//境内外新闻评论图表属性数组
	var options1 = {

	  width: 790,
	  height: 328,

	  legend: 
	  {
		position: 'top',
		alignment: 'end'
	  },
	  color: '#f00',
	  pointSize: 5,
	  chartArea:
	  {
		width: 690,
		height: 269,
		top:40
	  },

	  series: {0:{color: '#2a84d0', visibleInLegend: true}, 1:{color: '#65b102', visibleInLegend: true}},
	  tooltip:
	  {
		showColorCode: true
		
	  },

	  bar:
	  {
		groupWidth: 10
	  },
	  hAxis:
	  {
		format:"MM-dd",
		gridlines:
		{
			count:7
		}
		

	  },
	  vAxis:
	  {
		gridlines:
		{
			count:8
		}
	  },

	  animation:
	  {
      duration: 1000,
      easing: 'in'
	  },
	  curveType: 'function'

	};

//境内外新闻评论图表数组组装与生成
	$.ajax({
		  type: 'post',
		  url: $("#lastWeek").attr("action"),
		  dataType: 'json',
		  success: function(msg){
			 //所有新闻
			var AllNewsData = new google.visualization.DataTable();
			AllNewsData.addColumn('date', '日期');
			AllNewsData.addColumn('number', '境内新闻');
			AllNewsData.addColumn('number', '境外新闻');

			var chart = new google.visualization.LineChart(document.getElementById('columnChart'));
			
			var AllNews= new Array();
			var AllComment= new Array();
			var HomeNews= new Array();
			var HomeComment= new Array();
			var AbroadNews= new Array();
			var AbroadComment= new Array();
			if(msg.data!=''){
				for(j in msg.data){
					var str=msg.data[j].day;
					str=str.replace(/-/g,"/");
					AllNews.push([new Date(str),parseInt(msg.data[j].mtdHomeNews),parseInt(msg.data[j].mtdAbroadNews)]);
					AllComment.push([new Date(str),parseInt(msg.data[j].mtdHomeComment),parseInt(msg.data[j].mtdAbroadComment)]);
					HomeNews.push([new Date(str),parseInt(msg.data[j].mtdHomeNews)]);
					HomeComment.push([new Date(str),parseInt(msg.data[j].mtdHomeComment)]);
					AbroadNews.push([new Date(str),parseInt(msg.data[j].mtdAbroadNews)]);
					AbroadComment.push([new Date(str),parseInt(msg.data[j].mtdAbroadComment)]);
				}
				
				AllNewsData.addRows(AllNews);
				chart.draw(AllNewsData, options1);
			}else{
				nonum('columnChart');
			}

			//点击选框筛选效果
			$(".Choice input").click(function()
			{
				//所有新闻
				if($("#news").attr("checked")=="checked" && $("#all").attr("checked")=="checked"){
					options1.series={0:{color: '#2a84d0', visibleInLegend: true}, 1:{color: '#65b102', visibleInLegend: true}};//控制曲线颜色
					var AllNewsData = new google.visualization.DataTable();
					AllNewsData.addColumn('date', 'assad');					
					AllNewsData.addColumn('number', '境内新闻');
					AllNewsData.addColumn('number', '境外新闻');
					AllNewsData.addRows(AllNews);
					
					chart.draw(AllNewsData, options1);
				}
				//境内新闻
				if($("#news").attr("checked")=="checked" && $("#home").attr("checked")=="checked"){
					options1.series={0:{color: '#2a84d0', visibleInLegend: true}};//控制曲线颜色
					var HomeNewsData = new google.visualization.DataTable();
					HomeNewsData.addColumn('date', 'assad');
					HomeNewsData.addColumn('number', '境内新闻');
					HomeNewsData.addRows(HomeNews);
					
					chart.draw(HomeNewsData, options1);
				}
				//境外新闻
				if($("#news").attr("checked")=="checked" && $("#abroad").attr("checked")=="checked"){
					options1.series={0:{color: '#65b102', visibleInLegend: true}};//控制曲线颜色
					var AbroadNewsData = new google.visualization.DataTable();
					AbroadNewsData.addColumn('date', 'assad');
					AbroadNewsData.addColumn('number', '境外新闻');
					AbroadNewsData.addRows(AbroadNews);
					
					chart.draw(AbroadNewsData, options1);
				}
				//所有评论
				if($("#comment").attr("checked")=="checked" && $("#all").attr("checked")=="checked"){
					options1.series={0:{color: '#2a84d0', visibleInLegend: true}, 1:{color: '#65b102', visibleInLegend: true}};//控制曲线颜色
					var AllCommentData = new google.visualization.DataTable();
					AllCommentData.addColumn('date', 'assad');	
					AllCommentData.addColumn('number', '境内评论');
					AllCommentData.addColumn('number', '境外评论');
					AllCommentData.addRows(AllComment);
					
					chart.draw(AllCommentData, options1);
				}
				//境内评论
				if($("#comment").attr("checked")=="checked" && $("#home").attr("checked")=="checked"){
					options1.series={0:{color: '#2a84d0', visibleInLegend: true}};//控制曲线颜色
					var HomeCommentData = new google.visualization.DataTable();
					HomeCommentData.addColumn('date', 'assad');
					HomeCommentData.addColumn('number', '境内评论');
					HomeCommentData.addRows(HomeComment);
					
					chart.draw(HomeCommentData, options1);
				}
				//境外评论
				if($("#comment").attr("checked")=="checked" && $("#abroad").attr("checked")=="checked"){
					options1.series={0:{color: '#65b102', visibleInLegend: true}};//控制曲线颜色
					var AbroadCommentData = new google.visualization.DataTable();
					AbroadCommentData.addColumn('date', 'assad');
					AbroadCommentData.addColumn('number', '境外评论');
					AbroadCommentData.addRows(AbroadComment);
					
					chart.draw(AbroadCommentData, options1);
				}
			});	

		  }
			
	});
  }
</script>


<!--涉穗top 10 -->
<script type="text/javascript">
//显示前5条
	function changeValue1(own,className)
	{
		$(own).siblings().removeClass(className);
		$(own).parent().next().find("table").css("display","none");
		$(own).parent().next().find("table:lt(5)").css("display","block");
		$(own).addClass(className);
	}

//显示后5条
	function changeValue2(own,className)
	{
		$(own).siblings().removeClass(className);
		$(own).parent().next().find("table").css("display","none");
		$(own).parent().next().find("table:gt(4)").css("display","block");
		$(own).addClass(className);
	}
//默认显示前5条
	$.each($(".newsTopTable"),function(i,obj)
	{
		$(obj).find("table:lt(5)").css("display","block");
	})

//地图切换效果
	$(".mapContent").css("opacity","0");
	var mapSet = function(){};
	var clTimeout;
	var activeMap;
	var i = 0;
	var result;
	//请求地图数据
	$.ajax(
	{
		url: $("#newsmap").val(),
		type: 'post',
		data: {},
		dataType: 'json',
		success: function(data)
		{
			result = data.data;
			
			mapSet.prototype = 
			{
				//按钮切换效果
				bntChange: function()
				{	
					if(result==false){return false;}
					var len = result.length;
					var i_len = result[i].rbiId;
					
					$(".mapContent").stop();
					$(".point").stop();
					$(".mapContent").css({opacity:"0",height:"0px"});
					$(".point").css({opacity:"0",height:"0px"});
					var html='';
					html+='<div class="mapContentDiv">';
						html+='<div class="mapTitle">'+result[i].rbiName+'  <span style="font-size:15px"><b>'+result[i].mmnTimestamp+'</b></span></div>';
						html+='<div class="mapTitleP"><a href="'+result[i].mmnUrl+'" target="_blank" title=\''+result[i].mmnTitle+'\'>'+result[i].mmnTitle+'</a></div>';
						html+='<div class="mapDocket">'+result[i].mmnSummary+'</div>';

						html+='<div class="clubCk">';
						html+='<span>转载:<tt>'+result[i].reserved+'</tt></span>';
						html+='<span class="spanW">网站:<tt style="font-size:12px">'+result[i].wsmName+'</tt></span>';
						html+='</div>';
					html+='</div>';
					
					$(".mapContent").html(html);
					$($(".point")[i_len-1]).animate({height:"29px",opacity:'1'},500,function()
					{
						$(".mapContent").animate({height:"195px",opacity:'1'},1000,function()
						{
							i++;
							if(i == len)
							{
								i = 0;
							}
						});
					});		
				}
				
			}
			activeMap = new mapSet();
			clTimeout = setInterval("activeMap.bntChange()",5000);
		}
	});
</script>

<script type="text/javascript">
function changeUrl(obj)
{
	if($(obj).attr("id")=="comment"){
		$("#inout").find("a").attr("href",$("#monitorMediaComment").val());
	}else{
		$("#inout").find("a").attr("href",$("#monitorMediaReport").val());
	}
};
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
