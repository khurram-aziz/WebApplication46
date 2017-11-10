<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vue.aspx.cs" Inherits="WebApplication.Validation.Vue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        label { display: block; }
    </style>

    <div id="app">
        <ul>
            <li v-for="error in modelErrors">{{error}}</li>
            <li v-for="error in errors.items">{{error.msg}}</li>
        </ul>

        <fieldset>
            <legend>User: {{ totalErrors }} errors</legend>
            <label>First name: <input name="firstName" type="text" v-model="firstName" v-validate="'min:3|max:10'" /></label>
            <label>Last name: <input name="lastName" type="text" v-model="lastName" v-validate="'required'" /></label>
            <label>Email: <input name="emailAddress" type="email" v-model="emailAddress" v-validate="'required|email'" data-vv-as="Email Address" /></label>
            <label>Location: <input name="location" type="text" v-model="location" /></label>
            <label>Age: <input name="age" type="number" v-model="age" v-validate="'required|min_value:1|max_value:100'" /></label>
            <label>Subscription:
                <select name="subscription" v-model="subscription" v-validate="'required'">
                    <option value="">Choose one...</option>
                    <option v-for="subscription in subscriptions" v-bind:value="subscription.value">{{ subscription.text }}</option>
                </select>
            </label>
            <label>Password: <input name="password" type="password" v-model="password" v-validate="'required'" /></label>
            <label>Retype password: <input name="confirmPassword" type="password" v-validate="'required|confirmed:password'" /></label>
            <label>10 + 1 = <input name="captcha" type="number" v-validate="'required'" /></label>
        </fieldset>
        <button type="button" v-on:click="submit">Submit</button> {{ message }}
    </div>

    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
    <script src="/Scripts/vue.js"></script>
    <script src="/Scripts/vee-validate.js"></script>
    
    <script type="text/javascript">
        Vue.use(VeeValidate);
        var app = new Vue({
            el: '#app',
            data: {
                firstName: '', lastName: '',
                emailAddress: '',
                location: '', age: 20,
                subscription: '',
                subscriptions: [{ text: 'Technology', value: 'Technology' }, { text: 'Music', value: 'Music' }],
                password: '',

                message: '', modelErrors: [],
            },
            computed: {
                totalErrors: function () {
                    return this.errors.items.length + this.modelErrors.length;
                }
            },
            methods: {
                submit: function () {
                    //e.preventDefault();
                    this.$validator.validateAll().then(function (result) {
                        if (result) {
                            app.modelErrors = [];
                            $.ajax('/api/Ajax/Signup', {
                                type: 'POST',
                                contentType: 'application/json',
                                data: JSON.stringify(app.$data),
                                success: function (result) {
                                    app.message = 'Successfully updated!';
                                },
                                error: function (result) {
                                    app.message = 'Please correct the errors!';

                                    if (null !== result.responseJSON && null !== result.responseJSON.modelState) {
                                        var modelState = result.responseJSON.modelState;
                                        var errors = [];
                                        for (var key in modelState) {
                                            for (var i = 0; i < modelState[key].length; i++) {
                                                errors.push(modelState[key][i]);
                                            }
                                        }
                                        app.modelErrors = errors;
                                    }
                                }
                            });
                        }
                    });
                }
            }
        });

        const captcha = {
            getMessage: function(field, args) { return 'Captcha is invalid'; },
            validate: function(value, args) { return value == 11; }
        };
        const validator = new VeeValidate.Validator();
        validator.extend('captcha',  captcha);
        validator.attach('captcha', 'required|captcha');
    </script>

    <h1>Observations</h1>
    <ul>
        <li>We cannt change validation rules at runtime; for instance in Knockout example; the location is made required at runtime using button</li>
        <li>Note the use of data-vv-as; so when rule gets failed; the friendlier field name will be reported</li>
    </ul>

    <h1>Known Issues</h1>
    <ul>
        <li>First Name if not entered; will be checked only at server side</li>
        <li>When modelErrors exist; they dont disappear unless form is resubmitted</li>
    </ul>
</asp:Content>
