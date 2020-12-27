package it.unisa.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import it.unisa.bean.ProductBean;
import it.unisa.dao.ProdottoDao;
import it.unisa.dao.ProductManagerDao;

public class TestProductManagerDao {
	ProductManagerDao pmd = new ProductManagerDao();
	ProductBean prodottoEsistente = new ProductBean();//utilizzato nei test come prodotto esistente nel DB
	ProductBean prodottoNonEsistente = new ProductBean();//utilizzato nei test come prodotto non esistente nel DB
	ProdottoDao pd = new ProdottoDao();
	
	
	@Before
	public void setUp() {//viene preparato lo scenario per il testing
		
		prodottoEsistente.setId(2);
		prodottoEsistente.setNome("Coca Cola");
		prodottoEsistente.setPhoto("img/prodotti/bevande/cocacola.png");
		prodottoEsistente.setPrezzo(3);
		prodottoEsistente.setTipo(1);
		prodottoEsistente.setSconto(0);
		
		prodottoNonEsistente.setId(42);
		prodottoNonEsistente.setNome("Piedina");
		prodottoNonEsistente.setPhoto("img/prodotti/bevande/cocacola.png");
		prodottoNonEsistente.setPrezzo(5);
		prodottoNonEsistente.setTipo(2);
		prodottoNonEsistente.setSconto(0);
		
		pmd.doSave1(prodottoEsistente);
		pmd.doDelete(prodottoNonEsistente.getId());
		pmd.scontidoUpdate(prodottoEsistente.getId(), 0);
		pmd.doUpdate(prodottoEsistente.getId(), "Coca Cola", 3, prodottoEsistente.getPhoto());
	}
	
	@Test
	public void testControlloProdotto() {
		assertTrue(pmd.controlloProdotto(prodottoEsistente.getId()));
		assertFalse(pmd.controlloProdotto(prodottoNonEsistente.getId()));
	}
	
	@Test
	public void testScontiDoUpdate() {
		assertTrue(pmd.scontidoUpdate(prodottoEsistente.getId(), 15));
		assertEquals(15, pd.doRetrieveByKey(String.valueOf(prodottoEsistente.getId())).getSconto());
		
		assertFalse(pmd.scontidoUpdate(prodottoNonEsistente.getId(), 15));
		assertFalse(pmd.scontidoUpdate(prodottoEsistente.getId(), 600));
	}
	
	@Test
	public void testDoSave() {
		assertFalse(pmd.doSave(prodottoEsistente));
		assertTrue(pmd.doSave(prodottoNonEsistente));
	}
	
	@Test
	public void testDoUpdate() {
		assertTrue(pmd.doUpdate(prodottoEsistente.getId(), "Sprite", 6, prodottoEsistente.getPhoto()));
		assertFalse(pmd.doUpdate(prodottoNonEsistente.getId(), "Pepsi", 6, prodottoEsistente.getPhoto()));
		assertFalse(pmd.doUpdate(prodottoEsistente.getId(), "McBurger", 0, prodottoEsistente.getPhoto()));
	}
	
	@Test
	public void testDoDelete() {
		assertTrue(pmd.doDelete(prodottoEsistente.getId()));
		assertFalse(pmd.doDelete(prodottoNonEsistente.getId()));
	}
	
	@After
	public void tearDown() {
		pmd.doSave1(prodottoEsistente);
		pmd.doDelete(prodottoNonEsistente.getId());
		pmd.scontidoUpdate(prodottoEsistente.getId(), 0);
		pmd.doUpdate(prodottoEsistente.getId(), "Coca Cola", 3, prodottoEsistente.getPhoto());
	}
	
}
