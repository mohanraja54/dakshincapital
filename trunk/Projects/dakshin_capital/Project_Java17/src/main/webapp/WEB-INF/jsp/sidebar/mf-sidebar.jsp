<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.list-group-item.active, .list-group-item.active:hover, .list-group-item.active:focus {
    background-color: #ffa200;
    border-color: #ffa200;
    color: #fff;
    z-index: 2;
    border-right: 2px solid #ee1c25;
}
.list-group-item.active a{
	color: #000 !important;
}
.list-group-item{
	font-size: 15px;
}
.li-emi{
	font-size: 15px;
}
</style>
<ul class="list-group sidebar-nav-v1" id="sidebar-nav">

	<li class="list-group-item <c:if test="${page eq 'top-performing-mutual-funds' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/top-performing-mutual-funds"> Top Performing Mutual Funds</a></li>
	<li class="list-group-item <c:if test="${page eq 'mutual-funds-performance-comparison' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/mutual-funds-performance-comparison"> Mutual Funds Performance Comparison</a></li>
	<li class="list-group-item <c:if test="${page eq 'mutual-fund-returns-comparison' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/mutual-fund-returns-comparison"> Mutual Fund Point to Point Returns - Multiple Schemes &amp; Periods</a></li>
	<li class="list-group-item <c:if test="${page eq 'mutual-fund-sip-investment-calculator' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/mutual-fund-sip-investment-calculator"> SIP Return Calculator</a></li>
	<li class="list-group-item <c:if test="${page eq 'top-performing-systematic-investment-plan' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/top-performing-systematic-investment-plan"> Top Performing SIP</a></li>
	<li class="list-group-item <c:if test="${page eq 'top-performing-sip-plans-elss-funds' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/top-performing-sip-plans-elss-funds"> Top Performing SIP ELSS Funds</a></li>
	<li class="list-group-item <c:if test="${page eq 'sip-with-annual-increase' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/sip-with-annual-increase"> SIP with Annual Increase</a></li>
	<li class="list-group-item <c:if test="${page eq 'ppf-vs-elss' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/ppf-vs-elss"> PPF vs ELSS</a></li>
	<li class="list-group-item <c:if test="${page eq 'mutual-fund-stp-investment-calculator' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/mutual-fund-stp-investment-calculator"> Mutual Fund STP Calculator</a></li>
	<li class="list-group-item <c:if test="${page eq 'top-swp-funds' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/top-swp-funds"> Top SWP Funds</a></li>
	<li class="list-group-item <c:if test="${page eq 'mutual-fund-swp-investment-calculator' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/mutual-fund-swp-investment-calculator"> Mutual Fund SWP Calculator</a></li>
	<li class="list-group-item <c:if test="${page eq 'fixed-deposit-vs-debt-funds' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/fixed-deposit-vs-debt-funds"> Fixed Deposit vs Debt Funds</a></li>
	<li class="list-group-item <c:if test="${page eq 'liquid-funds-vs-savings-bank' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/liquid-funds-vs-savings-bank"> Liquid Funds vs Savings Bank</a></li>
	<li class="list-group-item <c:if test="${page eq 'top-dividend-paying-mutual-funds' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/top-dividend-paying-mutual-funds"> Top Dividend Paying Mutual Funds</a></li>
	<li class="list-group-item <c:if test="${page eq 'top-mutual-funds' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/top-mutual-funds"> Top Mutual Funds - 2020</a></li>
	<li class="list-group-item <c:if test="${page eq 'factsheet_amc' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/factsheet/Axis-Mutual-Fund/2020">  Fact Sheet</a></li>
	
	<%-- <li class="list-group-item <c:if test="${page eq 'quartile-ranking' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/quartile-ranking"> Mutual Fund Quartile Ranking</a></li>
	<li class="list-group-item <c:if test="${page eq 'top-consistent-mutual-fund-performers' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/top-consistent-mutual-fund-performers"> Top Consistent Mutual Fund Performers</a></li>
	<li class="list-group-item <c:if test="${page eq 'stp-calculator-profit-transfer' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/stp-calculator-profit-transfer"> STP Calculator Profit Transfer</a></li>
	<li class="list-group-item <c:if test="${page eq 'mutual-fund-swp-investment-calculator' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/mutual-fund-swp-investment-calculator"> Mutual Fund SWP Calculator</a></li>
	<li class="list-group-item <c:if test="${page eq 'top-performing-lumpsum-funds' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/top-performing-lumpsum-funds"> Top Performing Lumpsum Funds</a></li>
	<li class="list-group-item <c:if test="${page eq 'consisted-dividend-paying-funds' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/consisted-dividend-paying-funds"> Consisted Dividend Paying Funds</a></li>
	<li class="list-group-item <c:if test="${page eq 'historical-dividends' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/mutual-funds-historical-dividends"> Mutual Funds Historical Dividends</a></li> --%>
</ul>