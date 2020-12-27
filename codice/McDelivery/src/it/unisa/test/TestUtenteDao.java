package it.unisa.test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import org.apache.catalina.mbeans.MBeanUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import it.unisa.bean.UtenteBean;
import it.unisa.dao.UtenteDao;

public class TestUtenteDao {
	UtenteDao utd = new UtenteDao();
	
	UtenteBean utenteEsistente = new UtenteBean();//utilizzato nei test come utente esistente nel DB
	UtenteBean utenteNonEsistente = new UtenteBean();//utilizzato nei test come utente non esistente nel DB
	
	@Before
	public void setUp() {//viene preparato lo scenario per il testing
		
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
		utenteNonEsistente.setPwd("2d8c51d6df80e36c21c519b92e1acaa1a6e5a02a283693d3cdeb0684a0436026");
		utenteNonEsistente.setTipo(0);	
		
		utd.deleteUtente(utenteNonEsistente.getMail());
		utd.utentedoUpdate(utenteEsistente);
		utd.pwddoUpdate(utenteEsistente.getMail(), utenteEsistente.getPwd());
	}

	@Test
	public void testDoRetrieveByMailPwd() {
		assertNull(utd.doRetrieveByMailPwd(utenteNonEsistente.getMail()));
		
		assertNotNull(utd.doRetrieveByMailPwd(utenteEsistente.getMail()));
	}
	
	@Test
	public void testDoSaveUtente() {
		assertFalse(utd.doSaveUtente(utenteEsistente.getMail(), utenteEsistente.getPwd(), utenteEsistente.getNome(), utenteEsistente.getCognome(), utenteEsistente.getTipo(), utenteEsistente.getVia(), utenteEsistente.getCap(), utenteEsistente.getNumero()));
		
		assertTrue(utd.doSaveUtente(utenteNonEsistente.getMail(), utenteNonEsistente.getPwd(), utenteNonEsistente.getNome(), utenteNonEsistente.getCognome(), utenteNonEsistente.getTipo(), utenteNonEsistente.getVia(), utenteNonEsistente.getCap(), utenteNonEsistente.getNumero()));
	}
	
	@Test
	public void testUtentedoUpdate() {
		utenteEsistente.setNome("Ciro");
		utenteNonEsistente.setNome("Antonio");
		
		assertTrue(utd.utentedoUpdate(utenteEsistente) && utd.doRetrieveByMailPwd(utenteEsistente.getMail()).getNome().equals("Ciro"));
		
		assertFalse(utd.utentedoUpdate(utenteNonEsistente));
	}
	
	@Test
	public void testPwddoUpdate() {
		utenteEsistente.setPwd("9ed1515819dec61fd361d5fdabb57f41ecce1a5fe1fe263b98c0d6943b9b232e");
		utenteNonEsistente.setPwd("9ed1515819dec61fd361d5fdabb57f41ecce1a5fe1fe263b98c0d6943b9b232e");
		
		assertTrue(utd.pwddoUpdate(utenteEsistente.getMail(), utenteEsistente.getPwd()));

		assertFalse(utd.pwddoUpdate(utenteNonEsistente.getMail(), utenteNonEsistente.getPwd()));
	}
	
	@Test
	public void testMaildoRetrieveByKey() {
		assertFalse(utd.maildoRetrieveByKey(utenteNonEsistente.getMail()));
		
		assertTrue(utd.maildoRetrieveByKey(utenteEsistente.getMail()));
	}
	
	
}
