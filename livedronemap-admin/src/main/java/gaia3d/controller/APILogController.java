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

import gaia3d.domain.APILog;
import gaia3d.domain.PageType;
import gaia3d.domain.Pagination;
import gaia3d.service.APILogService;
import gaia3d.util.DateUtil;
import gaia3d.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * TODO spinner 처리를 해야 함
 * @author
 *
 */
@Slf4j
@RequestMapping("/log/")
@Controller
public class APILogController {
	
	@Autowired
	APILogService aPILogService;
	
	@RequestMapping(value="list-api-log")
	public String listAPILog(HttpServletRequest request, APILog aPILog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ aPILog = {}", aPILog);
		if(StringUtil.isNotEmpty(aPILog.getSearch_start_date())) {
			aPILog.setSearch_start_date(aPILog.getSearch_start_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(aPILog.getSearch_end_date())) {
			aPILog.setSearch_end_date(aPILog.getSearch_end_date().substring(0, 8) + DateUtil.END_TIME);
		}
		
		long totalCount = aPILogService.getAPILogTotalCount(aPILog);
		Pagination pagination = new Pagination(	request.getRequestURI(), 
												getSearchParameters(PageType.LIST, request, aPILog), 
												totalCount, 
												Long.valueOf(pageNo).longValue(), 
												aPILog.getList_counter());
		log.info("@@ pagination = {}", pagination);
		
		aPILog.setOffset(pagination.getOffset());
		aPILog.setLimit(pagination.getPageRows());
		List<APILog> aPILogList = new ArrayList<>();
		if(totalCount > 0l) {
			// TODO TODO spinner 처리를 해야 함
			aPILogList = aPILogService.getListAPILog(aPILog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("aPILog", aPILog);
		model.addAttribute("aPILogList", aPILogList);
		
		return "/log/list-api-log";
	}
	
	/**
	 * 검색 조건
	 * @param aPILog
	 * @return
	 */
	private String getSearchParameters(PageType pageType, HttpServletRequest request, APILog aPILog) {
		StringBuffer buffer = new StringBuffer();
		boolean isListPage = true;
		if(pageType.equals(PageType.MODIFY) || pageType.equals(PageType.DETAIL)) {
			isListPage = false;
		}
		
		if(!isListPage) {
			buffer.append("pageNo=" + request.getParameter("pageNo"));
		}
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(isListPage ? aPILog.getSearch_option() : request.getParameter("search_option")));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(
					isListPage ? aPILog.getSearch_value() : request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(isListPage ? aPILog.getSearch_word() : request.getParameter("search_type")));
		buffer.append("&");
		buffer.append("search_status=" + StringUtil.getDefaultValue(isListPage ? aPILog.getSearch_status() : request.getParameter("search_status")));
		buffer.append("&");
		buffer.append("search_start_date=" + StringUtil.getDefaultValue(isListPage ? aPILog.getSearch_start_date() : request.getParameter("search_start_date")));
		buffer.append("&");
		buffer.append("search_end_date=" + StringUtil.getDefaultValue(isListPage ? aPILog.getSearch_end_date() : request.getParameter("search_end_date")));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(isListPage ? aPILog.getOrder_word() : request.getParameter("order_word")));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(isListPage ? aPILog.getOrder_value() : request.getParameter("order_value")));
		if(!isListPage) {
			buffer.append("&");
			buffer.append("list_count=" + aPILog.getList_counter());
		}
		return buffer.toString();
	}
}
