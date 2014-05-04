package com.gzgb.epo.dao.warning;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.CriteriaQuery;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.engine.TypedValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gzgb.epo.dao.base.BaseDaoImpl;
import com.gzgb.epo.entity.User;
import com.gzgb.epo.entity.WeiBoList;
import com.gzgb.epo.service.shiro.ShiroDbRealm.ShiroUser;
import com.gzgb.epo.service.user.UserService;

/**
 * 
 * <pre>
 * 微博舆情DAO实现类
 * </pre>
 * 
 * @author XiaoJian
 * @version 1.0, 2014-2-25
 */

@Repository
public class WeiBoListDaoImpl extends BaseDaoImpl<WeiBoList> implements
		WeiBoListDao {


	@Autowired
	private UserService userService;
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> findWeiBo(Integer startTime, Integer endTime,
			Integer site, String content, Integer page, Integer rows,
			String sort, String order) {
		Criteria c = getSession().createCriteria(WeiBoList.class);
		addAuthority(c);
		c.add(Restrictions.between("wwlTimestamp", startTime, endTime));
		if (site != null) {
			c.add(Restrictions.eq("wsmId.id", Long.parseLong(site.toString())));
		}
		if (content != null) {
			content = "%" + content + "%";
			c.add(Restrictions.like("wwlContent", content));
		}

		List<WeiBoList> list = c.list();
		int total = 0;
		if (list != null) {
			total = list.size();
		}
		if (page == null || page == 0) {
			page = 1;
		}
		if (rows == null || rows == 0) {
			rows = 20;
		}
		if (sort != null && order != null) {
			if ("asc".equals(order)) {
				c.addOrder(Order.asc(sort));
			} else {
				c.addOrder(Order.desc(sort));
			}
		} else {
			// 默认按照热度降序排序
			c.addOrder(Order.desc("wwlHots"));
		}
		List<WeiBoList> objList = c.setFirstResult((page - 1) * rows)
				.setMaxResults(rows).list();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		if (objList != null && objList.size() > 0) {
			returnMap.put("total", total);
			returnMap.put("rows", objList);
			return returnMap;
		} else {
			returnMap.put("total", total);
			returnMap.put("rows", "");
			return returnMap;
		}

	}
	
	/**
	 * 
	 * <pre>
	 * 根据用户不同区县和不同的部门，展示不同的信息
	 * </pre>
	 * @param c
	 */
	public void addAuthority (Criteria c){
		ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if(shiroUser == null){
			return ;
		}
		User user = userService.findById(shiroUser.getId(), User.class);
		Criterion c1 =null;
		if(user.getRbiId()!=null){
			c1 = Restrictions.eq("rbiId.id", user.getRbiId().getId());
		}
		Criterion c2 =null;
		if(user.getDbiId()!=null){
			c2 = Restrictions.eq("dbiId.id", user.getDbiId().getId());
		}
		c.add(Restrictions.or(c1,c2));
	}

}
