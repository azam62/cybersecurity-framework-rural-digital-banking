using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

using System.Net;
using System.Net.Mail;


/// <summary>
/// Summary description for Class1
/// </summary>
/// 
namespace Cybersecurity_Framework_for_Rural_Digital_Banking
{
    public class BasicCode
    {
        private object mail;

        public BasicCode()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public string generateID(string col, string tbl)
        {
            SqlConnection con = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            con = new SqlConnection(ConfigurationManager.AppSettings["LIS"]);

            cmd = new SqlCommand();
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "select " + col + " from  " + tbl + " order by " + col + " desc";
            cmd.Connection = con;
            object obj = cmd.ExecuteScalar();
            con.Close();
            if (obj == null)
            {
                return "1";
            }
            else
            {
                int n = Convert.ToInt32(obj);
                n = n + 1;
                return n.ToString();
            }
        }
        public string SendOTPEmail(string toEmail, string subject, string msg, bool isHtml = true)
        {
            try
            {
                var fromEmail = ConfigurationManager.AppSettings["SmtpUser"];
                var fromPassword = ConfigurationManager.AppSettings["SmtpPass"];
                var smtpHost = ConfigurationManager.AppSettings["SmtpHost"] ?? "smtp.gmail.com";
                var smtpPort = int.Parse(ConfigurationManager.AppSettings["SmtpPort"] ?? "587");

                using (var message = new MailMessage(fromEmail, toEmail))
                {
                    message.Subject = subject;
                    message.Body = msg; // Sending OTP to the user's email
                    message.IsBodyHtml = isHtml;  // ✅ Ensures HTML formatting
                    message.Priority = MailPriority.High;
                    using (var smtpClient = new SmtpClient(smtpHost, smtpPort))
                    {
                        smtpClient.Credentials = new NetworkCredential(fromEmail, fromPassword);
                        smtpClient.EnableSsl = true;
                        smtpClient.Send(message);

                    }
                }
                return "Success";
            }
            catch (Exception ex)
            {

                return "Fail " + ex.Message;
            }

        }

   
    
    }

}