<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Knockout.aspx.cs" Inherits="WebApplication.Validation.Knockout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        label { display: block; }
    </style>

    <script id="customMessageTemplate" type="text/html">
        <em class="customMessage" data-bind='validationMessage: field'></em>
    </script>

    <ul data-bind='foreach: modelErrors'>
        <li data-bind='text: $data'></li>
    </ul>
    
    <fieldset>
        <legend>User: <span data-bind='text: errors().length'></span> errors</legend>
        
        <label>First name: <input data-bind='value: firstName' /></label>
        <label>Last name: <input data-bind='value: lastName' /></label>
        <div data-bind='validationOptions: { messageTemplate: "customMessageTemplate" }'>
            <label>Email: <input data-bind='value: emailAddress' required pattern="@" /></label>
            <label>Location: <input data-bind='value: location' /></label>
            <label>Age: <input data-bind='value: age' required /></label>
        </div>
        <label>Subscriptions: <select data-bind='value: subscription, options: subscriptionOptions, optionsCaption: "Choose one..."'></select></label>
        <label>Password: <input data-bind='value: password' type="password" /></label>
        <label>Retype password: <input data-bind='value: confirmPassword' type="password" /></label>
        <label>10 + 1 = <input data-bind='value: captcha' /></label>
    </fieldset>
    <button type="button" data-bind='click: submit'>Submit</button> <span data-bind='text: message'></span>
    <button type="button" data-bind='click: requireLocation'>Make 'Location' required</button>

    <script src="/Scripts/knockout-3.4.2.js"></script>
    <script src="/Scripts/knockout.validation.js"></script>

    <script type="text/javascript">
        ko.validation.rules.pattern.message = 'Invalid.';

        // ko.validation.configure({
        //     registerExtenders: true,
        //     messagesOnModified: true,
        //     insertMessages: true,
        //     parseInputAttributes: true,
        //     messageTemplate: null
        // });

        var captcha = function (val) {
            return val == 11;
        };

        var mustEqual = function (val, other) {
            return val == other;
        };

        var viewModel = {
            firstName: ko.observable().extend({
                minLength: 2,
                maxLength: 10
            }),
            lastName: ko.observable().extend({
                required: true
            }),
            emailAddress: ko.observable().extend({
                required: {
                    message: 'Please supply your email address.'
                }
            }),
            age: ko.observable().extend({
                min: 1,
                max: 100
            }),
            location: ko.observable(),
            subscriptionOptions: ['Technology', 'Music'],
            subscription: ko.observable().extend({
                required: true
            }),
            password: ko.observable(),
            captcha: ko.observable().extend({
                validation: {
                    validator: captcha,
                    message: 'Please check.'
                }
            }),

            message: ko.observable(), modelErrors: ko.observableArray(),

            submit: function () {
                var self = this;
                if (viewModel.errors().length == 0) {
                    this.modelErrors.removeAll();
                    $.ajax('/api/Ajax/Signup', {
                        type: 'POST',
                        contentType: 'application/json',
                        data: ko.toJSON(self),
                        success: function (result) {
                            self.message('Successfully updated!')
                        },
                        error: function (result) {
                            self.message('Please correct the errors!');

                            if (null !== result.responseJSON && null !== result.responseJSON.modelState) {
                                var modelState = result.responseJSON.modelState;
                                for (var key in modelState) {
                                    for (var i = 0; i < modelState[key].length; i++) {
                                        self.modelErrors.push(modelState[key][i]);
                                    }
                                }
                            }
                        }
                    });
                }
                else {
                    alert('Please check your submission.');
                    viewModel.errors.showAllMessages();
                }
            }
        };

        viewModel.confirmPassword = ko.observable().extend({
            validation: {
                validator: mustEqual,
                message: 'Passwords do not match.',
                params: viewModel.password
            }
        });

        viewModel.errors = ko.validation.group(viewModel);

        viewModel.requireLocation = function () {
            viewModel.location.extend({
                required: true
            });
        };

        ko.applyBindings(viewModel);
    </script>

    <h1>Known Issues</h1>
    <ul>
        <li>First Name if not entered; will be checked only at server side</li>
    </ul>
</asp:Content>
