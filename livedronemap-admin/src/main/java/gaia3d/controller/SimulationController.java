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

import gaia3d.domain.Client;
import gaia3d.domain.PageType;
import gaia3d.domain.Pagination;
import gaia3d.domain.SimulationLog;
import gaia3d.service.ClientService;
import gaia3d.service.SimulationLogService;
import gaia3d.util.DateUtil;
import gaia3d.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/simulation/")
public class SimulationController {
	
	@Autowired
	ClientService clientService;
	@Autowired
	SimulationLogService simulationLogService;
	
	
	@RequestMapping(value = "list-simulation")
	public String listSimulation(HttpServletRequest request, SimulationLog simulationLog, 
			@RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ simulationLog = {}", simulationLog);
		if(StringUtil.isNotEmpty(simulationLog.getStart_date())) {
			simulationLog.setStart_date(simulationLog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(simulationLog.getEnd_date())) {
			simulationLog.setEnd_date(simulationLog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		
		long totalCount = simulationLogService.getSimulationLogTotalCount(simulationLog);
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, request, simulationLog), 
												totalCount, 
												Long.valueOf(pageNo).longValue(), 
												simulationLog.getList_counter());
		log.info("@@ pagination = {}", pagination);
		
		simulationLog.setOffset(pagination.getOffset());
		simulationLog.setLimit(pagination.getPageRows());
		List<SimulationLog> simulationLogList = new ArrayList<>();
		if(totalCount > 0l) {
			simulationLogList = simulationLogService.getSimulationLogList(simulationLog);
		}
		
		List<Client> clientList = clientService.getListClient();
		model.addAttribute("clientList", clientList);
		model.addAttribute(pagination);
		model.addAttribute("simulationLog", simulationLog);
		model.addAttribute("simulationLogList", simulationLogList);
		
		return "/simulation/list-simulation";
	}
	
	/**
	 * 검색 조건
	 * @param droneProject
	 * @return
	 */
	private String getSearchParameters(PageType pageType, HttpServletRequest request, SimulationLog simulationLog) {
		StringBuffer buffer = new StringBuffer();
		boolean isListPage = true;
		if(pageType.equals(PageType.MODIFY) || pageType.equals(PageType.DETAIL)) {
			isListPage = false;
		}
		
		if(!isListPage) {
			buffer.append("pageNo=" + request.getParameter("pageNo"));
		}
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(isListPage ? simulationLog.getSearch_option() : request.getParameter("search_option")));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(
					isListPage ? simulationLog.getSearch_value() : request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("simulation_type=" + StringUtil.getDefaultValue(isListPage ? simulationLog.getSimulation_type() : request.getParameter("simulation_type")));
		buffer.append("&");
		buffer.append("status=" + StringUtil.getDefaultValue(isListPage ? simulationLog.getStatus() : request.getParameter("status")));
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(isListPage ? simulationLog.getStart_date() : request.getParameter("start_date")));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(isListPage ? simulationLog.getEnd_date() : request.getParameter("end_date")));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(isListPage ? simulationLog.getOrder_word() : request.getParameter("order_word")));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(isListPage ? simulationLog.getOrder_value() : request.getParameter("order_value")));
		if(!isListPage) {
			buffer.append("&");
			buffer.append("list_count=" + simulationLog.getList_counter());
		}
		return buffer.toString();
	}
	
}
