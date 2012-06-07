<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Login</h2>
    <p>
        There are three users already in the database - Scott, Sam, and Jisun - and all 
        with the same password, &quot;pass@word&quot;.&nbsp;
    </p>
    <p>
        <asp:Login ID="Login1" runat="server">
        </asp:Login>
    </p>
</asp:Content>

