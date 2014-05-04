package com.gzgb.epo.controller.knowledgeDictLibManage;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.aspectj.util.FileUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gzgb.epo.entity.DepartmentBaseInfo;
import com.gzgb.epo.entity.KnowledgeDictItem;
import com.gzgb.epo.entity.KnowledgeDictLib;
import com.gzgb.epo.entity.KnowledgeDictQuality;
import com.gzgb.epo.entity.Menu;
import com.gzgb.epo.entity.RegionBaseInfo;
import com.gzgb.epo.entity.User;
import com.gzgb.epo.service.base.BaseService;
import com.gzgb.epo.service.departmentBaseInfo.DepartmentBaseInfoService;
import com.gzgb.epo.service.knowledgeDictLib.KnowledgeDictLibService;
import com.gzgb.epo.service.knowledgeDictQuality.KnowledgeDictQualityService;
import com.gzgb.epo.service.knowledgeDictItem.KnowledgeDictItemService;
import com.gzgb.epo.service.menu.MenuService;
import com.gzgb.epo.service.regionBaseInfo.RegionBaseInfoService;
import com.gzgb.epo.service.shiro.ShiroDbRealm.ShiroUser;
import com.gzgb.epo.service.user.UserService;
import com.gzgb.epo.util.DateUtil;

/**
 * 
 * <pre>
 * 知识库管理
 * </pre>
 * 
 * @author XiaoJian
 * @version 1.0, 2013-12-18
 */
@Controller
@RequestMapping(value = "/knowledgeDictLibManage")
public class KnowledgeDictLibManageController {

	@Autowired
	private KnowledgeDictLibService kdlService;
	@Autowired
	private BaseService baseService;
	@Autowired
	private KnowledgeDictItemService kdiService;
	@Autowired
	private UserService userService;
	@Autowired
	private DepartmentBaseInfoService dbService;
	@Autowired
	private RegionBaseInfoService rbService;
	@Autowired
	private KnowledgeDictQualityService kdqService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private DepartmentBaseInfoService dbiService;
	
	Logger logger = LoggerFactory.getLogger(KnowledgeDictLibManageController.class);

	/**
	 * 进入知识库管理页面
	 * @return
	 */
	@RequestMapping(value = "index/{pMenuId}")
	public String index(@PathVariable Long pMenuId,Model model,HttpServletRequest request){
		    int newCountOfMonth = kdiService.getNewCountsOfThisMonth();
		    int newCountOfYear = kdiService.getNewCountsOfThisYear();
		    long totalitem = kdiService.getCountOfAll();
		    int countOfLevelOneLib = kdlService.getCountOfLib();
		    Long userId = (Long)request.getSession().getAttribute("userId");
			ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		    User user = userService.findById(shiroUser.getId(), User.class);
			if(user == null){
				return "error/403";
			}
			List<Long> kdlIdList = null;
			//如果该用户只有县区的Id，没有部门的Id， 那没该用户可以看到指定县区的词库以及所有部门的词库，包括公共的词库
			if(user.getRbiId() != null && user.getDbiId() == null){
				kdlIdList = new ArrayList<Long>();
				List<KnowledgeDictLib> rbiLibList  = kdlService.getLibByDbiIdOrRbiId("rbiId.id", user.getRbiId().getId());
				for(int i=0; i<rbiLibList.size(); i++){
					kdlIdList.add(rbiLibList.get(i).getId());
				}
				List<KnowledgeDictLib> libList = kdlService.getLibByLevel(1);
				for(int i=0; i<libList.size(); i++){
					kdlIdList.add(libList.get(i).getId());
				}
				List<KnowledgeDictLib> departmentlibList = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(Long.valueOf(3));
				for(int i=0; i<departmentlibList.size(); i++){
					kdlIdList.add(departmentlibList.get(i).getId());
				}
			}
			//如果该用户只有部门的Id，没有县区的Id， 那没该用户可以看到指定部门的词库以及所有县区的词库，包括公共的词库
			else if(user.getRbiId() == null && user.getDbiId() != null){
				kdlIdList = new ArrayList<Long>();
				List<KnowledgeDictLib> dbiLibList  = kdlService.getLibByDbiIdOrRbiId("dbiId.id", user.getDbiId().getId());
				for(int i=0; i<dbiLibList.size(); i++){
					kdlIdList.add(dbiLibList.get(i).getId());
				}
				List<KnowledgeDictLib> libList = kdlService.getLibByLevel(1);
				for(int i=0; i<libList.size(); i++){
					kdlIdList.add(libList.get(i).getId());
				}
				List<KnowledgeDictLib> rbilibList = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(Long.valueOf(2));
				for(int i=0; i<rbilibList.size(); i++){
					kdlIdList.add(rbilibList.get(i).getId());
				}
			}
			//如果该用户有部门的Id，有县区的Id， 那没该用户可以看到指定部门的词库以及县区的词库，包括公共的词库
			else if(user.getRbiId() != null && user.getDbiId() != null){
				kdlIdList = new ArrayList<Long>();
				List<KnowledgeDictLib> dbiLibList  = kdlService.getLibByDbiIdOrRbiId("dbiId.id", user.getDbiId().getId());
				for(int i=0; i<dbiLibList.size(); i++){
					kdlIdList.add(dbiLibList.get(i).getId());
				}
				List<KnowledgeDictLib> libList = kdlService.getLibByLevel(1);
				for(int i=0; i<libList.size(); i++){
					kdlIdList.add(libList.get(i).getId());
				}
				List<KnowledgeDictLib> rbiLibList  = kdlService.getLibByDbiIdOrRbiId("rbiId.id", user.getRbiId().getId());
				for(int i=0; i<rbiLibList.size(); i++){
					kdlIdList.add(rbiLibList.get(i).getId());
				}
			}		
			List<KnowledgeDictItem> listitem = null;
			listitem = kdiService.getNewItem(kdlIdList);
		    List<KnowledgeDictLib> listlib = kdlService.getLibByLevel(1);
		    DateUtil du = new DateUtil();
		    if(newCountOfMonth == -1 || newCountOfYear == -1 || totalitem == -1 || countOfLevelOneLib == -1)
		    	return "error/500";
		    for(KnowledgeDictItem kdi : listitem){
		    	kdi.setKdiCreateDate(du.getDate(new Date((long)kdi.getKdiCreateTime()*1000))); 
		    }
		    
		    model.addAttribute("newCountOfMonth", newCountOfMonth);
		    model.addAttribute("newCountOfYear", newCountOfYear);
		    model.addAttribute("totalitem", totalitem);
		    model.addAttribute("countOfLevelOneLib", countOfLevelOneLib);
		    model.addAttribute("listitem", listitem);
		    model.addAttribute("listlib", listlib); 
			menuService.getLeftMenu(pMenuId,model);
			return "knowledgeDictLibManage/knowledgeDictLibManageIndex";
	}

	
	/**
	 * 进入词库管理页面
	 * @return
	 */
	@RequestMapping(value = "knowledgeDictLibManageLibManage/{pMenuId}")
	public String libManage(@PathVariable Long pMenuId,Model model,HttpServletRequest request){
		List<KnowledgeDictLib> listlib = kdlService.getLibByLevel(1);
		model.addAttribute("listlib", listlib);
		request.setAttribute("page", 1);
//		Long pMenuId = menuService.findByMenuName("词库管理").getId();
		menuService.getLeftMenu(pMenuId,model);
			return "knowledgeDictLibManage/knowledgeDictLibManageLibManage";
	}
	
	@RequestMapping(value = "knowledgeDictLibManageLibManage")
	public String libManage1(Model model,HttpServletRequest request){
		List<KnowledgeDictLib> listlib = kdlService.getLibByLevel(1);
		model.addAttribute("listlib", listlib);
		request.setAttribute("page", 1);
		Long pMenuId = menuService.findByMenuName("词库管理").getId();
		menuService.getLeftMenu(pMenuId,model);
			return "knowledgeDictLibManage/knowledgeDictLibManageLibManage";
	}
	
	/**
	 * 进入添加词库页面
	 * @return
	 */
	@RequestMapping(value = "knowledgeDictLibManageToAddLib/{pMenuId}")
	public String toAddLib(@PathVariable Long pMenuId,Model model,HttpServletRequest request, Long id, Long parentId){
		if(id != null && parentId != null){
			KnowledgeDictLib lib = kdlService.findById(id, KnowledgeDictLib.class);
			model.addAttribute("parentId", parentId);
			model.addAttribute("id",id);
			model.addAttribute("kdlName", lib.getKdlName());
			if(lib.getRbiId() != null){
				model.addAttribute("rbId", lib.getRbiId().getId());
				model.addAttribute("rblist", rbService.findAll(RegionBaseInfo.class));
			}
			if(lib.getDbiId() != null){
				model.addAttribute("dbId", lib.getDbiId().getId());
				model.addAttribute("dblist", dbService.findAll(DepartmentBaseInfo.class));
			}
			
			model.addAttribute("kdlFileName", lib.getKdlFileName());
			model.addAttribute("kdlIsWeight", lib.getKdlIsWeight());
			model.addAttribute("kdlDetail", lib.getKdlDetail());
		}
		// List<KnowledgeDictLib> listlib = kdlService.getLibByLevel(1);
		// model.addAttribute("listlib", listlib);
		// model.addAttribute("parentId",1);
//		Long pMenuId = menuService.findByMenuName("添加词库").getId();
		menuService.getLeftMenu(pMenuId,model);
			return "knowledgeDictLibManage/knowledgeDictLibManageToAddLib";
	}
	
	@RequestMapping(value = "knowledgeDictLibManageToAddLib")
	public String toAddLib1(Model model,HttpServletRequest request, Long id, Long parentId){
		if(id != null && parentId != null){
			KnowledgeDictLib lib = kdlService.findById(id, KnowledgeDictLib.class);
			model.addAttribute("parentId", parentId);
			model.addAttribute("id",id);
			model.addAttribute("kdlName", lib.getKdlName());
			if(lib.getRbiId() != null){
				model.addAttribute("rbId", lib.getRbiId().getId());
				model.addAttribute("rblist", rbService.findAll(RegionBaseInfo.class));
			}
			if(lib.getDbiId() != null){
				model.addAttribute("dbId", lib.getDbiId().getId());
				model.addAttribute("dblist", dbService.findAll(DepartmentBaseInfo.class));
			}
			
			model.addAttribute("kdlFileName", lib.getKdlFileName());
			model.addAttribute("kdlIsWeight", lib.getKdlIsWeight());
			model.addAttribute("kdlDetail", lib.getKdlDetail());
		}
		// List<KnowledgeDictLib> listlib = kdlService.getLibByLevel(1);
		// model.addAttribute("listlib", listlib);
		// model.addAttribute("parentId",1);
		Long pMenuId = menuService.findByMenuName("添加词库").getId();
		menuService.getLeftMenu(pMenuId,model);
			return "knowledgeDictLibManage/knowledgeDictLibManageToAddLib";
	}
	
	/**
	 * 进入词条管理页面
	 * @return
	 */
	@RequestMapping(value = "knowledgeDictLibManageItemManage/{pMenuId}")
	public String itemManage(@PathVariable Long pMenuId,Model model,HttpServletRequest request, Long id){
		 List<KnowledgeDictLib> listlib = kdlService.getLibByLevel(1);
		 List<KnowledgeDictQuality> listQuality = kdqService.findAll(KnowledgeDictQuality.class);
		 List<Map<String, Object>> listIdandName = new ArrayList<Map<String, Object>>();
		 List<Map<String, Object>> childrenlib = new ArrayList<Map<String, Object>>();
		 List<Map<String, Object>> itemQualityList = new ArrayList<Map<String, Object>>();
		 Map<String, Object> map = new HashMap<String, Object>();
		 Map<String, Object> mapParent = new HashMap<String, Object>();
		 Long parentId = null;
		 map.put("id", 0);
		 map.put("name", "--");
		 itemQualityList.add(map);
		 mapParent.put("id", 1); 
		 mapParent.put("name", "一级词库");
		 listIdandName.add(mapParent);
		 for(KnowledgeDictLib lib : listlib){
			 Map<String, Object> mapIdandName = new HashMap<String, Object>();
			 mapIdandName.put("id", lib.getId());
			 mapIdandName.put("name", lib.getKdlName());
			 listIdandName.add(mapIdandName);
		 }
			
		 for(KnowledgeDictQuality quality : listQuality){
			 Map<String, Object> mapIdandNameQuality = new HashMap<String, Object>();
			 mapIdandNameQuality.put("id", quality.getId());
			 mapIdandNameQuality.put("name", quality.getKdqName());
			 itemQualityList.add(mapIdandNameQuality);
		 }
		 if(id != null){
			 KnowledgeDictLib childLib = kdlService.findById(id, KnowledgeDictLib.class);
			 parentId = childLib.getKdlParentId().getId();
			 List<KnowledgeDictLib> childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(parentId);
			for(KnowledgeDictLib lib: childrenLib){
				Map<String, Object> childrenMap = new HashMap<String, Object>();
				childrenMap.put("id", lib.getId());
				childrenMap.put("name", lib.getKdlName());
			    childrenlib.add(childrenMap);
			}		
		 }
		 
		 model.addAttribute("listIdandName", listIdandName);
		 model.addAttribute("childrenlib", childrenlib);
		 model.addAttribute("itemQualityList", itemQualityList);
		 model.addAttribute("parentId", parentId);
		 model.addAttribute("id", id);
//			Long pMenuId = menuService.findByMenuName("词条管理").getId();
			menuService.getLeftMenu(pMenuId,model);
		 return "knowledgeDictLibManage/knowledgeDictLibManageItemManage";
	}
	
	@RequestMapping(value = "knowledgeDictLibManageItemManage")
	public String itemManage1(Model model,HttpServletRequest request, Long id){
		 List<KnowledgeDictLib> listlib = kdlService.getLibByLevel(1);
		 List<KnowledgeDictQuality> listQuality = kdqService.findAll(KnowledgeDictQuality.class);
		 List<Map<String, Object>> listIdandName = new ArrayList<Map<String, Object>>();
		 List<Map<String, Object>> childrenlib = new ArrayList<Map<String, Object>>();
		 List<Map<String, Object>> itemQualityList = new ArrayList<Map<String, Object>>();
		 Map<String, Object> map = new HashMap<String, Object>();
		 Map<String, Object> mapParent = new HashMap<String, Object>();
		 Long parentId = null;
		 map.put("id", 0);
		 map.put("name", "--");
		 itemQualityList.add(map);
		 mapParent.put("id", 1); 
		 mapParent.put("name", "一级词库");
		 listIdandName.add(mapParent);
		 for(KnowledgeDictLib lib : listlib){
			 Map<String, Object> mapIdandName = new HashMap<String, Object>();
			 mapIdandName.put("id", lib.getId());
			 mapIdandName.put("name", lib.getKdlName());
			 listIdandName.add(mapIdandName);
		 }
			
		 for(KnowledgeDictQuality quality : listQuality){
			 Map<String, Object> mapIdandNameQuality = new HashMap<String, Object>();
			 mapIdandNameQuality.put("id", quality.getId());
			 mapIdandNameQuality.put("name", quality.getKdqName());
			 itemQualityList.add(mapIdandNameQuality);
		 }
		 if(id != null){
			 KnowledgeDictLib childLib = kdlService.findById(id, KnowledgeDictLib.class);
			 parentId = childLib.getKdlParentId().getId();
			 List<KnowledgeDictLib> childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(parentId);
			for(KnowledgeDictLib lib: childrenLib){
				Map<String, Object> childrenMap = new HashMap<String, Object>();
				childrenMap.put("id", lib.getId());
				childrenMap.put("name", lib.getKdlName());
			    childrenlib.add(childrenMap);
			}		
		 }
		 
		 model.addAttribute("listIdandName", listIdandName);
		 model.addAttribute("childrenlib", childrenlib);
		 model.addAttribute("itemQualityList", itemQualityList);
		 model.addAttribute("parentId", parentId);
		 model.addAttribute("id", id);
			Long pMenuId = menuService.findByMenuName("词条管理").getId();
			menuService.getLeftMenu(pMenuId,model);
		 return "knowledgeDictLibManage/knowledgeDictLibManageItemManage";
	}
	
	/**
	 * 进入添加词条 页面
	 * @return
	 */
	@RequestMapping(value = "knowledgeDictLibManageToAddItem/{pMenuId}")
	public String toAddItem(@PathVariable Long pMenuId,Model model,HttpServletRequest request, Long id){
		List<KnowledgeDictLib> parentLib = kdlService.getLibByLevel(1);
		List<Map<String, Object>> listLib = new ArrayList<Map<String, Object>>();
		//List<KnowledgeDictLib> childrenLib = kdlService.getLibByLevel(1);
		for(KnowledgeDictLib lib: parentLib){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", lib.getId());
			map.put("name", lib.getKdlName());
			listLib.add(map);
		}
		//获得词性List
		List<KnowledgeDictQuality> listkdq = kdqService.findAll(KnowledgeDictQuality.class);
		List<Map<String, Object>> listKdq = new ArrayList<Map<String, Object>>();
		for(KnowledgeDictQuality kdq: listkdq){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", kdq.getId());
			map.put("name", kdq.getKdqName());
			listKdq.add(map);
		}
		if(id != null && id != 0){
			KnowledgeDictItem kdi = kdiService.findById(id, KnowledgeDictItem.class);
			model.addAttribute("kdiName", kdi.getKdiName());
			model.addAttribute("kdiId", id);
			model.addAttribute("kdlId", kdi.getKdlId().getId());
			model.addAttribute("kdlPId", kdi.getKdlId().getKdlParentId().getId());
			model.addAttribute("kdiPingyin", kdi.getKdiPinyin());
			model.addAttribute("kdqId", kdi.getKdqId().getId());
			model.addAttribute("kdiWeight", kdi.getKdiWeight());
			model.addAttribute("kdiStatus", kdi.getKdiStatus());
			model.addAttribute("kdiSegmentation", kdi.getKdiSegmentation());
			List<KnowledgeDictLib> childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(kdi.getKdlId().getKdlParentId().getId());
			List<Map<String, Object>> childrenlistLib = new ArrayList<Map<String, Object>>();
			for(KnowledgeDictLib lib: childrenLib){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", lib.getId());
				map.put("name", lib.getKdlName());
				childrenlistLib.add(map);
			}
			model.addAttribute("childrenLib", childrenlistLib);
			
		}
		else{
				KnowledgeDictItem kdi = kdiService.findById(id, KnowledgeDictItem.class);
				model.addAttribute("kdiName", "");
				model.addAttribute("kdlId", 0);
				model.addAttribute("kdlPId", 0);
				model.addAttribute("kdiPingyin","");
				model.addAttribute("kdqId", 0);
				model.addAttribute("kdiWeight", 0);
				model.addAttribute("kdiStatus", 1);
				model.addAttribute("kdiSegmentation", 1);
				
		}
		    model.addAttribute("parentLib", listLib);
		    model.addAttribute("listKdq", listKdq);
//			Long pMenuId = menuService.findByMenuName("添加词条").getId();
			menuService.getLeftMenu(pMenuId,model);
			return "knowledgeDictLibManage/knowledgeDictLibManageToAddItem";
	}
	
	@RequestMapping(value = "knowledgeDictLibManageToAddItem")
	public String toAddItem(Model model,HttpServletRequest request, Long id){
		List<KnowledgeDictLib> parentLib = kdlService.getLibByLevel(1);
		List<Map<String, Object>> listLib = new ArrayList<Map<String, Object>>();
		//List<KnowledgeDictLib> childrenLib = kdlService.getLibByLevel(1);
		Map<String, Object> mapLevel0 = new HashMap<String, Object>();
		mapLevel0.put("id", 1);
		mapLevel0.put("name", "一级词库");
		listLib.add(mapLevel0);
		for(KnowledgeDictLib lib: parentLib){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", lib.getId());
			map.put("name", lib.getKdlName());
			listLib.add(map);
		}
		//获得词性List
		List<KnowledgeDictQuality> listkdq = kdqService.findAll(KnowledgeDictQuality.class);
		List<Map<String, Object>> listKdq = new ArrayList<Map<String, Object>>();
		for(KnowledgeDictQuality kdq: listkdq){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", kdq.getId());
			map.put("name", kdq.getKdqName());
			listKdq.add(map);
		}
		if(id != null && id != 0){
			KnowledgeDictItem kdi = kdiService.findById(id, KnowledgeDictItem.class);
			model.addAttribute("kdiName", kdi.getKdiName());
			model.addAttribute("kdiId", id);
			model.addAttribute("kdlId", kdi.getKdlId().getId());
			model.addAttribute("kdlPId", kdi.getKdlId().getKdlParentId().getId());
			model.addAttribute("kdiPingyin", kdi.getKdiPinyin());
			model.addAttribute("kdqId", kdi.getKdqId().getId());
			model.addAttribute("kdiWeight", kdi.getKdiWeight());
			model.addAttribute("kdiStatus", kdi.getKdiStatus());
			model.addAttribute("kdiSegmentation", kdi.getKdiSegmentation());
			List<KnowledgeDictLib> childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(kdi.getKdlId().getKdlParentId().getId());
			List<Map<String, Object>> childrenlistLib = new ArrayList<Map<String, Object>>();
			for(KnowledgeDictLib lib: childrenLib){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", lib.getId());
				map.put("name", lib.getKdlName());
				childrenlistLib.add(map);
			}
			model.addAttribute("childrenLib", childrenlistLib);
			
		}
		else{
				KnowledgeDictItem kdi = kdiService.findById(id, KnowledgeDictItem.class);
				model.addAttribute("kdiName", "");
				model.addAttribute("kdlId", 0);
				model.addAttribute("kdlPId", 0);
				model.addAttribute("kdiPingyin","");
				model.addAttribute("kdqId", 0);
				model.addAttribute("kdiWeight", 0);
				model.addAttribute("kdiStatus", 1);
				model.addAttribute("kdiSegmentation", 1);
				
		}
		    model.addAttribute("parentLib", listLib);
		    model.addAttribute("listKdq", listKdq);
			Long pMenuId = menuService.findByMenuName("添加词条").getId();
			menuService.getLeftMenu(pMenuId,model);
			return "knowledgeDictLibManage/knowledgeDictLibManageToAddItem";
	}
	
	/**
	 * 进入导入词条页面
	 * @return
	 */
	@RequestMapping(value = "knowledgeDictLibManageUploadItem/{pMenuId}")
	public String uploadItem(@PathVariable Long pMenuId,Model model,HttpServletRequest request, Long id, Long parentId){
		List<KnowledgeDictLib> listParentlib = kdlService.getLibByLevel(1);
		List<Map<String, Object>> listLib = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listParentLib = new ArrayList<Map<String, Object>>();
		for(KnowledgeDictLib lib: listParentlib){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", lib.getId());
			map.put("name", lib.getKdlName());
			listParentLib.add(map);
		}
		model.addAttribute("listParentLib", listParentLib);
		if(parentId != null){
			List<KnowledgeDictLib> listlib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(parentId);
			for(KnowledgeDictLib lib: listlib){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", lib.getId());
				map.put("name", lib.getKdlName());
				listLib.add(map);
			}
		}
		model.addAttribute("listLib", listLib);
		model.addAttribute("id", id);
		model.addAttribute("parentId", parentId);
//		Long pMenuId = menuService.findByMenuName("导入词条").getId();
		menuService.getLeftMenu(pMenuId,model);
			return "knowledgeDictLibManage/knowledgeDictLibManageUploadItem";
	}
	
	@RequestMapping(value = "knowledgeDictLibManageUploadItem")
	public String uploadItem1(Model model,HttpServletRequest request, Long id, Long parentId){
		List<KnowledgeDictLib> listParentlib = kdlService.getLibByLevel(1);
		List<Map<String, Object>> listLib = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listParentLib = new ArrayList<Map<String, Object>>();
		for(KnowledgeDictLib lib: listParentlib){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", lib.getId());
			map.put("name", lib.getKdlName());
			listParentLib.add(map);
		}
		model.addAttribute("listParentLib", listParentLib);
		if(parentId != null){
			List<KnowledgeDictLib> listlib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(parentId);
			for(KnowledgeDictLib lib: listlib){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", lib.getId());
				map.put("name", lib.getKdlName());
				listLib.add(map);
			}
		}
		model.addAttribute("listLib", listLib);
		model.addAttribute("id", id);
		model.addAttribute("parentId", parentId);
		Long pMenuId = menuService.findByMenuName("导入词条").getId();
		menuService.getLeftMenu(pMenuId,model);
			return "knowledgeDictLibManage/knowledgeDictLibManageUploadItem";
	}
	
	/**
	 * ajax getlist
	 * @return
	 */
	@RequestMapping(value = "getlistLib")
	public @ResponseBody List<Map<String, Object>> getlist(){
		  List<Map<String, Object>> listIdandName = new ArrayList<Map<String, Object>>();
		  List<KnowledgeDictLib> listlib =  kdlService.getLibByLevel(1);
		  Map<String, Object> map = new HashMap<String, Object>();
		  map.put("id", 1);
		  map.put("name", "--");
		  listIdandName.add(map);
		    for(KnowledgeDictLib lib: listlib){
		    	Map<String, Object> mapIdandName = new HashMap<String, Object>();
		    	mapIdandName.put("id", lib.getId());
		    	mapIdandName.put("name", lib.getKdlName());
		    	listIdandName.add(mapIdandName);
		    }
		    return listIdandName;
	}
	/**
	 * ajax getItemList
	 * @return
	 */
	@RequestMapping(value = "getItemList")
	public @ResponseBody Map<String,Object> getItemList(HttpServletRequest request, Long childrenLibId, Long itemQuality, String fuzzySearch, Integer page){

		Map<String,Object> mapLong = new HashMap<String,Object>();
		DateUtil du = new DateUtil();
		List<Long> kdlIdList = null;
		Map<String,Object> myMap = null;
		if(childrenLibId == null || childrenLibId == 0){
			Long userId = (Long)request.getSession().getAttribute("userId");
			User user = userService.findById(userId, User.class);
			if(user == null)
				return null;
			//如果该用户只有县区的Id，没有部门的Id， 那没该用户可以看到指定县区的词库以及所有部门的词库，包括公共的词库
			if(user.getRbiId() != null && user.getDbiId() == null){
				kdlIdList = new ArrayList<Long>();
				List<KnowledgeDictLib> rbiLibList  = kdlService.getLibByDbiIdOrRbiId("rbiId.id", user.getRbiId().getId());
				for(int i=0; i<rbiLibList.size(); i++){
					kdlIdList.add(rbiLibList.get(i).getId());
				}
				List<KnowledgeDictLib> libList = kdlService.getLibByLevel(1);
				for(int i=0; i<libList.size(); i++){
					kdlIdList.add(libList.get(i).getId());
				}
				List<KnowledgeDictLib> departmentlibList = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(Long.valueOf(3));
				for(int i=0; i<departmentlibList.size(); i++){
					kdlIdList.add(departmentlibList.get(i).getId());
				}
			}
			//如果该用户只有部门的Id，没有县区的Id， 那没该用户可以看到指定部门的词库以及所有县区的词库，包括公共的词库
			else if(user.getRbiId() == null && user.getDbiId() != null){
				kdlIdList = new ArrayList<Long>();
				List<KnowledgeDictLib> dbiLibList  = kdlService.getLibByDbiIdOrRbiId("dbiId.id", user.getDbiId().getId());
				for(int i=0; i<dbiLibList.size(); i++){
					kdlIdList.add(dbiLibList.get(i).getId());
				}
				List<KnowledgeDictLib> libList = kdlService.getLibByLevel(1);
				for(int i=0; i<libList.size(); i++){
					kdlIdList.add(libList.get(i).getId());
				}
				List<KnowledgeDictLib> rbilibList = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(Long.valueOf(2));
				for(int i=0; i<rbilibList.size(); i++){
					kdlIdList.add(rbilibList.get(i).getId());
				}
			}
			//如果该用户有部门的Id，有县区的Id， 那没该用户可以看到指定部门的词库以及县区的词库，包括公共的词库
			else if(user.getRbiId() != null && user.getDbiId() != null){
				kdlIdList = new ArrayList<Long>();
				List<KnowledgeDictLib> dbiLibList  = kdlService.getLibByDbiIdOrRbiId("dbiId.id", user.getDbiId().getId());
				for(int i=0; i<dbiLibList.size(); i++){
					kdlIdList.add(dbiLibList.get(i).getId());
				}
				List<KnowledgeDictLib> libList = kdlService.getLibByLevel(1);
				for(int i=0; i<libList.size(); i++){
					kdlIdList.add(libList.get(i).getId());
				}
				List<KnowledgeDictLib> rbiLibList  = kdlService.getLibByDbiIdOrRbiId("rbiId.id", user.getRbiId().getId());
				for(int i=0; i<rbiLibList.size(); i++){
					kdlIdList.add(rbiLibList.get(i).getId());
				}
			}
			myMap = kdiService.searchItem(kdlIdList ,itemQuality, fuzzySearch, page,  null, "kdiCreateTime", "desc");
		}else{
			kdlIdList = new ArrayList<Long>();
			kdlIdList.add(childrenLibId);
			myMap = kdiService.searchItem(kdlIdList ,itemQuality, fuzzySearch, page,  null, "kdiCreateTime", "desc");
		}	
		if(page==null || page == 0){
			page = 1;
		}
		Map<String,Object> map = new HashMap<String,Object>();
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		
	//	String parentName = parent.getKdlName();
		if(myMap!=null && !"".equals(myMap.get("rows").toString())){
			List<KnowledgeDictItem> list = (List<KnowledgeDictItem>)myMap.get("rows");
			for(int i=0;i<list.size();i++){
				KnowledgeDictItem kdi = list.get(i); 
				Map<String,Object> map1 = new HashMap<String,Object>();
				map1.put("id", kdi.getId());
				map1.put("name", kdi.getKdiName());
				map1.put("kdqId", kdi.getKdqId().getKdqName());
				map1.put("weight", kdi.getKdiWeight());
				map1.put("kdlId", kdi.getKdlId().getKdlName());
				map1.put("status", kdi.getKdiStatus() == 1? "正常": "不正常");
				map1.put("createTime", du.getDateString3(new Date((long)kdi.getKdiCreateTime()*1000)));
				map1.put("updateUrl", "/knowledgeDictLibManage/knowledgeDictLibManageToAddItem?id="+kdi.getId());
				
				dataList.add(map1);
			}
		}
		Map<String,Integer> pageList = new HashMap<String,Integer>();
		int total = (myMap==null) ? 0 :Integer.parseInt(myMap.get("total").toString());
		pageList.put("size", 10);   //默认为10
		int size = 1;
		if(total > 10){
			if(total % 10 !=0){
				size = total / 10 +1;
			}else{
				size = total / 10;
			}
		}
		pageList.put("count", size);
		pageList.put("current", page);
		pageList.put("total", total);
		
		map.put("data", dataList);
		map.put("page",pageList);
		return map;
	}
	
	/**
	 * ajax getlistROrD
	 * @return
	 */
	@RequestMapping(value = "getlistROrD")
	public @ResponseBody List<Map<String, Object>> getlistROrD(HttpServletRequest request, Boolean region){
		  List<Map<String, Object>> listIdandName = new ArrayList<Map<String, Object>>();
		  List<RegionBaseInfo> listrb = null;
		  List<DepartmentBaseInfo> listdb = null;
		  if(region == true){
			 listrb = (List<RegionBaseInfo>)rbService.findAll(RegionBaseInfo.class);
			 for(RegionBaseInfo lib: listrb){
				  Map<String,Object> map = new HashMap<String, Object>();
				  map.put("id", lib.getId());
				  map.put("name", lib.getRbiName());
				  listIdandName.add(map);
			  }
		  }
		  else{ 
			 listdb =  (List<DepartmentBaseInfo>)dbService.findAll(DepartmentBaseInfo.class);
			 for(DepartmentBaseInfo lib: listdb){
				  Map<String,Object> map = new HashMap<String, Object>();
				  map.put("id", lib.getId());
				  map.put("name", lib.getDbiName());
				  listIdandName.add(map);
			  }
		  }
			return listIdandName;
	}

	/**
	 * ajax addLib
	 * @return
	 */
	@RequestMapping(value = "addLib")
	public @ResponseBody Map<String, Object> addLib(HttpServletRequest request, KnowledgeDictLib lib){
		Map<String,Object> map = new HashMap<String,Object>();
		if(lib.getId() == null){                    // 增加词库
			  long parentId = lib.getKdlParentIdLong();
			  KnowledgeDictLib parentLib = kdlService.findById(parentId, KnowledgeDictLib.class);
			  lib.setKdlParentId(parentLib);
			  if(parentId != 1)
				  lib.setKdlLevel(2);
			  else 
				  lib.setKdlLevel(1);
			  lib.setKdlCount(0);
			  
			  Long userId = (Long)request.getSession().getAttribute("userId");
			  User user = userService.findById(userId, User.class);
			  lib.setUserId(user);
			  if(lib.getDbiIdLong() != null){
				  long dbiId = lib.getDbiIdLong();
				  DepartmentBaseInfo dbinfo = dbService.findById(dbiId, DepartmentBaseInfo.class);
				  lib.setDbiId(dbinfo);
				  lib.setRbiId(null);
				  }
			  if(lib.getRbiIdLong() != null){
				  long rbiId = lib.getRbiIdLong();
				  RegionBaseInfo dbinfo = rbService.findById(rbiId, RegionBaseInfo.class);
				  lib.setRbiId(dbinfo);
				  lib.setDbiId(null);
			  }
			  if(lib.getKdlIsWeight() == null)
				  lib.setKdlIsWeight((byte)0);
			  Date date = new Date();
			  Long createTime = date.getTime()/1000;
			  lib.setKdlCreateTime(createTime.intValue());
			  lib.setKdlUpdateTime(createTime.intValue());
			  if(kdlService.findByNameAndParentId(lib.getKdlName(), lib.getKdlParentIdLong()) != null)
				  map.put("exit", true);
			  else {
					  map.put("exit", false);
					try{
						kdlService.save(lib);
					}catch(Exception ex){
						ex.printStackTrace();
						map.put("errors",true);
					}
			      }
		}
		else{         //更新词库
			  long parentId = lib.getKdlParentIdLong();
			  KnowledgeDictLib parentLib = kdlService.findById(parentId, KnowledgeDictLib.class);
			  KnowledgeDictLib oldlib = kdlService.findById(lib.getId(), KnowledgeDictLib.class);
			  if(oldlib.getKdlParentId().getId() != parentId)
				  oldlib.setKdlParentId(parentLib);
			  if(parentId == 1)
				  oldlib.setKdlLevel(1);
			  oldlib.setKdlName(lib.getKdlName());
			  oldlib.setKdlDetail(lib.getKdlDetail());
			  if(lib.getDbiIdLong() != null)
				  oldlib.setDbiId(dbService.findById(lib.getDbiIdLong(), DepartmentBaseInfo.class));
			  if(lib.getRbiIdLong() != null)
				  oldlib.setRbiId(rbService.findById(lib.getRbiIdLong(), RegionBaseInfo.class));
			  if(lib.getKdlFileName() != null)
				  oldlib.setKdlFileName(lib.getKdlFileName());
			  if(lib.getKdlIsWeight() != null)
				  oldlib.setKdlIsWeight(lib.getKdlIsWeight());
			  Long time = new Date().getTime()/1000;
			  oldlib.setKdlUpdateTime(time.intValue());
			  map.put("exit", false);
				try{
					kdlService.update(oldlib);
				}catch(Exception ex){
					ex.printStackTrace();
					map.put("errors",true);
				}
			  
			  
		}
			map.put("errors",false);
			return map;
	}

	/**
	 * ajax getlistLibByParentId
	 * @return
	 */
	@RequestMapping(value = "getlistLibByParentId")
	public @ResponseBody Map<String, Object> getlistLibByParentId(HttpServletRequest request, Long kdlParentId, Integer page){

		Map<String,Long> mapLong = new HashMap<String,Long>();
		
		DateUtil du = new DateUtil();
		KnowledgeDictLib parent = kdlService.findById(kdlParentId, KnowledgeDictLib.class);
		Long userId = (Long)request.getSession().getAttribute("userId");
		
		User user = userService.findById(userId, User.class);
		if(user == null)
			return null;
		//在查看县区词库的情况下，如果该用户有县区的Id限制， 该用户只能看到所限制的县区的词库。
		if(kdlParentId == 2){
			if(user.getRbiId() != null){
				mapLong.put("rbiId.id", user.getRbiId().getId());
			}
			else{
				mapLong.put("kdlParentId.id", parent.getId());
			}
			//在查看部门词库的情况下，如果该用户有部门的Id限制， 该用户只能看到所限制的部门的词库。
		}else if(kdlParentId == 3){
			if(user.getDbiId() != null){
				mapLong.put("dbiId.id", user.getDbiId().getId());
			}
			else{
				mapLong.put("kdlParentId.id", parent.getId());
			}
			//其他情况下，默认能看到所有的词库
		}else{
			mapLong.put("kdlParentId.id", parent.getId());
		}
		
		Map<String,Object> myMap = kdlService.getAll(KnowledgeDictLib.class,null, null, null,mapLong, page, null, null, null);
		if(page==null || page == 0){
			page = 1;
		}
		Map<String,Object> map = new HashMap<String,Object>();
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		
		String parentName = parent.getKdlName();
		if(myMap!=null && !"".equals(myMap.get("rows").toString())){
			List<KnowledgeDictLib> list = (List<KnowledgeDictLib>)myMap.get("rows");
			for(int i=0;i<list.size();i++){
				KnowledgeDictLib kdl = list.get(i); 
				Map<String,Object> map1 = new HashMap<String,Object>();
				map1.put("name", kdl.getKdlName());
				map1.put("parentName", parentName);
				map1.put("count", kdl.getKdlCount());
				map1.put("user", kdl.getUserId().getUsername());
				map1.put("updateTime", du.getDateString3(new Date((long)kdl.getKdlUpdateTime()*1000)));
				map1.put("updateUrl", "/knowledgeDictLibManage/knowledgeDictLibManageToAddLib?id="+kdl.getId()+"&parentId="+kdl.getKdlParentId().getId());
				map1.put("inputUrl", "/knowledgeDictLibManage/knowledgeDictLibManageUploadItem?id="+kdl.getId()+"&parentId="+kdl.getKdlParentId().getId());
				map1.put("itemUrl", "/knowledgeDictLibManage/knowledgeDictLibManageItemManage?id="+kdl.getId());
				
				dataList.add(map1);
			}
		}
		Map<String,Integer> pageList = new HashMap<String,Integer>();
		int total = (myMap==null) ? 0 :Integer.parseInt(myMap.get("total").toString());
		pageList.put("size", 10);   //默认为10
		int size = 1;
		if(total > 10){
			if(total % 10 !=0){
				size = total / 10 +1;
			}else{
				size = total / 10;
			}
		}
		pageList.put("count", size);
		pageList.put("current", page);
		pageList.put("total", total);
		
		map.put("data", dataList);
		map.put("page",pageList);
		return map;
	}
	
	/**
	 * ajax getChildrenLibList
	 * @return
	 */
	@RequestMapping(value = "getChildrenLibList")
	public @ResponseBody List<Map<String,Object>> getChildrenLibList( HttpServletRequest request, Long id){
		  List<Map<String,Object>> listIdandName = new ArrayList<Map<String,Object>>();
		  Long userId = (Long)request.getSession().getAttribute("userId");
		  User user = userService.findById(userId, User.class);
		  List<KnowledgeDictLib> childrenLib = null;
		  //如果是县区词库的话，则要根据用户的rbiId属性来确定显示那些子词库给用户
		  if(id == 2){
			 if(user.getRbiId() != null){
				childrenLib = (List<KnowledgeDictLib>) kdlService.getLibByDbiIdOrRbiId("rbiId.id", user.getRbiId().getId());
			 }else{
				childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(id);
			 }
			  
		  }
		//如果是部门词库的话，则要根据用户的dbiId属性来确定显示那些子词库给用户
		  else if(id == 3){
			  if(user.getDbiId() != null){
					childrenLib = (List<KnowledgeDictLib>) kdlService.getLibByDbiIdOrRbiId("dbiId.id", user.getDbiId().getId());
				 }else{
					 childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(id);
				 }			  
		  }else{
			  childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(id);
		  }
		    for(KnowledgeDictLib lib: childrenLib){
		    	Map<String, Object> map = new HashMap<String, Object>();
		    	map.put("id", lib.getId());
		    	map.put("name", lib.getKdlName());
		    	listIdandName.add(map);
		    }
		        
		    return listIdandName;
	}
	
	/**
	 * ajax uploadFile
	 * @return
	 */
	@RequestMapping(value = "uploadFile")
	public @ResponseBody Map<String, Object> uploadFile( MultipartFile excel, HttpServletRequest request, HttpServletResponse response, Long parentId, Long childId, String path, String name){
	//	parentId = (long) 2;
	//	child = (long) 8;
		//name = "新建 Microsoft Excel 工作表.xls";
		//path = "C:\\Users\\Administrator.WIN-L7A5J2P04UQ\\Desktop\\高英shiyanshi\\epo\\src\\main\\webapp\\upload"; 
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		 Map<String, Object>  map = new HashMap<String, Object>();
		 String realPath = null;
		 //上传文件的原名(即上传前的文件名字)   
		 String originalFilename = null;
		//如果用的是Tomcat服务器，则文件会上传到\\%TOMCAT_HOME%\\webapps\\YourWebProject\\upload\\文件夹中   
	    //这里实现文件上传操作用的是commons.io.FileUtils类,它会自动判断/upload是否存在,不存在会自动创建   
	    realPath = request.getSession().getServletContext().getRealPath("/upload");  
		if(parentId == null && childId == null){
			map.put("error","至少选择一个词库");
			return map;
		}
		else{
				try{
					File uploadFile = new File(realPath);
					if(!uploadFile.exists())
						uploadFile.mkdir();
				}catch(Exception e){
					e.printStackTrace();
					map.put("error","系统出问题 ，请稍后再上传文件！");
					return map;
	
				}
			
			
	         String fileName = null;
	        //如果只是上传一个文件,则只需要MultipartFile类型接收文件即可,而且无需显式指定@RequestParam注解   
	        //如果想上传多个文件,那么这里就要用MultipartFile[]类型来接收文件,并且要指定@RequestParam注解   
	        //上传多个文件时,前台表单中的所有<input type="file"/>的name都应该是excel,否则参数里的excel无法获取到所有上传的文件   
	            if(excel.isEmpty()){  
	                map.put("error", "文件不能为空");
	               return map;  
	               
	            }else{  
		                originalFilename = excel.getOriginalFilename(); 
		                int index = originalFilename.lastIndexOf('.');
		                if(index != -1){
		                	if( !"xls".equals(originalFilename.substring((index+1), originalFilename.length())) && !"xlsx".equals(originalFilename.substring((index+1), originalFilename.length()))){
		                		 map.put("error", "文件格式不对，正确的文件格式应该是xls或xlsx格式！");
		      	               return map;  
		                	}
		                }
		                if(index == -1){
		                	map.put("error", "文件没有后缀名， 请检查文件格式是否为xls或xlsx格式的文件！");
		 	               return map; 
		                }
		                try {  
		                	 fileName = new Date().toString();
		                	 fileName = fileName.replace(':', '-');
		                	 fileName+=originalFilename;
		                    excel.transferTo(new File(realPath,  fileName));  
		                } catch (IOException e) {  
		                    e.printStackTrace();  
		                    map.put("error", "上传失败，请重新上传！");
		                    return map;  
		                   
		                }  
	            }
	          //解析excel文件
	            Long userId = (Long)request.getSession().getAttribute("userId");
				User user = userService.findById(userId, User.class);
	    		String filePath = realPath+'\\'+fileName;
	    		map = kdiService.inputItemByBatch(user, filePath, childId, parentId);
	    	  	return map;
		}
	
	  
	}
	

	/**
	 * ajax   deleteItemById
	 * @return
	 */
	@RequestMapping(value = "deleteItemById")
	public @ResponseBody boolean deleteItemById(String id){
		/*  List<Map<String,Object>> listIdandName = new ArrayList<Map<String,Object>>();
		  List<KnowledgeDictLib> childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(id);
		    for(KnowledgeDictLib lib: childrenLib){
		    	Map<String, Object> map = new HashMap<String, Object>();
		    	map.put("id", lib.getId());
		    	map.put("name", lib.getKdlName());
		    	listIdandName.add(map);
		    }
		        
		    return listIdandName;*/
		String[] ids = id.split(",");
		for(String itemId:ids){
			KnowledgeDictItem item = kdiService.findById(Long.valueOf(itemId), KnowledgeDictItem.class);
			if(item != null){
				int count = 0;
				KnowledgeDictLib kdl = item.getKdlId();
				count = kdl.getKdlCount();
				kdl.setKdlCount(count-1);
				kdlService.update(kdl);
				//如果所属词库不是一级词库的话，还要跟新以及词库的词条数量
				if(kdl.getKdlLevel() != 1){
					KnowledgeDictLib parent = kdl.getKdlParentId();
					count = parent.getKdlCount();
					parent.setKdlCount(count-1);
					kdlService.update(parent);	
				}
				kdiService.delete(item);
			}
			
		}

		return true;
		
	}
	
	/**
	 * ajax   openItem
	 * @return
	 */
	@RequestMapping(value = "openItem")
	public @ResponseBody boolean openItem(String id){
		/*  List<Map<String,Object>> listIdandName = new ArrayList<Map<String,Object>>();
		  List<KnowledgeDictLib> childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(id);
		    for(KnowledgeDictLib lib: childrenLib){
		    	Map<String, Object> map = new HashMap<String, Object>();
		    	map.put("id", lib.getId());
		    	map.put("name", lib.getKdlName());
		    	listIdandName.add(map);
		    }
		        
		    return listIdandName;*/
		String[] ids = id.split(",");
		for(String itemId:ids){
			KnowledgeDictItem item = kdiService.findById(Long.valueOf(itemId), KnowledgeDictItem.class);
			item.setKdiSwitch(1);
			kdiService.update(item);
		}
		return true;
		
	}
	
	/**
	 * ajax   closeItem
	 * @return
	 */
	@RequestMapping(value = "closeItem")
	public @ResponseBody boolean closeItem(String id){
		/*  List<Map<String,Object>> listIdandName = new ArrayList<Map<String,Object>>();
		  List<KnowledgeDictLib> childrenLib = (List<KnowledgeDictLib>) kdlService.findAllChildrenLibByPid(id);
		    for(KnowledgeDictLib lib: childrenLib){
		    	Map<String, Object> map = new HashMap<String, Object>();
		    	map.put("id", lib.getId());
		    	map.put("name", lib.getKdlName());
		    	listIdandName.add(map);
		    }
		        
		    return listIdandName;*/
		String[] ids = id.split(",");
		for(String itemId:ids){
			KnowledgeDictItem item = kdiService.findById(Long.valueOf(itemId), KnowledgeDictItem.class);
			item.setKdiSwitch(0);
			kdiService.update(item);
		}
		return true;
		
	}
	
	/**
	 * ajax addItem
	 * @return
	 */
	@RequestMapping(value = "addItem")
	public @ResponseBody Map<String, Object> addItem(HttpServletRequest request, KnowledgeDictItem item){
		  Map<String,Object> map = new HashMap<String,Object>();
		//更新词条
		  if(item.getId() != null){
			
			  KnowledgeDictItem orginItem = kdiService.findById(item.getId(), KnowledgeDictItem.class);
			  Long orchildId = orginItem.getKdlId().getId();
			  Long orparentId = orginItem.getKdlId().getKdlParentId().getId();
			  Long parentId = item.getParentIdLong();
			  Long childId = item.getKdlIdLong();
			  
			
			  KnowledgeDictLib childLib = kdlService.findById(item.getKdlIdLong(), KnowledgeDictLib.class);
			  if(childLib == null){
				  childLib = kdlService.findById(parentId, KnowledgeDictLib.class);
				  orginItem.setKdlId(childLib);
			  }
			  else{
				  orginItem.setKdlId(childLib);
			  }
			  KnowledgeDictQuality quality = kdqService.findById(item.getKdqIdLong(), KnowledgeDictQuality.class);
			  orginItem.setKdqId(quality);
			  Long time = new Date().getTime()/1000;
			  orginItem.setKdiUpdateTime(time.intValue());
			  orginItem.setKdiName(item.getKdiName());
			  orginItem.setKdiPinyin(item.getKdiPinyin());
			  orginItem.setKdiSegmentation(item.getKdiSegmentation());
			  orginItem.setKdiStatus(item.getKdiStatus());
			  orginItem.setKdiWeight(item.getKdiWeight());
			  kdiService.update(orginItem);
			  
			  //更新父词库
			  if(orparentId != parentId ){
				  if(orparentId != 1){
					  KnowledgeDictLib orparent = kdlService.findById(orparentId, KnowledgeDictLib.class);
					  orparent.setKdlCount((orparent.getKdlCount()-1));
					  kdlService.update(orparent);
				  }  
				  if(parentId != 1){
					  KnowledgeDictLib newparent = kdlService.findById(parentId, KnowledgeDictLib.class);
					  newparent.setKdlCount((newparent.getKdlCount()+1));
					  kdlService.update(newparent);
					  
				  }
			  }
			  //更新子词库
			  if(orchildId != childId){
				  KnowledgeDictLib orchild = kdlService.findById(orchildId, KnowledgeDictLib.class);
				  orchild.setKdlCount((orchild.getKdlCount()-1));
				  kdlService.update(orchild);
				  if(childId != null){
					  KnowledgeDictLib newchild = kdlService.findById(childId, KnowledgeDictLib.class);
					  newchild.setKdlCount((newchild.getKdlCount()+1));
					  kdlService.update(newchild);
				  }
				  
			  }
		  }
		  else{        //增加词条
			      //父词库
			      Long parentId = item.getParentIdLong();
				  KnowledgeDictLib parentLib = kdlService.findById(parentId, KnowledgeDictLib.class);
				  //子词库
				  Long childId = item.getKdlIdLong();
				  KnowledgeDictLib childLib = kdlService.findById(childId, KnowledgeDictLib.class);
				  if(childLib == null){
					  item.setKdlId(parentLib);
				  }
				  else{
					  item.setKdlId(childLib);
				  }
				 
				  //词性词库
				  Long qualityId = item.getKdqIdLong();
				  KnowledgeDictQuality qualityLib = kdqService.findById(qualityId, KnowledgeDictQuality.class);
				  item.setKdqId(qualityLib);
				  
                  //用户
				  Long userId = (Long)request.getSession().getAttribute("userId");
				  User user = userService.findById(userId, User.class);
 
				  item.setUserId(user);		 
				  item.setKdiSwitch(1);
				  Date date = new Date();
				  Long createTime = date.getTime()/1000;
				  item.setKdiCreateTime(createTime.intValue());
				  item.setKdiUpdateTime(createTime.intValue());
				  if(kdiService.findByName(item.getKdiName()) != null)
					  map.put("exit", true);
				  else {
						  map.put("exit", false);
						try{
							kdiService.save(item);
							if(childLib != null){
								parentLib.setKdlCount(parentLib.getKdlCount()+1);
								kdlService.update(parentLib);
								childLib.setKdlCount(childLib.getKdlCount()+1);
								kdlService.update(childLib);
							}
							else{
								parentLib.setKdlCount(parentLib.getKdlCount()+1);
								kdlService.update(parentLib);
							}
							
						}catch(Exception ex){
							ex.printStackTrace();
							map.put("errors",true);
						}
				      }
		  }
			map.put("errors",false);
			return map;
	}

}
