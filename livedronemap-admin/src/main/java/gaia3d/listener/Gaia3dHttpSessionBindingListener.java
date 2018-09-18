package gaia3d.listener;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import gaia3d.helper.SessionUserHelper;

import lombok.extern.slf4j.Slf4j;

/**
 * 세션 관리
 * @author jeongdae
 *
 */
@Slf4j
public class Gaia3dHttpSessionBindingListener implements HttpSessionBindingListener {

	/**
	 * 사용자의 로그인 세션에 SGNIHttpSessionBindingListener가 바인딩될 때 자동 호출되는 메소드로,
	 * 사용자 세션이 이미 존재하는지를 검사하여 하나의 어플리케이션 내에서 하나의 세션만 유지되도록 한다
	 * @param event
	 */
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		if (SessionUserHelper.isExistSession(event.getName())) {
			log.info("######################### Exist user_id = {}", event.getName());
//			if("N".equals(CacheConfig.getPolicy().getUser_duplication_login_yn())) {
//				SessionUserHelper.invalidateSession(event.getName());
//			}
		}
		log.info("######################### session create user_id = {}, session = {}", event.getName(), event.getSession());
		SessionUserHelper.loginUsersMap.put(event.getName(), event.getSession());
	}

	/**
	 * 
	 * 로그아웃 혹은 세션타임아웃 설정에 따라 사용자 세션으로부터 
	 * EgovHttpSessionBindingListener가 제거될 때 자동 호출되는 메소드로,
	 * 사용자의 로그인 아이디에 해당하는 세션을 ConcurrentHashMap에서 모두 제거한다
	 * @param event
	 */
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		log.info("######################### remove session user_id = {}, session = {}", event.getName(), event.getSession());
		SessionUserHelper.loginUsersMap.remove(event.getName(), event.getSession());
	}
}
