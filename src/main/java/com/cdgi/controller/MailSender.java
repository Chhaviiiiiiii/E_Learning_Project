package com.cdgi.controller;

import java.util.Properties;

import org.springframework.stereotype.Component;

import com.cdgi.pojo.UserInfo;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Component
public class MailSender {
		public static void sendMailForRegistration(UserInfo u) {
			
			final String fromEmail="chhavisharma0707@gmail.com";
			final String pass="jyhe mbhx ubon dcyd";
			
			Properties props=new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			
			
			
			Session session=Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromEmail, pass);
				}
			});
			
			try {
				Message message=new MimeMessage(session);
				message.setFrom(new InternetAddress(fromEmail));
				
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(u.getEmail()));
				//message.setRecipients(Message.RecipientType.CC, InternetAddress.parse("chhavisharma0707@gmail.com"));
				//message.setRecipients(Message.RecipientType.BCC, InternetAddress.parse("muskanmandloi7999@gmail.com"));
				
				message.setSubject("Registration on EduKate Done Successfully");
	
				String msg = "<p>Hi <strong>" + u.getUsername() + "</strong>,</p>"
				           + "<p>Your Registration on <strong>EduKate</strong> Done Successfully!</p>"
				           + "<p>Your Login Email: <strong>" + u.getEmail() + "</strong></p>";
				
				message.setContent(msg, "text/html");
				Transport.send(message);
				
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		
		
		
public static void sendMailForPayment(UserInfo u) {
			
			final String fromEmail="chhavisharma0707@gmail.com";
			final String pass="zggp ksih heei yaww";
			
			Properties props=new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			
			
			
			Session session=Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromEmail, pass);
				}
			});
			
			try {
				Message message=new MimeMessage(session);
				message.setFrom(new InternetAddress(fromEmail));
				
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(u.getEmail()));
				//message.setRecipients(Message.RecipientType.CC, InternetAddress.parse("chhavisharma0707@gmail.com"));
				//message.setRecipients(Message.RecipientType.BCC, InternetAddress.parse("muskanmandloi7999@gmail.com"));
				
				
				message.setSubject("Payment on EduKate for Subscribe Quiz");
				String msg = "<p>Hi <strong>" + u.getUsername() + "Your Payment for Subscribe Quiz on EduKate Done Successfully</strong>,</p>";
				
				
				message.setContent(msg, "text/html");
				Transport.send(message);
				
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}


public static void sendMailForQuizResult(UserInfo u, int score, int total, int quizId) {
    final String fromEmail = "chhavisharma0707@gmail.com";
    final String pass = "zggp ksih heei yaww";

    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");

    Session session = Session.getInstance(props, new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(fromEmail, pass);
        }
    });

    try {
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(u.getEmail()));
        message.setSubject("Quiz Result - EduKate 🎯");

        // Current time
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        java.time.format.DateTimeFormatter formatter = 
            java.time.format.DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String time = now.format(formatter);

        String status = ((double) score / total * 100) >= 40 ? "PASS ✅" : "FAIL ❌";

        String msg = "<h2>Quiz Result - EduKate</h2>"
                   + "<p>Hi <strong>" + u.getUsername() + "</strong>,</p>"
                   + "<p>You have successfully completed the quiz!</p>"
                   + "<table border='1' cellpadding='8' style='border-collapse:collapse;'>"
                   + "<tr><td><b>Quiz ID</b></td><td>" + quizId + "</td></tr>"
                   + "<tr><td><b>Your Score</b></td><td>" + score + " / " + total + "</td></tr>"
                   + "<tr><td><b>Status</b></td><td>" + status + "</td></tr>"
                   + "<tr><td><b>Time</b></td><td>" + time + "</td></tr>"
                   + "</table>"
                   + "<br><p>Thank you for playing!</p>"
                   + "<p><em>Team EduKate</em></p>";

        message.setContent(msg, "text/html");
        Transport.send(message);
    } catch (Exception e) {
        e.printStackTrace();
    }
}
	}