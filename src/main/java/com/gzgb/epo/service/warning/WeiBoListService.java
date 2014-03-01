package com.gzgb.epo.service.warning;

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

import com.gzgb.epo.dao.warning.WeiBoListDao;
import com.gzgb.epo.entity.NewsList;
import com.gzgb.epo.entity.WeiBoList;
import com.gzgb.epo.service.base.BaseService;
import com.gzgb.epo.util.DateUtil;

/**
 * 
 * <pre>
 * 微博舆情service
 * </pre>
 * 
 * @author XiaoJian
 * @version 1.0, 2014-2-25
 */
@Service
@Transactional(readOnly = true)
public class WeiBoListService extends BaseService<WeiBoList> {

	private static Logger logger = LoggerFactory
			.getLogger(WeiBoListService.class);

	@Autowired
	private WeiBoListDao weiBoListMainDao;

	/**
	 * 
	 * <pre>
	 * 根据时间戳、微博站点、微博内容查询微博
	 * </pre>
	 * 
	 * @param startTime
	 *            开始时间戳
	 * @param endTime
	 *            结束时间戳
	 * @param site
	 *            微博站点（新浪/腾讯)
	 * @param content
	 *            微博内容
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
	public Map<String, Object> findWeiBo(Integer startTime, Integer endTime,
			Integer site, String content, Integer page, Integer rows,
			String sort, String order) {
		logger.info("--findWeiBo()方法");
		Map<String, Object> map = weiBoListMainDao.findWeiBo(startTime,
				endTime, site, content, page, rows, sort, order);
		return map;
	}

	/**
	 * 
	 * <pre>
	 * 根据时间戳、微博站点查询热度最高的20条微博
	 * </pre>
	 * 
	 * @param startTime
	 *            开始时间戳
	 * @param endTime
	 *            结束时间戳
	 * @param site
	 *            微博站点（新浪/腾讯)
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findWeiBoTop20(Integer startTime,
			Integer endTime, Integer site) {
		logger.info("--findWeiBoTop20()方法");
		Map<String, Object> map = findWeiBo(startTime, endTime, site, null,
				null, null, null, null);
		List<Map<String, Object>> myMap = null;
		if (map != null && !"".equals(map.get("rows").toString())) {
			myMap = new ArrayList<Map<String, Object>>();
			List<WeiBoList> objList = (List<WeiBoList>) map.get("rows");
			if(objList!=null){
				int count = 20;
				if(objList.size()<20){
					count = objList.size();
				}
				for (int i = 0; i < count; i++) {
					WeiBoList weiBoList = objList.get(i);
					Map<String, Object> inMap = new HashMap<String, Object>(); 
					inMap.put("url", weiBoList.getWwlUrl());
					inMap.put("fullContent", weiBoList.getWwlContent());
					inMap.put("wsmId", weiBoList.getWsmId().getId());
					inMap.put("content", weiBoList.getWwlContent());
					inMap.put("comment", weiBoList.getWwlComment());
					inMap.put("ftorwarding", weiBoList.getWwlFtorwarding());
					inMap.put("author", weiBoList.getWwlAuthor());
					Long time = Long.parseLong(weiBoList.getWwlTimestamp().toString()) * 1000;
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
	 * 查找今天热点微博(10条)
	 * </pre>
	 * @param request
	 * @return
	 */
	public List<Map<String, Object>> findTodayWeiBo() {
		logger.info("--findTodayWeiBo()方法");
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
		
		Date date = DateUtil.parseDateTime("2013-05-05 23:23:23");
		//Date date = new Date();
		String start = f.format(date);
		f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String end = f.format(date);
		Long startT = DateUtil.parseSimpleDate(start).getTime()/1000;
		Long endT = DateUtil.parseDateTime(end).getTime()/1000;
		Map<String, Object> map = findWeiBo(startT.intValue(), endT.intValue(), null, null,
				null, null, null, null);
		if (map != null && !"".equals(map.get("rows").toString())) {
			List<WeiBoList> objList = (List<WeiBoList>) map.get("rows");
			if(objList!=null){
				int count = 10;
				if(objList.size()<10){
					count = objList.size();
				}
				for (int i = 0; i < count; i++) {
					WeiBoList weiBoList = objList.get(i);
					Map<String, Object> inMap = new HashMap<String, Object>(); 
					inMap.put("url", weiBoList.getWwlUrl());
					if(weiBoList.getWsmId()!=null){
						if(weiBoList.getWsmId().getId()==18){
							inMap.put("type", "xinlang");
						}else{
							inMap.put("type", "tx");
						}
					}
					inMap.put("title", weiBoList.getWwlContent());
					inMap.put("num1", weiBoList.getWwlComment());
					inMap.put("num2", weiBoList.getWwlFtorwarding());
					inMap.put("num3", weiBoList.getWwlAuthor());
					Long time = Long.parseLong(weiBoList.getWwlTimestamp().toString()) * 1000;
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
	 * 查找今天涉穗微博数
	 * </pre>
	 * @return
	 */
	public int findTodayWeiBoCount() {
		logger.info("--findTodayWeiBoCount()方法");
		int count = 0;
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
		Date date = DateUtil.parseDateTime("2013-05-05 23:23:23");
		//Date date = new Date();
		String start = f.format(date);
		f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String end = f.format(date);
		Long startT = DateUtil.parseSimpleDate(start).getTime()/1000;
		Long endT = DateUtil.parseDateTime(end).getTime()/1000;
		Map<String, Object> map = findWeiBo(startT.intValue(), endT.intValue(), null, null,
				null, null, null, null);
		if (map != null) {
			count =  (Integer) map.get("total");
		}
		return count;
	}

}
