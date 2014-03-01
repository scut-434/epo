package com.gzgb.epo.service.mainmediaAttention;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gzgb.epo.dao.mainmediaAttention.MainmediaAttentionDao;
import com.gzgb.epo.dao.puerMainmedia.MainmediaDao;
import com.gzgb.epo.entity.Mainmedia;
import com.gzgb.epo.entity.MainmediaAttention;
import com.gzgb.epo.service.base.BaseService;

/**
 * 
 * <pre>
 * 主流媒体关注度Service
 * </pre>
 * 
 * @author LiuYongbin
 * @version 1.0, 2014-2-26
 */
@Service
public class MainmediaAttentionService extends BaseService<MainmediaAttention> {

	private static Logger logger = LoggerFactory
			.getLogger(MainmediaAttentionService.class);
	@Autowired
	private MainmediaAttentionDao mmaDao;
	@Autowired
	private MainmediaDao mmDao;

	/**
	 * 
	 * <pre>
	 * 统计主流媒体的关注 Map<主流媒体名称，Map<类型， 数量>>
	 * </pre>
	 * 
	 * @param
	 * @return
	 */
	public Map<String, Map<String, Long>> findMainmediaAttention() {
		try {
			logger.info("---findMainmediaAttention()方法");
			List<Mainmedia> mainmediaList = mmDao.findAll(Mainmedia.class);
			Map<String, Map<String, Long>> map = new HashMap<String, Map<String, Long>>();
			for (Mainmedia mm : mainmediaList) {
				Map<String, String> mapping = new HashMap<String, String>();
				mapping.put("name", mm.getName());
				List<MainmediaAttention> mma = mmaDao.getAll(
						MainmediaAttention.class, mapping);
				Map<String, Long> targetMap = new HashMap<String, Long>();
				if (mma.size() != 0) {
					for (MainmediaAttention targetmma : mma) {
						
						targetMap.put(targetmma.getType(), targetmma.getCount());

					}
					map.put(mm.getName(), targetMap);
				}
				else{
					map.put(mm.getName(), null);
				}
			}
			return map;
		} catch (Exception ex) {
			logger.error(ex.toString());
			return null;
		}

	}

}
