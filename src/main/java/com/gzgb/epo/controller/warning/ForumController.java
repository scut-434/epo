package com.gzgb.epo.controller.warning;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gzgb.epo.entity.ForumList;
import com.gzgb.epo.service.warning.ForumListService;
import com.gzgb.epo.util.DateUtil;


/**
 * 
 * <pre>
 * 论坛帖子控制器
 * </pre>
 * 
 * @author JiangRundong
 * @version 1.0, 2013-2-25
 */
@Controller
@RequestMapping(value = "/forum")
public class ForumController {
	
	@Autowired
	private ForumListService forumListService;
	Logger logger = LoggerFactory.getLogger(ForumController.class);
	
	@RequestMapping(value = "monitorForum")
	public String monitorForum(Model model, HttpServletRequest request) {
		
		List<Map<String,Object>> webSiteNameList= forumListService.findWsmId();
		model.addAttribute("webSiteNameList", webSiteNameList);
		return "warning/monitorForum";
	}
	
//	@RequestMapping(value = "forumTop20")
//	public @ResponseBody String forumTop20(Model model,HttpServletRequest request){
//		
//		
//			return "warning/warningHotForum";
//	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "forumSearch")
	public @ResponseBody
	Map<String, Object> weiboSearch(HttpServletRequest request, String content,
			String start, String end, Integer sortOrder, Integer wsmId,
			Integer page) {
		if (page == null || page == 0) {
			page = 1;
		}
		Long a = DateUtil.parseSimpleDate(start).getTime() / 1000;
		Long b = DateUtil.parseSimpleDate(end).getTime() / 1000;
		int startTime = a.intValue();
		int endTime = b.intValue();

		Map<String, Object> myMap = null;
		if (sortOrder!=null && sortOrder == 0) {
			// 按时间 升序排序
			myMap = forumListService.findForum(startTime, endTime, wsmId,
					content, page, null, "wflTimestamp", "asc");
		} else {
			// 默认按热度降序排列
			myMap = forumListService.findForum(startTime, endTime, wsmId,
					content, page, null, null, null);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		if (myMap != null && !"".equals(myMap.get("rows").toString())) {
			List<ForumList> list = (List<ForumList>) myMap.get("rows");
			for (int i = 0; i < list.size(); i++) {
				ForumList forumList = list.get(i);
				Map<String, Object> inMap = new HashMap<String, Object>();
				inMap.put("url", forumList.getWflUrl());
				inMap.put("fullTitle", forumList.getWflTitle());
//				inMap.put("source", forumList.getWsmId().getId());
				inMap.put("title", forumList.getWflTitle());
				inMap.put("hots", forumList.getWflHots());
				inMap.put("reply", forumList.getWflReply());
				inMap.put("view", forumList.getWflView());
				inMap.put("site", forumList.getWsmId().getId());
//				inMap.put("fullAuthor", forumList.getWflAuthor());
//				inMap.put("author", forumList.getWflAuthor());
				Long time = Long.parseLong(forumList.getWflTimestamp().toString()) * 1000;
				SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 格式化日期
				inMap.put("date", f.format(new Date(time)));
				inMap.put("updateUrl", forumList.getWflUrl());

				dataList.add(inMap);
			}
		}
		Map<String, Object> pageList = new HashMap<String, Object>();
		int total = (myMap == null) ? 0 : Integer.parseInt(myMap.get("total")
				.toString());
		pageList.put("size", 20); // 默认为20
		int size = 1;
		if (total > 20) {
			if (total % 20 != 0) {
				size = total / 20 + 1;
			} else {
				size = total / 20;
			}
		}
		pageList.put("count", size);
		pageList.put("current", page);
		pageList.put("total", total);

		map.put("data", dataList);
		map.put("page", pageList);
		return map;
	}
	
	@RequestMapping(value = "forumIndex")
	public @ResponseBody
	List<Map<String, Object>> forumIndex(HttpServletRequest request,
			Integer day, Integer site) {
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		if (day != null) {
			Long a = DateUtil.parseSimpleDate("2013-4-8").getTime() / 1000;
			// Long a = new Date().getTime()/1000;
			Long b = a - day * 3600 * 24;
			int startTime = b.intValue();
			int endTime = a.intValue();
			dataList = forumListService
					.findForumTop20(startTime, endTime, site);
		}

		return dataList;
	}


}
