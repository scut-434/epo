<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>
<script type="text/javascript" src="${ctx }/static/js/jsapi"></script>
<script type="text/javascript" src="${ctx }/static/js/format+zh_CN,default,corechart.I.js"></script>

<style>
.tiezi{
	background: none repeat scroll 0 0 #1486CD;
	color: #FFFFFF;
	display: inline;
	float: left;
	font-size: 12px;
	font-weight: bold;
	height: 20px;
	line-height: 20px;
	text-align: center;
	width: 37px;
	margin-right: 3px;
}
.weibo { background: none repeat scroll 0 0 #AE5DA1; }
.boke { background: none repeat scroll 0 0 #FF5555; }
</style>
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
		<shiro:hasPermission name="14">
			<span><a href="#hot_top">今日热点微博</a></span>
		</shiro:hasPermission>
	</shiro:user>
		<shiro:user>
		<shiro:hasPermission name="15">
			<span><a href="#hot_top">今日热点帖子</a></span>
		</shiro:hasPermission>
	</shiro:user>
		<shiro:user>
		<shiro:hasPermission name="17">
			<span><a href="#sensitive_top">最新敏感舆情</a></span>
		</shiro:hasPermission>
	</shiro:user>
		<shiro:user>
		<shiro:hasPermission name="18">
			<span><a href="#map_top">实时预警舆情</a></span>
		</shiro:hasPermission>
	</shiro:user>
	
	<div class="hoverTop"><a href="#top">&nbsp;</a></div>
</div>
<!-- right nav end -->
					<div class="mainstream">
<!-- 数据 start -->
						<div class="warningBox">
							<div class="informationDiv">
								<div class="lconBox marginTop">
									<shiro:user>
										<shiro:hasPermission name="14">
									<div class="lconDiv warning">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">今天涉穗微博</div>
											<div class="lconNumber"><tt>${weibos }</tt>条</div>
										</div>
										<div class="lconbak3"></div>
									</div>
										</shiro:hasPermission>
									</shiro:user>

									<shiro:user>
										<shiro:hasPermission name="15">
									<div class="lconDiv warning">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">今天涉穗帖子</div>
											<div class="lconNumber"><tt>${blogs }</tt>个</div>
										</div>
										<div class="lconbak3"></div>
									</div>
										</shiro:hasPermission>
									</shiro:user>
									
									<shiro:user>
										<shiro:hasPermission name="16">
									<div class="lconDiv warning">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">今天涉穗博客</div>
											<div class="lconNumber"><tt>${forums }</tt>条</div>
										</div>
										<div class="lconbak3"></div>
									</div>
										</shiro:hasPermission>
									</shiro:user>
									
									<shiro:user>
										<shiro:hasPermission name="17">
									<div class="lconDiv warning">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">今天敏感舆情</div>
											<div class="lconNumber"><tt>${sensitive }</tt>条</div>
										</div>
										<div class="lconbak3"></div>
									</div>
										</shiro:hasPermission>
									</shiro:user>
								</div>
							</div>
						</div>
<!-- 数据 end -->



<!-- 涉穗新闻TOP10 涉穗评论TOP10 涉穗博客TOP10 start -->
						<div class="newsCommentaryTop" id="hot_top">
<!-- 涉穗新闻TOP10 start -->
						<shiro:user>
		<shiro:hasPermission name="14">
						<div class="newsTop tableListBoxHHHHHHHH">
							<div class="newsTopTitle">	
								<span class="name">今天热点涉穂微博</span>
								<span class="detail"><a href="/warning/warningHotWeibo" target="_blank">详细</a></span>
							</div>
							
							<c:choose>
							  <c:when test="${weiboCount ge 0}">
							<div class="newsTopBnt">
								<span class="oneFive act" onmousemove='changeValue1(this,"act")'>1-5</span>
								<c:if test="${weiboCount ge 5}"><span class="sixTen" onmousemove='changeValue2(this,"act")'>6-10</span></c:if>
							</div>
							<div class="newsTopTable">
								<c:forEach items="${weibolist}" var="types" varStatus="j">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td valign="bottom"><div class="newsCount">${j.count}</div></td>
										<td class="newsBorder">
											<div class="newsDocket newsTopDocket"><a href="${types.url }" target="_blank" title='${types.title }'><img class="mbImg" src="/static/images/${types.type }.gif" />${types.title }</a></div>
											<div class="sumTime">
												<span class="reprint detailReprint PeopleTimeMbn">评论：<tt>${types.num1 }</tt></span>
												<span class="soucre detailsoucre PeopleTimeMbn">转发：<tt>${types.num2 }</tt></span>
												<div class="clear"></div>
												<span class="soucre PeopleTimeMbn">作者：${types.num3 }</span>
												<span class="time PeopleTime">时间：<tt>${types.date }</tt></span>
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
		<shiro:hasPermission name="15">
						<div class="newsTop tableListBoxHHHHHHHH">
							<div class="newsTopTitle">	
								<span class="name">今天热点涉穂帖子</span>
								<span class="detail"><a href="/warning/warningHotPost" target="_blank">详细</a></span>
							</div>
							
							<c:choose>
							  <c:when test="${forumCount ge 0}">
							<div class="newsTopBnt">
								<span class="oneFive act" onmousemove='changeValue1(this,"act")'>1-5</span>
								<c:if test="${forumCount ge 5}"><span class="sixTen" onmousemove='changeValue2(this,"act")'>6-10</span></c:if>
							</div>
							<div class="newsTopTable">
								<c:forEach items="${forumlist}" var="types" varStatus="j">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td valign="bottom"><div class="newsCount">${j.count}</div></td>
										<td class="newsBorder">
											<div class="newsDocket newsTopDocket"><a href="${types.url }" target="_blank" title='${types.title }'>${types.title }</a></div>
											<div class="sumTime">
												<span class="reprint detailReprint PeopleTimeMbn">回复：<tt>${types.num1 }</tt></span>
												<span class="soucre detailsoucre PeopleTimeMbn">查看：<tt>${types.num2 }</tt></span>
												<div class="clear"></div>
												<span class="soucre PeopleTimeMbn">网站：${types.num3 }</span>
												<span class="time PeopleTime">时间：<tt>${types.date }</tt></span>
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
<!-- 涉穗评论TOP10 end -->

<!-- 涉穗博客TOP10 start -->
					<!--  
						
						<div class="newsTop tableListBoxHHHHHHHH">
							<div class="newsTopTitle">	
								<span class="name">今天热点涉穂博客</span>
								<span class="detail"><a href="/warning/warningHotBlog" target="_blank">详细</a></span>
							</div>
							
							<c:choose>
							  <c:when test="${blogCount ge 0}">
							<div class="newsTopBnt">
								<span class="oneFive act" onmousemove='changeValue1(this,"act")'>1-5</span>
								<c:if test="${blogCount ge 5}"><span class="sixTen" onmousemove='changeValue2(this,"act")'>6-10</span></c:if>
							</div>
							<div class="newsTopTable">
								<c:forEach items="${bloglist}" var="types" varStatus="j">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td valign="bottom"><div class="newsCount">${j.count}</div></td>
										<td class="newsBorder">
											<div class="newsDocket newsTopDocket"><a href="${types.url }" target="_blank" title='${types.title }'>${types.title }</a></div>
											<div class="sumTime">
												<span class="reprint detailReprint PeopleTimeMbn">评论：<tt>${types.num1 }</tt></span>
												<span class="soucre detailsoucre PeopleTimeMbn">查看：<tt>${types.num2 }</tt></span>
												<div class="clear"></div>
												<span class="soucre PeopleTimeMbn">作者：${types.num3 }</span>
												<span class="time PeopleTime">时间：<tt>${types.date }</tt></span>
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
						-->
<!-- 涉穗博客TOP10 end -->
					</div>
						<div class="clear"></div>
						
<!-- 涉穗新闻TOP10 涉穗评论TOP10 涉穗博客TOP10 end -->


<!-- 敏感舆情列表 start -->
		<shiro:user>
		<shiro:hasPermission name="17">
						<div class="sensitiveList">
							<div class="informationSourceTitle marginTop" id="sensitive_top">
							<span class="sourceLeft">最新敏感舆情</span>
							<span class="detxxi"><a href="/warning/warningSensitive" target="_blank">详细</a></span>
							</div>

							<div class="tableListDivTable tableListDivTable1">
							<c:choose>
								<c:when test="${latelyCount ge 0}">
							
									<table cellpadding="0" cellspacing="0">
										<tr>
											<th align="center" width="40%">标题</th>
											<th align="center" width="10%">网站</th>
											<th align="center" width="6%">来源</th>
											<th align="center" width="8%">敏感指数</th>
											<th align="center" width="16%">时间</th>
											<th align="center" width="10%">性质</th>
											<th align="center" width="10%">级别</th>
										</tr>
										<c:forEach items="${latelylist}" var="types" varStatus="j">
											<tr>
												<td class="title" align="left" width="40%" style="word-break:break-all"><div class="pTitle"><a title='${types.jslTitle }' href="${types.jslSourceUrl}" target="_blank">${types.jslTitle }</a></div></td>
												<td align="center" width="10%">${types.wsmName }</td>
												<td align="center" width="6%">${types.jslSourceType }</td>
												<td align="center" width="8%">${types.jslSensitivity }</td>
												<td align="center" width="16%">${types.jslTimestamp }</td>
												<td align="center" width="10%">${types.jslNature}</td>
												<td align="center" width="10%">${types.jslLevel }</td>
											</tr>
										</c:forEach>
									</table>
							
								</c:when>
							  	<c:otherwise>
							        <img class="nonum" src="/static/images/nonum.jpg" />
							  	</c:otherwise>
							</c:choose> 
						</div>
					</div>
					</shiro:hasPermission>
	</shiro:user>
<!-- 敏感舆情列表 end -->



<!-- 新闻舆情地图 start -->
		<shiro:user>
		<shiro:hasPermission name="18">
						<div class="newsMap">
<!-- 线性图表 start -->						
						<div class="nineBig">
						<div class="informationSourceTitle" id="map_top">
						<span class="sourceLeft">实时预警舆情</span>
						</div>
							<div class="clumnTBox">
								<div class="Choice">
									<span class="amplification"><a href="/warning/warningNow" target="_blank"></a></span>
								</div>
								<div class="marginTop2" id="columnChart2"></div>
							</div>
						</div>

						<div class="clomeMap clomeMapyj">
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
								<div class="mapTitleP"><a href="###" target="_blank">男子将两名幼子从8楼抛下后跳楼身亡</a></div>
								<div class="mapDocket">	虎毒尚不食子，然而前日下午一男子却将只有2岁和5岁的儿子抛下8楼，随后他也跳下楼去并当场身亡。两个孩子在送院过程中被证实死亡。事发从化街口，疑因男子不工作引发家庭矛盾，与妻子吵架后作出如此举动。无辜的孩子，破碎的家庭，再也难享美好天伦。
								</div>
								<div class="clubCk">
									<span>转载<tt>12323</tt></span>
									<span>评论<tt>5863</tt></span>
								</div>
							</div>--> 
						</div>
<!-- 内容展示区 end -->
                        </div>
						
<!-- 线性图表 end -->	
						</div>	
				</shiro:hasPermission>
	</shiro:user>			
<!-- 新闻舆情地图 end -->
	</div>
					</div>
					<input type="hidden" value="deparmentmap" />
					<input type="hidden" id="warningMap" value="/warning/warningMap" />


 <script type="text/javascript">
	//移除“回到顶部”样式
	$(".backTop").removeClass();

	var getData=new Array();//气泡数据
	var count=new Array(); //气泡数据总数（已过滤）
	var total_found; //气泡数据总数
	var namenmb =new Array();//气泡数据名称
	var colorData=new Array();//气泡颜色数组
	var percentage=new Array();//气泡数据百分比
	var contSum = new Array();
	var departmentName=new Array();//保存部门名称
 //返回顶部效果
function rightToTop()
{
	var top = ($(window).height() - $(".rightNavBox").height())/2 + $(document).scrollTop() +'px';
	$(".rightNavBox").css({top:top,display:'block'});
}

//执行返回顶部效果
setInterval("rightToTop()",100);

  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawChart);
  function drawChart() {
	var options = {
	 width:790,
	 height:500,
	 chartArea:
		  {
			left:0,
			top:0,
			width:790,
			height:500
		  },

	  hAxis: {
		textStyle:
		{
			color:'red'
		},
		baselineColor: '#fff',
		gridlines:{color:'#fff'},
		maxValue:90,
		minValue:10
		},

	  vAxis: {
		
		textStyle:
		{
			color:'red'
		},
		baselineColor: '#fff',
		gridlines:{color:'#fff'},
		maxValue:90,
		minValue:10
		},


		//enableInteractivity: true,

		sizeAxis:
		{
			maxSize:75,
			//maxValue:75,
			minSize:40
			//minValue:20

		},
		legend: {position: 'none'},

		bubble:
		{
			opacity: 1,
			textStyle:{color: 'black', fontName:"黑体", fontSize: "16"}
		},
				
		colorAxis: {colors: ['#30BFBD']}

	};


	var chart = new google.visualization.BubbleChart(document.getElementById('columnChart'));

	$.ajax({
		  type: 'post',
		  url: $("#todayDepartmentsTOP10").val(),
		 // async :false,
		  dataType: 'jsonp',
		  success: function(msg){
				if(msg.data==false){
					 nonum('columnChart');
					return false;
				}

				options.colorAxis.colors= ['#30BFBD','#F2914A','#F29C9F','#F39B77','#5698D5','#C490C0','#A172B8','#9EC745','#EB6876','#546FB4'];

				getData=msg.data;
				if(getData.length>0){
					for(j in getData){
						departmentName[j]=getData[j][0];
						count=Number(count+getData[j][4]);
						colorData[j]=options.colorAxis.colors[j];
					}
					options.colorAxis.colors=colorData;
				}

				var chart = new google.visualization.BubbleChart(document.getElementById('columnChart'));
				var data = new google.visualization.DataTable();
				data.addColumn('string');
				data.addColumn('number');
				data.addColumn('number');
				data.addColumn('number');
				data.addColumn('number', '关注度');
				data.addRows(msg.data);
				chart.draw(data, options);
				total_found=msg.count;
				
				for(j=0;j<getData.length;j++){

					contSum.push(getData[j][4]);

					namenmb.push('chart'+j);
				}
				
				/*部门top10百分比生成*/

				//样式
				var options1 = {
				  //title: 'My',
				  pieSliceText:'none',
				  width: 75,
				  height: 130,
				  chartArea: 
				  {
					width: 60,
					height: 110,
					top:0
				  },
				  tooltip:
				  {
					color: 'black', fontName: 'simsun', fontSize: 6,showColorCode:'false',trigger:'none'
				  },
				  legend:
				  {
					position: 'bottom',
					alignment: 'center',
					textStyle:
					{
						color:'#000',
						fontSize: 12,
						fontFamily:'simsun'
					}
				  },
				  slices: {
					 0: {color: '#D9D9D9'},
					 1: {color: '#30BFBD'} 
					},
					tooltip:{trigger:'none'}
				};
				
				//遍历组装数组，渲染视图
				for(i=0;i<getData.length;i++){
					
					percentage.push(contSum[i]/total_found);

					var topsum = percentage[i].toFixed(3)*1000/10;

					if(topsum == 0)
					{
						topsum = 1;
					}

					//生成百分比的html
					var html='';
					html+='<div class="roleDiv">';
					html+='<div class="centerImg marginTop2" style="overflow:hidden;width:70px;height:100px;" id="role'+i+'"></div>';
					html+='<p>'+departmentName[i]+'</p>';//数据名称填充
					html+='<div class="circle_div">'+topsum+'%'+'</div>';//百分比填充
					html+='</div>';

					$(".roleBox").append(html);

					namenmb[i] = new google.visualization.PieChart(document.getElementById('role'+Number(i)));

					var data = google.visualization.arrayToDataTable([
					  ['新闻', 'Hours per Day'],
					  ['消息', count-contSum[i]],
					  ['热点', contSum[i]]
					]);
					
					options1.slices = {0:{color: '#D9D9D9'},1:{color: colorData[i]}};
	
					namenmb[i].draw(data, options1);

					google.visualization.events.addListener(namenmb[i], 'onmouseover', selectHandler);
					
				}
		   }
		 });

	$("#columnChart").find("text").attr("stroke","");//去字体描边
	
  }
</script>

<script type="text/javascript">

function selectHandler() {
$.each($(".roleBox").find("g"),function(i,obj)
{
	$($(obj).find("path")[1]).css("display","none");
})
return false;
}
</script>
 

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

	//////////////
	//地图切换效果
	$(".mapContent").css("opacity","0");
	var mapSet = function(){};
	var clTimeout;
	var activeMap;
	var i = 0;
	var result;
	var mapUrl=$("#warningMap").val();
	
	ajaxMap();
	function ajaxMap(){
		//请求地图数据
		$.ajax({
			url: mapUrl,
			type: 'post',
			data: {},
			dataType: 'json',
			error: function(){},
			success: function(response){
				resetMap(response);
			}
		});
	}

	function resetMap(data){
		result = data.data;
		if(result=='' || result==false){
			return false;
		}else{
			mapSet.prototype = {
				//按钮切换效果
				bntChange: function(){
					var len = result.length;
					var i_len = result[i].rbiId;
					var rbiHtml;
					var view = result[i].view;
					var viewName="查看：";
					var typeHtml = '';
					var contentBox = '';

					switch(result[i].type){
						case 3:
							typeHtml = '<span class="tiezi weibo">微博</span>';
							break;
						case 4:
							typeHtml = '<span class="tiezi">帖子</span>';
							break;
						case 5:
							typeHtml = '<span class="tiezi boke">博客</span>';
							break;
					}

					if(result[i].fullTitle==""){
						rbiHtml = '<div class="mapDocket"><a href="'+result[i].url+'" target="_blank" title="'+result[i].content+'">'+typeHtml+result[i].content+'</a><div class="clear"></div></div>';
						viewName = "转发：";

					}else{
						rbiHtml = '<div class="mapTitleP"><a href="'+result[i].url+'" target="_blank" title="'+result[i].fullTitle+'">'+typeHtml+result[i].fullTitle+'</a><div class="clear"></div></div>'
						rbiHtml += '<div class="mapDocket" title="'+result[i].content+'">'+result[i].content+'</div>';
					}

					$(".mapContent, .point").stop();
					$(".mapContent, .point").css({opacity:"0",height:"0px"});

					contentBox += '<div class="mapContentDiv">';
					contentBox += '<div class="mapTitle">'+result[i].rbiName+'</div>'+rbiHtml;
					contentBox += '<div class="clubCk">';
					contentBox += 	'<span>评论：<tt>'+result[i].comment+'</tt></span>';
					contentBox += 	'<span>'+viewName+'<tt>'+view+'</tt></span>';
					contentBox += '</div>';

					$(".mapContent").html(contentBox);

					$($(".point")[i_len-1]).animate({height:"29px",opacity:'1'},500,function(){
						$(".mapContent").animate({height:'185px',opacity:'1'},1000,function(){
							i++;
							i = i==len ? 0 : i;
						});
					});		
				}
			}
			activeMap = new mapSet();
			clearInterval(clTimeout);
			clTimeout = setInterval("activeMap.bntChange()",5000);
		}
	}

	setInterval("ajaxMap()",1000*3600);
</script>
				
				</div>
				<!-- 页面内容  end -->
			</td>
		</tr>
	</table>
	</div>
<!-- table content end -->
</div>

<%@include file="../bottom.jsp"%>
</body>
</html>
