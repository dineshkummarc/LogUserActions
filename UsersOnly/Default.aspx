<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="UsersOnly_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
    Authenticated Users Only</h2>
<p>
    Only authenticated users can visit the pages in the UsersOnly folder. If you&#39;ve 
    reached here, you&#39;re logged in to the site!</p>
<p>
    Once you log in, your movements around the site are logged in the ActivityLog 
    table.</p>
<p>
    <asp:Button ID="ViewHistoryButton" runat="server" 
        onclick="ViewHistoryButton_Click" Text="View a History of Your Activity" />
</p>
</asp:Content>

