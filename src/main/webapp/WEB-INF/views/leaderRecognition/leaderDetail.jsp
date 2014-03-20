<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>广州广报</title>
<link type="text/css"  href="${ctx }/static/style/css.css" rel="stylesheet"/>
<link rel="shortcut icon" href="${ctx }/favicon.ico" />
<script type="text/javascript" src="${ctx }/static/js/base/base.js"></script>
<script type="text/javascript" src="${ctx}/static/easyui/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctx }/static/js/datepicker.js"></script>
<script type="text/javascript" src="${ctx }/static/js/eye.js"></script>
<script type="text/javascript" src="${ctx }/static/js/chooseDate.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jsapi"></script>
<script type="text/javascript" src="${ctx }/static/js/format+zh_CN,default,corechart.I.js"></script>
</head>
<body>
<style type="text/css">
	body{background:none;}
	.centerImg  img{padding-top:220px;}
	#noImg img{width:318px;height:108px;}
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
		width: 40px;
	}
	.weibo { background: none repeat scroll 0 0 #AE5DA1; }
	.boke { background: none repeat scroll 0 0 #FF5555; }
	
	.changemonitorCon { height: 2350px; }
	.leftpart {
	       float:left;
	       width: 280px;
	       padding-top: 12px;
	       }
	.rightpart {
	       float: left;
	       width: 350px;
	       margin-left:50px;
	       }
	.middlepart {
	       float: left;
	       width: 310px;
	       padding-top:6px;
	       margin-left: 30px;
	       }
	.rightbottom {
	       float: right;
	       width: 730px;
	       }
	.xiahuaxian1 { 
	       width:98%;
           height:28px;
           overflow:hidden;
           clear:both;
           border-bottom:1px solid #cccccc;
           padding-top: 24px;
           }
    .xiahuaxian2 { 
	       width:95%;
           height:30px;
           overflow:hidden;
           clear:both;
           border-bottom:1px solid #cccccc;
           padding-top: 24px;
           }   
	.biaoti1 { 
	      width:250px;
          display: inline;
          float: left;
          font-size: 18px;
          font-weight:bold;
          color:#1486cd;
           }
    .biaoti2 {
          width:250px;
          display: inline;
          float: left;
          font-size: 18px;
          font-weight:bold;
          color:#1486cd;
    }
    .xiangxi1 { 
           float:right;
           display:inline;
           width:30px;
           }
           
           
	.changemonitorCon { height: 3350px; }
	.distop { margin-top:80px; }
	.mergemedia {
	          width:979px;
	          height:675px;
	          margin:0 auto;
	          margin-top:80px;
	          }	   
	          
	
	
</style>
  <div class="monitorCon changemonitorCon" align="center">
	<div class="monitorTopBox" width="1045px" align="center">
	<!-- top start -->
			<div class="monitorTitle">
				<span class="aTitle">舆论领袖</span>
				<span class="bTitle">言论信息分析</span>
			</div>
			<div class="clear"></div>
	<!-- top end -->
	</div>
	<div class="tableListDivTable">
	  <div class="informationSourceTitle" algin = "center">
			<span class="sourceLeft">个人详细信息</span>
	</div>
		<table>
			<tr>
				<td align="center">网络ID：</td>
				<td align="center" >${leader.id }</td>
				<td rowspan = 6> <image src="/leaderRecognition/getImage?networkId=${leader.id }"/></td>
			</tr>
			<tr>
				<td align="center">社交账号：</td>
				<td align="center">${leader.socialAccount }</td>
			</tr>
			<tr>
				<td align="center">所在地域：</td>
				<td align="center">${leader.regionId.name }</td>
			</tr>
			<tr>
				<td align="center">收入阶层：</td>
				<td align="center">${leader.hierarchyId.name }</td>
			</tr>
			<tr>
				<td align="center">政治倾向：</td>
				<td align="center">${leader.political }</td>
			</tr>
			<tr>
				<td align="center">舆情影响力：</td>
				<td align="center">${leader.influence }</td>
			</tr>
			<tr>
				<td colspan=3 align="center"><a href="/leaderRecognition/leaderPersonalCenter?networkId=${leader.id }">个人中心</a></td>
			</tr>
		</table>
<!--画折线图 开始 -->	
						<div class="mainstream marginTop">
						<div class="informationSourceTitle">
						<span class="sourceLeft" align = "left">所发言论政治倾向变化图</span>
						</div>
						<div class="clumnTBox">
							<div class="Choice">
								
								<span class = "space1">时间：</span>
									<span class="systemSearchRight marginLeft">
										<select id="tableDate" class="select">
											<option value="5">最近5个月</option>
											<option value="10">最近10个月</option>
											<option value="15">最近15个月</option>
										</select>
									</span>
							
								<div class="clear"></div>
							</div>
							<!--<div class="marginTop2" id="columnChart1"></div>-->
							<div class="centerImg" id="LineChart" style="overflow:hidden;height:328px;"><img src="/static/images/loadingBig.gif" /></div>
							<div class="loading"></div>
						</div>
						</div>

<!-- 画折线图结束 -->

<!-- 画信息发布量柱状图开始 -->
						<div class="mainstream marginTop">
						<div class="informationSourceTitle">
						<span class="sourceLeft" align = "left">信息发布量柱状图</span>
						</div>
<!-- 线性图表 start -->
						<div class="clumnTBox">
							<div class="Choice">
								<span class = "space1">时间：</span>
									<span class="systemSearchRight marginLeft">
									<select name="9webDate" id="9webDate">
										<option value="5" selected="selected">最近5个月</option>
										<option value="10">最近10个月</option>
										<option value="15">最近15个月</option>	
									</select>
								</span>
							</div>

							<div class="centerImg" id="columnChart1" style="overflow:hidden;height:308px;"><img src="/static/images/loadingBig.gif" /></div>

						</div>
<!-- 线性图表 end -->
						</div>

<!-- 画信息发布量柱状图结束 -->


<!-- 画信息转载量柱状图开始 -->
						<div class="mainstream marginTop">
						<div class="informationSourceTitle">
						<span class="sourceLeft" align = "left">信息转载量柱状图</span>
						</div>
<!-- 线性图表 start -->
						<div class="clumnTBox">
							<div class="Choice">
								<span class = "space1">时间：</span>
									<span class="systemSearchRight marginLeft">
									<select name="reprinted" id="reprinted">
										<option value="5" selected="selected">最近5个月</option>
										<option value="10">最近10个月</option>
										<option value="15">最近15个月</option>	
									</select>
								</span>
							</div>

							<div class="centerImg" id="columnChart2" style="overflow:hidden;height:308px;"><img src="/static/images/loadingBig.gif" /></div>

						</div>
<!-- 线性图表 end -->
						</div>

<!-- 画信息转载量柱状图结束 -->
		<div class="informationSourceTitle">
			<span class="sourceLeft">参与历史事件</span>
		</div>
		<table font-color="black">
				<tr>
					<th align="center">社交账号</th>
					<th align="center">时间描述</th>
					<th align="center">类型</th>
					<th align="center">扮演角色</th>
					<th align="center">所持观点</th>
				</tr>
				
				<c:forEach var="history" items="${lhr }">
				<tr>
					<td align="center">${history.mediaLeaderId.socialAccount }</td>
					<td align="center">${history.description }</a></td>
					<td align="center">${history.type }</td>
					<td align="center">${history.role}</td>
					<td align="center">${history.view}</td>
				</tr>
				</c:forEach>
		</table>
		<div class="informationSourceTitle">
			<span class="sourceLeft">最新言论记录</span>
		</div>
	<table>
		<tr>
			<th align="center">社交账号</th>
			<th align="center">主题</th>
			<th align="center">类型</th>
			<th align="center">政治倾向</th>
			<th align="center">时间</th>
		</tr>
		
		<c:forEach var="remark" items="${rr }">
		<tr>
			<td align="center">${remark.mediaLeaderId.socialAccount }</td>
			<td align="center"><a href="${remark.href}" target="_blank">${remark.remarkname }</a></td>
			<td align="center">${remark.type }</td>
			<td align="center">${remark.political }</td>
			<td align="center">${remark.time}</td>
		</tr>
		</c:forEach>
	</table>
	</div>

<!-- 画影响人群阶层分布柱状图开始 -->
						<div class="mainstream marginTop">
						<div class="informationSourceTitle">
						<span class="sourceLeft" align = "left">影响人群阶层分布</span>
						</div>
<!-- 线性图表 start -->
						<div class="clumnTBox">
								<div class="Choice">
								<span class = "space1">时间：</span>
									<span class="systemSearchRight marginLeft">
									<select name="hierarchyTime" id="hierarchyTime">
										<option value="5" selected="selected">最近5个月</option>
										<option value="10">最近10个月</option>
										<option value="15">最近15个月</option>	
										<option value="0">全部</option>
									</select>
								</span>
							</div>
							<div class="centerImg" id="hierarchy" style="overflow:hidden;height:308px;"><img src="/static/images/loadingBig.gif" /></div>

						</div>
<!-- 线性图表 end -->
						</div>

<!-- 画影响人群阶层分布柱状图结束 -->
 <!-- 画影响人群区域分布柱状图开始 -->
						<div class="mainstream marginTop">
						<div class="informationSourceTitle">
						<span class="sourceLeft" align = "left">影响人群区域分布</span>
						</div>
<!-- 线性图表 start -->
						<div class="clumnTBox">
								<div class="Choice">
								<span class = "space1">时间：</span>
									<span class="systemSearchRight marginLeft">
									<select name="regionTime" id="regionTime">
										<option value="5" selected="selected">最近5个月</option>
										<option value="10">最近10个月</option>
										<option value="15">最近15个月</option>	
										<option value="0">全部</option>
									</select>
								</span>
							</div>
							<div class="centerImg" id="region" style="overflow:hidden;height:308px;"><img src="/static/images/loadingBig.gif" /></div>

						</div>
<!-- 线性图表 end -->
						</div>

<!-- 画影响人群区域分布柱状图结束 -->
<!-- 画影响人群学历分布柱状图开始 -->
						<div class="mainstream marginTop">
						<div class="informationSourceTitle" align = "center">
						<span class="sourceLeft" align = "left">影响人群学历分布</span>
						</div>
<!-- 线性图表 start -->
						<div class="clumnTBox">
						<div class="Choice" >
								<span class = "space1">时间：</span>
									<span class="systemSearchRight marginLeft">
									<select name="educationTime" id="educationTime">
										<option value="5" selected="selected">最近5个月</option>
										<option value="10">最近10个月</option>
										<option value="15">最近15个月</option>	
										<option value="0">全部</option>
									</select>
							</span>
							</div>
							<div class="centerImg" id="education" style="overflow:hidden;height:308px;"><img src="/static/images/loadingBig.gif" /></div>

						</div>
<!-- 线性图表 end -->
						</div>

<!-- 画影响人群学历分布柱状图结束 -->
  </div>
  <input type="hidden" id="statistics" value="/leaderRecognition/getPoliticalChangeByMonth" />
  <input type="hidden" id="9webTable" value="/leaderRecognition/getCountChangeByType" />
  <input type="hidden" id="influence" value="/leaderRecognition/getInfluenceByType" />
  <input type="hidden" id="networkid" value="${leader.id }" />
</body>

<script type="text/javascript">
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawChart);
  
  function drawChart() {

  }

</script>
<!-- 画折线图用的 -->
<script type="text/javascript">

var negative = "#FF0000";
var neutral = "#fcaf17";
var positive = "#00CD00";
var chart = new google.visualization.LineChart(document.getElementById('LineChart'));//定义图表类型与位置

var options = {

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

	  series: {0:{color: positive, visibleInLegend: true}, 1:{color: neutral, visibleInLegend: true}, 2:{color: negative, visibleInLegend: true}},
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
		format:"yyyy-MM",
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
		},
		minValue:8
	  },

	  animation:
	  {
      duration: 1000,
      easing: 'out'
	  },
	  curveType: 'none'
	};
$.ajax({
	  type: 'post',
	  url: $("#statistics").val(),
	  data: {month:$("#tableDate").val(),networkid:$("#networkid").val()},
	  dataType: 'json',
	  success: function(msg){
			createTable_nodata(msg);//生成图表,无数据
			createTable(msg);//生成图表
	  }
});


function showData(){

	$.ajax({
	  type: 'post',
	  url: $("#statistics").val(),
	  data: {month:$("#tableDate").val(),networkid:$("#networkid").val()},
	  dataType: 'json',
	  success: function(msg){
			createTable_nodata(msg);//生成图表,无数据
			createTable(msg);//生成图表
	  }
  });

}


//组装数据，渲染图表
function createTable(msg)
{
	var DataTable = new google.visualization.DataTable();	
	var chartData = [];//定义要渲染的数据数组
	//组装已选中的类型数组数据
	for(i in msg.time){
		chartData[i] = [new Date(msg.time[i].replace(/-/g,'\/'))];
	    chartData[i].push(parseInt(msg.positive[i]));
		
		chartData[i].push(parseInt(msg.neutral[i]));
	
		chartData[i].push(parseInt(msg.negative[i]));
		
		}

	//组装舆情类型
	DataTable.addColumn('date', '日期');
	DataTable.addColumn('number', '右倾');
	DataTable.addColumn('number', '中立');
	DataTable.addColumn('number', '左倾');
	DataTable.addRows(chartData);//加载数据
	chart.draw(DataTable, options);//生成图表
}


//生成图表,无数据
function createTable_nodata(msg){
	google.visualization.events.removeAllListeners(chart);
	var firstTable = new google.visualization.DataTable();	
	var data_all=new Array();
	firstTable.addColumn('date', '日期');
	data_all.push(new Date("1970-00-00"));
	data_all.push(0);
	data_all.push(0);
	data_all.push(0);
	firstTable.addColumn('number', '右倾');
	firstTable.addColumn('number', '中立');
	firstTable.addColumn('number', '左倾');

	firstTable.addRows([data_all]);//加载数据
	chart.draw(firstTable, options);//生成图表
}

//更改图表类型时，重新访问新数据
$("#tableDate").live("change",function(){
	showData();
});
</script>

<!-- 画信息发布柱状图用的 -->
<script type="text/javascript">

var options2 = {

  width: 790,
  height: 308,

  pointSize: 5,

  chartArea:
  {
	width: 650,
	height: 249,
	top:10
  },

  series: {
	  0:{color: positive, visibleInLegend: true},
	  1:{color: neutral, visibleInLegend: true},
	  2:{color: negative, visibleInLegend: true},

  },

  tooltip:
  {
	showColorCode: true
	
  },

  bar:
  {
	groupWidth: 34
  },
  hAxis:
  {
	gridlines:
	{
		count:4
	}

  },
  vAxis:
  {
	gridlines:
	{
		count:8
	},
	minValue:8
  },
  
  animation:
  {
  duration: 1000,
  easing: 'out'
  },
  curveType: 'function',
  isStacked: true
};

var webData = new google.visualization.DataTable();
var continuousDateChart = new google.visualization.ColumnChart(document.getElementById('columnChart1'));
var webList = new Array();
$.ajax({
	  type: 'post',
	  url: $("#9webTable").val(),
	  data: {month:$("#9webDate").val(),networkid:$("#networkid").val(),type:"发布"},
	  dataType: 'json',
	  success: function(msg){
		for(j in msg){
			webList.push(new Array(msg[j].time,parseInt(msg[j].count)));
		}
		
		//默认加载生成图表
		webData.addColumn('string', 'Date1');
		webData.addColumn('number', '发布量');
		webData.addRows(webList);
		continuousDateChart.draw(webData ,options2);

		//筛选天数
		$('#9webDate').change(function() {
			
			//筛选柱形
			$.ajax({
				  type: 'post',
				  url: $("#9webTable").val(),
				  data: {month:$("#9webDate").val(),networkid:$("#networkid").val(),type:"发布"},
				  dataType: 'json',
				  success: function(msg){

					webList = []; 
					
					for(j in msg){
						webList.push(new Array(msg[j].time,parseInt(msg[j].count)));
						
					}

					//重新加载生成柱形图表
					var changeWebData = new google.visualization.DataTable();

					changeWebData.addColumn('string', 'Date1');
					changeWebData.addColumn('number', '发布量');
					changeWebData.addRows(webList);
					continuousDateChart.draw(changeWebData ,options2);
					
				  }
			 });

			
		});
	  }
});
</script>

<!--画信息转载图用的 -->
<script type="text/javascript">


var options2 = {

  width: 790,
  height: 308,


  pointSize: 5,

  chartArea:
  {
	width: 650,
	height: 249,
	top:10
  },
  series: {
	  0:{color: positive, visibleInLegend: true},
	  1:{color: neutral, visibleInLegend: true},
	  2:{color: negative, visibleInLegend: true},

  },
  tooltip:
  {
	showColorCode: true
	
  },

  bar:
  {
	groupWidth: 34
  },
  hAxis:
  {
	gridlines:
	{
		count:4
	}

  },
  vAxis:
  {
	gridlines:
	{
		count:8
	},
	minValue:8
  },
  
  animation:
  {
  duration: 1000,
  easing: 'out'
  },
  curveType: 'function',
  isStacked: true
};

var reprinted = new google.visualization.DataTable();
var reprintedDateChart = new google.visualization.ColumnChart(document.getElementById('columnChart2'));
var reprintedList = new Array();
$.ajax({
	  type: 'post',
	  url: $("#9webTable").val(),
	  data: {month:$("#reprinted").val(),networkid:$("#networkid").val(),type:"转载"},
	  dataType: 'json',
	  success: function(msg){
		for(j in msg){
			reprintedList.push(new Array(msg[j].time,parseInt(msg[j].count)));
		}
		
		//默认加载生成图表
		reprinted.addColumn('string', 'Date1');
		reprinted.addColumn('number', '转载量');
		reprinted.addRows(reprintedList);
		reprintedDateChart.draw(reprinted ,options2);

		//筛选天数
		$('#reprinted').change(function() {
			
			//筛选柱形
			$.ajax({
				  type: 'post',
				  url: $("#9webTable").val(),
				  data: {month:$("#reprinted").val(),networkid:$("#networkid").val(),type:"转载"},
				  dataType: 'json',
				  success: function(msg){

					  reprintedList = []; 
					
					for(j in msg){
						reprintedList.push(new Array(msg[j].time,parseInt(msg[j].count)));
						
					}

					//重新加载生成柱形图表
					var reprintedData = new google.visualization.DataTable();

					reprintedData.addColumn('string', 'Date1');
					reprintedData.addColumn('number', '转载量');
					reprintedData.addRows(reprintedList);
					reprintedDateChart.draw(reprintedData ,options2);
					
				  }
			 });

			
		});
	  }
});
</script>

<!-- 画舆论领袖影响人群柱状图 -->

<script type="text/javascript">

var options2 = {

  width: 790,
  height: 308,
  legend: 
  {
	position: 'top',
	alignment: 'end'
  },
 


  pointSize: 5,

  chartArea:
  {
	width: 650,
	height: 249,
	top:10
  },

  tooltip:
  {
	showColorCode: true
	
  },

  bar:
  {
	groupWidth: 34
  },
  hAxis:
  {
	gridlines:
	{
		count:4
	}

  },
  vAxis:
  {
	gridlines:
	{
		count:8
	},
	minValue:8
  },
  
  animation:
  {
  duration: 1000,
  easing: 'out'
  },
  curveType: 'function',
  isStacked: true
};

var hierarchyData = new google.visualization.DataTable();
var hierarchyDateChart = new google.visualization.ColumnChart(document.getElementById('hierarchy'));
var hierarchyList = new Array();
$.ajax({
	  type: 'post',
	  url: $("#influence").val(),
	  data: {networkid:$("#networkid").val(),type:"阶层",month:$("#hierarchyTime").val()},
	  dataType: 'json',
	  success: function(msg){
		for(j in msg){
			hierarchyList.push(new Array(msg[j].name,parseInt(msg[j].count)));
		}
		
		//默认加载生成图表
		hierarchyData.addColumn('string', 'Date1');
		hierarchyData.addColumn('number', '数量');
		
		hierarchyData.addRows(hierarchyList);
		
		hierarchyDateChart.draw(hierarchyData ,options2);
		
		//筛选天数
		$('#hierarchyTime').change(function() {
			
			//筛选柱形
			$.ajax({
				type: 'post',
				  url: $("#influence").val(),
				  data: {networkid:$("#networkid").val(),type:"阶层",month:$("#hierarchyTime").val()},
				  dataType: 'json',
				  success: function(msg){
					  var hierarchyList = new Array();
					for(j in msg){
						hierarchyList.push(new Array(msg[j].name,parseInt(msg[j].count)));
					}
					
					var hierarchyData = new google.visualization.DataTable();
					//默认加载生成图表
					hierarchyData.addColumn('string', 'Date1');
					hierarchyData.addColumn('number', '数量');
					
					hierarchyData.addRows(hierarchyList);
					
					hierarchyDateChart.draw(hierarchyData ,options2);
				  }
			 });

			
		});
	
	  }
});

var regionData = new google.visualization.DataTable();
var regionDateChart = new google.visualization.ColumnChart(document.getElementById('region'));
var regionList = new Array();
$.ajax({
	  type: 'post',
	  url: $("#influence").val(),
	  data: {networkid:$("#networkid").val(),type:"地区",month:$("#regionTime").val()},
	  dataType: 'json',
	  success: function(msg){
		for(j in msg){
			regionList.push(new Array(msg[j].name,parseInt(msg[j].count)));
		}
		
		//默认加载生成图表
		regionData.addColumn('string', 'Date1');
		regionData.addColumn('number', '数量');
		regionData.addRows(regionList);
		regionDateChart.draw(regionData ,options2);
		
		//筛选天数
		$('#regionTime').change(function() {
			
			//筛选柱形
			$.ajax({
				type: 'post',
				  url: $("#influence").val(),
				  data: {networkid:$("#networkid").val(),type:"地区",month:$("#regionTime").val()},
				  dataType: 'json',
				  success: function(msg){
					  var regionList = new Array();
					for(j in msg){
						regionList.push(new Array(msg[j].name,parseInt(msg[j].count)));
					}
					
					var regionData = new google.visualization.DataTable();
					//默认加载生成图表
					regionData.addColumn('string', 'Date1');
					regionData.addColumn('number', '数量');
					
					regionData.addRows(regionList);
					
					regionDateChart.draw(regionData ,options2);
				  }
			 });

			
		});
	
	  }
});

var educationData = new google.visualization.DataTable();
var educationDateChart = new google.visualization.ColumnChart(document.getElementById('education'));
var educationList = new Array();
$.ajax({
	  type: 'post',
	  url: $("#influence").val(),
	  data: {networkid:$("#networkid").val(),type:"学历",month:$("#educationTime").val()},
	  dataType: 'json',
	  success: function(msg){
		for(j in msg){
			educationList.push(new Array(msg[j].name,parseInt(msg[j].count)));
		}
		
		//默认加载生成图表
		educationData.addColumn('string', 'Date1');
		educationData.addColumn('number', '数量');
		educationData.addRows(educationList);
		educationDateChart.draw(educationData ,options2);
	
		//筛选天数
		$('#educationTime').change(function() {
			
			//筛选柱形
			$.ajax({
				type: 'post',
				  url: $("#influence").val(),
				  data: {networkid:$("#networkid").val(),type:"学历",month:$("#educationTime").val()},
				  dataType: 'json',
				  success: function(msg){
					  var educationList = new Array();
					for(j in msg){
						educationList.push(new Array(msg[j].name,parseInt(msg[j].count)));
					}
					
					var educationData = new google.visualization.DataTable();
					//默认加载生成图表
					educationData.addColumn('string', 'Date1');
					educationData.addColumn('number', '数量');
					
					educationData.addRows(educationList);
					educationDateChart.draw(educationData ,options2);
				  }
			 });

			
		});
		
	  }
});
</script>
</html>