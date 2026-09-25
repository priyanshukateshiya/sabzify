<%@ Page Title="Set New Admin Password" Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="sabzify.Admin.ResetPassword" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Set New Admin Password</title>
    <%-- Same design system as Admin/ForgotPassword.aspx, copied value for value.
         Every selector starts with .admin-reset. --%>
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

        .admin-reset *,
        .admin-reset *::before,
        .admin-reset *::after {
            box-sizing: border-box;
        }

        .admin-reset .ar-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 40px 16px;
            background: #F3F8FD;
        }

        .admin-reset .ar-card {
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
        .admin-reset .ar-card::before {
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

        .admin-reset .ar-brand {
            margin: 0;
            text-align: center;
        }

        .admin-reset .ar-brand-name {
            display: block;
            font-size: 22px;
            font-weight: 700;
            letter-spacing: -.01em;
            color: #1B6E2A;
        }

        .admin-reset .ar-brand-tag {
            display: block;
            margin-top: 2px;
            font-size: 11px;
            font-weight: 600;
            line-height: 1.3;
            letter-spacing: .06em;
            text-transform: uppercase;
            color: #6B7280;
        }

        .admin-reset .ar-icon-bubble {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            margin: 16px auto 12px;
            border-radius: 50%;
            background: #E6F2E1;
        }

        .admin-reset .ar-icon-bubble svg {
            display: block;
            width: 20px;
            height: 20px;
            fill: #2E7D32;
        }

        .admin-reset h1.ar-title {
            margin: 0 0 8px;
            font-size: 24px;
            font-weight: 600;
            line-height: 1.3;
            text-align: center;
            color: #1A2B20;
        }

        .admin-reset p.ar-subtitle {
            max-width: 280px;
            margin: 0 auto 24px;
            font-size: 14px;
            line-height: 1.5;
            text-align: center;
            color: #6B7280;
        }

        .admin-reset .ar-field {
            margin-bottom: 16px;
        }

        .admin-reset .ar-label {
            display: block;
            margin-bottom: 6px;
            font-size: 13px;
            font-weight: 600;
            color: #1A2B20;
        }

        .admin-reset .ar-input-wrap {
            position: relative;
            display: block;
        }

        .admin-reset .ar-input-icon {
            position: absolute;
            top: 50%;
            left: 12px;
            width: 16px;
            height: 16px;
            transform: translateY(-50%);
            fill: #8A9BB0;
            pointer-events: none;
        }

        .admin-reset input.ar-input {
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

        .admin-reset input.ar-input::placeholder {
            color: #8A9BB0;
        }

        .admin-reset input.ar-input:focus {
            border-color: #3AAE52;
            box-shadow: 0 0 0 3px rgba(58, 174, 82, .15);
        }

        /* Show/hide toggle (UI only), sitting in the input's 40px right padding. */
        .admin-reset .ar-eye {
            position: absolute;
            top: 50%;
            right: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            padding: 0;
            border: 0;
            border-radius: 6px;
            background: transparent;
            transform: translateY(-50%);
            cursor: pointer;
        }

        .admin-reset .ar-eye svg {
            width: 16px;
            height: 16px;
            fill: #8A9BB0;
        }

        .admin-reset .ar-eye .ar-eye-off,
        .admin-reset .ar-eye.is-on .ar-eye-on {
            display: none;
        }

        .admin-reset .ar-eye.is-on .ar-eye-off {
            display: block;
        }

        .admin-reset .ar-eye:hover svg,
        .admin-reset .ar-eye.is-on svg {
            fill: #2E7D32;
        }

        .admin-reset ul.ar-rules {
            margin: 8px 0 0;
            padding: 0;
            list-style: none;
            font-size: 10.5px;
            line-height: 1.8;
            color: #6B7280;
        }

        .admin-reset ul.ar-rules li {
            position: relative;
            padding-left: 12px;
        }

        .admin-reset ul.ar-rules li::before {
            content: "";
            position: absolute;
            left: 2px;
            top: 50%;
            width: 4px;
            height: 4px;
            margin-top: -2px;
            border-radius: 50%;
            background: #9CA3AF;
        }

        /* Validators use Display="Dynamic", so they take no space until shown and
           the card simply grows. They sit after .ar-input-wrap, so they can never
           overlap the lock icon or the eye toggle. */
        .admin-reset .field-error {
            display: block;
            margin-top: 4px;
            font-size: 12px;
            line-height: 1.35;
            color: #C0392B;
            text-align: left;
        }

        /* Invalid-field red border - same :has() approach as the other pages.
           The :focus variant is more specific than input.ar-input:focus, so the
           green ring cannot override the red border. */
        .admin-reset .ar-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input.ar-input {
            border-color: #C0392B;
        }

        .admin-reset .ar-field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input.ar-input:focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .15);
        }

        .admin-reset .summary-error {
            margin: 0 0 4px;
            font-size: 11px;
            line-height: 1.4;
            color: #C0392B;
            text-align: center;
        }

        .admin-reset .summary-error:empty {
            display: none;
        }

        .admin-reset input.ar-btn {
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

        .admin-reset input.ar-btn:hover,
        .admin-reset input.ar-btn:focus {
            background: #256B29;
            color: #fff;
        }

        .admin-reset p.ar-foot {
            margin: 20px 0 0;
            font-size: 14px;
            text-align: center;
            color: #55655C;
        }

        .admin-reset p.ar-foot a {
            font-size: 14px;
            font-weight: 600;
            color: #2E7D32;
            text-decoration: none;
        }

        .admin-reset p.ar-foot a:hover,
        .admin-reset p.ar-foot a:focus {
            text-decoration: underline;
        }

        @media screen and (max-width: 480px) {
            .admin-reset .ar-page {
                padding-left: 0;
                padding-right: 0;
            }

            .admin-reset .ar-card {
                max-width: none;
                margin: 0 16px;
                padding: 28px 20px;
            }
        }

        @media screen and (max-width: 420px) {
            .admin-reset .ar-card {
                padding: 26px 20px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-reset">
            <div class="ar-page">
                <div class="ar-card">

                    <div class="ar-brand">
                        <span class="ar-brand-name">Sabzify</span>
                        <span class="ar-brand-tag">Admin</span>
                    </div>

                    <div class="ar-icon-bubble">
                        <svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z" />
                        </svg>
                    </div>

                    <h1 class="ar-title">Set a New Password</h1>
                    <p class="ar-subtitle">Your new password must be different from your previous password.</p>

                    <div class="ar-field">
                        <asp:Label ID="lblNewPassword" runat="server" AssociatedControlID="txtNewPassword" CssClass="ar-label" Text="New Password" />
                        <div class="ar-input-wrap">
                            <svg class="ar-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z" />
                            </svg>
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="ar-input" placeholder="Create a strong password" autocomplete="new-password" />
                            <button type="button" class="ar-eye" data-target="txtNewPassword" aria-label="Show password" aria-pressed="false">
                                <svg class="ar-eye-on" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z" /></svg>
                                <svg class="ar-eye-off" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 7c2.76 0 5 2.24 5 5 0 .65-.13 1.26-.36 1.83l2.92 2.92c1.51-1.26 2.7-2.89 3.43-4.75-1.73-4.39-6-7.5-11-7.5-1.4 0-2.74.25-3.98.7l2.16 2.16C10.74 7.13 11.35 7 12 7zM2 4.27l2.28 2.28.46.46A11.8 11.8 0 0 0 1 12c1.73 4.39 6 7.5 11 7.5 1.55 0 3.03-.3 4.38-.84l.42.42L19.73 22 21 20.73 3.27 3 2 4.27zM7.53 9.8l1.55 1.55c-.05.21-.08.43-.08.65 0 1.66 1.34 3 3 3 .22 0 .44-.03.65-.08l1.55 1.55c-.67.33-1.41.53-2.2.53-2.76 0-5-2.24-5-5 0-.79.2-1.53.53-2.2zm4.31-.78 3.15 3.15.02-.16c0-1.66-1.34-3-3-3l-.17.01z" /></svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword"
                            Text="Password is required" ValidationGroup="AdminReset" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:RegularExpressionValidator ID="revNewPassword" runat="server" ControlToValidate="txtNewPassword"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
                            Text="Min 8 characters with uppercase, lowercase and a number" ValidationGroup="AdminReset" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <ul class="ar-rules">
                            <li>At least 8 characters</li>
                            <li>One uppercase and one lowercase letter</li>
                            <li>At least one number</li>
                        </ul>
                    </div>

                    <div class="ar-field">
                        <asp:Label ID="lblConfirmPassword" runat="server" AssociatedControlID="txtConfirmPassword" CssClass="ar-label" Text="Confirm New Password" />
                        <div class="ar-input-wrap">
                            <svg class="ar-input-icon" viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z" />
                            </svg>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="ar-input" placeholder="Re-enter your password" autocomplete="new-password" />
                            <button type="button" class="ar-eye" data-target="txtConfirmPassword" aria-label="Show password" aria-pressed="false">
                                <svg class="ar-eye-on" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z" /></svg>
                                <svg class="ar-eye-off" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 7c2.76 0 5 2.24 5 5 0 .65-.13 1.26-.36 1.83l2.92 2.92c1.51-1.26 2.7-2.89 3.43-4.75-1.73-4.39-6-7.5-11-7.5-1.4 0-2.74.25-3.98.7l2.16 2.16C10.74 7.13 11.35 7 12 7zM2 4.27l2.28 2.28.46.46A11.8 11.8 0 0 0 1 12c1.73 4.39 6 7.5 11 7.5 1.55 0 3.03-.3 4.38-.84l.42.42L19.73 22 21 20.73 3.27 3 2 4.27zM7.53 9.8l1.55 1.55c-.05.21-.08.43-.08.65 0 1.66 1.34 3 3 3 .22 0 .44-.03.65-.08l1.55 1.55c-.67.33-1.41.53-2.2.53-2.76 0-5-2.24-5-5 0-.79.2-1.53.53-2.2zm4.31-.78 3.15 3.15.02-.16c0-1.66-1.34-3-3-3l-.17.01z" /></svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            Text="Please confirm your password" ValidationGroup="AdminReset" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                        <asp:CompareValidator ID="cvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtNewPassword" Operator="Equal" Type="String"
                            Text="Passwords do not match" ValidationGroup="AdminReset" Display="Dynamic"
                            CssClass="field-error" SetFocusOnError="true" />
                    </div>

                    <%-- Validators use Text only (no ErrorMessage) so field errors are not
                         duplicated here; this is reserved for server-side messages.
                         EnableClientScript="false" keeps it hidden on client-side failures. --%>
                    <asp:ValidationSummary ID="vsAdminReset" runat="server" ValidationGroup="AdminReset"
                        DisplayMode="SingleParagraph" HeaderText="" ShowMessageBox="false"
                        EnableClientScript="false" CssClass="summary-error" />

                    <asp:Button ID="btnResetPassword" runat="server" CssClass="ar-btn"
                        Text="Reset Password &#8594;" ValidationGroup="AdminReset"
                        PostBackUrl="~/Admin/Login.aspx" />

                    <p class="ar-foot"><a href="Login.aspx">&#8592; Back to Admin Login</a></p>

                </div>
            </div>
        </div>
    </form>

    <%-- UI only, no validation: flips the rendered input between password and
         plain text. --%>
    <script>
        (function () {
            var toggles = document.querySelectorAll('.admin-reset .ar-eye');
            Array.prototype.forEach.call(toggles, function (btn) {
                btn.addEventListener('click', function () {
                    var input = document.getElementById(btn.getAttribute('data-target'));
                    var show = input.getAttribute('type') === 'password';
                    input.setAttribute('type', show ? 'text' : 'password');
                    btn.classList.toggle('is-on', show);
                    btn.setAttribute('aria-pressed', show ? 'true' : 'false');
                    btn.setAttribute('aria-label', show ? 'Hide password' : 'Show password');
                });
            });
        })();
    </script>
</body>
</html>
