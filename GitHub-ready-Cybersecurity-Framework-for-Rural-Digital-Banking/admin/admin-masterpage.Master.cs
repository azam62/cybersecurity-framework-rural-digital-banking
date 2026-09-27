using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking.admin
{
    public partial class admin_masterpage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnPoweroff_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("../Home-Page/index.html");
        }

    }
}