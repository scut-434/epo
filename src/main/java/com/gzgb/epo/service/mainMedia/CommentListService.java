package com.gzgb.epo.service.mainMedia;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gzgb.epo.dao.mainMedia.CommentListDao;
import com.gzgb.epo.entity.CommentList;
import com.gzgb.epo.entity.NewsList;
import com.gzgb.epo.publics.Constants;
import com.gzgb.epo.service.base.BaseService;
import com.gzgb.epo.util.DateUtil;

/**
 * 
 * <pre>
 * 评论舆情service
 * </pre>
 * 
 * @author XiaoJian
 * @version 1.0, 2014-2-26
 */
@Service
@Transactional(readOnly = true)
public class CommentListService extends BaseService<CommentList> {
	

	private static Logger logger = LoggerFactory
			.getLogger(CommentListService.class);

	@Autowired
	private CommentListDao commentListDao;
	
	/**
	 * 
	 * <pre>
	 * 根据时间戳、境内外、评论内容查询评论
	 * </pre>
	 * 
	 * @param startTime
	 *            开始时间戳
	 * @param endTime
	 *            结束时间戳
	 * @param site
	 *            境内外
	 * @param content
	 *            内容
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
	public Map<String, Object> findComment(Integer startTime, Integer endTime,
			Integer site, String content, Integer page, Integer rows,
			String sort, String order) {
		logger.info("--findComment()方法");
		Map<String, Object> map = commentListDao.findComment(startTime,
				endTime, site, content, page, rows, sort, order);
		return map;
	}

	/**
	 * 
	 * <pre>
	 * 根据时间戳、境内外查询热度最高的20条评论
	 * </pre>
	 * 
	 * @param startTime
	 *            开始时间戳
	 * @param endTime
	 *            结束时间戳
	 * @param site
	 *            境内外
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findCommentTop20(Integer startTime,
			Integer endTime, Integer site) {
		logger.info("--findCommentTop20()方法");
		Map<String, Object> map = findComment(startTime, endTime, site, null,
				null, null, null, null);
		List<Map<String, Object>> myMap = null;
		if (map != null && !"".equals(map.get("rows").toString())) {
			myMap = new ArrayList<Map<String, Object>>();
			List<CommentList> objList = (List<CommentList>) map.get("rows");
			if(objList!=null){
				int count = 20;
				if(objList.size()<20){
					count = objList.size();
				}
				for (int i = 0; i < count; i++) {
					CommentList ommentList = objList.get(i);
					Map<String, Object> inMap = new HashMap<String, Object>(); 
					inMap.put("url", ommentList.getMmcUrl());
					inMap.put("fullContent", ommentList.getMmcContent());
					inMap.put("wsmId", ommentList.getWsmId().getId());
					inMap.put("content", ommentList.getMmcTitle());
					inMap.put("mmnReserved", ommentList.getMmcReserved());
					SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
					inMap.put("ftorwarding", f.format(new Date(Long.parseLong(ommentList.getMmcReservedTime().toString()) * 1000)));
					inMap.put("author", ommentList.getMmcKeywords());
					Long time = Long.parseLong(ommentList.getMmcTimestamp().toString()) * 1000;
					 f = new SimpleDateFormat("yyyy-MM-dd  HH:mm"); // 格式化日期
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
	 * 查找今天热点评论(10条)
	 * </pre>
	 * @param request
	 * @return
	 */
	public List<Map<String, Object>> findTodayComment() {
		logger.info("--findTodayComment()方法");
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
		
//		Date date = DateUtil.parseDateTime("2013-05-05 23:23:23");
		//Date date = new Date();
		String start = f.format(Constants.date);
		f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String end = f.format(Constants.date);
		Long startT = DateUtil.parseSimpleDate(start).getTime()/1000;
		Long endT = DateUtil.parseDateTime(end).getTime()/1000;
		Map<String, Object> map = findComment(startT.intValue(), endT.intValue(), null, null,
				null, null, null, null);
		if (map != null && !"".equals(map.get("rows").toString())) {
			List<CommentList> objList = (List<CommentList>) map.get("rows");
			if(objList!=null){
				int count = 10;
				if(objList.size()<10){
					count = objList.size();
				}
				for (int i = 0; i < count; i++) {
					CommentList commentList = objList.get(i);
					Map<String, Object> inMap = new HashMap<String, Object>(); 
					inMap.put("url", commentList.getMmcUrl());
					inMap.put("wsmName", commentList.getWsmId().getWsmName());
					inMap.put("title", commentList.getMmcTitle());
					inMap.put("Reserved", commentList.getMmcReserved());
					Long time = Long.parseLong(commentList.getMmcTimestamp().toString()) * 1000;
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
	 * 查找今天涉穗评论数
	 * </pre>
	 * @return
	 */
	public int findTodayCommentCount() {
		logger.info("--findTodayCommentCount()方法");
		int count = 0;
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
//		Date date = DateUtil.parseDateTime("2013-05-05 23:23:23");
		//Date date = new Date();
		String start = f.format(Constants.date);
		f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String end = f.format(Constants.date);
		Long startT = DateUtil.parseSimpleDate(start).getTime()/1000;
		Long endT = DateUtil.parseDateTime(end).getTime()/1000;
		Map<String, Object> map = findComment(startT.intValue(), endT.intValue(), null, null,
				null, null, null, null);
		if (map != null) {
			count =  (Integer) map.get("total");
		}
		return count;
	}

}
