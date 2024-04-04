package com.travel.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.bean.LoginForm;
import com.travel.bean.RegisterForm;
import com.travel.object.login.LoginResponse;
import com.travel.object.userregister.RegisterRequest;
import com.travel.object.userregister.RegisterResponse;

@Controller
public class LoginController {
	
	@Value("${apiUrl}")
	private String apiUrl;
	
	@GetMapping("/login")
	public String loginRegister(@ModelAttribute LoginForm loginForm,@ModelAttribute RegisterForm registerForm,HttpServletRequest request){
		
		return "login";
		
	}
	
	@GetMapping("/register")
	public String lRegister(@ModelAttribute LoginForm loginForm,@ModelAttribute RegisterForm registerForm,HttpServletRequest request){
		
		return "login";
		 
	}
	@GetMapping("/signup")
	public String signup(@ModelAttribute LoginForm loginForm,@ModelAttribute RegisterForm registerForm,HttpServletRequest request,Model model){
		model.addAttribute("page", "signup");
		return "login";
		
	}
	@PostMapping("/login")
	public String loginSubmit(@ModelAttribute LoginForm loginForm,@ModelAttribute RegisterForm registerForm,HttpServletRequest request,Model model){
		RestTemplate rest = new RestTemplate();
		ObjectMapper mapper = new ObjectMapper();
		RegisterRequest register = new RegisterRequest();
		register.setPassword(loginForm.getPassword());
		register.setPasswordValue(loginForm.getPassword());
		register.setUserEmail(loginForm.getUserName());
		register.setLoginId(loginForm.getUserName());
		register.setUserName("");
		register.setUserType(7);
		register.setUserProfilePhoto("none");
		register.setUserPermanentCountryId(1);
		register.setMobile("1234567890");
		register.setReferuserCode("none");
		register.setLoginStatus("online");
		register.setAccountStatus("Active");
		register.setUserProfileDob("1990-08-09");
		register.setNationality("US");
		register.setDeportmentId(1);
		register.setBrandName("4");
		register.setGender("Male");
		register.setRoleId(7);
		register.setViewaccess("booking");
		register.setProductType(0);
		LoginResponse loginResponse = new LoginResponse();
		String res = rest.postForObject(apiUrl+"/user/login?authcode=ABCD26S20", register, String.class);
		System.out.println(res);
		String msg = "";
		try {
			loginResponse = mapper.readValue(res, LoginResponse.class);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		if(loginResponse.getBaseResponse().getStatus() == 1 && loginResponse.getResponse().getRoleId()==6){
			msg = "User Login Succesfully";
			model.addAttribute("msgS", msg);
			request.getSession().setAttribute("userLogin", loginResponse.getResponse());
			return "redirect:/";
		}
		else{
			msg = "User Not Found";
			model.addAttribute("msgE", msg);
			return "login";
		}
		
		
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute LoginForm loginForm,@ModelAttribute RegisterForm registerForm,HttpServletRequest request,Model model){
		RestTemplate rest = new RestTemplate();
		ObjectMapper mapper = new ObjectMapper();
		RegisterRequest register = new RegisterRequest();
		register.setPassword(registerForm.getRegPassword());
		register.setPasswordValue(registerForm.getRegPassword());
		register.setUserEmail(registerForm.getEmail());
		register.setLoginId(registerForm.getEmail());
		register.setUserName(registerForm.getFirstName()+" "+registerForm.getLastName());
		register.setUserType(7);
		register.setUserProfilePhoto("none");
		register.setUserPermanentCountryId(1);
		register.setMobile("1234567890");
		register.setReferuserCode("none");
		register.setLoginStatus("online");
		register.setAccountStatus("Active");
		register.setUserProfileDob("1990-08-09");
		register.setNationality("US");
		register.setDeportmentId(1);
		register.setBrandName("4");
		register.setGender("Male");
		register.setRoleId(7);
		register.setViewaccess("booking");
		register.setProductType(0);
		RegisterResponse registerRes = new RegisterResponse();
		String res = rest.postForObject(apiUrl+"/user/addUser?authcode=ABCD26S20", register, String.class);
		System.out.println(res);
		String msg = "";
		try {
			registerRes = mapper.readValue(res, RegisterResponse.class);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		if(registerRes.getBaseResponse().getStatus() == 1){
			msg = "User Register Succesfully";
			model.addAttribute("msgS", msg);
		}
		else{
			msg = "Some technical issue in register please try later";
			model.addAttribute("msgE", msg);
		}
		
		return "login";
		
	}
	
	@GetMapping("/logout")
	public String logout(@ModelAttribute LoginForm loginForm,@ModelAttribute RegisterForm registerForm,HttpServletRequest request,Model model){
		request.getSession().removeAttribute("userLogin");
		model.addAttribute("msgS", "You Have Logged Out Successfully!");
		return "login";
		
	}

}
