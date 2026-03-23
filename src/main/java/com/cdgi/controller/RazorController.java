package com.cdgi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class RazorController {
	
//	@GetMapping("/")
//	public String mainPage() {
//		return "index";
//	}
//	
	@GetMapping("/pay")
	public ModelAndView succeess(@RequestParam("amount")int amt)
	{
		ModelAndView mv = new ModelAndView("success","msg",amt+" amount payed successfully");
		return mv;
	}
	
}
