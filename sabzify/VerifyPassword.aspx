<%@ Page Title="Verify Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VerifyPassword.aspx.cs" Inherits="sabzify.VerifyPassword" UnobtrusiveValidationMode="None" %>

<asp:Content ID="VerifyPasswordContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .site-header {
            display: none !important;
        }
        .site-main:has(.verify-page),
        .verify-page .auth-page {
            background: #F3F8FD;
        }

        .verify-page .auth-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 70vh;
            padding: 40px 16px;
        }

        .verify-page .auth-page .auth-card {
            position: relative;
            overflow: hidden;
            width: 100%;
            max-width: 420px;
            margin: 0 auto;
            padding: 36px 32px;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 8px 30px rgba(26, 43, 32, .08);
        }

        .verify-page .auth-page .auth-card::before {
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

        .verify-page .auth-card .auth-brand {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin: 0;
        }

        .verify-page .auth-card .auth-brand-name {
            font-size: 22px;
            font-weight: 700;
            color: #1B6E2A;
        }

        .verify-page .auth-card .auth-icon-bubble {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            margin: 14px auto 10px;
            border-radius: 50%;
            background: #E6F2E1;
        }

        .verify-page .auth-card .auth-icon-bubble svg {
            display: block;
            width: 20px;
            height: 20px;
            fill: #2E7D32;
        }

        .verify-page .auth-card h1.auth-title {
            margin: 0 0 6px;
            font-size: 22px;
            font-weight: 600;
            line-height: 1.3;
            text-align: center;
            color: #1A2B20;
        }

        .verify-page .auth-card p.auth-subtitle {
            max-width: 320px;
            margin: 0 auto 20px;
            font-size: 13px;
            line-height: 1.45;
            text-align: center;
            color: #6B7280;
        }

        .verify-page .auth-card .auth-label {
            display: block;
            margin-bottom: 6px;
            font-size: 12.5px;
            font-weight: 600;
            color: #374151;
        }

        .verify-page .auth-card .auth-field {
            margin-bottom: 14px;
        }

        .verify-page .auth-card input.auth-input {
            width: 100%;
            max-width: none;
            background: #F3F8FD;
            border: 1px solid #CBD5E1;
            border-radius: 8px;
            padding: 9px 12px 9px 36px;
            font-size: 13px;
            box-sizing: border-box;
        }

        .verify-page .auth-card input.auth-input:focus {
            border-color: #3AAE52;
            outline: none;
        }

        .verify-page .auth-card .auth-input-wrap {
            position: relative;
        }

        .verify-page .auth-card .auth-input-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            width: 16px;
            height: 16px;
            fill: #8A9BB0;
            pointer-events: none;
        }

        .verify-page .auth-card .auth-eye {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            color: #8A9BB0;
        }

        .verify-page .auth-card .auth-eye svg {
            width: 16px;
            height: 16px;
            fill: currentColor;
        }

        .verify-page .auth-card input.auth-btn {
            width: 100%;
            max-width: none;
            height: 40px;
            margin-top: 6px;
            border: none;
            border-radius: 8px;
            background: #1B7A3A;
            color: #fff;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .verify-page .auth-card input.auth-btn:hover {
            background: #166A32;
        }

        .verify-page .auth-card p.auth-foot {
            margin: 18px 0 0;
            font-size: 13px;
            text-align: center;
        }

        .verify-page .auth-card p.auth-foot a {
            font-weight: 600;
            color: #2E7D32;
            text-decoration: none;
        }

        .verify-page .auth-card p.auth-foot a:hover {
            text-decoration: underline;
        }

        .verify-page .auth-alert {
            margin-bottom: 14px;
            padding: 10px 12px;
            border-radius: 8px;
            font-size: 12.5px;
            text-align: center;
        }

        .verify-page .auth-alert--success {
            background: #E8F5E9;
            color: #2E7D32;
            border: 1px solid #C8E6C9;
        }

        .verify-page .auth-alert--error {
            background: #FFEBEE;
            color: #C62828;
            border: 1px solid #FFCDD2;
        }
    </style>

    <div class="verify-page">
        <div class="auth-page">
            <div class="auth-card auth-card--glow">

                <div class="auth-brand">
                    <svg class="auth-brand-leaf" viewBox="0 0 24 24" width="22" height="22" aria-hidden="true">
                        <path fill="#1B6E2A" d="M20 3C10 3 4 8 4 15c0 2.2.7 4.1 1.9 5.5L4 22.4 5.4 21l1.9-1.9C8.7 20.3 10.6 21 12.8 21 19.8 21 21 12 20 3zm-8.3 13.6c-.9 0-1.7-.2-2.4-.6 2.6-3.6 6-6.2 9.6-7.6-1.2 4.9-3.6 8.2-7.2 8.2z" />
                    </svg>
                    <span class="auth-brand-name">Sabzify</span>
                </div>

                <div class="auth-icon-bubble">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-2 16l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z" />
                    </svg>
                </div>

                <h1 class="auth-title">Verify Password</h1>
                <p class="auth-subtitle">Enter the verification code sent to your email and set your new password.</p>

                <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="auth-alert auth-alert--success">
                    Password reset successfully! You can now <a href="Login.aspx" style="color:#1B7A3A;font-weight:600;">Login here</a>.
                </asp:Panel>

                <asp:Label ID="lblError" runat="server" Visible="false" CssClass="auth-alert auth-alert--error" EnableViewState="false" />

                <asp:Panel ID="pnlForm" runat="server">
                    <div class="auth-field">
                        <label class="auth-label" for="<%= txtEmail.ClientID %>">Email Address</label>
                        <div class="auth-input-wrap">
                            <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M20 4H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zm0 4.24-8 5-8-5V6l8 5 8-5v2.24z" />
                            </svg>
                            <asp:TextBox ID="txtEmail" MaxLength="100" runat="server" CssClass="auth-input" placeholder="you@example.com" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Email is required" Display="Dynamic" CssClass="field-error"
                            ValidationGroup="VerifyPass" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Enter a valid email" Display="Dynamic" CssClass="field-error"
                            ValidationGroup="VerifyPass" SetFocusOnError="true" />
                    </div>

                    <div class="auth-field">
                        <label class="auth-label" for="<%= txtCode.ClientID %>">Verification Code</label>
                        <div class="auth-input-wrap">
                            <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14h2v2h-2v-2zm0-10h2v8h-2V6z"/>
                            </svg>
                            <asp:TextBox ID="txtCode" MaxLength="6" runat="server" CssClass="auth-input" placeholder="Enter 6-digit code (e.g. 123456)" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                            ErrorMessage="Verification code is required" Display="Dynamic" CssClass="field-error"
                            ValidationGroup="VerifyPass" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revCode" runat="server" ControlToValidate="txtCode"
                            ValidationExpression="^\d{6}$"
                            ErrorMessage="Enter the 6-digit verification code" Display="Dynamic" CssClass="field-error"
                            ValidationGroup="VerifyPass" SetFocusOnError="true" />
                    </div>

                    <div class="auth-field">
                        <label class="auth-label" for="<%= txtNewPassword.ClientID %>">New Password</label>
                        <div class="auth-input-wrap">
                            <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M18 8h-1V6a5 5 0 0 0-10 0v2H6a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zM9 6a3 3 0 0 1 6 0v2H9V6zm3 12a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" />
                            </svg>
                            <asp:TextBox ID="txtNewPassword" MaxLength="50" runat="server" CssClass="auth-input" TextMode="Password" placeholder="Enter new password" />
                            <button type="button" class="auth-eye" data-toggle-password="<%= txtNewPassword.ClientID %>" aria-label="Toggle password">
                                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 5c-5 0-9.3 3.1-11 7 1.7 3.9 6 7 11 7s9.3-3.1 11-7c-1.7-3.9-6-7-11-7zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z"/></svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword"
                            ErrorMessage="New password is required" Display="Dynamic" CssClass="field-error"
                            ValidationGroup="VerifyPass" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revNewPassword" runat="server" ControlToValidate="txtNewPassword"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,50}$"
                            ErrorMessage="8 to 50 characters with uppercase, lowercase and a number" Display="Dynamic" CssClass="field-error"
                            ValidationGroup="VerifyPass" SetFocusOnError="true" />
                    </div>

                    <div class="auth-field">
                        <label class="auth-label" for="<%= txtConfirmPassword.ClientID %>">Confirm New Password</label>
                        <div class="auth-input-wrap">
                            <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M18 8h-1V6a5 5 0 0 0-10 0v2H6a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zM9 6a3 3 0 0 1 6 0v2H9V6zm3 12a2 2 0 1 1 0-4 2 2 0 0 1 0 4z" />
                            </svg>
                            <asp:TextBox ID="txtConfirmPassword" MaxLength="50" runat="server" CssClass="auth-input" TextMode="Password" placeholder="Confirm new password" />
                            <button type="button" class="auth-eye" data-toggle-password="<%= txtConfirmPassword.ClientID %>" aria-label="Toggle password">
                                <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 5c-5 0-9.3 3.1-11 7 1.7 3.9 6 7 11 7s9.3-3.1 11-7c-1.7-3.9-6-7-11-7zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z"/></svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Please confirm your password" Display="Dynamic" CssClass="field-error"
                            ValidationGroup="VerifyPass" SetFocusOnError="true" />
                        <asp:CompareValidator ID="cvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtNewPassword" ErrorMessage="Passwords do not match" Display="Dynamic"
                            CssClass="field-error" ValidationGroup="VerifyPass" SetFocusOnError="true" />
                    </div>

                    <asp:ValidationSummary ID="vsVerifyPass" runat="server" ValidationGroup="VerifyPass"
                        DisplayMode="SingleParagraph" HeaderText="" ShowMessageBox="false"
                        CssClass="field-error" style="display:block; margin-bottom:10px; text-align:center;" />

                    <asp:Button ID="btnVerifyPassword" runat="server"
                        CssClass="auth-btn"
                        Text="Reset Password &#8594;"
                        OnClick="btnVerifyPassword_Click"
                        ValidationGroup="VerifyPass" />
                </asp:Panel>

                <p class="auth-foot"><a href="Login.aspx">&#8592; Back to Login</a></p>

            </div>
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
                });
            }
        })();
    </script>

</asp:Content>
