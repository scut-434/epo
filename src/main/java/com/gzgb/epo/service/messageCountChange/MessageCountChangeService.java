package com.gzgb.epo.service.messageCountChange;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gzgb.epo.dao.messageCountChange.MessageCountChangeDao;
import com.gzgb.epo.entity.MessageCountChange;
import com.gzgb.epo.service.base.BaseService;

/**
 * 
 * <pre>
 * 言论转载或发布数量的变化Service
 * </pre>
 * 
 * @author LiuYongbin
 * @version 1.0, 2014-2-25
 */
@Service
public class MessageCountChangeService extends BaseService<MessageCountChange> {

	private static Logger logger = LoggerFactory
			.getLogger(MessageCountChangeService.class);
	@Autowired
	private MessageCountChangeDao mccDao;

	/**
	 * 
	 * <pre>
	 * 通过社交账号查找记录
	 * </pre>
	 * 
	 * @param socialAccount
	 * @return
	 */
	public List<MessageCountChange> findByNetWorkId(Long id) {
		try {
			logger.info("---findByNetWorkId()方法");
			return mccDao.findByNetWorkId(id);
		} catch (Exception ex) {
			logger.error(ex.toString());
			return null;
		}

	}

	/**
	 * 
	 * <pre>
	 * 通过netWorkid 类型 ，找出特定月份的数量
	 * </pre>
	 * 
	 * @param getTotalOfMonthByType
	 * @return
	 */
	public long getTotalOfMonthByType(List<Integer> startAndEnd, Long networkid, String type) {
		try {
			logger.info("---getTotalOfMonthByType()方法");
			List<MessageCountChange> list = mccDao.findByidAndtimeAndtype(startAndEnd, networkid, type);
			if(list == null || list.size() == 0)
				return 0;
			else{
				long total = 0;
				for(int i=0; i<list.size(); i++){
					total+=list.get(i).getCount();
				}
				return total;
			}
			
		} catch (Exception ex) {
			logger.error(ex.toString());
			return 0;
		}

	}

}
