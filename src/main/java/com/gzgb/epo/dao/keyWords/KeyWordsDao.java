package com.gzgb.epo.dao.keyWords;

import java.util.List;
import java.util.Map;

import com.gzgb.epo.dao.base.BaseDao;
import com.gzgb.epo.entity.KeyWords;
import com.gzgb.epo.entity.MainmediaAttention;

/**
 * 
 * <pre>
 * 印象关键词Dao
 * </pre>
 * 
 * @author LiuYongbin
 * @version 1.0, 2014-2-26
 */
public interface KeyWordsDao extends BaseDao<KeyWords> {
	
	/**
	 * 
	 * <pre>
	 *查找前十 的记录
	 * </pre>
	 * @param type TODO
	 * @param mapId TODO
	 * @param startTime TODO
	 * @param number TODO
	 * 
	 * @param 
	 * @return
	 */
	public List<KeyWords> findKeyWords(String type, Map<String, Long> mapId, Integer startTime, Integer number);

}
