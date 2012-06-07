using System;
using System.IO;
using System.Configuration;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;

public class BasePage : System.Web.UI.Page
{
    protected void LogActivity(string activity, bool recordPageUrl)
    {
        if (Request.IsAuthenticated)
        {
            // Get information about the currently logged on user
            MembershipUser currentUser = Membership.GetUser(false);
            if (currentUser != null)
            {
                Guid userId = (Guid)currentUser.ProviderUserKey;

                // Log the activity in the database
                using (SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["MembershipConnectionString"].ConnectionString))
                {
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.CommandText = "usp_LogUserActivity";
                    myCommand.CommandType = CommandType.StoredProcedure;
                    myCommand.Connection = myConnection;

                    myCommand.Parameters.AddWithValue("@UserId", userId);
                    myCommand.Parameters.AddWithValue("@Activity", activity);
                    if (recordPageUrl)
                        myCommand.Parameters.AddWithValue("@PageUrl", Request.RawUrl);
                    else
                        myCommand.Parameters.AddWithValue("@PageUrl", DBNull.Value);

                    myConnection.Open();
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
        }
    }


    protected string FormatActivity(string activity, string pageUrl)
    {
        if (string.IsNullOrEmpty(pageUrl))
            return activity;
        else
            return string.Format(@"<a href=""{0}"">{1}</a>", pageUrl, activity);
    }


    protected string FormatLastUpdatedDate(DateTime lastUpdateDate, DateTime currentDate)
    {
        TimeSpan delta = currentDate.Subtract(lastUpdateDate);
        if (delta.Days > 7)
            return lastUpdateDate.ToShortDateString();
        else if (delta.Days > 1)
            return string.Format("{0} days ago", delta.Days);
        else if (delta.Days == 1)
            return string.Format("Yesterday", delta.Days);
        else if (delta.Hours > 1)
            return string.Format("{0} hours ago", delta.Hours);
        else if (delta.Hours == 1)
            return string.Format("1 hour ago", delta.Hours);
        else if (delta.Minutes > 1)
            return string.Format("{0} minutes ago", delta.Minutes);
        else if (delta.Minutes == 1)
            return string.Format("1 minute ago", delta.Minutes);
        else
            return "A few seconds ago";            
    }

    protected override void OnLoad(EventArgs e)
    {
        if (string.IsNullOrEmpty(Page.Title) || string.Compare(Page.Title, "Untitled Page", true) == 0)
        {
            SiteMapNode current = SiteMap.CurrentNode;
            if (current != null)
                Page.Title = current.Title;
            else
                Page.Title = Path.GetFileNameWithoutExtension(Request.PhysicalPath);
        }

        base.OnLoad(e);
    }
}
