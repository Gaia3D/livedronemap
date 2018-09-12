package gaia3d.util;

import java.io.IOException;
import java.lang.ProcessBuilder.Redirect;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

/**
 * 외부 명령 실행 
 * @author jskim
 *
 */
@Slf4j
@Component
public class ProcessRunner {
	
	ProcessBuilder builder = new ProcessBuilder();
	
	@PostConstruct
	public void printCommandStatus() {
		// 실행하는 명령어의 프린트 출력을 그대로 전달 도록 설정;
		this.builder.redirectOutput(Redirect.INHERIT); 
		this.builder.redirectError(Redirect.INHERIT);
	}
	
	/**
	 * CLI 명령을 String배열로 받아서 실행 
	 * 
	 * @param command
	 * @throws InterruptedException
	 * @throws IOException
	 */
	public void execProcess(List<String> command) throws InterruptedException, IOException  {
		log.debug("Exec command : {}", String.join(" ", command));
		builder.command(command);
	    Process process = builder.start();
		process.waitFor();
	}
	
}
