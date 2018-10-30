package gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import gaia3d.domain.Client;

@Component("clientValidator")
public class ClientValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (Client.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		Client client = (Client) target;
		
		if("insert".equals(client.getMethod_mode())) {
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "client_id", "file.required");
		}
		
		if(client.getClient_group_id() <= 0) {
			errors.rejectValue("client_group_id", "field.required", null, null);
		}
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "client_name", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "client_ip", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "api_key", "field.required");
	}
}
