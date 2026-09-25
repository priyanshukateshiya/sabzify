<%@ Page Title="Track Your Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrackOrder.aspx.cs" Inherits="sabzify.TrackOrder" UnobtrusiveValidationMode="None" ResponseEncoding="utf-8" %>

<asp:Content ID="TrackOrderContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .track-page (the page
         background is the one exception: it has to reach .site-main). --%>
    <style>
        .site-main:has(.track-page) {
            background: #F7FAFC;
        }

        .track-page {
            max-width: 1100px;
            margin: 0 auto;
            padding: 32px 24px 56px;
            color: #111827;
        }

        /* Page header ------------------------------------------------------ */
        .track-page .track-head {
            margin-bottom: 24px;
        }

        .track-page h1.track-title {
            margin: 0 0 4px;
            font-size: 30px;
            font-weight: 700;
            color: #111827;
        }

        .track-page .track-order-no {
            margin: 0;
            font-size: 12px;
            color: #6B7280;
        }

        /* Two-column shell ------------------------------------------------- */
        .track-page .track-cols {
            display: flex;
            align-items: flex-start;
            gap: 20px;
        }

        .track-page .track-main {
            flex: 1 1 auto;
            min-width: 0;
        }

        .track-page .track-side {
            display: flex;
            flex: 0 0 330px;
            flex-direction: column;
            gap: 16px;
            min-width: 0;
        }

        .track-page .track-card {
            border: 1px solid #E8EDF2;
            border-radius: 10px;
            background: #FFFFFF;
        }

        /* Status card ------------------------------------------------------ */
        .track-page .track-status {
            min-height: 190px;
            padding: 24px;
        }

        .track-page .track-eta {
            margin: 0 0 32px;
            font-size: 16px;
            font-weight: 600;
            color: #111827;
        }

        /* Progress tracker -------------------------------------------------
           The two connector bars are inset by half a circle on each side so
           the line runs from the first circle's centre to the last one's. */
        .track-page .track-steps {
            position: relative;
            display: flex;
            justify-content: space-between;
        }

        .track-page .track-line,
        .track-page .track-line-done {
            position: absolute;
            top: 14px;
            left: 15px;
            right: 15px;
            height: 2px;
            background: #E3E8E4;
        }

        .track-page .track-line-done {
            right: auto;
            width: calc((100% - 30px) * .75);
            background: #1B7A3A;
        }

        .track-page .track-step {
            position: relative;
            z-index: 1;
            flex: 1 1 0;
            text-align: center;
        }

        .track-page .track-dot {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            margin: 0 auto;
            border-radius: 50%;
            background: #1B7A3A;
        }

        .track-page .track-dot svg {
            width: 14px;
            height: 14px;
            fill: #FFFFFF;
        }

        .track-page .track-step--pending .track-dot {
            background: #D7DCD8;
        }

        .track-page .track-step--current .track-dot {
            border: 2px solid #1B7A3A;
            background: #FFFFFF;
            box-shadow: 0 0 0 4px rgba(27, 122, 58, .15);
        }

        .track-page .track-step--current .track-dot svg {
            fill: #1B7A3A;
        }

        .track-page .track-step-label {
            margin-top: 10px;
            font-size: 11px;
            font-weight: 600;
            color: #374151;
        }

        .track-page .track-step--current .track-step-label {
            color: #1B7A3A;
        }

        .track-page .track-step--pending .track-step-label {
            color: #9CA3AF;
        }

        .track-page .track-step-time {
            margin-top: 3px;
            font-size: 10px;
            color: #9CA3AF;
        }

        /* Side cards ------------------------------------------------------- */
        .track-page .track-side .track-card {
            padding: 18px;
        }

        .track-page .track-card-title {
            padding-bottom: 12px;
            margin-bottom: 14px;
            border-bottom: 1px solid #EEF1F4;
            font-size: 14px;
            font-weight: 600;
            color: #111827;
        }

        /* Delivery partner -------------------------------------------------- */
        .track-page .track-partner {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .track-page .track-avatar {
            flex: none;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: #E8EDE9;
        }

        .track-page .track-partner-name {
            flex: 1 1 auto;
            min-width: 0;
            font-size: 13px;
            font-weight: 500;
            color: #111827;
        }

        .track-page .track-call {
            display: flex;
            flex: none;
            align-items: center;
            justify-content: center;
            width: 34px;
            height: 34px;
            padding: 0;
            border: none;
            border-radius: 50%;
            background: #1B7A3A;
            cursor: pointer;
        }

        .track-page .track-call:hover {
            background: #166A32;
        }

        .track-page .track-call svg {
            width: 15px;
            height: 15px;
            fill: #FFFFFF;
        }

        /* Order summary ----------------------------------------------------- */
        .track-page .track-item {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 9px;
            font-size: 11px;
            color: #4B5563;
        }

        .track-page .track-item-amount {
            flex: none;
            font-weight: 600;
            color: #111827;
        }

        .track-page .track-divider {
            height: 1px;
            margin: 14px 0 12px;
            background: #EEF1F4;
        }

        .track-page .track-foot {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }

        .track-page .track-count {
            font-size: 11px;
            color: #6B7280;
        }

        .track-page .track-total {
            font-size: 17px;
            font-weight: 700;
            color: #1B7A3A;
        }

        /* Responsive -------------------------------------------------------- */
        @media (max-width: 1024px) {
            .track-page .track-side {
                flex-basis: 300px;
            }
        }

        @media (max-width: 768px) {
            .track-page .track-cols {
                display: block;
            }

            .track-page .track-side {
                margin-top: 16px;
            }

            .track-page h1.track-title {
                font-size: 24px;
            }

            .track-page .track-status {
                padding: 20px 14px;
            }

            .track-page .track-step {
                padding: 0 2px;
            }

            .track-page .track-step-label {
                font-size: 10px;
            }
        }

        @media (max-width: 480px) {
            .track-page .track-status {
                padding: 18px 10px;
            }

            .track-page .track-dot {
                width: 26px;
                height: 26px;
            }

            .track-page .track-dot svg {
                width: 12px;
                height: 12px;
            }

            .track-page .track-line,
            .track-page .track-line-done {
                top: 12px;
                left: 13px;
                right: 13px;
            }

            .track-page .track-line-done {
                right: auto;
                width: calc((100% - 26px) * .75);
            }

            .track-page .track-step {
                padding: 0 1px;
            }

            .track-page .track-step-label {
                font-size: 9px;
            }

            .track-page .track-step-time {
                display: none;
            }
        }
    </style>

    <div class="track-page">

        <div class="track-head">
            <h1 class="track-title">Track Your Order</h1>
            <p class="track-order-no">Order #SBZ-8924-M</p>
        </div>

        <div class="track-cols">

            <div class="track-main">
                <div class="track-card track-status">

                    <p class="track-eta">Arriving at 10:30 AM</p>

                    <div class="track-steps">
                        <span class="track-line"></span>
                        <span class="track-line-done"></span>

                        <div class="track-step">
                            <div class="track-dot">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M9.5 17.6 4 12l1.6-1.6 3.9 3.9L18.4 5.4 20 7z" />
                                </svg>
                            </div>
                            <div class="track-step-label">Order Placed</div>
                            <div class="track-step-time">08:15 AM</div>
                        </div>

                        <div class="track-step">
                            <div class="track-dot">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M9 2h6a1 1 0 0 1 1 1v1h2a1 1 0 0 1 1 1v16H5V5a1 1 0 0 1 1-1h2V3a1 1 0 0 1 1-1zm1 2v1h4V4zm-2 7h8v1.6H8zm0 4h8v1.6H8z" />
                                </svg>
                            </div>
                            <div class="track-step-label">Confirmed</div>
                            <div class="track-step-time">08:20 AM</div>
                        </div>

                        <div class="track-step">
                            <div class="track-dot">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M12 2 3 6v12l9 4 9-4V6zm0 2.2 6.3 2.8L12 9.8 5.7 7zM5 8.6l6 2.7v8.1l-6-2.7zm14 8.1-6 2.7v-8.1l6-2.7z" />
                                </svg>
                            </div>
                            <div class="track-step-label">Packing</div>
                            <div class="track-step-time">09:00 AM</div>
                        </div>

                        <div class="track-step track-step--current">
                            <div class="track-dot">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M3 5h11v10H3zm12 3h3.5l2.5 3v4h-6zM7 16a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm11 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4z" />
                                </svg>
                            </div>
                            <div class="track-step-label">Out for Delivery</div>
                            <div class="track-step-time">09:45 AM</div>
                        </div>

                        <div class="track-step track-step--pending">
                            <div class="track-dot">
                                <svg viewBox="0 0 24 24" aria-hidden="true">
                                    <path d="M12 3 3 10.5V21h6v-6h6v6h6V10.5z" />
                                </svg>
                            </div>
                            <div class="track-step-label">Delivered</div>
                        </div>

                    </div>

                </div>
            </div>

            <div class="track-side">

                <div class="track-card">
                    <div class="track-card-title">Delivery Partner</div>
                    <div class="track-partner">
                        <div class="track-avatar"></div>
                        <div class="track-partner-name">Pratik Nakum</div>
                        <%-- UI only: plain button, so it never posts back. --%>
                        <button type="button" class="track-call" aria-label="Call Pratik Nakum">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M6.6 10.8a15.1 15.1 0 0 0 6.6 6.6l2.2-2.2a1 1 0 0 1 1-.24 11.4 11.4 0 0 0 3.6.58 1 1 0 0 1 1 1V20a1 1 0 0 1-1 1A17 17 0 0 1 3 4a1 1 0 0 1 1-1h3.5a1 1 0 0 1 1 1 11.4 11.4 0 0 0 .58 3.6 1 1 0 0 1-.25 1z" />
                            </svg>
                        </button>
                    </div>
                </div>

                <div class="track-card">
                    <div class="track-card-title">Order Summary</div>

                    <div class="track-item">
                        <span>Fresh Farm Tomatoes (1kg)</span>
                        <span class="track-item-amount">&#8377;45</span>
                    </div>
                    <div class="track-item">
                        <span>Organic Spinach (500g)</span>
                        <span class="track-item-amount">&#8377;30</span>
                    </div>
                    <div class="track-item">
                        <span>Local Potatoes (2kg)</span>
                        <span class="track-item-amount">&#8377;60</span>
                    </div>

                    <div class="track-divider"></div>

                    <div class="track-foot">
                        <span class="track-count">Total Items: 3</span>
                        <span class="track-total">&#8377;135</span>
                    </div>
                </div>

            </div>

        </div>

    </div>

</asp:Content>
