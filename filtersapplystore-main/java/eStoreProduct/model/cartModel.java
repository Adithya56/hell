package eStoreProduct.model;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class cartModel {
	@Id
	private int id;
	private int cid;
	private int pid;

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

}