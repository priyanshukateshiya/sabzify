<%@ Page Title="Admin Login" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="sabzify.Admin.Login" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Login</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
        }

        body {
            background: #F7FAFD;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", "Noto Sans", "Liberation Sans", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
            color: #111827;
        }

        .admin-login {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            box-sizing: border-box;
        }

        .admin-login *,
        .admin-login *::before,
        .admin-login *::after {
            box-sizing: border-box;
        }

        .admin-login .al-card {
            width: 100%;
            max-width: 380px;
            background: #fff;
            border: 1px solid #EDF1F5;
            border-radius: 12px;
            padding: 32px 28px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
        }

        .admin-login .al-brand {
            margin: 0 0 8px;
            font-size: 24px;
            font-weight: 700;
            line-height: 1.2;
            color: #1B7A3A;
            text-align: center;
        }

        .admin-login .al-title {
            margin: 0 0 4px;
            font-size: 15px;
            font-weight: 600;
            line-height: 1.3;
            color: #111827;
            text-align: center;
        }

        .admin-login .al-sub {
            margin: 0 0 24px;
            font-size: 11.5px;
            line-height: 1.4;
            color: #6B7280;
            text-align: center;
        }

        .admin-login .field {
            margin-bottom: 16px;
        }

        .admin-login .field label {
            display: block;
            margin-bottom: 5px;
            font-size: 11px;
            font-weight: 600;
            color: #374151;
        }

        .admin-login .input-wrap {
            position: relative;
        }

        .admin-login .input-wrap svg {
            position: absolute;
            left: 12px;
            top: 50%;
            width: 15px;
            height: 15px;
            transform: translateY(-50%);
            color: #9CA3AF;
            pointer-events: none;
        }

        .admin-login .field input {
            display: block;
            width: 100%;
            height: 38px;
            margin: 0;
            padding: 0 12px 0 36px;
            border: 1px solid #E1E6EA;
            border-radius: 6px;
            background: #fff;
            font-family: inherit;
            font-size: 12.5px;
            color: #111827;
            outline: none;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .admin-login .field input::placeholder {
            color: #9CA3AF;
        }

        .admin-login .field input:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .12);
        }

        /* Validators render with an inline display style (none / inline), so
           force the visible ones onto their own line under the input. */
        .admin-login .field-error {
            display: block;
            margin-top: 4px;
            font-size: 11px;
            line-height: 1.35;
            color: #C0392B;
            text-align: left;
        }

        .admin-login .field-error:not([style*="display:none"]):not([style*="display: none"]) {
            display: block !important;
        }

        /* Invalid-field red border - same :has() approach as Register.aspx.
           Listed after :focus so the green ring never wins on an invalid field. */
        .admin-login .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input,
        .admin-login .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input:focus {
            border-color: #C0392B;
        }

        .admin-login .field:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input:focus {
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .12);
        }

        .admin-login .al-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin: 6px 0 20px;
        }

        .admin-login .al-remember {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 11px;
            color: #6B7280;
            white-space: nowrap;
        }

        .admin-login .al-remember input {
            width: 13px;
            height: 13px;
            margin: 0;
            accent-color: #1B7A3A;
            cursor: pointer;
        }

        .admin-login .al-remember label {
            cursor: pointer;
        }

        .admin-login .al-forgot {
            font-size: 11px;
            font-weight: 600;
            color: #1B7A3A;
            text-decoration: none;
            white-space: nowrap;
        }

        .admin-login .al-forgot:hover {
            text-decoration: underline;
        }

        .admin-login .summary-error {
            margin: 0 0 12px;
            font-size: 11px;
            line-height: 1.4;
            color: #C0392B;
            text-align: center;
        }

        .admin-login .summary-error:empty {
            display: none;
        }

        .admin-login .al-btn {
            display: block;
            width: 100%;
            height: 38px;
            margin: 0;
            border: 0;
            border-radius: 6px;
            background: #1B7A3A;
            color: #fff;
            font-family: inherit;
            font-size: 12.5px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color .15s ease;
        }

        .admin-login .al-btn:hover {
            background: #166A32;
        }

        @media (max-width: 420px) {
            .admin-login .al-card {
                padding: 26px 20px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-login">
            <div class="al-card">
                <h1 class="al-brand">Sabzify</h1>
                <h2 class="al-title">Admin Login</h2>
                <p class="al-sub">Secure access for management</p>

                <div class="field">
                    <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email Address" />
                    <div class="input-wrap">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <rect x="3" y="5" width="18" height="14" rx="2" />
                            <path d="M3 7l9 6 9-6" />
                        </svg>
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="admin@sabzify.com" autocomplete="username" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        Text="Email is required" ValidationGroup="AdminLogin" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        Text="Enter a valid email" ValidationGroup="AdminLogin" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                </div>

                <div class="field">
                    <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="Password" />
                    <div class="input-wrap">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <rect x="4" y="11" width="16" height="10" rx="2" />
                            <path d="M8 11V7a4 4 0 0 1 8 0v4" />
                            <circle cx="12" cy="16" r="1" />
                        </svg>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;" autocomplete="current-password" />
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                        Text="Password is required" ValidationGroup="AdminLogin" Display="Dynamic"
                        CssClass="field-error" SetFocusOnError="true" />
                </div>

                <div class="al-row">
                    <asp:CheckBox ID="chkRemember" runat="server" Text="Remember me" CssClass="al-remember" />
                    <a class="al-forgot" href="ForgotPassword.aspx">Forgot password?</a>
                </div>

                <%-- Validators use Text only (no ErrorMessage) so field errors are not
                     duplicated here; this is reserved for server-side messages such as
                     "Invalid credentials". EnableClientScript="false" keeps it hidden on
                     client-side validation failures. --%>
                <asp:ValidationSummary ID="vsAdminLogin" runat="server" ValidationGroup="AdminLogin"
                    DisplayMode="SingleParagraph" HeaderText="" ShowMessageBox="false"
                    EnableClientScript="false" CssClass="summary-error" />

                <asp:Button ID="btnAdminLogin" runat="server" Text="Login as Admin &#8594;"
                    ValidationGroup="AdminLogin" CssClass="al-btn"
                    PostBackUrl="~/Admin/Dashboard.aspx" />
            </div>
        </div>
    </form>
</body>
</html>
