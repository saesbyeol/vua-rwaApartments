<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Admin.Default" %>

<%@ Register Src="~/App_UserControls/LoginControl.ascx" TagPrefix="uc1" TagName="LoginControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <uc1:LoginControl runat="server" id="LoginControl" />
</asp:Content>
