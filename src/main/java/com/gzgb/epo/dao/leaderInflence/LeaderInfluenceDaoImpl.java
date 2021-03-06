package com.gzgb.epo.dao.leaderInflence;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.QueryException;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.gzgb.epo.dao.base.BaseDaoImpl;
import com.gzgb.epo.entity.LeaderInfluence;

/**
 * 
 * <pre>
 * 舆论领袖影响DaoImpl
 * </pre>
 * 
 * @author LiuYongbin
 * @version 1.0, 2014-2-25
 */
@Repository
public class LeaderInfluenceDaoImpl extends BaseDaoImpl<LeaderInfluence>
		implements LeaderInfluenceDao {

	/**
	 * 
	 * <pre>
	 * 根据社交账号获得记录
	 * </pre>
	 * 
	 * @param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<LeaderInfluence> findByNetWorkIdAndTypeAndTime(Long id, String type, Integer startTime)
			throws QueryException {
		try {
			Criteria criteria = getSession().createCriteria(
					LeaderInfluence.class);
			criteria.add(Restrictions.eq("mediaLeaderId.id", id));
			if(startTime != null)
				criteria.add(Restrictions.gt("time", startTime));
			if(type != null){
				criteria.add(Restrictions.eq("type", type));
				if("hierarchy".equals(type))
					criteria.addOrder(Order.asc("hierarchyId"));
				else if("region".equals(type))
					criteria.addOrder(Order.asc("cityRegionId"));
				else
					criteria.addOrder(Order.asc("educationId"));
			}
			
		
			List<LeaderInfluence> list = criteria.list();
			if (list.size() == 0) {
				return null;
			}
			return list;
		} catch (QueryException qe) {
			throw qe;
		}
	}
}
