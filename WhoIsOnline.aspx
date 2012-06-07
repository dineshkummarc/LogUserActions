<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="WhoIsOnline.aspx.cs" Inherits="WhoIsOnline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Who Is Online?</h2>
    <p>
        <asp:GridView ID="gvWhoIsOnline" runat="server" AutoGenerateColumns="False" 
            DataSourceID="WhoIsOnlineDataSource" EmptyDataText="There are currently no authenticated users visiting the site...">
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="UserID" 
                    DataNavigateUrlFormatString="~/ActivityHistoryByUser.aspx?UserID={0}" 
                    DataTextField="UserName" HeaderText="User" />
                <asp:TemplateField HeaderText="Activity" SortExpression="Activity">
                    <ItemTemplate>
                        <%# FormatActivity(Eval("Activity").ToString(), Eval("PageUrl").ToString()) %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Updated" SortExpression="ActivityDate">
                    <ItemTemplate>
                        <%# FormatLastUpdatedDate(Convert.ToDateTime(Eval("ActivityDate")), Convert.ToDateTime(Eval("CurrentDate")))%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="WhoIsOnlineDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:MembershipConnectionString %>" 
            SelectCommand="usp_GetCurrentActivityForOnlineUsers" 
            SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter DefaultValue="15" Name="MinutesSinceLastInActive" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

