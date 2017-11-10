<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JQuery.aspx.cs" Inherits="WebApplication.Validation.JQuery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ValidationSummary runat="server" ShowModelStateErrors="true" />
    <asp:FormView ID="FormView1" runat="server" ItemType="WebApplication.Models.UserModel"
        DefaultMode="Insert" SelectMethod="GetUser" InsertMethod="AddUser">
        <InsertItemTemplate>
            
            <fieldset>
                <ol>
                    <asp:DynamicEntity runat="server" Mode="Insert" />
                </ol>
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </fieldset>
            
        </InsertItemTemplate>
    </asp:FormView>

    <script src="/Scripts/jquery-1.10.2.js"></script>
    <script src="/Scripts/jquery.validate.js"></script>
    <script src="/Scripts/jquery.validate.unobtrusive.js"></script>
</asp:Content>
