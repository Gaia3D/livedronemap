package gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gaia3d.config.PropertiesConfig;

import gaia3d.domain.CacheManager;
import gaia3d.domain.DroneProject;
import gaia3d.domain.PageType;
import gaia3d.domain.Pagination;
import gaia3d.domain.TransferData;
import gaia3d.service.DroneProjectService;
import gaia3d.service.TransferDataService;
import gaia3d.util.DateUtil;
import gaia3d.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 프로젝트 가시화
 * @author Cheon JeongDae
 *
 */
@Slf4j
@RequestMapping("/drone-project/")
@Controller
public class DroneProjectController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private DroneProjectService droneProjectService;
	@Autowired
	private TransferDataService transferDataService;

	/**
	 * Project 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-drone-project")
	public String listDroneProject(HttpServletRequest request, DroneProject droneProject, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ droneProject = {}", droneProject);
		droneProject.setList_counter(5l);
		
		if(StringUtil.isNotEmpty(droneProject.getStart_date())) {
			droneProject.setStart_date(droneProject.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(droneProject.getEnd_date())) {
			droneProject.setEnd_date(droneProject.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}

		long totalCount = droneProjectService.getDroneProjectTotalCount(droneProject);
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, request, droneProject), 
												totalCount, 
												Long.valueOf(pageNo).longValue(), 
												droneProject.getList_counter());
		
		droneProject.setOffset(pagination.getOffset());
		droneProject.setLimit(pagination.getPageRows());
		
		List<DroneProject> droneProjectList = new ArrayList<>();
		if(totalCount > 0l) {
			droneProjectList = droneProjectService.getListDroneProject(droneProject);
		}
		
		String cesiumIonToken = propertiesConfig.getCesiumIonToken();
		
		model.addAttribute("policy", CacheManager.getPolicy());
		model.addAttribute(pagination);
		model.addAttribute("droneProject", droneProject);
		model.addAttribute("droneProjectList", droneProjectList);
		model.addAttribute("cesoumIonToken", cesiumIonToken);
		return "/drone-project/list-drone-project";
	}
	
	@GetMapping("drone-projects")
	@ResponseBody
	public Map<String, Object> getListDroneProject(HttpServletRequest request, DroneProject droneProject, @RequestParam(defaultValue="1") String pageNo) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		
		log.info("@@ droneProject = {}", droneProject);
		droneProject.setList_counter(5l);
		
		if(StringUtil.isNotEmpty(droneProject.getStart_date())) {
			droneProject.setStart_date(droneProject.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(droneProject.getEnd_date())) {
			droneProject.setEnd_date(droneProject.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long droneProjectTotalCount = droneProjectService.getDroneProjectTotalCount(droneProject);
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, request, droneProject), 
												droneProjectTotalCount, 
												Long.valueOf(pageNo).longValue(), 
												droneProject.getList_counter());
		map.put("pagination", pagination);
		
		droneProject.setOffset(pagination.getOffset());
		droneProject.setLimit(pagination.getPageRows());
		
		try {
			List<DroneProject> droneProjectList = new ArrayList<>();
			if(droneProjectTotalCount > 0l) {
				droneProjectList = droneProjectService.getListDroneProject(droneProject); 
			}
			map.put("droneProjectList", droneProjectList);
			map.put("droneProjectTotalCount", droneProjectTotalCount);
			// image total count 
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * Project 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detail-drone-project")
	public String detailDroneProject(HttpServletRequest request, @RequestParam(value="drone_project_id", required = true) Integer drone_project_id, Model model) {
		
		log.info("@@ drone_project_id = {}", drone_project_id);
		
		DroneProject droneProject = droneProjectService.getDroneProject(drone_project_id);
		log.info("############### droneProject = {}", droneProject);
		List<TransferData> transferDataList = transferDataService.getListTransferData(drone_project_id);
		TransferData viewTransferData = new TransferData();
		if(!transferDataList.isEmpty()) viewTransferData = transferDataList.get(0);
		
		model.addAttribute("policy", CacheManager.getPolicy());
		model.addAttribute("drone_project_id", drone_project_id);
		model.addAttribute("droneProject", droneProject);
		model.addAttribute("viewTransferData", viewTransferData);
		model.addAttribute("transferDataList", transferDataList);
		model.addAttribute("transferDataListSize", transferDataList.size());
		model.addAttribute("searchParameters", getSearchParameters(PageType.DETAIL, request, null));
		return "/drone-project/detail-drone-project";
	}
	
	/**
	 * 드론 프로젝트 조회 by 프로젝트 id
	 * @param request
	 * @return
	 */
	@GetMapping("{drone_project_id}")
	@ResponseBody
	public Map<String, Object> getDroneProject(HttpServletRequest request, @PathVariable Integer drone_project_id) {
		log.info("@@@@@@@@@@ drone_project_id = {}", drone_project_id);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(drone_project_id == null || drone_project_id.intValue() <= 0) {
				result = "drone.project.id.require";
				map.put("result", result);
				return map;
			}
			
			DroneProject droneProject = droneProjectService.getDroneProject(drone_project_id);
			map.put("droneProject", droneProject);
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * TODO 외부 api, 내부 api, 일반적인 url 3 종류로 url을 구분하자.
	 * @param request
	 * @param drone_project_id
	 * @return
	 */
	@GetMapping("{drone_project_id}/transfer-datas")
	@ResponseBody
	public Map<String, Object> listTransferData(HttpServletRequest request, @PathVariable Integer drone_project_id) {
		log.info("@@@@@@@@@@ drone_project_id = {}", drone_project_id);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(drone_project_id == null || drone_project_id.intValue() <= 0) {
				result = "drone.project.id.require";
				map.put("result", result);
				return map;
			}
			
			List<TransferData> transferDataList = transferDataService.getListTransferData(drone_project_id);
			TransferData viewTransferData = new TransferData();
			if(!transferDataList.isEmpty()) viewTransferData = transferDataList.get(0);
			
			map.put("shooting_date", viewTransferData.getViewLayerShootingDate());
			map.put("viewTransferData", viewTransferData);
			map.put("transferDataList", transferDataList);
			map.put("transferDataListSize", transferDataList.size());
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * TODO 이름을 바꾸고.... count 검사하고.... 다르면 데이터도 가져감, 원샷 여러 킬....
	 * @param request
	 * @param drone_project_id
	 * @return
	 */
	@GetMapping("{drone_project_id}/transfer-datas/count")
	@ResponseBody
	public Map<String, Object> getTransferDataCount(HttpServletRequest request, @PathVariable Integer drone_project_id) {
		log.info("@@@@@@@@@@ drone_project_id = {}", drone_project_id);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(drone_project_id == null || drone_project_id.intValue() <= 0) {
				result = "drone.project.id.require";
				map.put("result", result);
				return map;
			}
			
			int transferDataCount = transferDataService.getTransferDataCount(drone_project_id);
			
			map.put("transferDataCount", transferDataCount);
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 검색 조건
	 * @param droneProject
	 * @return
	 */
	private String getSearchParameters(PageType pageType, HttpServletRequest request, DroneProject droneProject) {
		StringBuffer buffer = new StringBuffer();
		boolean isListPage = true;
		if(pageType.equals(PageType.MODIFY) || pageType.equals(PageType.DETAIL)) {
			isListPage = false;
		}
		
		if(!isListPage) {
			buffer.append("pageNo=" + request.getParameter("pageNo"));
		}
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(isListPage ? droneProject.getSearch_word() : request.getParameter("search_word")));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(isListPage ? droneProject.getSearch_option() : request.getParameter("search_option")));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(
					isListPage ? droneProject.getSearch_value() : request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("status=" + StringUtil.getDefaultValue(isListPage ? droneProject.getStatus() : request.getParameter("status")));
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(isListPage ? droneProject.getStart_date() : request.getParameter("start_date")));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(isListPage ? droneProject.getEnd_date() : request.getParameter("end_date")));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(isListPage ? droneProject.getOrder_word() : request.getParameter("order_word")));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(isListPage ? droneProject.getOrder_value() : request.getParameter("order_value")));
		buffer.append("&");
		buffer.append("list_count=" + (isListPage ? droneProject.getList_counter() : StringUtil.getDefaultValue(request.getParameter("list_count"))));
		return buffer.toString();
	}
}
