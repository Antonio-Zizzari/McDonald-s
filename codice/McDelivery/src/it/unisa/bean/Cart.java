package it.unisa.bean;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	List<ProductBean> items;
	
	public Cart() {
		items = new ArrayList<ProductBean>();
	}
	
	public void addItem(ProductBean item) {
		if(items.contains(item)) {
			for(ProductBean it: items) {
				if(it.equals(item)) {
					it.setQuantita(it.getQuantita()+1);
					break;
				}
			}
		}else{
			items.add(item);
		}
	}
	
	public void setItemCart(int i, int quant) {
		items.get(i).setQuantita(quant);
	}
	
	public List<ProductBean> getList(){
		return items;
	}
	
	public int getSize() {
		return items.size();		
	}

	
	public void deleteItem(ProductBean item) {
		items.remove(item);
	}

	public List<ProductBean> getItems() {
		return items;
	}
	
	public void deleteItems() {
		items.clear();
	}
}
