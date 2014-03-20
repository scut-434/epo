<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>广州广报</title>
<link type="text/css"  href="${ctx }/static/style/css.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx}/static/easyui/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctx }/static/js/datepicker.js"></script>
<script type="text/javascript" src="${ctx }/static/js/eye.js"></script>
<script type="text/javascript" src="${ctx }/static/js/chooseDate.js"></script>
<script type="text/javascript" src="${ctx }/static/js/jsapi"></script>
<script type="text/javascript" src="${ctx }/static/js/format+zh_CN,default,corechart.I.js"></script>
<style type="text/css">
	body{background:none;}
	.changemonitorCon { height: 1000px; }
	.contentTitle { 
	          display:inline;
	          padding-top:10px;
	          font-size:20px;
	          color:#1486cd;
	          font-weight:bold;
	          float:left;
	          }
    	
</style>
</head>
<body>

		
				<!-- 页面内容 start -->
				
		      <div class="monitorCon changemonitorCon">
					<!-- top start -->
						<div class="monitorTopBox">
							<div class="monitorTitle">
								<span class="aTitle">城市形象与认识度</span>
								<span class="bTitle">情感分析</span>
							</div>
							
					    </div>
					<!-- top end -->
					<!-- content start -->
<!--画折线图 开始 -->	
					<div class="mainstream marginTop">
						<div class="informationSourceTitle">
						<span class="sourceLeft" >部门关注度情感分析图</span>
						</div>
						<div class="clumnTBox">
							<div class="Choice">
							<span class = "space1">类型：</span>
								<span class="systemSearchRight marginLeft">
									<select name="publicOrmedia" id="publicOrmedia">
										<option value="公众" selected="selected">公众</option>
										<option value="媒体">媒体</option>	
										<option value="全部">全部</option>	
									</select>
								</span>
								<span class = "space2">部门：</span>
								<span class="inputDiv inputModifyDiv">
								    <select name="departmentId" id="departmentId">
								        <option value="-1" selected = "selected">全部</option>												
										<c:forEach var="department" items="${departmentList }">
									            <option value="${department.id }" >${department.dbiName}</option>	        
									    </c:forEach>
								    </select> 
								</span>
								<span class = "space2">时间：</span>
									<span class="systemSearchRight marginLeft">
										<select id="Time" class="Time">
											<option value="5" selected="selected">最近5个月</option>
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

<!-- 画折线图结束 -->
<!--  
				<span class="contentTitle">职能部门关注度排行图</span>
-->
<!-- 画职能部门关注度排行图柱状图开始 -->
						<div class="informationSourceTitle marginTop2" id="9web_top">
						<span class="sourceLeft">职能部门关注度排行图</span>
						</div>
<!-- 线性图表 start -->
						<div class="clumnTBox">
							<div class="Choice">
								<span class = "space1">类型：</span>
								<span class="systemSearchRight marginLeft">
									<select name="publicOrmediaColumn" id="publicOrmediaColumn">
										<option value=1 selected="selected">公众</option>
										<option value=2>媒体</option>
										<option value=0>全部</option>	
									</select>
								</span>
								
			<!--  				
								<span class = "space1">倾向类型：</span>
								<span class="systemSearchRight marginLeft">
									<select name="politicalOrEmotion" id="politicalOrEmotion">
										<option value=1 selected="selected">情感倾向</option>
										<option value=2>政治倾向</option>
										<option value=0>全部</option>	
									</select>
								</span>
			-->	
								<span class = "space2">时间：</span>
								<span class="systemSearchRight marginLeft">
									<select name="pmCloumTime" id="pmCloumTime">
										<option value="3" selected="selected">3个月</option>
										<option value="5">5个月</option>	
										<option value="7">7个月</option>
										<option value="9">9个月</option>
										<option value="11">11个月</option>
										<option value="0">全部</option>
									</select>
								</span>
							</div>

							<div class="centerImg" id="departmentColumnChart" style="overflow:hidden;height:308px;"><img src="/static/images/loadingBig.gif" /></div>

						</div>
<!-- 线性图表 end -->
						</div>

<!-- 画职能部门关注度排行图柱状图结束 -->
				</div>
				
				<!-- 页面内容  end -->
<input type="hidden" id="getAttentionChange" value="/cityRecognize/getDepartnemtAttentionChange">
<input type="hidden" id="getDepartmentAttention" value="/cityRecognize/getDepartmentConcern">
<!-- table content end -->


<!--画职能部门关注度排行图柱状图 -->
<script type="text/javascript">
var departmentOptions = {

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
	width: 690,
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

var reprinted = new google.visualization.DataTable();
var reprintedDateChart = new google.visualization.ColumnChart(document.getElementById('departmentColumnChart'));
var reprintedList = new Array();
$.ajax({
	  type: 'post',
	  url: $("#getDepartmentAttention").val(),
	  data: {publicOrMedia:$("#publicOrmediaColumn").val(),month:$("#pmCloumTime").val()},
	  dataType: 'json',
	  success: function(msg){
		for(j in msg){
			reprintedList.push(new Array(msg[j].name,parseInt(msg[j].total)));
		}
		//默认加载生成图表
		reprinted.addColumn('string', '部门名称');
		reprinted.addColumn('number', '关注量');
		reprinted.addRows(reprintedList);
		reprintedDateChart.draw(reprinted ,departmentOptions);
		//筛选媒体或公众或全部类型
		$('#publicOrmediaColumn').change(function() {
			
			//筛选柱形
			$.ajax({
				  type: 'post',
				  url: $("#getDepartmentAttention").val(),
				  data: {publicOrMedia:$("#publicOrmediaColumn").val(),month:$("#pmCloumTime").val()},
				  dataType: 'json',
				  success: function(msg){

					  reprintedList = []; 
					
					for(j in msg){
						reprintedList.push(new Array(msg[j].name,parseInt(msg[j].total)));
						
					}

					//重新加载生成柱形图表
					var reprintedData = new google.visualization.DataTable();

					reprintedData.addColumn('string', '部门名称');
					reprintedData.addColumn('number', '关注量');
					reprintedData.addRows(reprintedList);
					reprintedDateChart.draw(reprintedData ,departmentOptions);
					
				  }
			 });
			
			

			
		});
		
		
		//筛选月数
		$('#pmCloumTime').change(function() {
			
			//筛选柱形
			$.ajax({
				  type: 'post',
				  url: $("#getDepartmentAttention").val(),
				  data: {publicOrMedia:$("#publicOrmediaColumn").val(),month:$("#pmCloumTime").val()},
				  dataType: 'json',
				  success: function(msg){

					  reprintedList = []; 
					
					for(j in msg){
						reprintedList.push(new Array(msg[j].name,parseInt(msg[j].total)));
						
					}

					//重新加载生成柱形图表
					var reprintedData = new google.visualization.DataTable();

					reprintedData.addColumn('string', '部门名称');
					reprintedData.addColumn('number', '关注量');
					reprintedData.addRows(reprintedList);
					reprintedDateChart.draw(reprintedData ,departmentOptions);
					
				  }
			 });

		});
/*		
		//筛选情感倾向或政治倾向
		$('#politicalOrEmotion').change(function() {
			
			//筛选柱形
			$.ajax({
				  type: 'post',
				  url: $("#getDepartmentAttention").val(),
				  data: {publicOrMedia:$("#publicOrmediaColumn").val(),month:$("#pmCloumTime").val(),type:$("#politicalOrEmotion").val()},
				  dataType: 'json',
				  success: function(msg){

					  reprintedList = []; 
					
					for(j in msg){
						reprintedList.push(new Array(msg[j].name,parseInt(msg[j].total)));
						
					}

					//重新加载生成柱形图表
					var reprintedData = new google.visualization.DataTable();

					reprintedData.addColumn('string', '部门名称');
					reprintedData.addColumn('number', '关注量');
					reprintedData.addRows(reprintedList);
					reprintedDateChart.draw(reprintedData ,departmentOptions);
					
				  }
			 });

		});
	 	
	*/
	  }
});
</script>




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


function showData(){

	$.ajax({
	  type: 'post',
	  url: $("#getAttentionChange").val(),
	  data: {type:$("#publicOrmedia").val(),month:$("#Time").val(),departmentId:$("#departmentId").val()},
	  dataType: 'json',
	  success: function(msg){
			createTable_nodata(msg);//生成图表,无数据
			createTable(msg);//生成图表
	  }
  });

}

$.ajax({
	  type: 'post',
	  url: $("#getAttentionChange").val(),
	  data: {type:$("#publicOrmedia").val(),month:$("#Time").val(),departmentId:$("#departmentId").val()},
	  dataType: 'json',
	  success: function(msg){
			createTable_nodata(msg);//生成图表,无数据
			createTable(msg);//生成图表
			
	  }
});


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
	//alert(chartData);
	
	//组装舆情类型
	DataTable.addColumn('date', '日期');
	DataTable.addColumn('number', '正面');
	DataTable.addColumn('number', '中立');
	DataTable.addColumn('number', '负面');
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
	firstTable.addColumn('number', '正面');
	firstTable.addColumn('number', '中立');
	firstTable.addColumn('number', '负面');

	firstTable.addRows([data_all]);//加载数据
	chart.draw(firstTable, options);//生成图表
}
//更改图表类型时，重新访问新数据
$("#publicOrmedia").live("change",function(){
	showData();
});
$("#Time").live("change",function(){
	showData();
});
$("#departmentId").live("change",function(){
	showData();
});

</script>

</body>
</html>
