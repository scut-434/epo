package com.gzgb.epo.service.mediaLeader;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gzgb.epo.dao.mediaLeader.MediaLeaderDao;
import com.gzgb.epo.entity.CityRegion;
import com.gzgb.epo.entity.MediaLeader;
import com.gzgb.epo.service.base.BaseService;

/**
 * 
 * <pre>
 * 舆论领袖Service
 * </pre>
 * 
 * @author LiuYongbin
 * @version 1.0, 2014-2-25
 */
@Service
public class MediaLeaderService extends BaseService<MediaLeader> {

	private static Logger log = LoggerFactory.getLogger(BaseService.class);
	@Autowired
	MediaLeaderDao mlDao;
	/**
	 * 
	 * <pre>
	 * 查询所有记录,附带参数并排序,参数可模糊匹配
	 * </pre>
	 * 
	 * @param cls
	 *            实体类名
	 * @param mapString
	 *            字符串参数列表
	 * @param mapByte
	 *            字字节型参数列表
	 * @param mapInt
	 *            整形参数列表
	 * @param mapLong
	 *            Long型参数列表 
	 * @param cityRegionList
	 *            城市类型参数列表 ,
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
	public Map<String, Object> getAllWithList(final Map<String, String> mapString,
			final Map<String, Byte> mapByte, final Map<String, Integer> mapInt,
			final Map<String, Long> mapLong, final List<CityRegion> cityRegionList, Integer page, Integer rows,
			String sort, String order) {
		try {
			log.info("---getAllWithList()方法");
			return mlDao.getAllWithList(mapString, mapByte, mapInt, mapLong, cityRegionList,
					page, rows, sort, order);
		} catch (Exception ex) {
			log.error(ex.toString());
			return null;
		}
	}
	
}
