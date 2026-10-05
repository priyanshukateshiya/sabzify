<%@ Page Title="Admin Password Reset" Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="sabzify.Admin.ForgotPassword" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Password Reset</title>
    <%-- Same design as the customer ForgotPassword.aspx (its inline block plus the
         Site.css auth rules it builds on), copied from the computed values so this
         standalone page needs neither Site.Master nor Site.css. Every selector
         starts with .admin-forgot. --%>
    <style>
        html, body {
            margin: 0;
            padding: 0;
        }

        body {
            background: #F3F8FD;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", "Noto Sans", "Liberation Sans", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
            font-size: 16px;
            line-height: 1.5;
            color: #1A2B20;
        }

        .admin-forgot *,
        .admin-forgot *::before,
        .admin-forgot *::after {
            box-sizing: border-box;
        }

        .admin-forgot .af-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 40px 16px;
            background: #F3F8FD;
        }

        .admin-forgot .af-card {
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
        .admin-forgot .af-card::before {
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

        .admin-forgot .af-brand {
            margin: 0;
            text-align: center;
        }

        .admin-forgot .af-brand-name {
            display: block;
            font-size: 22px;
            font-weight: 700;
            letter-spacing: -.01em;
            color: #1B6E2A;
        }

        .admin-forgot .af-brand-tag {
            display: block;
            margin-top: 2px;
            font-size: 11px;
            font-weight: 600;
            line-height: 1.3;
            letter-spacing: .06em;
            text-transform: uppercase;
            color: #6B7280;
        }

        .admin-forgot .af-icon-bubble {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            margin: 16px auto 12px;
            border-radius: 50%;
            background: #E6F2E1;
        }

        .admin-forgot .af-icon-bubble svg {
            display: block;
            width: 20px;
            height: 20px;
            fill: #2E7D32;
        }

        .admin-forgot h1.af-title {
            margin: 0 0 8px;
            font-size: 24px;
            font-weight: 600;
            line-height: 1.3;
            text-align: center;
            color: #1A2B20;
        }

        .admin-forgot p.af-subtitle {
            max-width: 280px;
            margin: 0 auto 24px;
            font-size: 14px;
            line-height: 1.5;
            text-align: center;
            color: #6B7280;
        }

        .admin-forgot .af-field {
            margin-bottom: 16px;
        }

        .admin-forgot .af-label {
            display: block;
            margin-bottom: 6px;
            font-size: 13px;
            font-weight: 600;
            color: #1A2B20;
        }

        .admin-forgot .af-input-wrap {
            position: relative;
            display: block;
        }

        .admin-forgot .af-input-icon {
            position: absolute;
            top: 50%;
            left: 12px;
            width: 16px;
            height: 16px;
            transform: translateY(-50%);
            fill: #8A9BB0;
            pointer-events: none;
        }

        .admin-forgot input.af-input {
            display: block;
            width: 100%;
            height: 42px;
            margin: 0;
            padding: 0 40px 0 36px;
            border: 1px solid #CBD5E1;
            border-radius: 8px;
            background: #F3F8FD;
            font-family: inherit;
            font-size: 13px;
            color: #1A2B20;
            outline: none;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .admin-forgot input.af-input::placeholder {
            color: #8A9BB0;
        }

        .admin-forgot input.af-input:focus {
            border-color: #3AAE52;
            box-shadow: 0 0 0 3px rgba(58, 174, 82, .15);
        }

        /* Validators use Display="Dynamic", so they take no space until shown and
           the card simply grows. They sit after .af-input-wrap, so they can never
           overlap the leading icon. */
        .admin-forgot .field-error {
            display: block;
            margin-top: 4px;
            font-size: 12px;
            line-height: 1.35;
            color: #C0392B;
            text-align: left;
        }

        /* Invalid-field red border - same :has() approach as the customer pages.
           The :focus variant is more specific than input.af-input:focus, so the
           green ring cannot override the red border. */
        .admin-forgot .af-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input.af-input {
            border-color: #C0392B;
        }

        .admin-forgot .af-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input.af-input:focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .15);
        }

        .admin-forgot .summary-error {
            margin: 0 0 4px;
            font-size: 11px;
            line-height: 1.4;
            color: #C0392B;
            text-align: center;
        }

        .admin-forgot .summary-error:empty {
            display: none;
        }

        .admin-forgot input.af-btn {
            display: block;
            width: 100%;
            height: 42px;
            margin: 8px 0 0;
            padding: 1px 6px;
            border: 0;
            border-radius: 10px;
            background: #2E7D32;
            color: #fff;
            font-family: inherit;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .admin-forgot input.af-btn:hover,
        .admin-forgot input.af-btn:focus {
            background: #256B29;
            color: #fff;
        }

        .admin-forgot p.af-foot {
            margin: 20px 0 0;
            font-size: 14px;
            text-align: center;
            color: #55655C;
        }

        .admin-forgot p.af-foot a {
            font-size: 14px;
            font-weight: 600;
            color: #2E7D32;
            text-decoration: none;
        }

        .admin-forgot p.af-foot a:hover,
        .admin-forgot p.af-foot a:focus {
            text-decoration: underline;
        }

        .admin-forgot p.af-note {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
            margin: 12px 0 0;
            font-size: 10px;
            line-height: 1.4;
            text-align: center;
            color: #9CA3AF;
        }

        .admin-forgot p.af-note svg {
            flex: none;
            width: 11px;
            height: 11px;
            fill: #9CA3AF;
        }

        @media screen and (max-width: 480px) {
            .admin-forgot .af-page {
                padding-left: 0;
                padding-right: 0;
            }

            .admin-forgot .af-card {
                max-width: none;
                margin: 0 16px;
                padding: 28px 20px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-forgot">
            <div class="af-page">
                <div class="af-card">

                    <div class="af-brand">
                        <span class="af-brand-name">Sabzify</span>
                        <span class="af-brand-tag">Admin</span>
                    </div>

                    <div class="af-icon-bubble">
                        <svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M12.65 10A5.99 5.99 0 0 0 7 6c-3.31 0-6 2.69-6 6s2.69 6 6 6a5.99 5.99 0 0 0 5.65-4H17v4h4v-4h2v-4H12.65zM7 14c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2z" />
                        </svg>
                    </div>

                    <h1 class="af-title">Reset Admin Password</h1>
                    <p class="af-subtitle">Enter your admin email address to receive a password reset link.</p>

                    <div class="af-field">
                        <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" CssClass="af-label" Text="Admin Email Address" />
                        <div class="af-input-wrap">
                            <svg class="af-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M20 4H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2zm0 4.24-8 5-8-5V6l8 5 8-5v2.24z" />
                            </svg>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="af-input" placeholder="admin@sabzify.com" autocomplete="username" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            Text="Email is required" ValidationGroup="AdminForgot" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            Text="Enter a valid email" ValidationGroup="AdminForgot" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <%-- Validators use Text only (no ErrorMessage) so field errors are not
                         duplicated here; this is reserved for server-side messages.
                         EnableClientScript="false" keeps it hidden on client-side failures. --%>
                    <asp:ValidationSummary ID="vsAdminForgot" runat="server" ValidationGroup="AdminForgot"
                        DisplayMode="SingleParagraph" HeaderText="" ShowMessageBox="false"
                        EnableClientScript="false" CssClass="summary-error" />

                    <asp:Button ID="btnSendReset" runat="server" CssClass="af-btn"
                        Text="Send Reset Link &#8594;" ValidationGroup="AdminForgot"
                        PostBackUrl="~/Admin/VerifyCode.aspx" />

                    <p class="af-foot"><a href="Login.aspx">&#8592; Back to Admin Login</a></p>

                    <p class="af-note">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M12 1 3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z" />
                        </svg>
                        For security, reset links expire in 15 minutes.
                    </p>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
