<%@ WebHandler Language="C#" Class="LoginCaptchaHandler" %>

using System.Web;

/// <summary>
/// Called via fetch() when the user clicks the CAPTCHA refresh button.
/// Updates Session["LoginCaptcha"] so the server-side validator stays in
/// sync with whatever code the client just drew on the canvas.
/// </summary>
public class LoginCaptchaHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        string code = (context.Request.QueryString["code"] ?? "").Trim().ToUpper();

        // Basic sanity check — must be 6 alphanumeric chars
        if (code.Length == 6 && System.Text.RegularExpressions.Regex.IsMatch(code, @"^[A-Z0-9]{6}$"))
        {
            context.Session["LoginCaptcha"] = code;
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write("ok");
    }

    public bool IsReusable { get { return false; } }
}
