package com.elpudu.productos.catalogo.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.mail.SimpleMailMessage;
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
	
	@Autowired
	private SimpleMailMessage simpleMailMessage;
	
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
			
			StringBuffer message = new StringBuffer();
			
			message.append("Nombre: ").append(contact.getName()).append("\n");
			message.append("Email: ").append(contact.getEmail()).append("\n");
			
			if (contact.getAddress() != null) {
				message.append("Dirección: ").append(contact.getAddress()).append("\n");
			}
			if (contact.getPhoneNumber() != null) {
				message.append("Teléfono: ").append(contact.getPhoneNumber()).append("\n");
			}
			
			message.append("Comentario: ").append(contact.getComment());

			
			try {
				simpleMailMessage.setSentDate(new Date());
				simpleMailMessage.setText(message.toString());
				javaMailSender.send(simpleMailMessage);
				status.setComplete();
				
				params.put("messageKey", "your.email.was.successfully.sent");
				params.put("disableForm", "true");
				
			} catch (Exception e) {
				params.put("messageKey", "there.was.a.problem.while.sending.your.email");
			}
		}
		
		params.put("contact", contact);
		
		return new ModelAndView("contactUs", params);
	}
	
	
}