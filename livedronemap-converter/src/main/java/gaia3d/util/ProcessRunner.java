package gaia3d.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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
	public static void execProcess(List<String> command) throws IOException {
		log.info("@@@@@@@ command = {}", command);
		log.info("--------------- start ----------------");
		
		ProcessBuilder processBuilder = new ProcessBuilder(command);
		processBuilder.redirectErrorStream(true);
        
        Process process = processBuilder.start();
        
        try(InputStream inputStream = process.getInputStream();
        	InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
    		BufferedReader bufferedReader = new BufferedReader(inputStreamReader);) {
        	
        	String readLine = null;
			while((readLine = bufferedReader.readLine()) != null) {
				log.info(readLine);
			}
			
			process.waitFor();
			log.info("--------------- end ----------------");
        	
        } catch (Exception e) {
        	e.printStackTrace();
		}
		
	}
	
}
