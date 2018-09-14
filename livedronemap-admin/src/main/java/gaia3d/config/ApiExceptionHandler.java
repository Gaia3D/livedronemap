package gaia3d.config;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import gaia3d.domain.ApiResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestControllerAdvice
public class ApiExceptionHandler extends ResponseEntityExceptionHandler {

	private ApiResult createApiResult(Exception ex) {
		ApiResult apiResult = new ApiResult();
		apiResult.setMessage(ex.getMessage());
		return apiResult;
	}
	
	@Override
	protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers, HttpStatus status, WebRequest request) {
		ApiResult apiResult = createApiResult(ex);
		return super.handleExceptionInternal(ex, apiResult, headers, status, request);
	}
	
//	@ResponseStatus(value=HttpStatus.UNAUTHORIZED)
//	@ExceptionHandler(value=RuntimeException.class)
//	public ResponseEntity<ApiResult> hanleSystemException(Exception ex, WebRequest request) {
//		return handleExceptionInternal(ex, body, headers, status, request);
//	}
	
//	@ExceptionHandler(Exception.class)
//	public ModelAndView error(Exception exception) {
//		log.error("**********************************************************");
//		log.error("**************** GlobalExceptionHandler ******************");
//		log.error("**********************************************************");
//		
//		exception.printStackTrace();
//		
//		ModelAndView mav = new ModelAndView();
//	    mav.addObject("exception", exception);
//	    mav.setViewName("/error/error");
//	    return mav;
//	}
}
