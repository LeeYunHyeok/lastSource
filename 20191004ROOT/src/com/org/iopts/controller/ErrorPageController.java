package com.org.iopts.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ErrorPageController {

	private static final Logger logger = LoggerFactory.getLogger(ErrorPageController.class);

	
	@RequestMapping("/errorPage")
    @ResponseStatus(value=HttpStatus.INTERNAL_SERVER_ERROR)
    public String showErrorPage(){
		
		logger.info("Error_________________________________________________");
		
        return "errorPage";
    }


}
