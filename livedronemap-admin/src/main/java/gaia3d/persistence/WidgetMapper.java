package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.Widget;

/**
 * 위젯
 * @author jeongdae
 *
 */
@Repository
public interface WidgetMapper {

	/**
	 * 위젯 목록
	 * @param widget
	 * @return
	 */
	List<Widget> getListWidget(Widget widget);
	
	/**
	 * 위젯 저장
	 * @param widget
	 * @return
	 */
	int insertWidget(Widget widget);
	
	/**
	 * 위젯 수정
	 * @param widget
	 * @return
	 */
	int updateWidget(Widget widget);
}
