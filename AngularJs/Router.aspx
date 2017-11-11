<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Router.aspx.cs" Inherits="WebApplication.AngularJs.Router" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div ng-app="myApp">
        <script type="text/ng-template" id="main.htm">main</script>
        <script type="text/ng-template" id="red.htm">red</script>
        <script type="text/ng-template" id="green.htm">green</script>
        <script type="text/ng-template" id="blue.htm">blue</script>

        <p><a href="#/!">Main</a></p>

        <a href="#!red">Red</a> | <a href="#!green">Green</a> | <a href="#!blue">Blue</a>

        <div ng-view></div>
    </div>

    <script src="/Scripts/angular.js"></script>
    <script src="/Scripts/angular-route.js"></script>

    <script type="text/javascript">
        var app = angular.module('myApp', ['ngRoute']);
        app.config(function ($routeProvider) {
            $routeProvider
                .when('/', {
                    templateUrl: 'main.htm'
                })
                .when('/red', {
                    templateUrl: 'red.htm'
                })
                .when('/green', {
                    templateUrl: 'green.htm'
                })
                .when('/blue', {
                    templateUrl: 'blue.htm'
                });
        });
    </script>
</asp:Content>
