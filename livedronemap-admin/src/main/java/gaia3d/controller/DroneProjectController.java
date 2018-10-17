package gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.domain.DroneProject;
import gaia3d.domain.PageType;
import gaia3d.domain.Pagination;
import gaia3d.domain.TransferData;
import gaia3d.service.DroneProjectService;
import gaia3d.service.TransferDataService;
import gaia3d.util.DateUtil;
import gaia3d.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/drone-project/")
@Controller
public class DroneProjectController {
	
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
		log.info("@@ pagination = {}", pagination);
		
		droneProject.setOffset(pagination.getOffset());
		droneProject.setLimit(pagination.getPageRows());
		List<DroneProject> droneProjectList = new ArrayList<>();
		if(totalCount > 0l) {
			droneProjectList = droneProjectService.getListDroneProject(droneProject);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("droneProject", droneProject);
		model.addAttribute("droneProjectList", droneProjectList);
		return "/drone-project/list-drone-project";
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
		List<TransferData> transferDataList = transferDataService.getListTransferData(drone_project_id);
		
		log.info("############### day = {}", transferDataList.get(0).getLayer_shooting_date());
		
		model.addAttribute("drone_project_id", drone_project_id);
		model.addAttribute("droneProject", droneProject);
		model.addAttribute("viewTransferData", transferDataList.get(0));
		model.addAttribute("transferDataList", transferDataList);
		model.addAttribute("transferDataListSize", transferDataList.size());
		model.addAttribute("searchParameters", getSearchParameters(PageType.DETAIL, request, null));
		return "/drone-project/detail-drone-project";
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
