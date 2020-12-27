package it.unisa.test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import it.unisa.bean.McDriveBean;
import it.unisa.bean.ProductBean;
import it.unisa.bean.UtenteBean;
import it.unisa.dao.ProdottoDao;
import it.unisa.dao.ProductManagerDao;


public class TestProdottoDao {
	ProductManagerDao pmd = new ProductManagerDao();
	
	ProductBean prodottoEsistente = new ProductBean();//utilizzato nei test come prodotto esistente nel DB
	ProductBean prodottoNonEsistente = new ProductBean();//utilizzato nei test come prodotto non esistente nel DB
	ProductBean prodottoInOfferta = new ProductBean();//utilizzato nei test come prodotto in offerta esistente nel DB
	ProdottoDao pd = new ProdottoDao();
	
	UtenteBean utenteEsistente = new UtenteBean();//utilizzato nei test come utente esistente nel DB
	UtenteBean utenteNonEsistente = new UtenteBean();//utilizzato nei test come utente non esistente nel DB
	
	McDriveBean mcDriveEsistente = new McDriveBean();//utilizzato nei test come McDrive esistente nel DB
	McDriveBean mcDriveNonEsistente = new McDriveBean();//utilizzato nei test come McDrive non esistente nel DB

	ArrayList<ProductBean> carrelloNonVuoto = new ArrayList<ProductBean>();
	ArrayList<ProductBean> carrelloVuoto = new ArrayList<ProductBean>();
	
	@Before
	public void setUp() {//viene preparato lo scenario per il testing
		
		prodottoEsistente.setId(2);
		prodottoEsistente.setNome("Coca Cola");
		prodottoEsistente.setPhoto("img/prodotti/bevande/cocacola.png");
		prodottoEsistente.setPrezzo(3);
		prodottoEsistente.setTipo(1);
		prodottoEsistente.setSconto(0);
		prodottoEsistente.setQuantita(2);
		
		prodottoNonEsistente.setId(500);
		prodottoNonEsistente.setNome("Piedina");
		prodottoNonEsistente.setPhoto("img/prodotti/bevande/cocacola.png");
		prodottoNonEsistente.setPrezzo(5);
		prodottoNonEsistente.setTipo(2);
		prodottoNonEsistente.setSconto(0);
		
		//prodotto esistente e in offerta 
		prodottoInOfferta.setId(1);
		prodottoInOfferta.setNome("Acqua");
		prodottoInOfferta.setPhoto("img/prodotti/bevande/acqua.png");
		prodottoInOfferta.setPrezzo(1);
		prodottoInOfferta.setTipo(1);
		prodottoInOfferta.setSconto(50);
		
		utenteEsistente.setNome("Alberto");
		utenteEsistente.setCognome("Battaglia");
		utenteEsistente.setMail("albertobattaglia@gmail.com");
		utenteEsistente.setVia("Via Roma");
		utenteEsistente.setNumero(11);
		utenteEsistente.setCap(88054);
		utenteEsistente.setPwd("3e15a6ba6776c9154dec00efd67d6ba5cf14714dfd7aa660821e6f8b816fcd33");
		utenteEsistente.setTipo(0);
		
		utenteNonEsistente.setNome("Mario");
		utenteNonEsistente.setCognome("Moggi");
		utenteNonEsistente.setMail("mariomaggi@gmail.com");
		utenteNonEsistente.setVia("belli");
		utenteNonEsistente.setNumero(32);
		utenteNonEsistente.setCap(80040);
		utenteEsistente.setPwd("2d8c51d6df80e36c21c519b92e1acaa1a6e5a02a283693d3cdeb0684a0436026");
		utenteEsistente.setTipo(0);
		
		mcDriveEsistente.setNome("McDrive Torre Annunziata");
		mcDriveEsistente.setCap(84294);
		mcDriveEsistente.setNumero(14);
		mcDriveEsistente.setVia("Via Napoli");
		
		mcDriveNonEsistente.setNome("Cremona");
		mcDriveNonEsistente.setCap(77742);
		mcDriveNonEsistente.setNumero(16);
		mcDriveNonEsistente.setVia("via Natali");
		
		carrelloNonVuoto.add(prodottoEsistente);
		
		
		pmd.scontidoUpdate(prodottoInOfferta.getId(), 50);
	}
	
	@Test
	public void testControlloProdotto() {
		assertTrue(pd.controlloProdotto(prodottoEsistente.getId()));
		assertFalse(pd.controlloProdotto(prodottoNonEsistente.getId()));
	}
	
	@Test
	public void testDoRetrieveByKey() {
		assertNotNull(pd.doRetrieveByKey(String.valueOf(prodottoEsistente.getId())));
		assertNull(pd.doRetrieveByKey(String.valueOf(prodottoNonEsistente.getId())));
	}
	
	@Test
	public void testDoRetrieveAllOfferta() {
		assertTrue(pd.doRetrieveAllOfferta().contains(prodottoInOfferta));
		assertFalse(pd.doRetrieveAllOfferta().contains(prodottoEsistente));
		assertFalse(pd.doRetrieveAllOfferta().contains(prodottoNonEsistente));
	}
	
	@Test
	public void testAddOrdine() {
		assertTrue(pd.addOrdine(utenteEsistente.getMail(), carrelloNonVuoto, mcDriveEsistente.getNome(), 5));
		
		assertFalse(pd.addOrdine(utenteEsistente.getMail(), carrelloVuoto, mcDriveEsistente.getNome(), 5));
		assertFalse(pd.addOrdine(utenteNonEsistente.getMail(), carrelloNonVuoto, mcDriveEsistente.getNome(), 5));
		assertFalse(pd.addOrdine(utenteEsistente.getMail(), carrelloNonVuoto, mcDriveNonEsistente.getNome(), 5));
		assertFalse(pd.addOrdine(utenteEsistente.getMail(), carrelloNonVuoto, mcDriveEsistente.getNome(), 0));
	}
	
	
	@Test
	public void testDoRetrieveAll() {
		assertTrue(pd.doRetrieveAll(null).contains(prodottoEsistente));
		assertTrue(pd.doRetrieveAll(String.valueOf(prodottoEsistente.getTipo())).contains(prodottoEsistente));
		assertFalse(pd.doRetrieveAll(null).contains(prodottoNonEsistente));
		assertFalse(pd.doRetrieveAll(String.valueOf(prodottoNonEsistente.getTipo())).contains(prodottoNonEsistente));
	}
	
	@After
	public void tearDown() {
		pmd.scontidoUpdate(prodottoInOfferta.getId(), 0);
	}
	
}
