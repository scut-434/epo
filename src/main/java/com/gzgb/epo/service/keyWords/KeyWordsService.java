package com.gzgb.epo.service.keyWords;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gzgb.epo.dao.keyWords.KeyWordsDao;
import com.gzgb.epo.dao.publicEmotion.PublicEmotionDao;
import com.gzgb.epo.entity.KeyWords;
import com.gzgb.epo.entity.MainmediaAttention;
import com.gzgb.epo.service.base.BaseService;
import com.gzgb.epo.service.publicEmotion.PublicEmotionService;

/**
 * 
 * <pre>
 * 印象关注词Service
 * </pre>
 * 
 * @author LiuYongbin
 * @version 1.0, 2014-2-26
 */
@Service
public class KeyWordsService extends BaseService<KeyWords> {

	private static Logger logger = LoggerFactory.getLogger(PublicEmotionService.class);
	@Autowired
	private KeyWordsDao kwDao;
	
	/**
	 * 
	 * <pre>
	 * 根据条件查找记录
	 * </pre>
	 * 
	 * @param 
	 * @return
	 */
	public List<KeyWords> findKeyWords(String type, Long cityRegionId, Long mainmediaId, Integer startTime, Integer number) {
		try {
			logger.info("---findKeyWords()方法");
			Map<String, Long> mapId = new HashMap<String, Long>();
			if(cityRegionId != null){
				mapId.put("cityRegionId.id", cityRegionId);
			}
			if(mainmediaId != null){
				mapId.put("mainmediaId.id", mainmediaId);
			}
			List<KeyWords> list = kwDao.findKeyWords(type, mapId, startTime, number);
            return list;
		} catch (Exception ex) {
			logger.error(ex.toString());
			return null;
		}

	}
}
