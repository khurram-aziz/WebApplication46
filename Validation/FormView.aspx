<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormView.aspx.cs" Inherits="WebApplication.Validation.FormView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ValidationSummary runat="server" ShowModelStateErrors="true" />
    <asp:FormView ID="FormView1" runat="server" ItemType="WebApplication.Models.UserModel"
        DefaultMode="Insert" SelectMethod="GetUser" InsertMethod="AddUser">
        <InsertItemTemplate>
            
            FirstName:
            <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' />
            <br />
            LastName:
            <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' />
            <br />
            EmailAddress:
            <asp:TextBox ID="EmailAddressTextBox" runat="server" Text='<%# Bind("EmailAddress") %>' />
            <br />
            Age:
            <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>' />
            <br />
            Location:
            <asp:TextBox ID="LocationTextBox" runat="server" Text='<%# Bind("Location") %>' />
            <br />
            Subscription:
            <asp:TextBox ID="SubscriptionTextBox" runat="server" Text='<%# Bind("Subscription") %>' />
            <br />
            Password:
            <asp:TextBox ID="PasswordTextBox" runat="server" Text='<%# Bind("Password") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            
        </InsertItemTemplate>
    </asp:FormView>
</asp:Content>
