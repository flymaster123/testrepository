package com.travel.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.travel.bean.ImageForm;
import com.travel.bean.LoginForm;


@Controller
public class SiteMapUploadController {

 
	@GetMapping("/sitemap/login")
	public String sitemapLogin(@ModelAttribute LoginForm loginForm){
		return "sitemaplogin";
	} 
	
	@PostMapping("/sitemap/login")
	public String imageloginSubmit(@ModelAttribute LoginForm loginForm,@ModelAttribute ImageForm imageForm,Model model){
		if(loginForm.getUserName().equalsIgnoreCase("support@lowtickets.com") && loginForm.getPassword().equals("lowtickets")){
			return "sitemapupload";
		}
		else{
		model.addAttribute("loginError", "Username & Password didn't matched");	
		return "sitemaplogin";
		}
	}
	
		
	@PostMapping("/sitemap/submit")
	public String imagesubmit(@ModelAttribute ImageForm imageForm,HttpServletRequest request,Model model){
		System.out.println("folder name : " + imageForm.getFolderName());
		
	//	String UPLOADED_FOLDER = request.getServletContext().getRealPath("")+"//resources//images//"+imageForm.getFolderName().toLowerCase().replaceAll(" ", "-")+"//";   // for server
		String UPLOADED_FOLDER = request.getServletContext().getRealPath(""); 
		System.out.println("UPLOADED_FOLDER :-- "+UPLOADED_FOLDER);
		File directory = new File(UPLOADED_FOLDER);
	   	 if (! directory.exists()){
	   	        directory.mkdir();
	   	    }
		byte[] bytesLogo = null;
		 try {
    		 bytesLogo = imageForm.getFile().getBytes();
    		
		} catch (IOException e) {
			
			e.printStackTrace();
		}
    	 Path path = Paths.get(UPLOADED_FOLDER + imageForm.getFile().getOriginalFilename());
          try {
        	  Files.write(path, bytesLogo);
        	 
		} catch (IOException e) {
			
			e.printStackTrace();
		}
         model.addAttribute("imageSuccess", "Sitemap Uploaded Successfully!");
		return "sitemapupload";
	}


	
}
