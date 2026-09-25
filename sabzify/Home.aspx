<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="sabzify.Home" UnobtrusiveValidationMode="None" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- ================= Hero ================= --%>
    <div class="shell">
        <section class="hero">
        <div class="hero-media" aria-hidden="true"></div>
        <div class="hero-content">
            <h1 class="hero-title">Fresh Vegetables,<br />Delivered to Your Door</h1>
            <p class="hero-text">Farm-fresh vegetables at affordable prices. Delivered straight to your home in Rajkot.</p>
            <a class="btn btn-leaf hero-btn" href="#">Shop Now</a>
        </div>
        </section>
    </div>

    <%-- ================= Shop by Category ================= --%>
    <section class="shell section">
        <div class="section-head">
            <h2 class="section-title">Shop by Category</h2>
            <a class="view-all" href="#">View All &#8594;</a>
        </div>

        <div class="cat-grid">

            <a class="cat-card" href="#">
                <span class="cat-icon">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M20 3C10 3 4 8 4 15c0 2.2.7 4.1 1.9 5.5L4 22.4 5.4 21l1.9-1.9C8.7 20.3 10.6 21 12.8 21 19.8 21 21 12 20 3zm-8.3 13.6c-.9 0-1.7-.2-2.4-.6 2.6-3.6 6-6.2 9.6-7.6-1.2 4.9-3.6 8.2-7.2 8.2z" />
                    </svg>
                </span>
                <span class="cat-name">Vegetables</span>
            </a>

            <a class="cat-card" href="#">
                <span class="cat-icon">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 22c0-5 2-9 6-11-1 5-3 8-6 11zm0 0C9 19 7 16 6 11c4 2 6 6 6 11zM12 9C10.5 6 11 3 13 1c1 2.5.5 5.5-1 8z" />
                    </svg>
                </span>
                <span class="cat-name">Leafy Greens</span>
            </a>

            <a class="cat-card" href="#">
                <span class="cat-icon">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M14.5 3.5 17 6l-1.8 1.8 1.4 1.4L18.4 7.4 21 10l-9.5 9.5a5 5 0 0 1-7-7L14.5 3.5z" />
                    </svg>
                </span>
                <span class="cat-name">Root Veggies</span>
            </a>

            <a class="cat-card" href="#">
                <span class="cat-icon">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M7 2h10v2h3v4a4 4 0 0 1-4 4h-.3A5 5 0 0 1 13 14.9V18h4v3H7v-3h4v-3.1a5 5 0 0 1-2.7-2.9H8a4 4 0 0 1-4-4V4h3V2zm-1 4v2a2 2 0 0 0 2 2V6H6zm12 0h-2v4a2 2 0 0 0 2-2V6z" />
                    </svg>
                </span>
                <span class="cat-name">Seasonal</span>
            </a>

        </div>
    </section>

    <%-- ================= Fresh Today ================= --%>
    <section class="shell section">
        <div class="section-head">
            <h2 class="section-title">Fresh Today</h2>
        </div>

        <div class="prod-grid">

            <article class="prod-card">
                <div class="prod-media">
                    <a href="ProductDetails.aspx"><img class="product-img" src="Content/Images/tomato.png" alt="Fresh Tomato" /></a>
                    <span class="prod-badge">20% OFF</span>
                </div>
                <div class="prod-body">
                    <h3 class="prod-name"><a href="ProductDetails.aspx">Fresh Tomato</a></h3>
                    <p class="prod-unit">1 kg</p>
                    <p class="prod-price">
                        <span class="price-now">&#8377;35</span>
                        <span class="price-old">&#8377;45</span>
                    </p>
                    <button type="button" class="btn btn-leaf prod-btn">Add to Cart</button>
                </div>
            </article>

            <article class="prod-card">
                <div class="prod-media">
                    <img class="product-img" src="Content/Images/carrot.png" alt="Fresh Carrot" />
                </div>
                <div class="prod-body">
                    <h3 class="prod-name">Fresh Carrot</h3>
                    <p class="prod-unit">1 kg</p>
                    <p class="prod-price">
                        <span class="price-now">&#8377;40</span>
                    </p>
                    <div class="qty-stepper">
                        <button type="button" class="qty-btn" aria-label="Decrease quantity">&#8722;</button>
                        <span class="qty-value">1</span>
                        <button type="button" class="qty-btn" aria-label="Increase quantity">+</button>
                    </div>
                </div>
            </article>

            <article class="prod-card">
                <div class="prod-media">
                    <img class="product-img" src="Content/Images/cabbage.png" alt="Cabbage" />
                </div>
                <div class="prod-body">
                    <h3 class="prod-name">Cabbage</h3>
                    <p class="prod-unit">1 pc (~400g)</p>
                    <p class="prod-price">
                        <span class="price-now">&#8377;55</span>
                    </p>
                    <button type="button" class="btn btn-leaf prod-btn">Add to Cart</button>
                </div>
            </article>

            <article class="prod-card">
                <div class="prod-media">
                    <img class="product-img" src="Content/Images/onion.png" alt="Red Onion" />
                </div>
                <div class="prod-body">
                    <h3 class="prod-name">Red Onion</h3>
                    <p class="prod-unit">1 kg</p>
                    <p class="prod-price">
                        <span class="price-now">&#8377;30</span>
                    </p>
                    <button type="button" class="btn btn-leaf prod-btn">Add to Cart</button>
                </div>
            </article>

            <article class="prod-card">
                <div class="prod-media">
                    <img class="product-img" src="Content/Images/capsicum.png" alt="Green Capsicum" />
                    <span class="prod-badge">15% OFF</span>
                </div>
                <div class="prod-body">
                    <h3 class="prod-name">Green Capsicum</h3>
                    <p class="prod-unit">500 g</p>
                    <p class="prod-price">
                        <span class="price-now">&#8377;65</span>
                        <span class="price-old">&#8377;75</span>
                    </p>
                    <button type="button" class="btn btn-leaf prod-btn">Add to Cart</button>
                </div>
            </article>

        </div>
    </section>

    <%-- ================= Fresh Deals banner ================= --%>
    <div class="shell">
        <section class="deals">
        <div class="deals-copy">
            <h2 class="deals-title">Fresh Deals Every Day</h2>
            <p class="deals-text">Get up to <span class="deals-em">30% OFF</span> on seasonal vegetables</p>
            <a class="btn btn-white deals-btn" href="#">Shop Deals</a>
        </div>
        <div class="deals-media" aria-hidden="true"></div>
        </section>
    </div>

    <%-- ================= Why Choose Sabzify ================= --%>
    <section class="shell section">
        <h2 class="section-title section-title--center">Why Choose Sabzify</h2>

        <div class="why-grid">

            <div class="why-card">
                <span class="why-icon">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M20 3C10 3 4 8 4 15c0 2.2.7 4.1 1.9 5.5L4 22.4 5.4 21l1.9-1.9C8.7 20.3 10.6 21 12.8 21 19.8 21 21 12 20 3zm-8.3 13.6c-.9 0-1.7-.2-2.4-.6 2.6-3.6 6-6.2 9.6-7.6-1.2 4.9-3.6 8.2-7.2 8.2z" />
                    </svg>
                </span>
                <h3 class="why-name">Farm Fresh</h3>
                <p class="why-text">Sourced directly from local farms across Rajkot.</p>
            </div>

            <div class="why-card">
                <span class="why-icon">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 2 9.2 7.6 3 8.5l4.5 4.4L6.4 19 12 16.1 17.6 19l-1.1-6.1L21 8.5l-6.2-.9L12 2z" />
                    </svg>
                </span>
                <h3 class="why-name">Premium Quality</h3>
                <p class="why-text">Hand-picked and thoroughly checked for quality.</p>
            </div>

            <div class="why-card">
                <span class="why-icon">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M3 6h11v9H3V6zm12 3h3.5l2.5 3v3h-6V9zM6.5 16a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm11 0a2 2 0 1 1 0 4 2 2 0 0 1 0-4z" />
                    </svg>
                </span>
                <h3 class="why-name">Fast Delivery</h3>
                <p class="why-text">Same-day delivery on every order placed before noon.</p>
            </div>

            <div class="why-card">
                <span class="why-icon">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M12 1 3 5v6c0 5 3.8 9.7 9 11 5.2-1.3 9-6 9-11V5l-9-4zm-1 15-4-4 1.4-1.4L11 13.2l4.6-4.6L17 10l-6 6z" />
                    </svg>
                </span>
                <h3 class="why-name">Best Prices</h3>
                <p class="why-text">Affordable rates directly from the farm, no middlemen.</p>
            </div>

        </div>
    </section>

</asp:Content>
