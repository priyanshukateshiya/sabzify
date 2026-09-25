<%@ Page Title="Verify Admin Code" Language="C#" AutoEventWireup="true" CodeBehind="VerifyCode.aspx.cs" Inherits="sabzify.Admin.VerifyCode" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Verify Admin Code</title>
    <%-- Same design system as Admin/ForgotPassword.aspx, copied value for value.
         Every selector starts with .admin-verify. --%>
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

        .admin-verify *,
        .admin-verify *::before,
        .admin-verify *::after {
            box-sizing: border-box;
        }

        .admin-verify .av-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 40px 16px;
            background: #F3F8FD;
        }

        .admin-verify .av-card {
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
        .admin-verify .av-card::before {
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

        .admin-verify .av-brand {
            margin: 0;
            text-align: center;
        }

        .admin-verify .av-brand-name {
            display: block;
            font-size: 22px;
            font-weight: 700;
            letter-spacing: -.01em;
            color: #1B6E2A;
        }

        .admin-verify .av-brand-tag {
            display: block;
            margin-top: 2px;
            font-size: 11px;
            font-weight: 600;
            line-height: 1.3;
            letter-spacing: .06em;
            text-transform: uppercase;
            color: #6B7280;
        }

        .admin-verify .av-icon-bubble {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            margin: 16px auto 12px;
            border-radius: 50%;
            background: #E6F2E1;
        }

        .admin-verify .av-icon-bubble svg {
            display: block;
            width: 20px;
            height: 20px;
            fill: #2E7D32;
        }

        .admin-verify h1.av-title {
            margin: 0 0 8px;
            font-size: 24px;
            font-weight: 600;
            line-height: 1.3;
            text-align: center;
            color: #1A2B20;
        }

        .admin-verify p.av-subtitle {
            max-width: 280px;
            margin: 0 auto;
            font-size: 14px;
            line-height: 1.5;
            text-align: center;
            color: #6B7280;
        }

        .admin-verify .av-email {
            display: block;
            margin-top: 2px;
            font-size: 12px;
            font-weight: 600;
            color: #111827;
        }

        /* Six code boxes, always one row. The validators live outside the row
           (in .code-validators), so they can never wrap or push a box. */
        .admin-verify .code-row {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            justify-content: center;
            gap: 10px;
            margin: 22px 0;
        }

        .admin-verify .code-row input {
            display: block;
            width: 44px;
            min-width: 44px;
            max-width: 44px;
            height: 48px;
            flex: 0 0 44px;
            padding: 0;
            margin: 0;
            text-align: center;
            font-family: inherit;
            font-size: 18px;
            font-weight: 600;
            color: #1A2B20;
            border: 1px solid #E1E6EA;
            border-radius: 8px;
            background: #fff;
            box-sizing: border-box;
            outline: none;
            transition: border-color .15s ease, box-shadow .15s ease;
        }

        .admin-verify .code-row input:focus {
            border-color: #1B7A3A;
            box-shadow: 0 0 0 3px rgba(27, 122, 58, .12);
        }

        /* Empty validator spans (Display="Dynamic", no text): they take no space,
           but ASP.NET toggles their display, which :has() below reads. */
        .admin-verify .code-validators {
            height: 0;
            overflow: hidden;
            font-size: 0;
            line-height: 0;
        }

        /* Invalid-box red border - same :has() approach as the other pages. A
           box's two validators share the class .cv1 ... .cv6. The :focus variant
           keeps the green ring from overriding the red border. */
        .admin-verify .code-field:has(.cv1:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(1),
        .admin-verify .code-field:has(.cv2:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(2),
        .admin-verify .code-field:has(.cv3:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(3),
        .admin-verify .code-field:has(.cv4:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(4),
        .admin-verify .code-field:has(.cv5:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(5),
        .admin-verify .code-field:has(.cv6:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(6) {
            border-color: #C0392B;
        }

        .admin-verify .code-field:has(.cv1:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(1):focus,
        .admin-verify .code-field:has(.cv2:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(2):focus,
        .admin-verify .code-field:has(.cv3:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(3):focus,
        .admin-verify .code-field:has(.cv4:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(4):focus,
        .admin-verify .code-field:has(.cv5:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(5):focus,
        .admin-verify .code-field:has(.cv6:not([style*="display:none"]):not([style*="display: none"])) .code-row input:nth-child(6):focus {
            border-color: #C0392B;
            box-shadow: 0 0 0 3px rgba(192, 57, 43, .15);
        }

        .admin-verify .summary-error {
            margin: -12px 0 14px;
            font-size: 11px;
            line-height: 1.4;
            color: #C0392B;
            text-align: center;
        }

        .admin-verify .summary-error:empty {
            display: none;
        }

        .admin-verify input.av-btn {
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

        .admin-verify input.av-btn:hover,
        .admin-verify input.av-btn:focus {
            background: #256B29;
            color: #fff;
        }

        .admin-verify p.av-resend {
            margin: 16px 0 0;
            font-size: 11px;
            line-height: 1.5;
            text-align: center;
            color: #6B7280;
        }

        .admin-verify .av-resend-btn {
            padding: 0;
            margin: 0 0 0 2px;
            border: 0;
            background: none;
            font-family: inherit;
            font-size: 11px;
            font-weight: 600;
            color: #1B7A3A;
            cursor: pointer;
        }

        .admin-verify .av-resend-btn:hover {
            text-decoration: underline;
        }

        .admin-verify .av-resend-btn:disabled {
            color: #9CA3AF;
            text-decoration: none;
            cursor: default;
        }

        .admin-verify p.av-foot {
            margin: 20px 0 0;
            font-size: 14px;
            text-align: center;
            color: #55655C;
        }

        .admin-verify p.av-foot a {
            font-size: 14px;
            font-weight: 600;
            color: #2E7D32;
            text-decoration: none;
        }

        .admin-verify p.av-foot a:hover,
        .admin-verify p.av-foot a:focus {
            text-decoration: underline;
        }

        @media screen and (max-width: 480px) {
            .admin-verify .av-page {
                padding-left: 0;
                padding-right: 0;
            }

            .admin-verify .av-card {
                max-width: none;
                margin: 0 16px;
                padding: 28px 20px;
            }
        }

        @media screen and (max-width: 420px) {
            .admin-verify .av-card {
                padding: 26px 20px;
            }

            .admin-verify .code-row {
                gap: 8px;
            }

            .admin-verify .code-row input {
                width: 38px;
                min-width: 38px;
                max-width: 38px;
                height: 44px;
                flex: 0 0 38px;
            }
        }

        /* Very narrow phones: let the boxes shrink evenly so the row never
           wraps or overflows. */
        @media screen and (max-width: 360px) {
            .admin-verify .code-row {
                gap: 6px;
            }

            .admin-verify .code-row input {
                width: auto;
                min-width: 0;
                max-width: 38px;
                flex: 1 1 0;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-verify">
            <div class="av-page">
                <div class="av-card">

                    <div class="av-brand">
                        <span class="av-brand-name">Sabzify</span>
                        <span class="av-brand-tag">Admin</span>
                    </div>

                    <div class="av-icon-bubble">
                        <svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M18 21.99 14.5 18.49l1.41-1.41 2.12 2.12 4.24-4.24 1.41 1.41-5.68 5.62zM11 18H4V8l8 5 8-5v5h2V6c0-1.1-.9-2-2-2H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h7v-2zm9-12-8 5-8-5h16z" />
                        </svg>
                    </div>

                    <h1 class="av-title">Check Your Email</h1>
                    <p class="av-subtitle">
                        We've sent a 6-digit verification code to
                        <span class="av-email">admin@sabzify.com</span>
                    </p>

                    <div class="code-field">
                        <div class="code-row">
                            <asp:TextBox ID="txtCode1" runat="server" MaxLength="1" inputmode="numeric" autocomplete="one-time-code" aria-label="Digit 1" />
                            <asp:TextBox ID="txtCode2" runat="server" MaxLength="1" autocomplete="off" aria-label="Digit 2" />
                            <asp:TextBox ID="txtCode3" runat="server" MaxLength="1" autocomplete="off" aria-label="Digit 3" />
                            <asp:TextBox ID="txtCode4" runat="server" MaxLength="1" autocomplete="off" aria-label="Digit 4" />
                            <asp:TextBox ID="txtCode5" runat="server" MaxLength="1" autocomplete="off" aria-label="Digit 5" />
                            <asp:TextBox ID="txtCode6" runat="server" MaxLength="1" autocomplete="off" aria-label="Digit 6" />
                        </div>

                        <%-- Outside the flex row. No Text/ErrorMessage: the summary below is
                             the only message, shown once. Display="Dynamic" (not "None") so
                             ASP.NET toggles each span's display, which drives the red border. --%>
                        <div class="code-validators">
                            <asp:RequiredFieldValidator ID="rfvCode1" runat="server" ControlToValidate="txtCode1" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv1" />
                            <asp:RegularExpressionValidator ID="revCode1" runat="server" ControlToValidate="txtCode1" ValidationExpression="^\d$" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv1" />
                            <asp:RequiredFieldValidator ID="rfvCode2" runat="server" ControlToValidate="txtCode2" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv2" />
                            <asp:RegularExpressionValidator ID="revCode2" runat="server" ControlToValidate="txtCode2" ValidationExpression="^\d$" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv2" />
                            <asp:RequiredFieldValidator ID="rfvCode3" runat="server" ControlToValidate="txtCode3" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv3" />
                            <asp:RegularExpressionValidator ID="revCode3" runat="server" ControlToValidate="txtCode3" ValidationExpression="^\d$" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv3" />
                            <asp:RequiredFieldValidator ID="rfvCode4" runat="server" ControlToValidate="txtCode4" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv4" />
                            <asp:RegularExpressionValidator ID="revCode4" runat="server" ControlToValidate="txtCode4" ValidationExpression="^\d$" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv4" />
                            <asp:RequiredFieldValidator ID="rfvCode5" runat="server" ControlToValidate="txtCode5" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv5" />
                            <asp:RegularExpressionValidator ID="revCode5" runat="server" ControlToValidate="txtCode5" ValidationExpression="^\d$" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv5" />
                            <asp:RequiredFieldValidator ID="rfvCode6" runat="server" ControlToValidate="txtCode6" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv6" />
                            <asp:RegularExpressionValidator ID="revCode6" runat="server" ControlToValidate="txtCode6" ValidationExpression="^\d$" ErrorMessage="" ValidationGroup="AdminVerify" Display="Dynamic" CssClass="cv6" />
                        </div>
                    </div>

                    <asp:ValidationSummary ID="vsAdminVerify" runat="server" ValidationGroup="AdminVerify"
                        DisplayMode="SingleParagraph" HeaderText="Enter the complete 6-digit code"
                        ShowMessageBox="false" CssClass="summary-error" />

                    <asp:Button ID="btnVerifyCode" runat="server" CssClass="av-btn"
                        Text="Verify Code &#8594;" ValidationGroup="AdminVerify"
                        PostBackUrl="~/Admin/ResetPassword.aspx" />

                    <p class="av-resend">
                        Didn't receive the code?
                        <button type="button" id="btnResend" class="av-resend-btn" disabled="disabled">Resend Code (00:30)</button>
                    </p>

                    <p class="av-foot"><a href="Login.aspx">&#8592; Back to Admin Login</a></p>

                </div>
            </div>
        </div>
    </form>

    <%-- UI only, no validation: moves focus between the boxes, spreads a pasted
         code across them, and runs the resend countdown. --%>
    <script>
        (function () {
            var boxes = Array.prototype.slice.call(document.querySelectorAll('.admin-verify .code-row input'));

            boxes.forEach(function (box, i) {
                box.addEventListener('input', function () {
                    if (/^\d$/.test(box.value) && i < boxes.length - 1) {
                        boxes[i + 1].focus();
                        boxes[i + 1].select();
                    }
                });

                box.addEventListener('keydown', function (e) {
                    if (e.key === 'Backspace' && box.value === '' && i > 0) {
                        e.preventDefault();
                        boxes[i - 1].focus();
                        boxes[i - 1].value = '';
                    }
                });

                box.addEventListener('paste', function (e) {
                    var text = (e.clipboardData || window.clipboardData).getData('text') || '';
                    var digits = text.replace(/\D/g, '');
                    if (!digits) {
                        return;
                    }
                    e.preventDefault();
                    var start = digits.length >= boxes.length ? 0 : i;
                    for (var j = 0; j < digits.length && start + j < boxes.length; j++) {
                        boxes[start + j].value = digits.charAt(j);
                    }
                    boxes[Math.min(start + digits.length, boxes.length) - 1].focus();
                });
            });

            var resend = document.getElementById('btnResend');
            var timer = null;

            function startCountdown() {
                var left = 30;
                resend.disabled = true;
                resend.textContent = 'Resend Code (00:30)';
                clearInterval(timer);
                timer = setInterval(function () {
                    left--;
                    if (left <= 0) {
                        clearInterval(timer);
                        resend.disabled = false;
                        resend.textContent = 'Resend Code';
                        return;
                    }
                    resend.textContent = 'Resend Code (00:' + (left < 10 ? '0' : '') + left + ')';
                }, 1000);
            }

            resend.addEventListener('click', startCountdown);
            startCountdown();
        })();
    </script>
</body>
</html>
