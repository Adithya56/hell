package eStoreProduct.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import eStoreProduct.DAO.cartDAO;
import eStoreProduct.DAO.customerDAO;
import eStoreProduct.model.custCredModel;

@Controller
public class homeController {
	static boolean flag = false;
	customerDAO cdao;
	

	@Autowired
	public homeController(customerDAO customerdao) {
		cdao = customerdao;
		
	}
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String getHome(Model model) {
		//System.out.println("Home Page");
		model.addAttribute("fl", flag);

		// call the view
		return "home";
	}
	

	@RequestMapping(value = "/loggedIn", method = RequestMethod.GET)
	public String getHomeLogged(Model model) {
		//System.out.println("Home Page");

		flag = true;
		model.addAttribute("fl", flag);
		// call the view
		return "home";
	}

	@RequestMapping(value = "/signUp", method = RequestMethod.GET)
	public String getSignUpPage(Model model) {
		//System.out.println("Sign Up Page");

		// call the view
		return "signUp";
	}

	@RequestMapping(value = "/signIn", method = RequestMethod.GET)
	public String getSignInPage(Model model) {
		//System.out.println("Sign In Page");

		// call the view
		return "signIn";
	}

	
	/*
	 * @RequestMapping(value = "/signOk", method = RequestMethod.GET) public String
	 * getHomeFinal(Model model,HttpSession session) {
	 * 
	 * //System.out.println("checking sign in"); //System.out.println(email + " " +
	 * //psd); /// custCredModel cust = cdao.getCustomer(email, psd);
	 * //System.out.println("object received when logged in " + cust); try {
	 * cdao.updatelastlogin(cust.getCustId());
	 * session.setAttribute("customer",cust); session.setAttribute("fl", true); }
	 * catch (Exception e) { System.out.println(e); } //else {
	 * session.setAttribute("fl", false); }
	 * 
	 * return "redirect:/"; // Redirect to the home page ("/") }
	 */
	
	@RequestMapping(value = "/signOk", method = RequestMethod.GET)
	public String getHomeFinal(@RequestParam("em") String email, @RequestParam("ps") String psd, Model model,
			HttpSession session) {
		System.out.println("checking sign in");
		System.out.println(email + " " + psd);
		custCredModel cust = cdao.getCustomer(email, psd);
		System.out.println("object recieved when looged in " + cust);
		// custCredModel b = cdao.checkCustomer(email, psd);
		System.out.println("checking sign in 1");
		try {
			System.out.println(cust.getCustId());
			cdao.updatelastlogin(cust.getCustId());
			// model.addAttribute();
			session.setAttribute("customer", cust);
			// session.setAttribute("cid", );
		} catch (Exception e) {
			System.out.println(e);
		}
		System.out.println("checking sign in 2");
		if (cust != null) {
			session.setAttribute("customer", cust); // Store customer object in the session
			flag = true;
		}
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		model.addAttribute("cust1", cust1);
		model.addAttribute("fl", flag);
		return "home";
	}


	
	@RequestMapping(value = "/signInCreateAccount", method = RequestMethod.POST)
	public String createAccount(@Validated custCredModel ccm, Model model) {
		//System.out.println("sign Up page creating account");
		boolean b = cdao.createCustomer(ccm);

		// set it to the model
		if (b) {
			model.addAttribute("customer", ccm);
		}
		// call the view
		return "createdMsg";
	}

	@RequestMapping(value = "/logout")
	public String userlogout(Model model, HttpSession session) {
		custCredModel cust = (custCredModel) session.getAttribute("customer");
		model.addAttribute("cust", cust);
		flag = false;
		model.addAttribute("fl", flag);

		return "home";
	}

	
}