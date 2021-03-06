package com.gzgb.epo.service.warning;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gzgb.epo.dao.warning.ForumListDao;
import com.gzgb.epo.entity.BlogList;
import com.gzgb.epo.entity.ForumList;
import com.gzgb.epo.publics.Constants;
import com.gzgb.epo.service.base.BaseService;
import com.gzgb.epo.util.DateUtil;

/**
 * 
 * <pre>
 * 论坛帖子舆情service
 * </pre>
 * 
 * @author JiangRundong
 * @version 1.0, 2014-2-25
 */
@Service
@Transactional(readOnly = true)

public class ForumListService extends BaseService<ForumList>{
	private static Logger logger = LoggerFactory
	.getLogger(ForumListService.class);
	
	@Autowired
	private ForumListDao forumListMainDao;
	
	/**
	 * 
	 * <pre>
	 * 根据时间戳、帖子站点、帖子内容查询帖子
	 * </pre>
	 * 
	 * @param startTime
	 *            开始时间戳
	 * @param endTime
	 *            结束时间戳
	 * @param site
	 *            帖子站点
	 * @param content
	 *            帖子内容
	 * @param page
	 *            当前第几页
	 * @param rows
	 *            每页显示数目
	 * @param sort
	 *            按某字段排序
	 * @param order
	 *            升/降序
	 * @return
	 */
	public Map<String, Object> findForum(Integer startTime, Integer endTime,
			Integer site, String content, Integer page, Integer rows,
			String sort, String order) {
		logger.info("--findForum()方法");
		Map<String, Object> map = forumListMainDao.findForum(startTime,
				endTime, site, content, page, rows, sort, order);
		return map;
	}
	
	/**
	 * 
	 * <pre>
	 * 根据时间戳、微博站点查询热度最高的20条帖子
	 * </pre>
	 * 
	 * @param startTime
	 *            开始时间戳
	 * @param endTime
	 *            结束时间戳
	 * @param site
	 *            帖子站点
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findForumTop20(Integer startTime,
			Integer endTime, Integer site) {
		logger.info("--findForumTop20()方法");
		Map<String, Object> map = findForum(startTime, endTime, site, null,
				null, null, null, null);
		List<Map<String, Object>> myMap = null;
		if (map != null && !"".equals(map.get("rows").toString())) {
			myMap = new ArrayList<Map<String, Object>>();
			List<ForumList> objList = (List<ForumList>) map.get("rows");
			if(objList!=null){
				
				int count=20;
				if(objList.size()<20){
					count=objList.size();
				}
				for (int i = 0; i < count; i++) {
					ForumList forumList = objList.get(i);
					Map<String, Object> inMap = new HashMap<String, Object>(); 
					inMap.put("url", forumList.getWflUrl());
					inMap.put("fullTitle", forumList.getWflTitle());
//					inMap.put("wsmId", forumList.getWsmId().getId());
					inMap.put("title", forumList.getWflTitle());
					inMap.put("reply", forumList.getWflReply());
					inMap.put("view", forumList.getWflView());
					inMap.put("site", forumList.getWsmId().getWsmName());
					Long time = Long.parseLong(forumList.getWflTimestamp().toString()) * 1000;
					SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 格式化日期
					inMap.put("date", f.format(new Date(time)));
					myMap.add(inMap);
				}
			}
			
		}

		return myMap;
	}
	
	/**
	 * 
	 * <pre>
	 * 找出帖子所在的所有站点
	 * </pre>
	 * 
	 * @return
	 */
	public List<Map<String, Object>> findWsmId() {
		logger.info("--findWsmId()方法");
		List<ForumList> list = findAll(ForumList.class);
		List<Map<String, Object>> myList = new ArrayList<Map<String, Object>>();
		Map<Object, Object> map = new HashMap<Object, Object>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				ForumList forumList = list.get(i);
				if(forumList.getWsmId()!=null){
					try {
						map.put(forumList.getWsmId().getId(), forumList.getWsmId().getWsmName());
					} catch (Exception e) {
						System.out.println("some Object not found");
					}
					
				}
				
			}
			for(Iterator it=map.keySet().iterator();it.hasNext();){
				Map<String, Object> myMap = new HashMap<String, Object>();
				Long key = (Long) it.next();
				myMap.put("key",key );
				myMap.put("value", map.get(key));
				myList.add(myMap);
			}
		}

		return myList;
	}
	
	/**
	 * 
	 * <pre>
	 * 查找今天热点帖子(10条)
	 * </pre>
	 * @param request
	 * @return
	 */
	public List<Map<String, Object>> findTodayForum() {
		logger.info("--findTodayForum()方法");
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
		
//		Date date = DateUtil.parseDateTime("2013-05-05 23:23:23");
		//Date date = new Date();
		String start = f.format(Constants.date);
		f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String end = f.format(Constants.date);
		Long startT = DateUtil.parseSimpleDate(start).getTime()/1000;
		Long endT = DateUtil.parseDateTime(end).getTime()/1000;
		Map<String, Object> map = findForum(startT.intValue(), endT.intValue(), null, null,
				null, null, null, null);
		if (map != null && !"".equals(map.get("rows").toString())) {
			List<ForumList> objList = (List<ForumList>) map.get("rows");
			if(objList!=null){
				int count = 10;
				if(objList.size()<10){
					count = objList.size();
				}
				for (int i = 0; i < count; i++) {
					ForumList forumList = objList.get(i);
					Map<String, Object> inMap = new HashMap<String, Object>(); 
					inMap.put("wsmId", forumList.getWsmId().getId());
					inMap.put("title", forumList.getWflTitle());
					inMap.put("num1", forumList.getWflReply());
					inMap.put("num2", forumList.getWflView());
					inMap.put("num3", forumList.getWsmId().getWsmName());
					Long time = Long.parseLong(forumList.getWflTimestamp().toString()) * 1000;
					f = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 格式化日期
					inMap.put("date", f.format(new Date(time)));
					dataList.add(inMap);
				}
			}
		}
		
		return dataList;
	}
	
	/**
	 * 
	 * <pre>
	 * 查找实时舆情
	 * </pre>
	 * @param number
	 * @return
	 */
	public List<Map<String, Object>> findSensitive(Integer number){
		logger.info("--findSensitive()方法");
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
		
//		Date date = DateUtil.parseDateTime("2013-05-05 23:23:23");
		//Date date = new Date();
		String start = f.format(Constants.date);
		f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String end = f.format(Constants.date);
		Long startT = DateUtil.parseSimpleDate(start).getTime()/1000;
		Long endT = DateUtil.parseDateTime(end).getTime()/1000;
		Map<String, Object> map = findForum(startT.intValue(), endT.intValue(), null, null,
				null, null, null, null);
		if (map != null && !"".equals(map.get("rows").toString())) {
			List<ForumList> objList = (List<ForumList>) map.get("rows");
			if(objList!=null){
				for (int i = 0; i < objList.size(); i++) {
					ForumList forumList = objList.get(i);
					Map<String, Object> inMap = new HashMap<String, Object>(); 
					try {
						inMap.put("rbiName", forumList.getRbiId().getRbiName());
						inMap.put("rbiId", forumList.getRbiId().getId());
					} catch (Exception e) {
						System.out.println("some Object not found --FourmListService.findSensitive()方法");
					}
					inMap.put("url", forumList.getWflUrl());
					inMap.put("content", forumList.getWflContent());
					inMap.put("wsmId", forumList.getWsmId().getId());
					inMap.put("title", forumList.getWflTitle());
					inMap.put("comment", forumList.getWflReply());
					inMap.put("view", forumList.getWflView());
					inMap.put("fullTitle", forumList.getWflTitle());
					inMap.put("type", 4);
					Long time = Long.parseLong(forumList.getWflTimestamp().toString()) * 1000;
					f = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 格式化日期
					inMap.put("dateTime", f.format(new Date(time)));
					f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
					inMap.put("date", f.format(new Date(time)));
					dataList.add(inMap);
				}
			}
		}
		
		return dataList;
	}
	
	/**
	 * 
	 * <pre>
	 * 查找今天涉穗帖子数
	 * </pre>
	 * @return
	 */
	public int findTodayForumCount() {
		logger.info("--findTodayForumCount()方法");
		int count = 0;
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
//		Date date = DateUtil.parseDateTime("2013-05-05 23:23:23");
		//Date date = new Date();
		String start = f.format(Constants.date);
		f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String end = f.format(Constants.date);
		Long startT = DateUtil.parseSimpleDate(start).getTime()/1000;
		Long endT = DateUtil.parseDateTime(end).getTime()/1000;
		Map<String, Object> map = findForum(startT.intValue(), endT.intValue(), null, null,
				null, null, null, null);
		if (map != null) {
			count =  (Integer) map.get("total");
		}
		return count;
	}

}
