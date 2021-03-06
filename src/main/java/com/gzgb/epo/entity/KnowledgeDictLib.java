package com.gzgb.epo.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.gzgb.epo.publics.Constants;

/**
 * 
 * <pre>
 * 词库实体
 * </pre>
 * 
 * @author XiaoJian
 * @version 1.0, 2013-12-29
 */
@Entity
@Table(name = "epo_knowledgedictlib", schema = Constants.GZGB_SCH)
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SequenceGenerator(name = "gzgb_knowledgedictlib", sequenceName = "gzgb_knowledgedictlib_seq", allocationSize = 1)
public class KnowledgeDictLib extends BaseEntity {

	private static final long serialVersionUID = 985235545427634485L;

	/**
	 * 自增ID
	 */
	private Long id;
	
	/**
	 * 词库名称
	 */
	private String kdlName;
	
	/**
	 * 所属父词库
	 */
	private KnowledgeDictLib kdlParentId;
	
	/**
	 * 词库层次
	 */
	private Integer kdlLevel;
	
	/**
	 * 词库总数
	 */
	private Integer kdlCount;
	
	/**
	 * 词性概述
	 */
	private String kdlDetail;
	
	/**
	 * 创建用户
	 */
	private User userId;
	
	/**
	 * 所属部门
	 */
	private DepartmentBaseInfo dbiId;
	
	/**
	 * 所属区县
	 */
	private RegionBaseInfo rbiId;
	
	/**
	 * 文件生成是否设置权重
	 */
	private Byte kdlIsWeight;
	
	/**
	 * 生成文件名称
	 */
	private String kdlFileName;
	
	/**
	 * 创建时间
	 */
	private Integer kdlCreateTime;
	
	/**
	 * 更新时间
	 */
	private Integer kdlUpdateTime;
	
	/**
	 * 所属父词库 Long型的临时变量
	 */
	private Long kdlParentIdLong;
	
	/**
	 * User Long型的临时变量
	 */
	private Long userIdLong;
	
	/**
	 * DepartmentBaseInfo Long型的临时变量
	 */
	private Long dbiIdLong;
	
	/**
	 * RegionBaseInfo Long型的临时变量
	 */
	private Long rbiIdLong;
	
	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY, generator = "gzgb_knowledgedictlib")
	@Column(name = "kdlId")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "kdlName", nullable = false)
	public String getKdlName() {
		return kdlName;
	}

	public void setKdlName(String kdlName) {
		this.kdlName = kdlName;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "kdlParentId", nullable = false, columnDefinition = "INTEGER default 0")
	public KnowledgeDictLib getKdlParentId() {
		return kdlParentId;
	}

	public void setKdlParentId(KnowledgeDictLib kdlParentId) {
		this.kdlParentId = kdlParentId;
	}

	@Column(name = "kdlLevel", nullable = false, columnDefinition = "INTEGER default 0")
	public Integer getKdlLevel() {
		return kdlLevel;
	}

	public void setKdlLevel(Integer kdlLevel) {
		this.kdlLevel = kdlLevel;
	}

	@Column(name = "kdlCount", nullable = false, columnDefinition = "INTEGER default 0")
	public Integer getKdlCount() {
		return kdlCount;
	}

	public void setKdlCount(Integer kdlCount) {
		this.kdlCount = kdlCount;
	}
	
	@Column(name = "kdlDetail", length=1024)
	public String getKdlDetail() {
		return kdlDetail;
	}

	public void setKdlDetail(String kdlDetail) {
		this.kdlDetail = kdlDetail;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "umiId", nullable = false)
	public User getUserId() {
		return userId;
	}

	public void setUserId(User userId) {
		this.userId = userId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "dbiId", nullable = true, columnDefinition = "INTEGER default 0")
	public DepartmentBaseInfo getDbiId() {
		return dbiId;
	}

	public void setDbiId(DepartmentBaseInfo dbiId) {
		this.dbiId = dbiId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "rbiId", nullable = true, columnDefinition = "INTEGER default 0")
	public RegionBaseInfo getRbiId() {
		return rbiId;
	}

	public void setRbiId(RegionBaseInfo rbiId) {
		this.rbiId = rbiId;
	}
	
	@Column(name = "kdlIsWeight", nullable = false, columnDefinition = "INTEGER default 0")
	public Byte getKdlIsWeight() {
		return kdlIsWeight;
	}

	public void setKdlIsWeight(Byte kdlIsWeight) {
		this.kdlIsWeight = kdlIsWeight;
	}

	@Column(name = "kdlFileName")
	public String getKdlFileName() {
		return kdlFileName;
	}

	public void setKdlFileName(String kdlFileName) {
		this.kdlFileName = kdlFileName;
	}

	@Column(name = "kdlCreateTime", nullable = false)
	public Integer getKdlCreateTime() {
		return kdlCreateTime;
	}

	public void setKdlCreateTime(Integer kdlCreateTime) {
		this.kdlCreateTime = kdlCreateTime;
	}

	@Column(name = "kdlUpdateTime", nullable = false)
	public Integer getKdlUpdateTime() {
		return kdlUpdateTime;
	}

	public void setKdlUpdateTime(Integer kdlUpdateTime) {
		this.kdlUpdateTime = kdlUpdateTime;
	}

	@Transient
	public Long getKdlParentIdLong() {
		return kdlParentIdLong;
	}

	public void setKdlParentIdLong(Long kdlParentIdLong) {
		this.kdlParentIdLong = kdlParentIdLong;
	}

	@Transient
	public Long getUserIdLong() {
		return userIdLong;
	}

	public void setUserIdLong(Long userIdLong) {
		this.userIdLong = userIdLong;
	}

	@Transient
	public Long getDbiIdLong() {
		return dbiIdLong;
	}

	public void setDbiIdLong(Long dbiIdLong) {
		this.dbiIdLong = dbiIdLong;
	}

	@Transient
	public Long getRbiIdLong() {
		return rbiIdLong;
	}

	public void setRbiIdLong(Long rbiIdLong) {
		this.rbiIdLong = rbiIdLong;
	}
	
}
