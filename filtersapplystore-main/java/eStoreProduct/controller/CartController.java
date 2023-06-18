package eStoreProduct.controller;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import eStoreProduct.model.Product;
import eStoreProduct.model.custCredModel;
import eStoreProduct.utility.ProductStockPrice;
import eStoreProduct.DAO.ProductDAO;
import eStoreProduct.DAO.cartDAO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
//import eStoreProduct.BLL.BLLClass;
import javax.servlet.http.HttpSession;

@Controller
public class CartController {
	cartDAO cartimp;
	private final ProductDAO pdaoimp;
	List<ProductStockPrice> alist=new ArrayList<>();
	//BLLClass obj = new BLLClass();
	@Autowired
	public CartController(cartDAO cartdao,ProductDAO productdao)
	{
	    cartimp=cartdao;
	    pdaoimp=productdao;
	}

	
	@GetMapping("/addToCart")
	@ResponseBody
	public String addToCart(@RequestParam(value = "productId", required = true) int productId, Model model,HttpSession session)
			throws NumberFormatException, SQLException {
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if(cust1!=null)
		{        
		//System.out.println("add to cart called1");
		//ProductDAO pdao = new ProductDAO();
		//System.out.println("add to cart called2");
		return cartimp.addToCart(productId, cust1.getCustId()) + " Added to cart";}
		else {
			ProductStockPrice product=pdaoimp.getProductById(productId);
		//System.out.println("added to cart "+product.getProd_id());
		//System.out.println(product);
			alist.add(product);
			return "added to cart";

	}}
	
	@RequestMapping(value = "/cartDisplay", method = RequestMethod.GET)
	public String getSignUpPage(Model model) {
		//System.out.println("product description Page");

		// call the view
		return "cartItems";
	}

	@GetMapping("/removeFromCart")
	@ResponseBody
	public String removeFromCart(@RequestParam(value = "productId", required = true) int productId, Model model,HttpSession session)
			throws NumberFormatException, SQLException {
		//System.out.println("pid remove from cart  "+productId);		
		
		custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if(cust1!=null)
		{        System.out.println("remove from cart login");
			return cartimp.removeFromCart(productId, 1) + " remove from cart";}
		else {
			//Product product=pdaoimp.getProductById(productId);
			//System.out.println("remove from cart nonlogin");
			for(ProductStockPrice p:alist)
			{
			if(p.getProd_id()==productId)
			
			alist.remove(p);
			}
			
			return "remove from cart";
		}

	}
	

    @GetMapping("/cartItems")
    public String userCartItems(Model model,HttpSession session)
            throws NumberFormatException, SQLException {
        //System.out.println("carts called1");
        double cartt = 0;
        //ProductDAO pdao = new ProductDAO();
        custCredModel cust1 = (custCredModel) session.getAttribute("customer");
		if(cust1!=null)
		{        
			List<ProductStockPrice> products = cartimp.getCartProds(cust1.getCustId());
			//cartt = obj.calcartp(products);
			//System.out.println("cartt value "+cartt);
		//	model.addAttribute("cartt", cartt);
	        // Set the products attribute in the model
	        model.addAttribute("products", products);
	        
	        // Forward to the cart.jsp view
	        return "cart";
		}
		else
		{
			 // Set the products attribute in the model
	        model.addAttribute("products", alist);
	        for(ProductStockPrice p:alist)
			{
				//System.out.println(p);
			}
	        // Forward to the cart.jsp view
	        return "cart";	
	        
		}
    }
	 
}
 