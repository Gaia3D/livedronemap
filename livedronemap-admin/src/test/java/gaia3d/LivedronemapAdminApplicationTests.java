package gaia3d;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class LivedronemapAdminApplicationTests {

	@Autowired
	private SqlSessionFactory sqlSession;
	
	@Test
	public void testSqlSession() throws Exception {
		System.out.println("@@@@@@@@@@@@ sqlSession : " + sqlSession);
	}

}
