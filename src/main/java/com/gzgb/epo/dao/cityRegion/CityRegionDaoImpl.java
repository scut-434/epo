package com.gzgb.epo.dao.cityRegion;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.QueryException;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.gzgb.epo.dao.base.BaseDaoImpl;
import com.gzgb.epo.entity.CityRegion;
import com.gzgb.epo.entity.Education;
import com.gzgb.epo.entity.KnowledgeDictLib;

/**
 * 
 * <pre>
 * 地区DaoImpl
 * </pre>
 * 
 * @author LiuYongbin
 * @version 1.0, 2014-2-25
 */
@Repository
public class CityRegionDaoImpl extends BaseDaoImpl<CityRegion> implements
		CityRegionDao {

	/**
	 * 
	 * <pre>
	 * 根据级别找出词库List
	 * </pre>
	 * 
	 * @param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<CityRegion> getListByLevel(int level) throws QueryException{
		try {
			Criteria criteria = getSession().createCriteria(CityRegion.class);
			criteria.add(Restrictions.eq("level", level));
			return criteria.list();	
		} catch (QueryException qe) {
			throw qe;
		}
	}
	
}
