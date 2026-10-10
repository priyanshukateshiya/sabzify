using System;
using System.Web.UI;

namespace sabzify.Admin
{
    public partial class Logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.AdminLogout(Session, Response);
            Response.Redirect("~/Admin/Login.aspx", true);
        }
    }
}
