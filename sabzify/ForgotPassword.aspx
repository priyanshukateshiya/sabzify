<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="sabzify.ForgotPassword" UnobtrusiveValidationMode="None" %>

<asp:Content ID="ForgotPasswordContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles: served with the page HTML, so they never depend on a
         cached copy of /Content/Site.css. Every selector starts with .forgot-page. --%>
    <style>
        .site-main:has(.forgot-page),
        .forgot-page .auth-page {
            background: #F3F8FD;
        }

        .forgot-page .auth-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 70vh;
            padding: 40px 16px;
        }

        .forgot-page .auth-page .auth-card {
            position: relative;
            overflow: hidden;
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
            padding: 40px 32px;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 8px 30px rgba(26, 43, 32, .08);
        }

        /* Soft light-green glow in the card's top-right corner. */
        .forgot-page .auth-page .auth-card::before {
            content: "";
            position: absolute;
            top: -70px;
            right: -70px;
            width: 180px;
            height: 180px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(76, 175, 80, .22) 0%, rgba(76, 175, 80, .08) 45%, rgba(76, 175, 80, 0) 70%);
            pointer-events: none;
        }

        .forgot-page .auth-card .auth-brand {
            justify-content: center;
            margin: 0;
        }

        .forgot-page .auth-card .auth-brand-name {
            font-size: 22px;
            font-weight: 700;
            color: #1B6E2A;
        }

        .forgot-page .auth-card .auth-icon-bubble {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            margin: 16px auto 12px;
            border-radius: 50%;
            background: #E6F2E1;
        }

        .forgot-page .auth-card .auth-icon-bubble svg {
            display: block;
            width: 20px;
            height: 20px;
            fill: #2E7D32;
        }

        .forgot-page .auth-card h1.auth-title {
            margin: 0 0 8px;
            font-size: 24px;
            font-weight: 600;
            line-height: 1.3;
            text-align: center;
            color: #1A2B20;
        }

        .forgot-page .auth-card p.auth-subtitle {
            max-width: 280px;
            margin: 0 auto 24px;
            font-size: 14px;
            line-height: 1.5;
            text-align: center;
            color: #6B7280;
        }

        .forgot-page .auth-card .auth-label {
            font-size: 13px;
            font-weight: 600;
        }

        .forgot-page .auth-card input.auth-input {
            max-width: none;
            background: #F3F8FD;
            border-color: #CBD5E1;
            border-radius: 8px;
        }

        .forgot-page .auth-card input.auth-input:focus {
            border-color: #3AAE52;
        }

        .forgot-page .auth-card input.auth-input::placeholder {
            color: #8A9BB0;
        }

        .forgot-page .auth-card .auth-input-icon {
            fill: #8A9BB0;
        }

        .forgot-page .auth-card input.auth-btn {
            max-width: none;
        }

        .forgot-page .auth-card p.auth-foot {
            margin: 20px 0 0;
            font-size: 14px;
            text-align: center;
        }

        .forgot-page .auth-card p.auth-foot a {
            font-size: 14px;
            font-weight: 600;
            color: #2E7D32;
        }

        @media screen and (max-width: 480px) {
            .forgot-page .auth-page {
                padding-left: 0;
                padding-right: 0;
            }

            .forgot-page .auth-page .auth-card {
                max-width: none;
                margin: 0 16px;
                padding: 28px 20px;
            }
        }
    </style>

    <div class="forgot-page">
    <div class="auth-page auth-page--forgot">
        <div class="auth-card auth-card--glow">

            <div class="auth-brand">
                <span class="auth-brand-name">Sabzify</span>
            </div>

            <div class="auth-icon-bubble">
                <svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M13 3a9 9 0 0 0-9 9H1l3.9 3.9L9 12H6a7 7 0 1 1 2.05 4.95l-1.42 1.42A9 9 0 1 0 13 3zm0 6.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5z" />
                </svg>
            </div>

            <h1 class="auth-title">Forgot Password?</h1>
            <p class="auth-subtitle">Enter your email address to receive a password reset link.</p>

            <div class="auth-field">
                <label class="auth-label" for="<%= txtEmail.ClientID %>">Email Address</label>
                <div class="auth-input-wrap">
                    <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M20 4H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zm0 4.24-8 5-8-5V6l8 5 8-5v2.24z" />
                    </svg>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="auth-input" TextMode="SingleLine" placeholder="you@example.com" />
                </div>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Email is required"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true"
                    ValidationGroup="Forgot" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    ErrorMessage="Enter a valid email"
                    Display="Dynamic"
                    CssClass="field-error"
                    SetFocusOnError="true"
                    ValidationGroup="Forgot" />
            </div>

            <asp:Button ID="btnSendResetLink" runat="server"
                CssClass="auth-btn"
                Text="Send Reset Link &#8594;"
                ValidationGroup="Forgot" />

            <p class="auth-foot"><a href="Login.aspx">&#8592; Back to Login</a></p>

        </div>
    </div>
    </div>

</asp:Content>
