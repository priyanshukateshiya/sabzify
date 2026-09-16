<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="sabzify.Login" UnobtrusiveValidationMode="None" %>

<asp:Content ID="LoginContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="auth-page">
        <div class="auth-card">

            <div class="auth-brand">
                <svg class="auth-brand-leaf" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M20 3C10 3 4 8 4 15c0 2.2.7 4.1 1.9 5.5L4 22.4 5.4 21l1.9-1.9C8.7 20.3 10.6 21 12.8 21 19.8 21 21 12 20 3zm-8.3 13.6c-.9 0-1.7-.2-2.4-.6 2.6-3.6 6-6.2 9.6-7.6-1.2 4.9-3.6 8.2-7.2 8.2z" />
                </svg>
                <span class="auth-brand-name">Sabzify</span>
            </div>

            <p class="auth-subtitle">Welcome back! Please login to your account.</p>

            <div class="auth-field">
                <label class="auth-label" for="<%= txtEmail.ClientID %>">Email Address</label>
                <div class="auth-input-wrap">
                    <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M20 4H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zm0 4.24-8 5-8-5V6l8 5 8-5v2.24z" />
                    </svg>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="auth-input" TextMode="SingleLine" placeholder="Enter your email" />
                </div>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Email is required"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true"
                    ValidationGroup="Login" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Enter a valid email"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true"
                    ValidationGroup="Login" />
            </div>

            <div class="auth-field">
                <div class="auth-label-row">
                    <label class="auth-label" for="<%= txtPassword.ClientID %>">Password</label>
                    <a class="auth-forgot" href="#">Forgot Password?</a>
                </div>
                <div class="auth-input-wrap">
                    <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M18 8h-1V6a5 5 0 0 0-10 0v2H6a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zM9 6a3 3 0 0 1 6 0v2H9V6zm3 12a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" />
                    </svg>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="auth-input" TextMode="Password" placeholder="Enter your password" />
                    <button type="button" class="auth-eye" data-toggle-password="<%= txtPassword.ClientID %>" aria-label="Show password">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M12 5c-5 0-9.3 3.1-11 7 1.7 3.9 6 7 11 7s9.3-3.1 11-7c-1.7-3.9-6-7-11-7zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z" />
                        </svg>
                    </button>
                </div>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="Password is required"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true"
                    ValidationGroup="Login" />
            </div>

            <asp:Button ID="btnLogin" runat="server"
                CssClass="auth-btn"
                Text="Login &#8594;"
                OnClick="btnLogin_Click"
                ValidationGroup="Login" />

            <p class="auth-foot">Don't have an account? <a href="Register.aspx">Register</a></p>

        </div>
    </div>

    <script type="text/javascript">
        (function () {
            var toggles = document.querySelectorAll('[data-toggle-password]');
            for (var i = 0; i < toggles.length; i++) {
                toggles[i].addEventListener('click', function () {
                    var input = document.getElementById(this.getAttribute('data-toggle-password'));
                    if (!input) { return; }
                    var hidden = input.type === 'password';
                    input.type = hidden ? 'text' : 'password';
                    this.classList.toggle('is-on', hidden);
                    this.setAttribute('aria-label', hidden ? 'Hide password' : 'Show password');
                });
            }
        })();
    </script>

</asp:Content>
