using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ActivityHistoryByUser : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // Populate the ViewUser DDL
            ViewUser.DataSource = Membership.GetAllUsers();
            ViewUser.DataBind();

            // Set the ViewUser DDL to the value passed through the querystring
            if (!string.IsNullOrEmpty(Request.QueryString["UserID"]))
            {
                ListItem li = ViewUser.Items.FindByValue(Request.QueryString["UserID"]);
                if (li != null)
                    li.Selected = true;

                string viewingUserName = ViewUser.SelectedItem.Text;
                base.LogActivity(string.Format("Viewing activity history for {0}...", viewingUserName), true);
                UserToView.Text = viewingUserName;
            }
            else
            {
                RefreshPageWithUpdatedUserIDQueryStringValue();
            }
        }
    }

    protected void ViewUser_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshPageWithUpdatedUserIDQueryStringValue();
    }

    private void RefreshPageWithUpdatedUserIDQueryStringValue()
    {
        Response.Redirect("ActivityHistoryByUser.aspx?UserID=" + Server.UrlEncode(ViewUser.SelectedValue));
    }
}
