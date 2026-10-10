<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="sabzify.Login" UnobtrusiveValidationMode="None" %>

<asp:Content ID="LoginContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .site-header {
            display: none !important;
        }
    </style>

    <div class="auth-page auth-page--login">
        <%-- DefaultButton makes Enter inside this card click btnLogin. Without it the
             browser submits with the header's hidden btnSearch, so Enter in the email
             or password box ran a search postback instead of logging in. --%>
        <asp:Panel ID="pnlLogin" runat="server" CssClass="auth-card" DefaultButton="btnLogin">

            <div class="auth-brand">
                <svg class="auth-brand-leaf" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M20 3C10 3 4 8 4 15c0 2.2.7 4.1 1.9 5.5L4 22.4 5.4 21l1.9-1.9C8.7 20.3 10.6 21 12.8 21 19.8 21 21 12 20 3zm-8.3 13.6c-.9 0-1.7-.2-2.4-.6 2.6-3.6 6-6.2 9.6-7.6-1.2 4.9-3.6 8.2-7.2 8.2z" />
                </svg>
                <span class="auth-brand-name">Sabzify</span>
            </div>

            <p class="auth-subtitle">Welcome back! Please login to your account.</p>

            <asp:Panel ID="pnlError" runat="server" CssClass="auth-alert" role="alert" Visible="false" EnableViewState="false">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M12 2 1 21h22L12 2zm1 15h-2v-2h2v2zm0-4h-2V9h2v4z" />
                </svg>
                <asp:Literal ID="litError" runat="server" />
            </asp:Panel>

            <div class="auth-field">
                <label class="auth-label" for="<%= txtEmail.ClientID %>">Email Address</label>
                <div class="auth-input-wrap">
                    <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M20 4H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zm0 4.24-8 5-8-5V6l8 5 8-5v2.24z" />
                    </svg>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="auth-input" TextMode="SingleLine"
                        placeholder="Enter your email" MaxLength="100"
                        autocomplete="email" inputmode="email" spellcheck="false" autocapitalize="off" />
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
                    <a class="auth-forgot" href="ForgotPassword.aspx">Forgot Password?</a>
                </div>
                <div class="auth-input-wrap">
                    <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M18 8h-1V6a5 5 0 0 0-10 0v2H6a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zM9 6a3 3 0 0 1 6 0v2H9V6zm3 12a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" />
                    </svg>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="auth-input" TextMode="Password"
                        placeholder="Enter your password" MaxLength="50" autocomplete="current-password" />
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

            <div class="auth-divider">
                <span>or</span>
            </div>

            <a href="Admin/Login.aspx" class="auth-btn--admin">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm0 10.99h7c-.53 4.12-3.28 7.79-7 8.94V12H5V6.3l7-3.11v8.8z"/>
                </svg>
                Admin Login
            </a>

            <p class="auth-foot">Don't have an account? <a href="Register.aspx">Register</a></p>

        </asp:Panel>
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
