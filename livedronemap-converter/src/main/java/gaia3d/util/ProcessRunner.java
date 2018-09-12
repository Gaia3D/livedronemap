package gaia3d.util;

import java.io.IOException;
import java.lang.ProcessBuilder.Redirect;
import java.util.List;

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
	
	/**
	 * CLI 명령을 String배열로 받아서 실행 
	 * 
	 * @param command
	 * @throws InterruptedException
	 * @throws IOException
	 */
	public void execProcess(List<String> command) throws InterruptedException, IOException  {
		log.debug("Exec command : {}", String.join(" ", command));
		ProcessBuilder builder = new ProcessBuilder();
//		builder.redirectErrorStream(true);
		builder.redirectOutput(Redirect.INHERIT); 
		builder.redirectError(Redirect.INHERIT);
		builder.command(command);
		
	    Process process = builder.start();
		process.waitFor();
	}
	
}
