package com.elpudu.productos.catalogo.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.elpudu.productos.catalogo.controller.validation.ContactValidator;
import com.elpudu.productos.catalogo.domain.Contact;

@Controller
public class SendMailController {
	

	private static Log log = LogFactory.getLog(SendMailController.class);
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	@Autowired @Qualifier(value="toAddress")
	private InternetAddress toAddress;
	
	@Autowired @Qualifier(value="fromAddress")
	private InternetAddress fromAddress;
	
	@Autowired
	private MimeMessage mimeMessage;
	
	
	private ContactValidator contactValidator = new ContactValidator();
	
	@InitBinder
	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws Exception {

		binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
		binder.setRequiredFields(new String[]{"email", "name", "comment"});
	}

	@RequestMapping("/sendMail.html")
	public ModelAndView sendMail(Contact contact, BindingResult result, SessionStatus status) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		contactValidator.validate(contact, result);
		
		if (!result.hasErrors()) {
			
			log.info("Configurando mensaje para envio.");
			StringBuffer message = new StringBuffer("");
			
			message.append("Nombre: ").append(contact.getName()).append("\n");
			message.append("Email: ").append(contact.getEmail()).append("\n");
			
			if (contact.getAddress() != null) {
				message.append("Dirección: ").append(contact.getAddress()).append("\n");
			}
			if (contact.getPhoneNumber() != null) {
				message.append("Teléfono: ").append(contact.getPhoneNumber()).append("\n");
			}
			
			if (contact.getOrderInfo() != null) {
				message.append("Pedido: ").append(contact.getOrderInfo()).append("\n");
			}
			
			message.append("Comentario: ").append(contact.getComment());

			
			try {
				mimeMessage.setHeader("Content-Type", "application/octet-stream");
				mimeMessage.setHeader("Content-Transfer-Encoding", "base64");
				
				mimeMessage.setText(new String(message.toString().getBytes("UTF-8"), "UTF-8"), "UTF-8");

				mimeMessage.setSubject("Información de contacto", "UTF-8");


				mimeMessage.setSentDate(new Date());
				mimeMessage.setRecipient(RecipientType.TO, toAddress);
				mimeMessage.setFrom(fromAddress);


				log.info("Previo a enviar mail.");
				javaMailSender.send(mimeMessage);
				log.info("Envio exitoso.");
				
				status.setComplete();
				
				params.put("messageKey", "your.email.was.successfully.sent");
				params.put("disableForm", "true");
				
			} catch (Exception e) {
				params.put("messageKey", "there.was.a.problem.while.sending.your.email");
				log.error("Error al enviar mail. " + e, e);
			}
		}
		
		params.put("contact", contact);
		
		return new ModelAndView("contactUs", params);
	}
	
	
}
