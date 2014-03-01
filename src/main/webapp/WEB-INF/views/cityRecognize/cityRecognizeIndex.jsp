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
<div class="con">
<!-- topNav start -->
	<div class="topNav">
		<div class="navDiv"><a href="/mainMedia/index" >主流媒体舆情</a></div>
		<div class="navDiv"><a href="/warning/index" >舆情预警</a></div> 
		<div class="navDiv act"><a href="/cityRecognize/index" >城市形象与认知度</a></div>
		<div class="navDiv"><a href="/leaderRecognition/index" >舆论领袖识别</a></div>
		<div class="navDiv"><a href="/knowledgeDictLibManage/index" >知识库管理</a></div>
		<div class="navDiv"><a href="/systemManage/index" >系统管理</a></div>
	</div>
<!-- topNav end -->

<!-- table content start -->
	<div class="tableContent">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top">
				<div class="tableContentLeft">
					<div class="navTitle"><a class="act" href="/cityRecognize/index" target="_blank">城市形象与认知度</a></div>
					<div class="navSubTitle"><a href="/cityRecognize/cityRecognizeSentimentAnalysis" targe="_blank" >情感分析</a></div>
					<div class="navSubTitle"><a href="/cityRecognize/cityRecognizeImpressionKey" target="_blank">印象关键词</a></div>
					<div class="navSubTitle"><a href="/cityRecognize/cityRecognizeDistributionMap" target="_blank">涉穗报道分布图</a></div>
					<div class="navSubTitle"><a href="/cityRecognize/cityRecognizeMainMediaConcern" target="_blank">主流媒体关注度</a></div>
					<div class="navSubTitle"><a href="/cityRecognize/cityRecognizePublicOpinion" target="_blank">公众评价</a></div>
				</div>
			</td>
			<td class="tdBak" valign="top">
				<div class="tableContentRight">
					<div class="currentPosition">
					&nbsp;&nbsp;&nbsp;&nbsp;当前位置：&nbsp;&nbsp;城市形象与认知度&nbsp;>&nbsp;城市形象与认知度
					</div>
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

.biaoti { width:450px;
          display: inline;
          float: left;
          font-size: 20px;
          height:30px;
          inline-height:38px;
          font-weight:bold;
          color:#1486cd;
          text-indent:5px;
}
.xiangxi { float:right;
           display:inline;
           width:40px;
}
.xiahuaxian { width:100%;
              height:30px;
              overflow:hidden;
              clear:both;
              border-bottom:1px solid #cccccc;
}
</style>
				<!-- 页面内容 start -->
				<span class="biaoti">媒体及公众对广州的情感倾向</span>
				<br/>
				<img src="http://chart.apis.google.com/chart?chs=400x250&chd=${emotion_Y}&cht=bhg&chbh=30&chtt=情感倾向分布&chco=ff0000&chf=c,s,76A4FB|bg,s,FFF2CC&chxt=x,y&chxl=${emotion_X}"/>
				<br />  
				<img src="http://chart.apis.google.com/chart?chs=400x250&chd=${timeEmotion}&cht=lc&chbh=50&chdl=正面|中立|负面&chtt=情感倾向变化趋势&chco=ff0000,0000ff,00ff00&chf=
c,ls,90,999999,0.25,CCCCCC,0.25,FFFFFF,0.25&chxt=x,y&chxl=${timeString}"/>
				<br/>
				<img src="http://chart.apis.google.com/chart?chs=600x400&chd=${mediaAttention_Y}&cht=bvs&chbh=50&chdl=正面|中立|负面&chtt=主流媒体关注度柱状图&chco=ff0000,0000ff,00ff00&chf=c,s,76A4FB|bg,s,FFF2CC&chxt=x,y&chxl=${mediaAttention_X}"/>
				<br />
				<img src="http://chart.apis.google.com/chart?chs=400x400&chd=${publicAttention_Y}&cht=bvs&chbh=50&chdl=正面|中立|负面&chtt=公众对广州的关注度&chco=ff0000,0000ff,00ff00&chxt=x,y&chxl=${publicAttention_X}"/>
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
