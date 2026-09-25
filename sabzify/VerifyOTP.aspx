<%@ Page Title="Verify OTP" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VerifyOTP.aspx.cs" Inherits="sabzify.VerifyOTP" UnobtrusiveValidationMode="None" %>

<asp:Content ID="VerifyOTPContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles: served with the page HTML, so they never depend on a
         cached copy of /Content/Site.css. Every selector starts with .otp-page. --%>
    <style>
        .otp-page .auth-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 70vh;
            padding: 40px 16px;
            background: #F1F8E4;
        }

        .otp-page .auth-page .auth-card {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
            padding: 32px;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 8px 30px rgba(26, 43, 32, .08);
        }

        .otp-page .auth-card .auth-brand {
            justify-content: center;
            margin: 0 0 20px;
        }

        .otp-page .auth-card .auth-brand-name {
            font-size: 22px;
            font-weight: 700;
            color: #1B6E2A;
        }

        .otp-page .auth-card h1.auth-title {
            margin: 0 0 6px;
            font-size: 22px;
            font-weight: 600;
            line-height: 1.3;
            text-align: center;
            color: #1A2B20;
        }

        .otp-page .auth-card p.auth-subtitle {
            margin: 0;
            font-size: 14px;
            line-height: 1.5;
            text-align: center;
            color: #6B7280;
        }

        .otp-page .auth-card .otp-number {
            font-weight: 700;
            color: #1A2B20;
        }

        .otp-page .otp-row {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            justify-content: center;
            gap: 10px;
            margin: 24px 0;
        }

        /* Each box sits in .otp-cell with its two validators (Display="Dynamic",
           empty text), so the cell is exactly one box wide. */
        .otp-page .otp-row .otp-cell {
            flex: 0 0 48px;
            min-width: 0;
        }

        .otp-page .otp-row .field-error {
            margin: 0;
        }

        .otp-page .otp-row input.otp-box {
            display: block;
            width: 48px;
            min-width: 48px;
            max-width: 48px;
            height: 52px;
            flex: 0 0 48px;
            padding: 0;
            margin: 0;
            text-align: center;
            font-size: 20px;
            font-weight: 600;
            color: #1A2B20;
            border: 1px solid #D9DED6;
            border-radius: 10px;
            background: #fff;
            box-shadow: none;
            box-sizing: border-box;
        }

        .otp-page .otp-row input.otp-box:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, .15);
        }

        .otp-page .otp-cell:has(.field-error:not([style*="display:none"]):not([style*="display: none"])) input.otp-box {
            border-color: #C0392B;
        }

        /* The ValidationSummary renders style="display:none" while valid, so it
           takes no space until it shows. */
        .otp-page .auth-card .form-error {
            margin: -12px 0 12px;
            font-size: 13px;
            line-height: 1.35;
            text-align: center;
            color: #C0392B;
        }

        .otp-page .auth-card input.auth-btn {
            width: 100%;
            max-width: none;
            margin-top: 0;
        }

        .otp-page .auth-card p.auth-foot {
            margin: 16px 0 0;
            font-size: 14px;
            text-align: center;
            white-space: nowrap;
            color: #1A2B20;
        }

        .otp-page .auth-card button.resend-btn {
            background: none;
            border: 0;
            padding: 0;
            font: inherit;
            font-size: 14px;
            font-weight: 400;
            color: #4CAF50;
            cursor: default;
            opacity: 1;
            text-decoration: none;
        }

        .otp-page .auth-card button.resend-btn:not(:disabled) {
            cursor: pointer;
            font-weight: 600;
        }

        .otp-page .auth-card button.resend-btn:not(:disabled):hover,
        .otp-page .auth-card button.resend-btn:not(:disabled):focus {
            color: #2E7D32;
            text-decoration: underline;
        }

        @media screen and (max-width: 480px) {
            .otp-page .auth-page {
                padding-left: 0;
                padding-right: 0;
            }

            .otp-page .auth-page .auth-card {
                max-width: none;
                margin: 0 16px;
                padding: 28px 20px;
            }

            .otp-page .otp-row {
                gap: 8px;
            }

            .otp-page .otp-row .otp-cell {
                flex: 0 0 40px;
            }

            .otp-page .otp-row input.otp-box {
                width: 40px;
                min-width: 40px;
                max-width: 40px;
                height: 46px;
                flex: 0 0 40px;
                font-size: 18px;
            }

            .otp-page .auth-card p.auth-foot {
                white-space: normal;
            }
        }
    </style>

    <div class="otp-page">
    <div class="auth-page auth-page--otp">
        <div class="auth-card auth-card--otp">

            <div class="auth-brand">
                <span class="auth-brand-name">Sabzify</span>
            </div>

            <h1 class="auth-title">Verify Your Mobile</h1>
            <p class="auth-subtitle">Enter the 6-digit code sent to<br /><strong class="otp-number">+91 98765 43210</strong></p>

            <%-- Each box is wrapped in .otp-cell with its own validators, so the
                 :has() red-border rule can target just the invalid box. The
                 validators render empty (ErrorMessage="") - the one message comes
                 from the ValidationSummary header below. --%>
            <div class="otp-row" id="otpRow">

                <div class="otp-cell">
                    <asp:TextBox ID="txtOtp1" runat="server" CssClass="otp-box" MaxLength="1" inputmode="numeric" autocomplete="one-time-code" aria-label="Digit 1" />
                    <asp:RequiredFieldValidator ID="rfvOtp1" runat="server" ControlToValidate="txtOtp1" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                    <asp:RegularExpressionValidator ID="revOtp1" runat="server" ControlToValidate="txtOtp1" ValidationExpression="^\d$" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                </div>

                <div class="otp-cell">
                    <asp:TextBox ID="txtOtp2" runat="server" CssClass="otp-box" MaxLength="1" inputmode="numeric" aria-label="Digit 2" />
                    <asp:RequiredFieldValidator ID="rfvOtp2" runat="server" ControlToValidate="txtOtp2" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                    <asp:RegularExpressionValidator ID="revOtp2" runat="server" ControlToValidate="txtOtp2" ValidationExpression="^\d$" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                </div>

                <div class="otp-cell">
                    <asp:TextBox ID="txtOtp3" runat="server" CssClass="otp-box" MaxLength="1" inputmode="numeric" aria-label="Digit 3" />
                    <asp:RequiredFieldValidator ID="rfvOtp3" runat="server" ControlToValidate="txtOtp3" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                    <asp:RegularExpressionValidator ID="revOtp3" runat="server" ControlToValidate="txtOtp3" ValidationExpression="^\d$" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                </div>

                <div class="otp-cell">
                    <asp:TextBox ID="txtOtp4" runat="server" CssClass="otp-box" MaxLength="1" inputmode="numeric" aria-label="Digit 4" />
                    <asp:RequiredFieldValidator ID="rfvOtp4" runat="server" ControlToValidate="txtOtp4" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                    <asp:RegularExpressionValidator ID="revOtp4" runat="server" ControlToValidate="txtOtp4" ValidationExpression="^\d$" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                </div>

                <div class="otp-cell">
                    <asp:TextBox ID="txtOtp5" runat="server" CssClass="otp-box" MaxLength="1" inputmode="numeric" aria-label="Digit 5" />
                    <asp:RequiredFieldValidator ID="rfvOtp5" runat="server" ControlToValidate="txtOtp5" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                    <asp:RegularExpressionValidator ID="revOtp5" runat="server" ControlToValidate="txtOtp5" ValidationExpression="^\d$" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                </div>

                <div class="otp-cell">
                    <asp:TextBox ID="txtOtp6" runat="server" CssClass="otp-box" MaxLength="1" inputmode="numeric" aria-label="Digit 6" />
                    <asp:RequiredFieldValidator ID="rfvOtp6" runat="server" ControlToValidate="txtOtp6" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                    <asp:RegularExpressionValidator ID="revOtp6" runat="server" ControlToValidate="txtOtp6" ValidationExpression="^\d$" ErrorMessage="" Display="Dynamic" CssClass="field-error otp-error" ValidationGroup="Otp" />
                </div>

            </div>

            <asp:ValidationSummary ID="vsOtp" runat="server"
                ValidationGroup="Otp"
                DisplayMode="SingleParagraph"
                HeaderText="Enter the complete 6-digit code"
                ShowMessageBox="false"
                CssClass="form-error" />

            <asp:Button ID="btnVerify" runat="server"
                CssClass="auth-btn"
                Text="Verify &amp; Proceed"
                ValidationGroup="Otp" />

            <p class="auth-foot">Didn't receive the code?
                <button type="button" class="otp-resend resend-btn" id="btnResendOtp" disabled="disabled">Resend OTP (00:30)</button>
            </p>

        </div>
    </div>
    </div>

    <script type="text/javascript">
        (function () {
            var boxes = document.querySelectorAll('#otpRow .otp-box');

            // Let ASP.NET validators re-check a box after its value is set from script.
            function notifyChange(box) {
                var evt = document.createEvent('HTMLEvents');
                evt.initEvent('change', true, false);
                box.dispatchEvent(evt);
            }

            for (var i = 0; i < boxes.length; i++) {
                (function (index) {
                    var box = boxes[index];

                    box.addEventListener('input', function () {
                        if (/^\d$/.test(box.value) && index < boxes.length - 1) {
                            boxes[index + 1].focus();
                            boxes[index + 1].select();
                        }
                    });

                    box.addEventListener('keydown', function (e) {
                        if ((e.key === 'Backspace' || e.keyCode === 8) && box.value === '' && index > 0) {
                            e.preventDefault();
                            boxes[index - 1].focus();
                            boxes[index - 1].select();
                        }
                    });

                    box.addEventListener('paste', function (e) {
                        var text = (e.clipboardData || window.clipboardData).getData('text') || '';
                        var digits = text.replace(/\s/g, '');
                        if (!/^\d{6}$/.test(digits)) { return; }
                        e.preventDefault();
                        for (var j = 0; j < boxes.length; j++) {
                            boxes[j].value = digits.charAt(j);
                            notifyChange(boxes[j]);
                        }
                        boxes[boxes.length - 1].focus();
                    });
                })(i);
            }

            // Resend countdown: 00:30 -> 00:00, then becomes a clickable link.
            var resend = document.getElementById('btnResendOtp');
            var seconds = 30;

            function render() {
                var ss = seconds < 10 ? '0' + seconds : '' + seconds;
                resend.textContent = 'Resend OTP (00:' + ss + ')';
            }

            render();
            var timer = setInterval(function () {
                seconds--;
                if (seconds <= 0) {
                    clearInterval(timer);
                    resend.textContent = 'Resend OTP';
                    resend.disabled = false;
                    return;
                }
                render();
            }, 1000);
        })();
    </script>

</asp:Content>
