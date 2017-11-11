<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebApi.aspx.cs" Inherits="WebApplication.AngularJs.WebApi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div ng-app="myApp">
        <div class="col-sm-8" ng-controller="cityController" ng-init="loadStates()">
            <div>{{status}}</div>
            <select data-ng-options="s for s in states" data-ng-model="selectedState"></select>
            <button class="btn btn-info btn-lg option" ng-click="listCities($event)">List Cities</button>

            <div ng-show="citiesLoaded">
                <select data-ng-options="c.city for c in cities" data-ng-model="selectedCity"></select>
                <button class="btn btn-info btn-lg option" ng-click="submitCity($event)">Submit</button>
            </div>
        </div>
    </div>

    <script src="/Scripts/angular.js"></script>
    <script src="/Scripts/angular-route.js"></script>

    <script type="text/javascript">
        var app = angular.module('myApp', []).controller('cityController', function ($scope, $http) {
            $scope.status = '';
            $scope.working = false;
            $scope.citiesLoaded = false;

            $scope.states = [];
            $scope.selectedState = '';
            $scope.cities = [];
            $scope.selectedCity = null;

            $scope.loadStates = function () {
                $scope.status = 'loading states...';
                $scope.working = true;
                $http.get('/api/Ajax/States').then(function(response) {
                    $scope.status = 'states loaded!';
                    $scope.working = false;

                    $scope.states = response.data;
                }, function(response) {
                    $scope.status = 'failed to load states!';
                    $scope.working = false;
                })
                .catch(function (response) {
                    console.log('error');
                    console.log(response);
                    debugger;
                });
            };

            $scope.listCities = function (e) {
                e.preventDefault();
                $scope.status = 'loading cities...';
                $http({
                    url: '/api/Ajax/Cities',
                    method: 'GET',
                    params: { state: $scope.selectedState }
                }).then(function (response) {
                    //data, status, headers, config, statusText, xhrStatus
                    console.log(response.data);

                    $scope.status = 'cities loaded!';
                    $scope.working = false;
                    $scope.citiesLoaded = true;

                    $scope.cities = response.data.cities;
                }, function (response) {
                    //data, status, headers, config, statusText, xhrStatus
                    $scope.status = 'failed to load cities!';
                    $scope.working = false;
                })
                .catch(function (response) {
                    console.log('error');
                    console.log(response);
                    debugger;
                });
            };

            $scope.submitCity = function (e) {
                e.preventDefault();
                alert($scope.selectedCity.id + ' : ' + $scope.selectedCity.city);
            };
        });
    </script>
</asp:Content>
