<%@ Page Title="Order Confirmation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="sabzify.OrderConfirmation" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="OrderConfirmationContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .oc-page (the page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.oc-page) {
            background: #FFFFFF;
        }

        .oc-page {
            max-width: 560px;
            margin: 0 auto;
            padding: 48px 24px 64px;
            text-align: center;
            color: #111827;
        }

        /* Success icon ----------------------------------------------------- */
        .oc-page .oc-check {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 56px;
            height: 56px;
            margin: 0 auto 24px;
            border-radius: 50%;
            background: #1B9E4B;
            box-shadow: 0 0 0 8px rgba(27, 158, 75, .10);
        }

        .oc-page .oc-check svg {
            width: 28px;
            height: 28px;
            fill: none;
            stroke: #FFFFFF;
            stroke-width: 2.5;
            stroke-linecap: round;
            stroke-linejoin: round;
        }

        /* Heading ---------------------------------------------------------- */
        .oc-page h1.oc-title {
            margin: 0 0 14px;
            font-size: 30px;
            font-weight: 700;
            line-height: 1.25;
            color: #1B7A3A;
        }

        .oc-page .oc-sub {
            max-width: 420px;
            margin: 0 auto 32px;
            font-size: 13px;
            line-height: 1.7;
            color: #6B7280;
        }

        /* Details block ---------------------------------------------------- */
        .oc-page .oc-details {
            display: flex;
            gap: 16px;
            margin-bottom: 32px;
            text-align: left;
        }

        .oc-page .oc-col-left,
        .oc-page .oc-col-right {
            display: flex;
            flex-direction: column;
            gap: 14px;
            min-width: 0;
        }

        .oc-page .oc-col-left {
            flex: 0 0 280px;
        }

        .oc-page .oc-col-right {
            flex: 1 1 auto;
        }

        .oc-page .oc-card {
            padding: 14px 16px;
            border: 1px solid #E8EDE9;
            border-radius: 10px;
            background: #FFFFFF;
        }

        .oc-page .oc-card-head {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .oc-page .oc-card-head svg {
            flex: none;
            width: 16px;
            height: 16px;
            fill: #1B6E2A;
        }

        .oc-page .oc-label {
            font-size: 10px;
            letter-spacing: .04em;
            text-transform: uppercase;
            color: #6B7280;
        }

        .oc-page .oc-value {
            margin-top: 4px;
            font-size: 14px;
            font-weight: 600;
            color: #111827;
        }

        .oc-page .oc-note {
            margin-top: 4px;
            font-size: 11px;
            color: #6B7280;
        }

        /* Total card ------------------------------------------------------- */
        .oc-page .oc-card-total {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            border: none;
            background: #EAF7EE;
        }

        .oc-page .oc-total-amount {
            flex: none;
            font-size: 17px;
            font-weight: 700;
            color: #1B7A3A;
        }

        /* Track Order button ----------------------------------------------- */
        .oc-page .oc-track {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 220px;
            height: 40px;
            padding: 0;
            border: none;
            border-radius: 999px;
            background: #1B7A3A;
            box-shadow: 0 6px 18px rgba(27, 122, 58, .28);
            color: #FFFFFF;
            font-family: inherit;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        .oc-page .oc-track:hover {
            background: #166A32;
        }

        /* Responsive ------------------------------------------------------- */
        @media (max-width: 768px) {
            .oc-page .oc-details {
                display: block;
            }

            .oc-page .oc-col-left {
                margin-bottom: 14px;
            }

            .oc-page h1.oc-title {
                font-size: 26px;
            }
        }

        @media (max-width: 480px) {
            .oc-page {
                padding: 32px 16px;
            }

            .oc-page h1.oc-title {
                font-size: 22px;
            }
        }
    </style>

    <div class="oc-page">

        <div class="oc-check">
            <svg viewBox="0 0 24 24" aria-hidden="true">
                <path d="M4 12.5 9.5 18 20 7" />
            </svg>
        </div>

        <h1 class="oc-title">Order Placed<br />Successfully!</h1>

        <p class="oc-sub">Thank you for choosing Sabzify. Your fresh produce is being prepared with care and will be on its way to you soon.</p>

        <div class="oc-details">

            <div class="oc-col-left">

                <div class="oc-card">
                    <div class="oc-card-head">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M6 2h8l4 4v16H6V2zm7 1.5V7h3.5L13 3.5zM8.5 11h7v1.5h-7V11zm0 3.5h7V16h-7v-1.5zm0 3.5h4.5v1.5H8.5V18z" />
                        </svg>
                        <span class="oc-label">Order Number</span>
                    </div>
                    <div class="oc-value">OR62051</div>
                </div>

                <div class="oc-card">
                    <div class="oc-card-head">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M3 5h18a1 1 0 0 1 1 1v3H2V6a1 1 0 0 1 1-1zM2 11h20v7a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-7zm3 4v2h5v-2H5z" />
                        </svg>
                        <span class="oc-label">Payment Method</span>
                    </div>
                    <div class="oc-value">UPI</div>
                </div>

            </div>

            <div class="oc-col-right">

                <div class="oc-card">
                    <div class="oc-card-head">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M12 2a7 7 0 0 0-7 7c0 5.2 7 13 7 13s7-7.8 7-13a7 7 0 0 0-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z" />
                        </svg>
                        <span class="oc-label">Delivery Address</span>
                    </div>
                    <div class="oc-value">Rajkot, Gujarat</div>
                    <div class="oc-note">Expected delivery today by 5:00 PM</div>
                </div>

                <div class="oc-card oc-card-total">
                    <div class="oc-card-head">
                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <path d="M3 6a2 2 0 0 1 2-2h11v2H5v12h14v-3h2v3a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V6zm13 4h6v4h-6a2 2 0 0 1 0-4zm1.5 1.4a.9.9 0 1 0 0 1.8.9.9 0 0 0 0-1.8z" />
                        </svg>
                        <span class="oc-label">Total Amount</span>
                    </div>
                    <div class="oc-total-amount">&#8377;850.00</div>
                </div>

            </div>

        </div>

        <%-- No form fields on this page, so no validators are needed. The button
             skips validation and has no handler yet; a tracking page comes later. --%>
        <asp:Button ID="btnTrackOrder" runat="server"
            Text="Track Order &#8594;"
            CssClass="oc-track"
            CausesValidation="false"
            PostBackUrl="~/TrackOrder.aspx" />

    </div>

</asp:Content>
