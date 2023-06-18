package eStoreProduct.BLL;

import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;

import eStoreProduct.DAO.ProdStockDAO;
import eStoreProduct.model.Product;
public class BLLClass {
	ProdStockDAO productstock;
	public BLLClass()
	{
		
	}
	@Autowired
	public BLLClass(ProdStockDAO ps)
	{
	   productstock=ps;
	}

	int prdqty;
	HashMap<Integer, Integer> hmfixprice = new HashMap<Integer, Integer>();

	HashMap<Integer, Integer> hm = new HashMap<Integer, Integer>();
	HashMap<Integer, Integer> hmprice = new HashMap<Integer, Integer>();

	public int calcartp(List<Product> p) {
		int cartpcost = 0;

		for (Product pr : p) {
			if (hmprice.containsKey(pr.getProd_id())) {
				hmprice.put(pr.getProd_id(), (int) productstock.getProdPriceById(pr.getProd_id()));
				hmfixprice.put(pr.getProd_id(), (int) productstock.getProdPriceById(pr.getProd_id()));
				hm.put(pr.getProd_id(), 1);

				cartpcost += productstock.getProdPriceById(pr.getProd_id());
			} else {
				hmprice.put(pr.getProd_id(), (int) productstock.getProdPriceById(pr.getProd_id()));
				hmfixprice.put(pr.getProd_id(), (int) productstock.getProdPriceById(pr.getProd_id()));
				hm.put(pr.getProd_id(), 1);

				cartpcost += productstock.getProdPriceById(pr.getProd_id());

			}
		}
		return cartpcost;

	}

	public void updateQty(int pid, int qty) {
		if (hm.containsKey(pid)) {

			if (hmprice.containsKey(pid)) {
				int p = hmfixprice.get(pid);
				System.out.println("before:" + p);
				p = p * qty;
				System.out.println("After:" + p);

				hmprice.put(pid, p);
			}

			hm.put(pid, qty);
		} else {
			if (hmprice.containsKey(pid)) {
				int p = hmfixprice.get(pid);
				System.out.println("before:==" + qty);

				p = p * qty;
				System.out.println("After:" + p);

				hmprice.put(pid, p);
			}
			hm.put(pid, qty);
		}

	}

	public int getupdateprice() {
		int upprice = 0;
		for (Entry<Integer, Integer> e : hmprice.entrySet()) {
			upprice += e.getValue();
		}
		return upprice;
	}

	public void remove(int p) {
		hm.remove(p);
		hmprice.remove(p);
	}

	public HashMap<Integer, Integer> getItemsqty() {
 		return hm;
	}

	public HashMap<Integer, Integer> gethmprice() {
		return hmprice;
	}
}
