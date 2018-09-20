package gaia3d.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.DroneProject;
import gaia3d.domain.ProjectException;

@RequestMapping("/api/")
@RestController
public class DroneProjectAPIController {

	@PostMapping("projects")
	public ResponseEntity<DroneProject> createProject(HttpServletRequest request, @RequestBody DroneProject project) {
		
//		if (customerService.isCustomerExist(customer)) {
//			return new ResponseEntity<Void>(HttpStatus.CONFLICT);
//		}
//		final Customer savedCustomer = customerService.saveCustomer(customer);
//		
//		final HttpHeaders headers = new HttpHeaders();
//		headers.setLocation(ucBuilder.path("/customer/{id}").buildAndExpand(savedCustomer.getId()).toUri());
//		return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
		
		if(project == null) new ProjectException(0l);
		
		return new ResponseEntity<DroneProject>(project, HttpStatus.OK);
	}
	
	@PutMapping("projects/{project_id}")
	public ResponseEntity<DroneProject> updateProject(@PathVariable Long project_id, @RequestBody DroneProject project) {
		
//		Customer updatedCustomer = customerService.updateCustomer(id, customer);
//
//		if (updatedCustomer == null) {
//			return new ResponseEntity<Customer>(HttpStatus.NOT_FOUND);
//		}
//		
//		return new ResponseEntity<Customer>(updatedCustomer, HttpStatus.OK);
		
		return new ResponseEntity<DroneProject>(project, HttpStatus.OK);
	}
	
	@DeleteMapping("projects/{project_id}")
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void delete(@PathVariable Long project_id) {
		
	}
}
