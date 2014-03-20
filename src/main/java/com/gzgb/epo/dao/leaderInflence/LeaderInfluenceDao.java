package com.gzgb.epo.dao.leaderInflence;

import java.util.List;
import java.util.Map;

import com.gzgb.epo.dao.base.BaseDao;
import com.gzgb.epo.entity.LeaderInfluence;

/**
 * 
 * <pre>
 * 舆论领袖影响Dao
 * </pre>
 * 
 * @author Administrator
 * @version 1.0, 2014-2-25
 */
public interface LeaderInfluenceDao extends BaseDao<LeaderInfluence> {

	/**
	 * 
	 * <pre>
	 * 根据社交账号获得记录
	 * </pre>
	 * @param startTime TODO
	 * @param socialAccount
	 * 
	 * @return
	 */
	public List<LeaderInfluence> findByNetWorkIdAndTypeAndTime(Long id, String type, Integer startTime);
}
