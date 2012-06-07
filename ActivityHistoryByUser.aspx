<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ActivityHistoryByUser.aspx.cs" Inherits="ActivityHistoryByUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Activity History for
        <asp:Label ID="UserToView" runat="server"></asp:Label>
    </h2>
    <p>
        The following grid lists the user&#39;s activity log.</p>
    <p>
        View activity history for: 
        <asp:DropDownList ID="ViewUser" runat="server" AutoPostBack="True" 
            DataTextField="UserName" DataValueField="ProviderUserKey" 
            onselectedindexchanged="ViewUser_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <p>
        <asp:GridView ID="gvActivityLog" runat="server" 
            DataSourceID="ActivityLogDataSource" AutoGenerateColumns="False">
            <Columns>
                <asp:TemplateField HeaderText="Activity">
                    <ItemTemplate>
                        <%# FormatActivity(Eval("Activity").ToString(), Eval("PageUrl").ToString()) %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Updated">
                    <ItemTemplate>
                        <%# FormatLastUpdatedDate(Convert.ToDateTime(Eval("ActivityDate")), Convert.ToDateTime(Eval("CurrentDate")))%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="ActivityLogDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:MembershipConnectionString %>" 
            SelectCommand="usp_GetUserActivityLog" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ViewUser" Name="UserID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

