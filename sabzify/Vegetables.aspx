<%@ Page Title="Vegetables" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vegetables.aspx.cs" Inherits="sabzify.Vegetables" UnobtrusiveValidationMode="None" %>

<asp:Content ID="VegetablesContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-scoped styles. Every selector starts with .veg-page. --%>
    <style>
        .veg-page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 32px 24px 48px;
            color: #111827;
        }

        .veg-page .veg-layout {
            display: grid;
            grid-template-columns: 220px minmax(0, 1fr);
            gap: 24px;
            align-items: start;
        }

        /* Filters sidebar ------------------------------------------------ */
        .veg-page .veg-filters {
            position: sticky;
            top: 24px;
            padding: 20px;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 4px 18px rgba(26, 43, 32, .06);
        }

        .veg-page .veg-filters-title {
            margin: 0 0 14px;
            padding-bottom: 10px;
            border-bottom: 1px solid #E5E7EB;
            font-size: 18px;
            font-weight: 600;
            color: #1B6E2A;
        }

        .veg-page .veg-filters-heading {
            margin: 0 0 8px;
            font-size: 13px;
            font-weight: 600;
            color: #111827;
        }

        .veg-page .veg-check {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0 0 8px;
            font-size: 14px;
            font-weight: 400;
            color: #374151;
            cursor: pointer;
        }

        .veg-page .veg-check input {
            width: 15px;
            height: 15px;
            margin: 0;
            accent-color: #1B6E2A;
            cursor: pointer;
        }

        .veg-page .veg-check--gap {
            margin-top: 18px;
        }

        /* Header row ------------------------------------------------------ */
        .veg-page .veg-head {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 20px;
        }

        .veg-page h1.veg-title {
            margin: 0 0 4px;
            font-size: 26px;
            font-weight: 700;
            line-height: 1.25;
            color: #111827;
        }

        .veg-page .veg-count {
            margin: 0;
            font-size: 13px;
            color: #6B7280;
        }

        .veg-page .veg-sort {
            height: 36px;
            padding: 0 10px;
            border: 1px solid #E5E7EB;
            border-radius: 8px;
            background: #fff;
            font-size: 13px;
            color: #111827;
            cursor: pointer;
        }

        /* Product grid ---------------------------------------------------- */
        .veg-page .veg-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
            min-height: 280px;
        }

        .veg-page .veg-card {
            display: flex;
            flex-direction: column;
            padding: 10px;
            border: 1px solid #E5E7EB;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 4px 18px rgba(26, 43, 32, .06);
            cursor: pointer;
            transition: transform 0.15s ease, box-shadow 0.15s ease, border-color 0.15s ease;
        }

        .veg-page .veg-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 22px rgba(26, 43, 32, .12);
            border-color: #A7D7A0;
        }

        .veg-page .veg-card.is-in-cart {
            border-color: #A7D7A0;
        }

        .veg-page .veg-media {
            position: relative;
            height: 150px;
            border-radius: 8px;
            overflow: hidden;
            background: #F3F4F6;
        }

        .veg-page .veg-media img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .veg-page .veg-badge {
            position: absolute;
            top: 8px;
            right: 8px;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            line-height: 1.3;
            color: #fff;
            z-index: 2;
        }

        .veg-page .veg-badge--sale {
            background: #F59E0B;
        }

        .veg-page .veg-badge--organic {
            background: #1B6E2A;
        }

        .veg-page h3.veg-name {
            margin: 12px 0 6px;
            font-size: 14px;
            font-weight: 600;
            line-height: 1.35;
            color: #111827;
            text-decoration: none;
        }

        .veg-page .veg-price {
            margin: 0 0 10px;
            font-size: 16px;
            font-weight: 700;
            color: #111827;
        }

        .veg-page .veg-unit {
            font-size: 12px;
            font-weight: 400;
            color: #6B7280;
        }

        .veg-page .veg-old {
            margin-left: 4px;
            font-size: 12px;
            font-weight: 400;
            color: #9CA3AF;
            text-decoration: line-through;
        }

        .veg-page .veg-actions {
            margin-top: auto;
            padding-bottom: 6px;
        }

        .veg-page .veg-add {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            width: 100%;
            height: 36px;
            padding: 0 8px;
            border: 0;
            border-radius: 6px;
            background: #1B6E2A;
            font-size: 13px;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .veg-page .veg-add:hover,
        .veg-page .veg-add:focus {
            background: #155822;
        }

        .veg-page .veg-add svg {
            width: 15px;
            height: 15px;
            fill: currentColor;
            flex: none;
        }

        .veg-page .stepper {
            position: relative;
            display: none;
            align-items: center;
            justify-content: space-between;
            height: 36px;
            padding: 0 4px;
            border: 1px solid #A7D7A0;
            border-radius: 6px;
            background: #EEF6EC;
        }

        .veg-page .veg-card.is-in-cart .stepper {
            display: flex;
        }

        .veg-page .veg-card.is-in-cart .veg-add {
            display: none;
        }

        .veg-page .stepper-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            padding: 0;
            border: 0;
            border-radius: 4px;
            background: transparent;
            font-size: 18px;
            font-weight: 600;
            line-height: 1;
            color: #1B6E2A;
            cursor: pointer;
        }

        .veg-page .stepper-btn:hover,
        .veg-page .stepper-btn:focus {
            background: #DDEFD9;
        }

        .veg-page input.qty-input {
            width: 32px;
            max-width: 32px;
            height: 28px;
            padding: 0;
            border: 0;
            background: transparent;
            text-align: center;
            font-size: 14px;
            font-weight: 600;
            color: #111827;
            outline: none;
        }

        /* Pagination ------------------------------------------------------- */
        .veg-page .veg-pager {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 32px;
        }

        .veg-page .pager-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            padding: 0;
            border: 1px solid #D1D5DB;
            border-radius: 50%;
            background: #fff;
            font-size: 12px;
            font-weight: 500;
            color: #374151;
            cursor: pointer;
            transition: all 0.15s ease;
        }

        .veg-page .pager-btn:hover:not(:disabled):not(.is-active) {
            border-color: #1B6E2A;
            color: #1B6E2A;
        }

        .veg-page .pager-btn.is-active {
            border-color: #1B6E2A;
            background: #1B6E2A;
            color: #fff;
        }

        .veg-page .pager-btn:disabled {
            opacity: .4;
            cursor: not-allowed;
        }

        .veg-page .pager-btn svg {
            width: 14px;
            height: 14px;
            fill: currentColor;
        }

        .veg-page .pager-gap {
            font-size: 12px;
            color: #6B7280;
            padding: 0 4px;
        }

        .veg-page .veg-empty {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
            color: #6B7280;
            font-size: 16px;
            background: #fff;
            border-radius: 12px;
            border: 1px dashed #D1D5DB;
        }

        /* Responsive ------------------------------------------------------- */
        @media screen and (max-width: 1024px) {
            .veg-page .veg-grid {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }
        }

        @media screen and (max-width: 768px) {
            .veg-page .veg-layout {
                grid-template-columns: minmax(0, 1fr);
            }

            .veg-page .veg-filters {
                position: static;
            }

            .veg-page .veg-head {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .veg-page .veg-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media screen and (max-width: 480px) {
            .veg-page {
                padding: 24px 16px 40px;
            }

            .veg-page .veg-grid {
                gap: 10px;
            }

            .veg-page .veg-media {
                height: 120px;
            }

            .veg-page .veg-pager {
                gap: 6px;
            }
        }
    </style>

    <div class="veg-page">
        <div class="veg-layout">

            <%-- ================= Filters ================= --%>
            <aside class="veg-filters">
                <h2 class="veg-filters-title">Filters</h2>
                <p class="veg-filters-heading">Categories</p>
                <label class="veg-check">
                    <input type="checkbox" id="chkLeafy" value="Leafy Greens" onchange="onFilterChange()" /> Leafy Greens
                </label>
                <label class="veg-check">
                    <input type="checkbox" id="chkRoot" value="Root Vegetables" onchange="onFilterChange()" /> Root Vegetables
                </label>
                <label class="veg-check">
                    <input type="checkbox" id="chkMarrows" value="Marrows" onchange="onFilterChange()" /> Marrows
                </label>
                <label class="veg-check veg-check--gap">
                    <input type="checkbox" id="chkOrganic" value="Organic" onchange="onFilterChange()" /> Organic Only
                </label>
            </aside>

            <section class="veg-main">

                <%-- ================= Header row ================= --%>
                <div class="veg-head">
                    <div>
                        <h1 class="veg-title">Fresh Vegetables</h1>
                        <p class="veg-count" id="lblVegCount">Showing 1&#8211;4 of 48 fresh items in Rajkot</p>
                    </div>
                    <select id="ddlSort" class="veg-sort" aria-label="Sort products" onchange="onSortChange()">
                        <option value="popularity">Sort by: Popularity</option>
                        <option value="price-asc">Price: Low to High</option>
                        <option value="price-desc">Price: High to Low</option>
                        <option value="newest">Newest</option>
                    </select>
                </div>

                <%-- ================= Product grid ================= --%>
                <div class="veg-grid" id="vegGrid">
                </div>

                <%-- ================= Pagination ================= --%>
                <nav class="veg-pager" id="vegPager" aria-label="Pages">
                </nav>

            </section>
        </div>
    </div>

    <script type="text/javascript">
        var allProducts = <%= ProductsJson %>;
        var isLoggedIn = <%= sabzify.AuthHelper.IsLoggedIn(Session) ? "true" : "false" %>;
        var PAGE_SIZE = 4;
        var currentPage = 1;
        var currentFiltered = [];
        var cartQuantities = {};

        function escapeHtml(text) {
            if (!text) return '';
            var map = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' };
            return text.replace(/[&<>"']/g, function(m) { return map[m]; });
        }

        function openProduct(id) {
            if (!isLoggedIn) {
                window.location.href = 'Login.aspx?ReturnUrl=' + encodeURIComponent('ProductDetails.aspx?id=' + id);
            } else {
                window.location.href = 'ProductDetails.aspx?id=' + id;
            }
        }

        function handleCardAdd(e, id) {
            e.stopPropagation();
            if (!isLoggedIn) {
                window.location.href = 'Login.aspx?ReturnUrl=' + encodeURIComponent('Vegetables.aspx');
                return;
            }
            cartQuantities[id] = 1;
            renderGrid();
        }

        function handleStepperClick(e, id, step) {
            e.stopPropagation();
            var cur = cartQuantities[id] || 1;
            var next = cur + step;
            if (next <= 0) {
                delete cartQuantities[id];
            } else if (next <= 10) {
                cartQuantities[id] = next;
            }
            renderGrid();
        }

        function handleInputClick(e) {
            e.stopPropagation();
        }

        function getFilteredProducts() {
            var leafy = document.getElementById('chkLeafy').checked;
            var root = document.getElementById('chkRoot').checked;
            var marrows = document.getElementById('chkMarrows').checked;
            var organicOnly = document.getElementById('chkOrganic').checked;

            var activeCats = [];
            if (leafy) activeCats.push('Leafy Greens');
            if (root) activeCats.push('Root Vegetables');
            if (marrows) activeCats.push('Marrows');

            var filtered = allProducts.filter(function (p) {
                // If any category checkbox is checked, match them
                if (activeCats.length > 0) {
                    if (activeCats.indexOf(p.Category) === -1) {
                        return false;
                    }
                }
                // Organic filter
                if (organicOnly && !p.IsOrganic) {
                    return false;
                }
                return true;
            });

            // Sorting
            var sortVal = document.getElementById('ddlSort').value;
            if (sortVal === 'price-asc') {
                filtered.sort(function (a, b) { return a.Price - b.Price; });
            } else if (sortVal === 'price-desc') {
                filtered.sort(function (a, b) { return b.Price - a.Price; });
            } else if (sortVal === 'newest') {
                filtered.sort(function (a, b) { return b.Id - a.Id; });
            } else {
                // Popularity
                filtered.sort(function (a, b) { return (b.Popularity || 0) - (a.Popularity || 0); });
            }

            return filtered;
        }

        function onFilterChange() {
            currentPage = 1;
            updateView();
        }

        function onSortChange() {
            currentPage = 1;
            updateView();
        }

        function goToPage(page) {
            var totalPages = Math.ceil(currentFiltered.length / PAGE_SIZE) || 1;
            if (page < 1 || page > totalPages) return;
            currentPage = page;
            updateView();
            window.scrollTo({ top: 120, behavior: 'smooth' });
        }

        function updateView() {
            currentFiltered = getFilteredProducts();
            var totalCount = currentFiltered.length;
            var totalPages = Math.ceil(totalCount / PAGE_SIZE) || 1;
            if (currentPage > totalPages) currentPage = totalPages;

            // Update Count Label
            var lblCount = document.getElementById('lblVegCount');
            if (totalCount === 0) {
                lblCount.textContent = 'Showing 0 fresh items in Rajkot';
            } else {
                var start = (currentPage - 1) * PAGE_SIZE + 1;
                var end = Math.min(currentPage * PAGE_SIZE, totalCount);
                lblCount.textContent = 'Showing ' + start + '–' + end + ' of ' + totalCount + ' fresh items in Rajkot';
            }

            renderGrid();
            renderPagination(totalPages, currentPage);
        }

        function renderGrid() {
            var grid = document.getElementById('vegGrid');
            if (!grid) return;

            if (currentFiltered.length === 0) {
                grid.innerHTML = '<div class="veg-empty">No products found.</div>';
                return;
            }

            var startIdx = (currentPage - 1) * PAGE_SIZE;
            var pageItems = currentFiltered.slice(startIdx, startIdx + PAGE_SIZE);

            var html = '';
            for (var i = 0; i < pageItems.length; i++) {
                var p = pageItems[i];
                var isInCart = !!cartQuantities[p.Id];
                var qty = cartQuantities[p.Id] || 1;

                var badgeHtml = '';
                if (p.IsSale && p.DiscountPercent > 0) {
                    badgeHtml = '<span class="veg-badge veg-badge--sale">-' + p.DiscountPercent + '%</span>';
                } else if (p.IsOrganic) {
                    badgeHtml = '<span class="veg-badge veg-badge--organic">Organic</span>';
                }

                var oldPriceHtml = '';
                if (p.OldPrice) {
                    oldPriceHtml = '<span class="veg-old">&#8377;' + p.OldPrice + '</span>';
                }

                html += '<article class="veg-card' + (isInCart ? ' is-in-cart' : '') + '" onclick="openProduct(' + p.Id + ')">' +
                    '<div class="veg-media">' +
                        '<img src="' + escapeHtml(p.ImageUrl) + '" alt="' + escapeHtml(p.Name) + '" />' +
                        badgeHtml +
                    '</div>' +
                    '<h3 class="veg-name">' + escapeHtml(p.Name) + '</h3>' +
                    '<p class="veg-price">&#8377;' + p.Price + ' <span class="veg-unit">/' + escapeHtml(p.Unit) + '</span> ' + oldPriceHtml + '</p>' +
                    '<div class="veg-actions">' +
                        '<button type="button" class="veg-add" onclick="handleCardAdd(event, ' + p.Id + ')">' +
                            '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7 18a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm10 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM2 3h2.2l2.5 11.2a2 2 0 0 0 2 1.6h8.4a2 2 0 0 0 2-1.5L21 7H6.3l-.5-2.2A2 2 0 0 0 3.9 3H2z" /></svg>' +
                            'Add to Cart' +
                        '</button>' +
                        '<div class="stepper">' +
                            '<button type="button" class="stepper-btn" onclick="handleStepperClick(event, ' + p.Id + ', -1)" aria-label="Decrease quantity">&#8722;</button>' +
                            '<input type="text" readonly="readonly" class="qty-input" value="' + qty + '" onclick="handleInputClick(event)" aria-label="' + escapeHtml(p.Name) + ' quantity" />' +
                            '<button type="button" class="stepper-btn" onclick="handleStepperClick(event, ' + p.Id + ', 1)" aria-label="Increase quantity">+</button>' +
                        '</div>' +
                    '</div>' +
                '</article>';
            }

            grid.innerHTML = html;
        }

        function renderPagination(totalPages, currentPage) {
            var pager = document.getElementById('vegPager');
            if (!pager) return;

            if (totalPages <= 1) {
                pager.innerHTML = '';
                return;
            }

            var html = '';

            // Previous Button
            var prevDisabled = (currentPage === 1) ? ' disabled="disabled"' : '';
            html += '<button type="button" class="pager-btn"' + prevDisabled + ' onclick="goToPage(' + (currentPage - 1) + ')" aria-label="Previous page">' +
                '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M15.4 7.4 14 6l-6 6 6 6 1.4-1.4L10.8 12z" /></svg>' +
            '</button>';

            // Page numbers
            if (totalPages <= 7) {
                for (var i = 1; i <= totalPages; i++) {
                    var activeClass = (i === currentPage) ? ' is-active' : '';
                    html += '<button type="button" class="pager-btn' + activeClass + '" onclick="goToPage(' + i + ')">' + i + '</button>';
                }
            } else {
                // Complex pagination e.g. 1 2 3 ... 12
                if (currentPage <= 3) {
                    for (var p = 1; p <= 3; p++) {
                        var active = (p === currentPage) ? ' is-active' : '';
                        html += '<button type="button" class="pager-btn' + active + '" onclick="goToPage(' + p + ')">' + p + '</button>';
                    }
                    html += '<span class="pager-gap">&#8230;</span>';
                    html += '<button type="button" class="pager-btn" onclick="goToPage(' + totalPages + ')">' + totalPages + '</button>';
                } else if (currentPage >= totalPages - 2) {
                    html += '<button type="button" class="pager-btn" onclick="goToPage(1)">1</button>';
                    html += '<span class="pager-gap">&#8230;</span>';
                    for (var p = totalPages - 2; p <= totalPages; p++) {
                        var active = (p === currentPage) ? ' is-active' : '';
                        html += '<button type="button" class="pager-btn' + active + '" onclick="goToPage(' + p + ')">' + p + '</button>';
                    }
                } else {
                    html += '<button type="button" class="pager-btn" onclick="goToPage(1)">1</button>';
                    html += '<span class="pager-gap">&#8230;</span>';
                    html += '<button type="button" class="pager-btn is-active" onclick="goToPage(' + currentPage + ')">' + currentPage + '</button>';
                    html += '<span class="pager-gap">&#8230;</span>';
                    html += '<button type="button" class="pager-btn" onclick="goToPage(' + totalPages + ')">' + totalPages + '</button>';
                }
            }

            // Next Button
            var nextDisabled = (currentPage === totalPages) ? ' disabled="disabled"' : '';
            html += '<button type="button" class="pager-btn"' + nextDisabled + ' onclick="goToPage(' + (currentPage + 1) + ')" aria-label="Next page">' +
                '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M8.6 16.6 10 18l6-6-6-6-1.4 1.4 4.6 4.6z" /></svg>' +
            '</button>';

            pager.innerHTML = html;
        }

        // Initialize on load
        (function () {
            var urlParams = new URLSearchParams(window.location.search);
            var catParam = urlParams.get('cat');
            if (catParam) {
                var c = catParam.toLowerCase();
                if (c.indexOf('leafy') !== -1) document.getElementById('chkLeafy').checked = true;
                else if (c.indexOf('root') !== -1) document.getElementById('chkRoot').checked = true;
                else if (c.indexOf('marrow') !== -1) document.getElementById('chkMarrows').checked = true;
                else if (c.indexOf('organic') !== -1) document.getElementById('chkOrganic').checked = true;
            }

            updateView();
        })();
    </script>

</asp:Content>
