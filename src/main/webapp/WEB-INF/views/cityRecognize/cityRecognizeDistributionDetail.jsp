<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
	.changemonitorCon { height: 1400px; }
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
								<span class="aTitle">涉穂报道分布图</span>
								<span class="bTitle">详细信息</span>
							</div>
							
					    </div>
					<!-- top end -->
					<!-- content start -->
				<center>
	
                        <div class="mainstream marginTop">
						<div class="informationSourceTitle" align = "center">
						<span class="sourceLeft" align = "left">${province}省涉穂相关报道</span>
						</div>
<!--画涉穂相关报道饼图 开始 -->	
			<div class="clumnTBox">
			<div class="Choice">
				<span class="space1">类型：</span>
				<span class="systemSearchRight marginLeft">
					<select name="emotionOrPolitical" id="emotionOrPolitical">
						<option value="0" selected="selected">情感倾向</option>
						<option value="1">政治倾向</option>	
					</select>
				</span>
				<span class="space2">时间：</span>
				<span class="systemSearchRight marginLeft">
					<select id="emotionOrPoliticalTime" class="emotionOrPoliticalTime">
						<option value="2" selected="selected">最近2个月</option>
						<option value="4">最近4个月</option>
						<option value="6">最近6个月</option>
						<option value="8">最近8个月</option>
					</select>
				</span>
				
			</div>
			<div class="clear"></div>
            <div class="centerImg" id="reportPieChart" style="overflow:hidden;height:350px;"><img src="/static/images/loadingBig.gif" /></div>
			<div class="loading"></div>
		</div>
		
	</div>
<!-- 画涉穂相关报道饼图结束 -->


<!-- 画涉穂报道焦点开始-->
						<div class="mainstream marginTop">
						<div class="informationSourceTitle marginTop2" id="9web_top">
						<span class="sourceLeft" align = "left">${province}涉穂报道关键字柱状图</span>
						</div>
						<div class="clumnTBox">
							<div class="Choice">
								<span class = "space1">类型：</span>
								<span class="systemSearchRight marginLeft">
									<select name="focusType" id="focusType">
										<option value="0" selected="selected">情感倾向</option>
										<option value="1">政治倾向</option>
									</select>
								</span>
							
								<span class = "space1">时间：</span>
								<span class="systemSearchRight marginLeft">
									<select name="focusTime" id="focusTime">
										<option value="3" selected="selected">3个月</option>
										<option value="5">5个月</option>	
										<option value="7">7个月</option>
										<option value="9">9个月</option>
										<option value="11">11个月</option>
									</select>
								</span>
								</div>
							<div class="centerImg" id="focusColumn" style="overflow:hidden;height:308px;"><img src="/static/images/loadingBig.gif" /></div>
						</div>

						</div>

<!-- 画涉穂报道焦点结束 -->


<!-- 画涉穂报道倾向变化开始-->
						<div class="mainstream marginTop">
						<div class="informationSourceTitle marginTop2" id="9web_top">
						<span class="sourceLeft" align = "left">${province}涉穂报道倾向折线图</span>
						</div>
						<div class="clumnTBox">
							<div class="Choice">
								<span class = "space1">时间：</span>
								<span class="systemSearchRight marginLeft">
									<select name="reportType" id="reportType">
										<option value="0" selected="selected">情感倾向</option>
										<option value="1">政治倾向</option>
									</select>
								</span>
							
								<span class = "space1">时间：</span>
								<span class="systemSearchRight marginLeft">
									<select name="reportTime" id="reportTime">
										<option value="5" selected="selected">5个月</option>
										<option value="7">7个月</option>	
										<option value="9">9个月</option>
										<option value="11">11个月</option>
									</select>
								</span>
								</div>
							<div class="centerImg" id="reportLineChart" style="overflow:hidden;height:308px;"><img src="/static/images/loadingBig.gif" /></div>
						</div>

						</div>

<!-- 画涉穂报道倾向变化结束 -->
				</center>
<!-- content end -->
			</div>
				
<!-- 页面内容  end -->
<input type="hidden" id="getEmoOrPoliByTime" value="/cityRecognize/getEmoOrPoliByTime" />
<input type="hidden" id="getFocusByTimeAndType" value="/cityRecognize/getFocusByTimeAndType" />
<input type="hidden" id="getReportByTimeAndType" value="/cityRecognize/getReportByTimeAndType" />
<input type="hidden" id="cityRegionId" value="${cityRegionId }" />
<!-- table content end -->

<script type = "text/javascript">
$(function (){
	drawEmotionOrPoliticalPieChart();
	drawFocusColumnChart();
	drawReportLineChart();
	$('#emotionOrPolitical').change(function() {
		drawEmotionOrPoliticalPieChart();
	});
	
	$('#emotionOrPoliticalTime').change(function() {
		
		drawEmotionOrPoliticalPieChart();
	});
	$('#focusType').change(function() {
		
		drawFocusColumnChart();
	});
	$('#focusTime').change(function() {
		
		drawFocusColumnChart();
	});
	$('#reportType').change(function() {
		
		drawReportLineChart();
	});
	$('#reportTime').change(function() {
		drawReportLineChart();
	});
	
});

</script>

<!-- 画涉穂相关报道饼图用的 -->

<script type="text/javascript">	
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawChart);
  function drawChart() {

  }

  var negative = "#FF0000";
  var neutral = "#fcaf17";
  var positive = "#00CD00";
  var pieChartOptions = {

  		 slices: {
  		  0:{color: positive,visibleInLegend: true},
  		  1:{color: neutral,visibleInLegend: true},
  		  2:{color: negative,visibleInLegend: true}

  		},
  				 
  		   width: 315,
  		  height: 250,
  		  chartArea: 
  		  {
  			width: 315,
  			height: 250,
  			top:65
  		  },
  		  legend:
  		  {
  			alignment: 'center',
  			textStyle:
  			{
  				fontSize: 16,
  				fontFamily:'simsun'
  			}
  		  }
  		 
  		};
  function drawEmotionOrPoliticalPieChart(){
		$.ajax({
			type: 'post',
			url: $("#getEmoOrPoliByTime").val(),
			data: {type:$("#emotionOrPolitical").val(), month:$("#emotionOrPoliticalTime").val(), isAbout:1,cityRegionId:$("#cityRegionId").val()},
			dataType: 'json',
			success: function(msg){
				var webList = new Array();
				for(j in msg){
					webList.push(new Array(msg[j].name,parseInt(msg[j].count)));
				}
				
		
				webList.unshift(new Array('新闻', 'Hours per Day'));//添加一个设置项

				var HYdata = google.visualization.arrayToDataTable(webList);
				var HYchart = new google.visualization.PieChart(document.getElementById('reportPieChart'));
				HYchart.draw(HYdata, pieChartOptions);
			}
				  
		});
	}
		
</script>


<!-- 画涉穂相关报道关注焦点柱状图用的 -->
<script type = "text/javascript">
var focusColumnChart = new google.visualization.ColumnChart(document.getElementById('focusColumn'));
var FocusColumnChartOption = {

		  width: 790,
		  height: 308,
		 
		 
		  series: {
			  0:{color: positive, visibleInLegend: true},
			  1:{color: neutral, visibleInLegend: true},
			  2:{color: negative, visibleInLegend: true},

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
		  easing: 'in'
		  },
		  curveType: 'function',
		  isStacked: true
		};
		
function drawFocusColumnChart(){
	$.ajax({
		type: 'post',
		  url: $("#getFocusByTimeAndType").val(),
		  data: {type:$('#focusType').val(), month:$("#focusTime").val(), isAbout:1,cityRegionId:$("#cityRegionId").val()},
		  dataType: 'json',
		  success: function(msg){
			  var focusData = new google.visualization.DataTable();
			  var focusList = new Array();
			for(j in msg){
				var array = new Array();
				array.push(msg[j][0]);
				array.push(msg[j][1]);
				array.push(msg[j][2]);
				array.push(msg[j][3]);
				focusList.push(array);
			}
			
			//默认加载生成图表
			if($('#focusType').val() == 0){
				focusData.addColumn('string', '关键字名称');
				focusData.addColumn('number', '正面');
				focusData.addColumn('number', '中立');
				focusData.addColumn('number', '负面');
			}
			else{
				focusData.addColumn('string', '关键字名称');
				focusData.addColumn('number', '右倾');
				focusData.addColumn('number', '中立');
				focusData.addColumn('number', '左倾');
				
			}
			focusData.addRows(focusList);
			
			focusColumnChart.draw(focusData ,FocusColumnChartOption);
			
		}
			  
	});
}
		
</script>


<!--画涉穂报道的倾向折线图 -->
<script type = "text/javascript">

var LineChartOptions = {

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
			height: 229,
			top:40
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
var lineChart = new google.visualization.LineChart(document.getElementById('reportLineChart'));//定义图表类型与位置		
		
function drawReportLineChart(){
	$.ajax({
	  type: 'post',
	  url: $("#getReportByTimeAndType").val(),
	  data: {type:$("#reportType").val(),month:$("#reportTime").val(),isAbout: 1,cityRegionId:$("#cityRegionId").val()},
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
	if($("#reportType").val() == 0){
		DataTable.addColumn('date', '日期');
		DataTable.addColumn('number', '正面');
		DataTable.addColumn('number', '中立');
		DataTable.addColumn('number', '负面');
	}
	else{
		DataTable.addColumn('date', '日期');
		DataTable.addColumn('number', '右倾');
		DataTable.addColumn('number', '中立');
		DataTable.addColumn('number', '左倾');
	}
	DataTable.addRows(chartData);//加载数据
	lineChart.draw(DataTable, LineChartOptions);//生成图表
}


//生成图表,无数据
function createTable_nodata(msg){
	google.visualization.events.removeAllListeners(lineChart);
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
	lineChart.draw(firstTable, LineChartOptions);//生成图表
}

</script>


</body>
</html>
