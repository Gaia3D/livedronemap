package gaia3d.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zaxxer.hikari.HikariDataSource;

import gaia3d.domain.DroneProject;
import gaia3d.domain.PGStatActivity;
import gaia3d.domain.UserInfo;
import gaia3d.domain.Widget;
import gaia3d.helper.SessionUserHelper;
import gaia3d.service.AccessLogService;
import gaia3d.service.DroneProjectService;
import gaia3d.service.MonitoringService;
import gaia3d.service.UserService;
import gaia3d.service.WidgetService;
import gaia3d.util.DateUtil;
import gaia3d.util.FormatUtil;
import lombok.extern.slf4j.Slf4j;


/**
 * 위젯 관리
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/config/")
public class WidgetController {
	
	private static final long WIDGET_LIST_VIEW_COUNT = 7l;
	
	@Autowired
	private HikariDataSource dataSource;
	@Autowired
	private DroneProjectService droneProjectService;
	@Autowired
	private AccessLogService logService;
	@Autowired
	private MonitoringService monitoringService;
	@Autowired
	private UserService userService;
	@Autowired
	private WidgetService widgetService;
	
	/**
	 * 위젯 정보 수정 화면
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-widget")
	public String modifyWidget(HttpServletRequest request, Model model) {
		
		Widget widget = new Widget();
		List<Widget> widgetList = widgetService.getListWidget(widget);
		
		String today = DateUtil.getToday(FormatUtil.VIEW_YEAR_MONTH_DAY_TIME);
		String yearMonthDay = today.substring(0, 4) + today.substring(5,7) + today.substring(8,10);
				
		// 사용자 현황
		UserInfo userInfo = new UserInfo();
		userInfo.setStatus(UserInfo.STATUS_USE);
		Long activeUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserInfo.STATUS_FORBID);
		Long fobidUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserInfo.STATUS_FAIL_LOGIN_COUNT_OVER);
		Long failUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserInfo.STATUS_SLEEP);
		Long sleepUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserInfo.STATUS_TERM_END);
		Long expireUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus(UserInfo.STATUS_TEMP_PASSWORD);
		Long tempPasswordUserTotalCount = userService.getUserTotalCount(userInfo);
		
		// 감사 로그
		// accessLogWidget
		
		model.addAttribute("today", today);
		model.addAttribute("yearMonthDay", today.subSequence(0, 10));
		model.addAttribute("thisYear", yearMonthDay.subSequence(0, 4));
		
		// 사용자 상태별 현황
		model.addAttribute("activeUserTotalCount", activeUserTotalCount);
		model.addAttribute("fobidUserTotalCount", fobidUserTotalCount);
		model.addAttribute("failUserTotalCount", failUserTotalCount);
		model.addAttribute("sleepUserTotalCount", sleepUserTotalCount);
		model.addAttribute("expireUserTotalCount", expireUserTotalCount);
		model.addAttribute("tempPasswordUserTotalCount", tempPasswordUserTotalCount);
		
		// dbcpWidget
		model.addAttribute("userSessionCount", SessionUserHelper.loginUsersMap.size());
		model.addAttribute("initialSize", dataSource.getMaximumPoolSize());
////		model.addAttribute("maxTotal", dataSource.getMaxTotal());
//		model.addAttribute("maxIdle", dataSource.getMaxIdle());
		model.addAttribute("minIdle", dataSource.getMinimumIdle());
//		model.addAttribute("numActive", dataSource.getNumActive());
//		model.addAttribute("numIdle", dataSource.getNumIdle());
		// 사용자 dbcp 정보
		Map<String, Integer> userDbcp = getUserDbcp();
		model.addAttribute("userUserSessionCount", userDbcp.get("userSessionCount"));
		model.addAttribute("userInitialSize", userDbcp.get("initialSize"));
		model.addAttribute("userMaxTotal", userDbcp.get("maxTotal"));
		model.addAttribute("userMaxIdle", userDbcp.get("maxIdle"));
		model.addAttribute("userMinIdle", userDbcp.get("minIdle"));
		model.addAttribute("userNumActive", userDbcp.get("numActive"));
		model.addAttribute("userNumIdle", userDbcp.get("numIdle"));
		
		// DB 세션 현황
		List<PGStatActivity> dbSessionList = monitoringService.getListDBSession();
		Integer dbSessionCount = dbSessionList.size();
		if(dbSessionCount > 7) dbSessionList = dbSessionList.subList(0, 7);
		model.addAttribute("dbSessionCount", dbSessionCount);
		model.addAttribute("dbSessionList", dbSessionList);
		
		model.addAttribute(widget);
		model.addAttribute(widgetList);
		
		return "/config/modify-widget";
	}
	
//	/**
//	 * 위젯 수정
//	 * @param model
//	 * @return
//	 */
//	@PostMapping(value = "ajax-update-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxUpdateWidget(HttpServletRequest request, Widget widget) {
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			
//			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//			
//			log.info("@@ widget = {} ", widget);
//			if(widget.getWidget_order() == null || "".equals(widget.getWidget_order())) {
//				result = "widget.invalid";
//				map.put("result", result);
//				return map;
//			}
//			
//			List<Widget> widgetList = new ArrayList<>();
//			String[] orders = widget.getWidget_order().split(",");
//			int count = orders.length;
//			for(int i=1; i<count; i++) {
//				widget = new Widget();
//				widget.setUser_id(userSession.getUser_id());
//				widget.setWidget_id(Long.valueOf(orders[i]));
//				widget.setView_order(Integer.valueOf(i));
//				widgetList.add(widget);
//			}
//			
//			widgetService.updateWidget(widgetList);
//			
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		return map;
//	}
	
	/**
	 * 프로젝트별 데이터 건수
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "drone-project-widget")
	@ResponseBody
	public Map<String, Object> ajaxProjectDataWidget(HttpServletRequest request) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			DroneProject droneProject = new DroneProject();
			droneProject.setOffset(0l);
			droneProject.setLimit(6l);
			List<DroneProject> droneProjectList = droneProjectService.getListDroneProject(droneProject);
			
			map.put("droneProjectList", droneProjectList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
//	/**
//	 * 데이터 상태별 통계 정보
//	 * @param request
//	 * @return
//	 */
//	@RequestMapping(value = "ajax-data-status-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxDataStatusStatistics(HttpServletRequest request) {
//		
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			DataInfo dataInfo = new DataInfo();
//			dataInfo.setStatus(DataInfo.STATUS_USE);
//			long useTotalCount = dataService.getDataTotalCountByStatus(dataInfo);
//			dataInfo.setStatus(DataInfo.STATUS_FORBID);
//			long forbidTotalCount = dataService.getDataTotalCountByStatus(dataInfo);
//			dataInfo.setStatus(DataInfo.STATUS_ETC);
//			long etcTotalCount = dataService.getDataTotalCountByStatus(dataInfo);
//						
//			map.put("useTotalCount", useTotalCount);
//			map.put("forbidTotalCount", forbidTotalCount);
//			map.put("etcTotalCount", etcTotalCount);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//		
//		map.put("result", result);
//		return map;
//	}
//	
//	/**
//	 * 데이터 변경 요청 목록
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "ajax-data-info-log-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxDataInfoLogWidget(HttpServletRequest request) {
//		log.info("------------ data info log widget");
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
//			Calendar calendar = Calendar.getInstance();
//			calendar.add(Calendar.DATE, -7);
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
//			String searchDay = simpleDateFormat.format(calendar.getTime());
//			String startDate = searchDay + DateUtil.START_TIME;
//			String endDate = today + DateUtil.END_TIME;
//			
//			DataInfoLog dataInfoLog = new DataInfoLog();
//			dataInfoLog.setStart_date(startDate);
//			dataInfoLog.setEnd_date(endDate);
//			dataInfoLog.setOffset(0l);
//			dataInfoLog.setLimit(WIDGET_LIST_VIEW_COUNT);
//			List<DataInfoLog> dataInfoLogList = dataLogService.getListDataInfoLog(dataInfoLog);
//			
//			map.put("dataInfoLogList", dataInfoLogList);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		return map;
//	}
//	
//	/**
//	 * 사용자 추적 이력 목록
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "ajax-access-log-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxAccessLogWidget(HttpServletRequest request) {
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
//			Calendar calendar = Calendar.getInstance();
//			calendar.add(Calendar.DATE, -7);
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
//			String searchDay = simpleDateFormat.format(calendar.getTime());
//			String startDate = searchDay + DateUtil.START_TIME;
//			String endDate = today + DateUtil.END_TIME;
//			
//			AccessLog accessLog = new AccessLog();
//			accessLog.setStart_date(startDate);
//			accessLog.setEnd_date(endDate);
//			accessLog.setOffset(0l);
//			accessLog.setLimit(WIDGET_LIST_VIEW_COUNT);
//			List<AccessLog> accessLogList = logService.getListAccessLog(accessLog);
//			
//			map.put("accessLogList", accessLogList);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		return map;
//	}
//	
//	/**
//	 * 스케줄 실행 이력 목록
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "ajax-schedule-log-list-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxScheduleLogListWidget(HttpServletRequest request) {
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
//			Calendar calendar = Calendar.getInstance();
//			calendar.add(Calendar.DATE, -7);
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
//			String searchDay = simpleDateFormat.format(calendar.getTime());
//			String startDate = searchDay + DateUtil.START_TIME;
//			String endDate = today + DateUtil.END_TIME;
//			
//			ScheduleLog scheduleLog = new ScheduleLog();
//			scheduleLog.setStart_date(startDate);
//			scheduleLog.setEnd_date(endDate);
//			scheduleLog.setOffset(0l);
//			scheduleLog.setLimit(WIDGET_LIST_VIEW_COUNT);
//			List<ScheduleLog> scheduleLogList = scheduleService.getListScheduleLog(scheduleLog);
//			
//			map.put("scheduleLogList", scheduleLogList);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		return map;
//	}
//	
	/**
	 * 사용자 페이지 DBCP 정보
	 * @return
	 */
	private Map<String, Integer> getUserDbcp() {
		// 사용자 페이지에서 API로 가져와야 함
		Map<String, Integer> userDbcp = new HashMap<>();
		String success_yn = null;
		String result_message = "";
		Integer userSessionCount = 0;
		Integer initialSize = 0;
		Integer maxTotal = 0;
		Integer maxIdle = 0;
		Integer minIdle = 0;
		Integer numActive = 0;
		Integer numIdle = 0;
		
		userDbcp.put("userSessionCount", userSessionCount);
		userDbcp.put("initialSize", initialSize);
		userDbcp.put("maxTotal", maxTotal);
		userDbcp.put("maxIdle", maxIdle);
		userDbcp.put("minIdle", minIdle);
		userDbcp.put("numActive", numActive);
		userDbcp.put("numIdle", numIdle);
		
		return userDbcp;
	}
}
