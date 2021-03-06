package com.gzgb.epo.service.warning;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gzgb.epo.dao.warning.SensitiveDayDao;
import com.gzgb.epo.entity.SensitiveDay;
import com.gzgb.epo.publics.Constants;
import com.gzgb.epo.service.base.BaseService;
import com.gzgb.epo.util.DateUtil;

/**
 * 
 * <pre>
 * 每天敏感信息量service
 * </pre>
 * @author XiaoJian
 * @version 1.0, 2014-3-1
 */
@Service
@Transactional(readOnly = true)
public class SensitiveDayService extends BaseService<SensitiveDay> {
	
	private static Logger logger = LoggerFactory
	.getLogger(SensitiveDayService.class);

	@Autowired
	private SensitiveDayDao sensitiveDayDao;
	
	/**
	 * 
	 * <pre>
	 * 查找最新敏感舆情数
	 * </pre>
	 * @return
	 */
	public int findLatelyCount() {
		logger.info("--findLatelyCount()方法");
		int count = 0;
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
//		Date date = DateUtil.parseDateTime("2013-05-05 23:23:23");
		//Date date = new Date();
		String start = f.format(Constants.date);
		f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String end = f.format(Constants.date);
		Long startT = DateUtil.parseSimpleDate(start).getTime()/1000;
		Long endT = DateUtil.parseDateTime(end).getTime()/1000;
		SensitiveDay sensitiveDay = sensitiveDayDao.findLatelyCount(startT.intValue(), endT.intValue());
		if(sensitiveDay!=null){
			count = sensitiveDay.getJsdTotal();
		}
		return count;
	}
	
	/**
	 * 
	 * <pre>
	 * 根据天数统计各站点敏感信息
	 * </pre>
	 * @param day 天数
	 * @return
	 */
	public Map<String,Object> findLatelyStatistics(Integer day){
		logger.info("--findLatelyStatistics()方法");
		SimpleDateFormat f1 = new SimpleDateFormat("yyyy-MM-dd"); // 格式化日期
		SimpleDateFormat f2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		Date date = DateUtil.parseDateTime("2013-05-05 23:23:23");
		//Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		List<Date> listDate = new ArrayList<Date>();
		listDate.add(Constants.date);
		for(int i=1;i<day;i++){
			calendar.setTime(Constants.date);
			calendar.add(Calendar.DAY_OF_MONTH, 0-i);
			Date date1 = calendar.getTime();
			listDate.add(date1);
		}
		Map<String, Object> myMap = new HashMap<String, Object>();
		List<Map<String, Object>> news = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> comments = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> weibos = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> forums = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> blogs = new ArrayList<Map<String, Object>>();

		for(Date k: listDate){
			String start = f1.format(k);
			String end = f2.format(k);
			Long startT = DateUtil.parseSimpleDate(start).getTime()/1000;
			Long endT = DateUtil.parseDateTime(end).getTime()/1000;
			SensitiveDay sensitiveDay = sensitiveDayDao.findLatelyCount(startT.intValue(), endT.intValue());
			if(sensitiveDay!=null){
				Map<String, Object> inMap = new HashMap<String, Object>();
				inMap.put("date", start);
				inMap.put("count", sensitiveDay.getJsdNews());
				news.add(inMap);
				inMap = new HashMap<String, Object>();
				inMap.put("date", start);
				inMap.put("count", sensitiveDay.getJsdComment());
				comments.add(inMap);
				inMap = new HashMap<String, Object>();
				inMap.put("date", start);
				inMap.put("count", sensitiveDay.getJsdWeibo());
				weibos.add(inMap);
				inMap = new HashMap<String, Object>();
				inMap.put("date", start);
				inMap.put("count", sensitiveDay.getJsdForum());
				forums.add(inMap);
				inMap = new HashMap<String, Object>();
				inMap.put("date", start);
				inMap.put("count", sensitiveDay.getJsdBlog());
				blogs.add(inMap);
			}
		}
		myMap.put("news", news);
		myMap.put("comments", comments);
		myMap.put("weibos", weibos);
		myMap.put("forums", forums);
		myMap.put("blogs", blogs);

		return myMap;
	}

}
