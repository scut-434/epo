//获取数据列表
var params='';
var objParams = {};
var re = new RegExp("[0-9\-]+","g");
function getItemVal(pageGo)
{
	//获取表单
	var objForm = $('form')[0];
	//通过获取日期
	rangDate = $('#widgetField span').html().match(re);
	//准备参数：搜索条件
	objParams = {};
	objParams[$('#sortOrder').attr('name')] = $('#sortOrder').val();
	objParams['start'] = rangDate[0];
	objParams['end'] = rangDate[1];

	params = $(objForm).find(':text,input:checked,select');
	for(var i=0; i<params.length; i++) {
		if ($(params[i]).val() != '') {
			objParams[$(params[i]).attr('name')] = $(params[i]).val();
		}
	}
	getItemList(pageGo);
	return false;
}

function getItemList(pageGo)
{
	//获取表单
	var objForm = $('form')[0];
	//获取排序方式
	objParams[$('#sortOrder').attr('name')] = $('#sortOrder').val();
	
	var requestUrl = $(objForm).attr('action').toString();
	//设置分页地址
	var max = $("#maxPage").html() == null || isNaN($("#maxPage").html()) || parseInt($("#maxPage").html()) == 0 ? 1 : parseInt($("#maxPage").html());
	if (pageGo > 0 && pageGo <= max){
		var requestUrl = requestUrl.indexOf('?') == -1 ? requestUrl+'?page='+pageGo : requestUrl+'&page='+pageGo;
	}else{
		$("#pageGo").val(1);
		return false;
	}

	//异步请求数据
	getRequestData(requestUrl, objParams, 'post', dataToHtml);
}

//异步请求数据
function getRequestData(url, params, method, handle)
{
	$('#loading').show();
	$('#tableContainer').hide();
	$.ajax({
		type : method,
		url : url,
		data : params,
		dataType : 'json',
		success : function(data) {
					handle(data);
					$('#loading').hide();
					$('#tableContainer').show();
		}
	});
}

//格式化分页信息
function pageToHtml(page)
{
	var pageContent = '<div class="tablePageRight">';

	if (page.total > 0){
		//跳转页
		pageContent += '<span>第</span><span><input id="pageGo" type="text" value='+page.current+' /></span><span>页</span>';
		pageContent += '<span onclick="return getItemList($(\'#pageGo\').val())"><a href="###"></a></span></div>';

		//上一页
		pageContent += '<div class="tablePageNum">';
		pageContent += '<span '+(page.current>1 ? 'onclick="return getItemList('+(page.current-1) +')" class="up"><a href="###"></a></span>': 'class="upend"><a></a></span>');

		var pageLength = 5;
		for(var i=1; i<=page.count; i++) {
			if (page.current>Math.floor(pageLength/2) && page.current<page.count-Math.floor(pageLength/2) && (i<page.current-Math.floor(pageLength/2) || i>page.current+Math.floor(pageLength/2))){
				continue;
			} 
			if (page.current<Math.ceil(pageLength/2) && i>pageLength){
				continue;
			}
			if (page.current>page.count-Math.ceil(pageLength/2) && i<=page.count-pageLength){
				continue;
			}
			if (page.current == i){
				pageContent += '<span class="normal act"><a href="###">'+i+'</a></span>';
			} else {
				pageContent += '<span onclick="return getItemList('+i+')" class="normal"><a href="###">'+i+'</a></span>';
			}
		}

		//下一页
		pageContent += '<span '+(page.current<page.count ? 'onclick="return getItemList('+(page.current+1) +')" class="next"><a href="###"></a></span>': 'class="nextend"><a></a></span>'); 
	}

	pageContent += '</div>';

	$('#pageInfo').html('<span>共有<tt>'+page.total+'</tt>条记录</span> <span>共有<tt id="maxPage">'+page.count+'</tt>页</span>');
	$('#pageContainer').html(pageContent);
}

//格式化搜索列表
function dataToHtml(response)
{
	var tableHeader = '<tr><th align="center" width="33%">标题</th><th align="center" width="9%">热度</th><th align="center" width="10%">查看数</th><th align="center" width="7%">回复数</th><th align="center" width="13%">网站</th><th align="center" width="15%">发布时间</th><th align="center" width="9%">操作</th></tr>';
	var tableContent = '';
	if (response.data && response.data.length > 0){
		for(var i=0; i<response.data.length; i++) {
			tableContent += '<td align="center" width="33%"><div class="pTitle"><a title="'+response.data[i].fullTitle+'" target="_blank" href="'+response.data[i].url+'">'+response.data[i].title+'</a></div></td>';
			tableContent += '<td align="center" width="9%">'+response.data[i].hots+'</td>';
			tableContent += '<td align="center" width="10%">'+response.data[i].view+'</td>';
			tableContent += '<td align="center" width="7%">'+response.data[i].reply+'</td>';
			tableContent += '<td align="center" width="13%">'+response.data[i].site+'</td>';
			tableContent += '<td align="center" width="15%">'+response.data[i].date+'</td>';
			tableContent += '<td align="center" width="9%"><div class="mainstreamTableBnt">';
			tableContent += '<span class="bntLeft"><a href="'+response.data[i].updateUrl+'" onclick="return coveDiv(this);"></a></span>';
			tableContent += '</div></td></tr>';
		}
	}

	pageToHtml(response.page);
	$('#tableContainer').html(tableHeader+tableContent);
}