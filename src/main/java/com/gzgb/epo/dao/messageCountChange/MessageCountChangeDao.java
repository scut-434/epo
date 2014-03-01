package com.gzgb.epo.dao.messageCountChange;

import java.util.List;

import com.gzgb.epo.dao.base.BaseDao;
import com.gzgb.epo.entity.MessageCountChange;

/**
 * 
 * <pre>
 * 舆论领袖言论发布或转载量变化Dao
 * </pre>
 * 
 * @author LiuYongbin
 * @version 1.0, 2014-2-25
 */
public interface MessageCountChangeDao extends BaseDao<MessageCountChange> {

	/**
	 * 
	 * <pre>
	 * 根据社交账号获得记录
	 * </pre>
	 * 
	 * @param socialAccount
	 * @return
	 */
	public List<MessageCountChange> findBySocialAccount(String socialAccount);
}
