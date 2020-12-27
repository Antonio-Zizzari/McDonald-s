package it.unisa.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import it.unisa.bean.McDriveBean;
import it.unisa.bean.OrdineBean;
import it.unisa.bean.ProductBean;
import it.unisa.bean.UtenteBean;
import it.unisa.dao.*;

public class TestCorriereDao {
	
	CorriereDAO corrDao = new CorriereDAO();
	
	UtenteBean utenteEsistente = new UtenteBean();//utilizzato nei test come utente esistente nel DB
	UtenteBean utenteNonEsistente = new UtenteBean();//utilizzato nei test come utente non esistente nel DB
	
	OrdineBean ordineEsistente = new OrdineBean();//utilizzato nei test come Ordine esistente nel DB
	OrdineBean ordineNonEsistente = new OrdineBean();//utilizzato nei test come Ordine non esistente nel DB
	
	McDriveBean mcDriveEsistente = new McDriveBean();//utilizzato nei test come McDrive esistente nel DB
	McDriveBean mcDriveNonEsistente = new McDriveBean();//utilizzato nei test come McDrive non esistente nel DB

	@Before
	public void setUp() {//viene preparato lo scenario per il testing
		
		ordineEsistente.setNome("Alberto");
		ordineEsistente.setCognome("Battaglia");
		ordineEsistente.setMail("albertobattaglia@gmail.com");
		ordineEsistente.setNumero(1);
		ordineEsistente.setTotale(23);
		ordineEsistente.setData("2020-01-18");;
		ordineEsistente.setPresoInCarico(0);
		
		ordineNonEsistente.setNome("Francesco");
		ordineNonEsistente.setCognome("Gatti");
		ordineNonEsistente.setMail("TEST2@gmail.com");
		ordineNonEsistente.setNumero(3);
		ordineNonEsistente.setTotale(5);
		ordineNonEsistente.setData("2020-8-4");;
		ordineNonEsistente.setPresoInCarico(0);
		
		utenteEsistente.setNome("Alberto");
		utenteEsistente.setCognome("Battaglia");
		utenteEsistente.setMail("albertobattaglia@gmail.com");
		utenteEsistente.setVia("Via Roma");
		utenteEsistente.setNumero(11);
		utenteEsistente.setCap(88054);
		utenteEsistente.setPwd("8ea2a8cf9b5b488a2b33161bd74afa68dea2ff5fbc55eedabb3fa0c2849a185b");
		utenteEsistente.setTipo(0);
		
		utenteNonEsistente.setNome("Mario");
		utenteNonEsistente.setCognome("Moggi");
		utenteNonEsistente.setMail("mariomaggi@gmail.com");
		utenteNonEsistente.setVia("belli");
		utenteNonEsistente.setNumero(32);
		utenteNonEsistente.setCap(80040);
		utenteNonEsistente.setPwd("2d8c51d6df80e36c21c519b92e1acaa1a6e5a02a283693d3cdeb0684a0436026");
		utenteNonEsistente.setTipo(0);
		
	
		mcDriveEsistente.setNome("McDrive Torre Annunziata");
		mcDriveEsistente.setCap(84294);
		mcDriveEsistente.setNumero(14);
		mcDriveEsistente.setVia("Via Napoli");
		
		mcDriveNonEsistente.setNome("Cremona");
		mcDriveNonEsistente.setCap(77742);
		mcDriveNonEsistente.setNumero(16);
		mcDriveNonEsistente.setVia("via Natali");
		
		corrDao.resetOrdine(ordineEsistente);
	}
	
	@Test
	public void testControlloMc() {
		assertTrue(corrDao.controlloMc(mcDriveEsistente.getNome()));
		assertFalse(corrDao.controlloMc(mcDriveNonEsistente.getNome()));
	}
	
	@Test
	public void testControlloOrdine() {
		assertTrue(corrDao.controlloOrdine(ordineEsistente.getData(), ordineEsistente.getNumero()));
		assertFalse(corrDao.controlloOrdine(ordineNonEsistente.getData(), ordineNonEsistente.getNumero()));
	}
	
	@Test
	public void testOrdineRetrieve() {
		assertNotNull(corrDao.ordineRetrieve(mcDriveEsistente.getNome()));
		assertNull(corrDao.ordineRetrieve(mcDriveNonEsistente.getNome()));
		
		assertTrue(corrDao.ordineRetrieve(mcDriveEsistente.getNome()).contains(ordineEsistente));
		assertFalse(corrDao.ordineRetrieve(mcDriveEsistente.getNome()).contains(ordineNonEsistente));
	}
	
	@Test
	public void testDoUpdateOrdine() {
		assertTrue(corrDao.doUpdateOrdine(ordineEsistente));
		assertFalse(corrDao.doUpdateOrdine(ordineNonEsistente));
		
		assertFalse(corrDao.doUpdateOrdine(ordineEsistente));//false perche è gia stato preso in carico
		assertEquals(1,ordineEsistente.getPresoInCarico());
	}
	
	@Test
	public void testMcRetrieveAll() {
		assertTrue(corrDao.mcRetrieveAll().contains(mcDriveEsistente));
		assertFalse(corrDao.mcRetrieveAll().contains(mcDriveNonEsistente));
	}
	
}
