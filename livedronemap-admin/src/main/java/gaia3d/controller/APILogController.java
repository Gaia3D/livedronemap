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
import gaia3d.util.FormatUtil;
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
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
		if(StringUtil.isEmpty(aPILog.getStart_date())) {
			aPILog.setStart_date(today.substring(0,4) + DateUtil.START_DAY_TIME);
		} else {
			aPILog.setStart_date(aPILog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isEmpty(aPILog.getEnd_date())) {
			aPILog.setEnd_date(today + DateUtil.END_TIME);
		} else {
			aPILog.setEnd_date(aPILog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
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
		String status_code = aPILog.getStatus_code() != null ? String.valueOf(aPILog.getStatus_code()) : "0";
		if(!isListPage) {
			status_code = request.getParameter("status_code") != null && !"".equals(request.getParameter("status_code")) ? request.getParameter("status_code") : "0";
		}
		buffer.append("status_code=" + status_code);
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(isListPage ? aPILog.getStart_date() : request.getParameter("start_date")));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(isListPage ? aPILog.getEnd_date() : request.getParameter("end_date")));
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
