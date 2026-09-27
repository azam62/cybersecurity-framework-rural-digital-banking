using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cybersecurity_Framework_for_Rural_Digital_Banking.admin
{
    public partial class search_by_account : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            sdsSearchByAccount.DataBind();
        }

    }
}