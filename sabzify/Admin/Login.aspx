<%@ Page Title="Admin Login" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="sabzify.Admin.Login" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Login - Sabzify</title>
    <link href="../Content/Site.css" rel="stylesheet" />
    <link href="../favicon.ico" rel="shortcut icon" type="image/x-icon" />

    <style>
        *, *::before, *::after {
            box-sizing: border-box;
        }

        html, body {
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        .auth-page {
            min-height: 100vh;
        }

        .auth-field {
            margin-bottom: 16px;
        }

        .auth-label {
            display: block;
            margin-bottom: 6px;
            font-size: 12px;
            font-weight: 600;
            color: var(--sabz-ink-900);
        }

        .auth-input-wrap {
            position: relative;
            display: flex;
            align-items: center;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }

        .auth-input-icon {
            position: absolute;
            top: 50%;
            left: 16px;
            width: 18px;
            height: 18px;
            transform: translateY(-50%);
            fill: var(--sabz-ink-400);
            pointer-events: none;
            z-index: 2;
        }

        .auth-input {
            display: block;
            box-sizing: border-box;
            width: 100%;
            max-width: 100%;
            height: 54px;
            padding: 0 46px 0 44px;
            border: 1px solid var(--sabz-line);
            border-radius: 10px;
            background: #fff;
            font-size: 13.5px;
            color: var(--sabz-ink-900);
            outline: none;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .auth-input::placeholder {
            color: var(--sabz-ink-400);
        }

        .auth-input:focus {
            border-color: var(--sabz-green-500);
            box-shadow: 0 0 0 3px rgba(58, 174, 82, .15);
        }

        .auth-eye {
            position: absolute;
            top: 50%;
            right: 12px;
            transform: translateY(-50%);
            display: flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            padding: 0;
            border: 0;
            border-radius: 6px;
            background: transparent;
            cursor: pointer;
            z-index: 2;
        }

        .auth-eye svg {
            width: 18px;
            height: 18px;
            fill: var(--sabz-ink-400);
            transition: fill .15s ease;
        }

        .auth-eye:hover svg,
        .auth-eye.is-on svg {
            fill: var(--sabz-green-600);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-page">
            <div class="auth-card">

                <div class="auth-brand">
                    <svg class="auth-brand-leaf" viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M20 3C10 3 4 8 4 15c0 2.2.7 4.1 1.9 5.5L4 22.4 5.4 21l1.9-1.9C8.7 20.3 10.6 21 12.8 21 19.8 21 21 12 20 3zm-8.3 13.6c-.9 0-1.7-.2-2.4-.6 2.6-3.6 6-6.2 9.6-7.6-1.2 4.9-3.6 8.2-7.2 8.2z" />
                    </svg>
                    <span class="auth-brand-name">Sabzify</span>
                </div>

                <p class="auth-subtitle">Admin Portal - Please login to your account.</p>

                <div class="auth-field">
                    <label class="auth-label" for="<%= txtEmail.ClientID %>">Email Address</label>
                    <div class="auth-input-wrap">
                        <svg class="auth-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M20 4H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zm0 4.24-8 5-8-5V6l8 5 8-5v2.24z" />
                        </svg>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="auth-input" TextMode="SingleLine" placeholder="Enter admin email" autocomplete="username" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Email is required"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="AdminLogin" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        ErrorMessage="Enter a valid email"
                        Display="Dynamic"
                        CssClass="field-error"
                        SetFocusOnError="true"
                        ValidationGroup="AdminLogin" />
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
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="auth-input" TextMode="Password" placeholder="Enter admin password" autocomplete="current-password" />
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
                        ValidationGroup="AdminLogin" />
                </div>

                <asp:Label ID="lblError" runat="server" CssClass="field-error" style="display:block; margin-bottom:12px; text-align:center; font-size:12.5px;" Visible="false" EnableViewState="false" />

                <asp:Button ID="btnAdminLogin" runat="server"
                    CssClass="auth-btn"
                    Text="Login as Admin &#8594;"
                    OnClick="btnAdminLogin_Click"
                    ValidationGroup="AdminLogin" />

                <div class="auth-divider">
                    <span>or</span>
                </div>

                <a href="../Login.aspx" class="auth-btn--admin">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 12a5 5 0 1 0 0-10 5 5 0 0 0 0 10zm0 2c-4.4 0-8 2.2-8 5v1h16v-1c0-2.8-3.6-5-8-5z"/>
                    </svg>
                    User Login
                </a>

                <p class="auth-foot">Return to store? <a href="../Home.aspx">Home Page</a></p>

            </div>
        </div>
    </form>

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
</body>
</html>
