using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

using System.Net;
using System.Net.Mail;

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
            string cs = ConfigurationManager.ConnectionStrings["LIS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT TOP 1 " + col + " FROM " + tbl + " ORDER BY " + col + " DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    object obj = cmd.ExecuteScalar();

                    if (obj == null)
                        return "1";
                    else
                        return (Convert.ToInt32(obj) + 1).ToString();
                }
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