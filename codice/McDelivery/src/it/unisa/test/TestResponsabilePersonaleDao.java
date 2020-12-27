package it.unisa.test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;

import it.unisa.bean.UtenteBean;
import it.unisa.dao.ResponsabilePersonaleDao;
import it.unisa.dao.UtenteDao;

public class TestResponsabilePersonaleDao {
	ResponsabilePersonaleDao rpd = new ResponsabilePersonaleDao();
	UtenteDao utd = new UtenteDao();
	
	UtenteBean corriereEsistente = new UtenteBean();//utilizzato come corriere esistente nel DB
	UtenteBean corriereNonEsistente = new UtenteBean();//utilizzato come corriere non esistente nel DB
	
	@Before
	public void setUp() {//viene preparato lo scenario per il testing
		
		corriereEsistente.setNome("Pino");
		corriereEsistente.setCognome("Giordano");
		corriereEsistente.setMail("pinogiordy@gmail.org");
		corriereEsistente.setVia("Via Napoli");
		corriereEsistente.setNumero(14);
		corriereEsistente.setCap(84294);
		corriereEsistente.setPwd("8ea2a8cf9b5b488a2b33161bd74afa68dea2ff5fbc55eedabb3fa0c2849a185b");
		corriereEsistente.setTipo(1);
		
		corriereNonEsistente.setNome("Mario");
		corriereNonEsistente.setCognome("Moggi");
		corriereNonEsistente.setMail("mariomaggi@gmail.com");
		corriereNonEsistente.setVia("belli");
		corriereNonEsistente.setNumero(32);
		corriereNonEsistente.setCap(80040);
		corriereNonEsistente.setPwd("2d8c51d6df80e36c21c519b92e1acaa1a6e5a02a283693d3cdeb0684a0436026");
		corriereNonEsistente.setTipo(0);
		
		utd.doSaveUtente(corriereEsistente.getMail(), corriereEsistente.getPwd(), corriereEsistente.getNome(), corriereEsistente.getCognome(), 1, corriereEsistente.getVia(), corriereEsistente.getCap(), corriereEsistente.getNumero());
	}
	
	@Test
	public void testCorrieriRetrieveAll() {
		assertTrue(rpd.corrieriRetrieveAll().contains(corriereEsistente));
		assertFalse(rpd.corrieriRetrieveAll().contains(corriereNonEsistente));
	}
	
	@Test
	public void testControlloCorriere() {
		assertTrue(rpd.controlloCorriere(corriereEsistente.getMail()));
		assertFalse(rpd.controlloCorriere(corriereNonEsistente.getMail()));
	}
	
	@Test
	public void testCorrieredoDelete() {
		assertTrue(rpd.corrieredoDelete(corriereEsistente.getMail()));
		assertFalse(rpd.corrieredoDelete(corriereNonEsistente.getMail()));
		
		assertFalse(rpd.corrieriRetrieveAll().contains(corriereEsistente));
	}
	
}
