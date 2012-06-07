using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UsersOnly_Default : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            base.LogActivity("Visiting the UsersOnly homepage...", false);
        }
    }

    protected void ViewHistoryButton_Click(object sender, EventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid UserId = (Guid) currentUser.ProviderUserKey;

        Response.Redirect("~/ActivityHistoryByUser.aspx?UserID=" + UserId.ToString());
    }
}
