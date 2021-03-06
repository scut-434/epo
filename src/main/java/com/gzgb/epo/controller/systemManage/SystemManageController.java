package com.gzgb.epo.controller.systemManage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gzgb.epo.entity.DepartmentBaseInfo;
import com.gzgb.epo.entity.RegionBaseInfo;
import com.gzgb.epo.entity.Role;
import com.gzgb.epo.entity.User;
import com.gzgb.epo.entity.WebSiteMain;
import com.gzgb.epo.service.departmentBaseInfo.DepartmentBaseInfoService;
import com.gzgb.epo.service.menu.MenuService;
import com.gzgb.epo.service.regionBaseInfo.RegionBaseInfoService;
import com.gzgb.epo.service.role.RoleService;
import com.gzgb.epo.service.user.UserService;
import com.gzgb.epo.service.websitemain.WebSiteMainService;

/**
 * 
 * <pre>
 * 系统管理控制器
 * </pre>
 * 
 * @author XiaoJian
 * @version 1.0, 2013-12-18
 */
@Controller
@RequestMapping(value = "/systemManage")
public class SystemManageController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private WebSiteMainService webSiteMainService;
	
	@Autowired
	private RoleService roleService;
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private DepartmentBaseInfoService dbService;
	
	@Autowired
	private RegionBaseInfoService rbService;
	
	Logger logger = LoggerFactory.getLogger(SystemManageController.class);

	/**
	 * 进入系统管理页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "index/{pMenuId}")
	public String index(@PathVariable Long pMenuId,Model model, HttpServletRequest request) {
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageIndex";
	}

	/**
	 * 进入站点管理页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "toSiteManage/{pMenuId}")
	public String toSiteManage(@PathVariable Long pMenuId,Model model, HttpServletRequest request) {
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToSiteManage";
	}
	
	@RequestMapping(value = "toSiteManage")
	public String toSiteManage1(Model model, HttpServletRequest request) {
		Long pMenuId = menuService.findByMenuName("站点管理").getId();
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToSiteManage";
	}

	/**
	 * 进入添加站点页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "toAddSite/{pMenuId}")
	public String toAddSite(@PathVariable Long pMenuId,Model model, HttpServletRequest request) {
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToAddSite";
	}
	
	@RequestMapping(value = "toAddSite")
	public String toAddSite1(Model model, HttpServletRequest request) {
		Long pMenuId = menuService.findByMenuName("添加站点").getId();
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToAddSite";
	}

	/**
	 * 进入信息统计页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "statistics")
	public String statistics(Model model, HttpServletRequest request) {
		return "systemManage/systemManageStatistics";
	}

	/**
	 * 进入采集点管理页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "toGatherManage/{pMenuId}")
	public String toGatherManage(@PathVariable Long pMenuId,Model model, HttpServletRequest request, Long webSiteID) {
		model.addAttribute("webSiteID", webSiteID);
		List<WebSiteMain> list= webSiteMainService.getAll(WebSiteMain.class, null);
		List<Map<Object,Object>> webSiteNameList = new ArrayList<Map<Object,Object>>();
		if(list!=null && list.size()>0){
			for(int i=0;i<list.size();i++){
				WebSiteMain webSiteMain =list.get(i);
				Map<Object,Object> map = new HashMap<Object,Object>();
				map.put("key",webSiteMain.getId());
				map.put("value",webSiteMain.getWsmName());
				webSiteNameList.add(map);
			}
		}
		model.addAttribute("webSiteNameList", webSiteNameList);
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToGatherManage";
	}
	
	@RequestMapping(value = "toGatherManage")
	public String toGatherManage1(Model model, HttpServletRequest request, Long webSiteID) {
		model.addAttribute("webSiteID", webSiteID);
		List<WebSiteMain> list= webSiteMainService.getAll(WebSiteMain.class, null);
		List<Map<Object,Object>> webSiteNameList = new ArrayList<Map<Object,Object>>();
		if(list!=null && list.size()>0){
			for(int i=0;i<list.size();i++){
				WebSiteMain webSiteMain =list.get(i);
				Map<Object,Object> map = new HashMap<Object,Object>();
				map.put("key",webSiteMain.getId());
				map.put("value",webSiteMain.getWsmName());
				webSiteNameList.add(map);
			}
		}
		model.addAttribute("webSiteNameList", webSiteNameList);
		Long pMenuId = menuService.findByMenuName("采集点管理").getId();
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToGatherManage";
	}

	/**
	 * 进入添加采集点页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "toAddGather/{pMenuId}")
	public String toAddGather(@PathVariable Long pMenuId,Model model, HttpServletRequest request) {
		List<WebSiteMain> list= webSiteMainService.getAll(WebSiteMain.class, null);
		List<Map<Object,Object>> webSiteNameList = new ArrayList<Map<Object,Object>>();
		if(list!=null && list.size()>0){
			for(int i=0;i<list.size();i++){
				WebSiteMain webSiteMain =list.get(i);
				Map<Object,Object> map = new HashMap<Object,Object>();
				map.put("key",webSiteMain.getId());
				map.put("value",webSiteMain.getWsmName());
				webSiteNameList.add(map);
			}
		}
		model.addAttribute("webSiteNameList", webSiteNameList);
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToAddGather";
	}
	
	@RequestMapping(value = "toAddGather")
	public String toAddGather1(Model model, HttpServletRequest request) {
		List<WebSiteMain> list= webSiteMainService.getAll(WebSiteMain.class, null);
		List<Map<Object,Object>> webSiteNameList = new ArrayList<Map<Object,Object>>();
		if(list!=null && list.size()>0){
			for(int i=0;i<list.size();i++){
				WebSiteMain webSiteMain =list.get(i);
				Map<Object,Object> map = new HashMap<Object,Object>();
				map.put("key",webSiteMain.getId());
				map.put("value",webSiteMain.getWsmName());
				webSiteNameList.add(map);
			}
		}
		model.addAttribute("webSiteNameList", webSiteNameList);
		Long pMenuId = menuService.findByMenuName("添加采集点").getId();
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToAddGather";
	}

	/**
	 * 进入个人中心页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "personalCenter/{pMenuId}")
	public String personalCenter(@PathVariable Long pMenuId,Model model, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("userId");
		if(id!=null){
			User user = userService.findById(id, User.class);
			Long time = Long.parseLong(user.getLastLoginTime().toString())* 1000;
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 	//格式化日期 
			String lastTime = f.format(new Date(time));
			user.setLastTime(lastTime);
			user.setType(userService.getUserType(user.getUserType()));
			model.addAttribute("user", user);
		}
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManagePersonalCenter";
	}

	@RequestMapping(value = "personalCenter")
	public String personalCenter1(Model model, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("userId");
		if(id!=null){
			User user = userService.findById(id, User.class);
			Long time = Long.parseLong(user.getLastLoginTime().toString())* 1000;
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 	//格式化日期 
			String lastTime = f.format(new Date(time));
			user.setLastTime(lastTime);
			user.setType(userService.getUserType(user.getUserType()));
			model.addAttribute("user", user);
		}
		Long pMenuId = menuService.findByMenuName("个人中心").getId();
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManagePersonalCenter";
	}
	
	/**
	 * 进入更改密码页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "toChangePass/{pMenuId}")
	public String toChangePass(@PathVariable Long pMenuId,Model model, HttpServletRequest request) {
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToChangePass";
	}
	
	@RequestMapping(value = "toChangePass")
	public String toChangePass1(Model model, HttpServletRequest request) {
		Long pMenuId = menuService.findByMenuName("更改密码").getId();
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToChangePass";
	}

	/**
	 * 进入修改信息页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "toEditUser/{pMenuId}")
	public String toEditUser(@PathVariable Long pMenuId,Model model, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("userId");
		if(id!=null){
			User user = userService.findById(id, User.class);
			model.addAttribute("user", user);
		}
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToEditUser";
	}
	
	@RequestMapping(value = "toEditUser")
	public String toEditUser(Model model, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("userId");
		if(id!=null){
			User user = userService.findById(id, User.class);
			model.addAttribute("user", user);
		}
		Long pMenuId = menuService.findByMenuName("修改信息").getId();
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToEditUser";
	}

	/**
	 * 进入用户管理页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "toUserManage/{pMenuId}")
	public String toUserManage(@PathVariable Long pMenuId,Model model, HttpServletRequest request) {
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToUserManage";
	}
	
	@RequestMapping(value = "toUserManage")
	public String toUserManage1(Model model, HttpServletRequest request) {
		Long pMenuId = menuService.findByMenuName("用户管理").getId();
		menuService.getLeftMenu(pMenuId,model);
		return "systemManage/systemManageToUserManage";
	}

	/**
	 * 进入添加用户页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "toAddUser/{pMenuId}")
	public String toAddUser(@PathVariable Long pMenuId,Model model, HttpServletRequest request) {
		List<Role> roles = new ArrayList<Role>();
		List<Role> roleList = new ArrayList<Role>();
		roleList.addAll(roleService.findAll(Role.class));
		model.addAttribute("roleList", roleList);
		model.addAttribute("roles", roles);
		menuService.getLeftMenu(pMenuId,model);
		getDbAndRb(model);
		return "systemManage/systemManageToAddUser";
	}
	
	@RequestMapping(value = "toAddUser")
	public String toAddUser(Model model, HttpServletRequest request) {
		List<Role> roles = new ArrayList<Role>();
		List<Role> roleList = new ArrayList<Role>();
		roleList.addAll(roleService.findAll(Role.class));
		model.addAttribute("roleList", roleList);
		Long pMenuId = menuService.findByMenuName("添加用户").getId();
		model.addAttribute("roles", roles);
		menuService.getLeftMenu(pMenuId,model);
		getDbAndRb(model);
		return "systemManage/systemManageToAddUser";
	}
	
	/**
	 * 
	 * <pre>
	 * 得到区县和部门列表
	 * </pre>
	 * @param model
	 */
	public void getDbAndRb(Model model){
		List<DepartmentBaseInfo> list1= dbService.findAll(DepartmentBaseInfo.class);
		List<RegionBaseInfo> list2= rbService.findAll(RegionBaseInfo.class);
		List<Map<Object,Object>> dbiIdList = new ArrayList<Map<Object,Object>>();
		List<Map<Object,Object>> rbiIdList = new ArrayList<Map<Object,Object>>();
		if(list1!=null && list1.size()>0){
			for(int i=0;i<list1.size();i++){
				DepartmentBaseInfo departmentBaseInfo =list1.get(i);
				Map<Object,Object> map = new HashMap<Object,Object>();
				map.put("key",departmentBaseInfo.getId());
				map.put("value",departmentBaseInfo.getDbiName());
				dbiIdList.add(map);
			}
		}
		if(list2!=null && list2.size()>0){
			for(int i=0;i<list2.size();i++){
				RegionBaseInfo regionBaseInfo =list2.get(i);
				Map<Object,Object> map = new HashMap<Object,Object>();
				map.put("key",regionBaseInfo.getId());
				map.put("value",regionBaseInfo.getRbiName());
				rbiIdList.add(map);
			}
		}
		model.addAttribute("dbiIdList", dbiIdList);
		model.addAttribute("rbiIdList", rbiIdList);
	}


}
