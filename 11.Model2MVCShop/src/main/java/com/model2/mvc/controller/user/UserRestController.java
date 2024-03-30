package com.model2.mvc.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/app/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="addUser", method=RequestMethod.POST)
	public User addUser(@RequestBody User user) throws Exception {
		
		System.out.println("/app/user/addUser : POST");
		
		System.out.println("user : "+user);
		
		userService.addUser(user);
		
		return user;
		
	}
	
	@RequestMapping( value="getUser/{userId}", method=RequestMethod.GET )
	public User getUserGET( @PathVariable String userId ) throws Exception{
		
		System.out.println("/app/user/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}
	
	@RequestMapping( value="getUser/{userId}", method=RequestMethod.POST )
	public User getUserPOST( @PathVariable String userId ) throws Exception{
		
		System.out.println("/app/user/getUser : GET");
		
		
		User user = userService.getUser(userId);
		
		System.out.println(user);
		
		//Business Logic
		return user;
	}

	@RequestMapping( value="login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
			HttpSession session ) throws Exception{

			System.out.println("/user/json/login : POST");
			//Business Logic
			System.out.println("::"+user);
			User dbUser=userService.getUser(user.getUserId());

			if( user.getPassword().equals(dbUser.getPassword())){
				session.setAttribute("user", dbUser);
			}

			return dbUser;
	}
	
	@RequestMapping(value="checkDuplication/{userId}", method=RequestMethod.POST)
	public Map<String, Object> checkDuplication(@PathVariable String userId) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Boolean result = new Boolean(userService.checkDuplication(userId));
		
		map.put("result", result);
		map.put("userId", userId);
		
		return map;
		
	}
	
	@RequestMapping(value="listUser", method=RequestMethod.GET)
	public Map listUserGet() throws Exception {
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0)
			search.setCurrentPage(1);
		
		search.setPageSize(pageSize);
		
		Map<String , Object> map = userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
		
	}
	
	@RequestMapping(value="listUser", method=RequestMethod.POST)
	public Map listUserPost(@RequestBody Search search) throws Exception {
		
		if(search.getCurrentPage() == 0) {
			
			search.setCurrentPage(1);
			
		}
		
		search.setPageSize(pageSize);
		
		if(search.getSearchKeyword() == null || search.getSearchCondition().equals(""))
		{
			search.setSearchCondition(null);
		}
		
		Map<String, Object> map = userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
		
	}
	
	@RequestMapping("logout")
	public void logout(HttpSession session) {
		
		System.out.println("logoutAction start");
		
		session.removeAttribute("user");
		
		System.out.println("logoutAction end");
		
	}//end of logoutAction
	
	@RequestMapping("updateUserView/{userId}")
	public User updateUserView(@PathVariable("userId") String userId) throws Exception {
		
		System.out.println("updateUserViewAction start");
		
		User user=userService.getUser(userId);
		
		System.out.println("updateUserViewAction end");
		
		return user;
		
	}
	
	@RequestMapping("updateUser")
	public User updateUser(@RequestBody User user, HttpSession session) throws Exception {
		
		System.out.println("updateUserAction start");
		
		userService.updateUser(user);
		
		user = userService.getUser(user.getUserId());
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		System.out.println(user.getUserId()+", "+sessionId);
		
		if(sessionId.equals(user.getUserId())){
			System.out.println("update : setSession");
			session.setAttribute("user", user);
		}
		
		System.out.println("updateUserAction end");
		
		return user;
		
	}
	
}
















