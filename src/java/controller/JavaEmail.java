/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import jakarta.mail.Transport;
import jakarta.mail.internet.MimeMessage;
import java.util.Random;

/**
 *
 * @author tungn
 */
public class JavaEmail {

    public static void sendOtpEmail(String toEmail, String otp) {
        final String fromEmail = "khanhnthe181799@fpt.edu.vn";
        final String password = "wfqj xhfa hnqm ureq ";

        Properties pop = new Properties();
        pop.put("mail.smtp.host", "smtp.gmail.com");
        pop.put("mail.smtp.port", "587");
        pop.put("mail.smtp.auth", "true");
        pop.put("mail.smtp.starttls.enable", "true");

        Session session;
        session = Session.getInstance(pop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã OTP xác thực tài khoản");
            message.setText("Mã OTP của bạn là: " + otp + ". Vui lòng không chia sẻ mã này với ai. \nThời hạn OTP trong vòng 2 phút.");

            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("❌ Lỗi khi gửi email!");
        }
    }

    public static String createOTP() {
        final String OTP_Character = "1234567890";
        final int OTP_LENGTH = 6;

        StringBuilder otp = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < OTP_LENGTH; i++) {
            otp.append(OTP_Character.charAt(random.nextInt(OTP_Character.length())));
        }
        return otp.toString();
    }
}
