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
<li class="list-group-item <c:if test="${menu eq 'Become A Crorepati' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/become-a-crorepati">  Become A Crorepati</a></li>
<li class="list-group-item <c:if test="${menu eq 'SIP Calculator' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/systematic-investment-plan-calculator">  SIP Calculator</a></li>
<li class="list-group-item <c:if test="${menu eq 'Retirement Planning' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/retirement-planning-calculator">  Retirement Planning</a></li>

<li class="list-group-item <c:if test="${menu eq 'Asset Allocation' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/asset-allocation">  Asset Allocation</a></li>
<%-- <li class="list-group-item <c:if test="${menu eq 'Home Loan EMI' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/home-loan-emi-calculator">  Home Loan EMI</a></li>
<li class="list-group-item <c:if test="${menu eq 'Personal Loan EMI' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/personal-loan-emi-calculator">  Personal Loan EMI</a></li>

<li class="list-group-item <c:if test="${menu eq 'Car Loan EMI' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/car-loan-emi-calculator">  Car Loan EMI</a></li>
<li class="list-group-item <c:if test="${menu eq 'Education Loan EMI' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/education-loan-emi-calculator">  Education Loan EMI</a></li> --%>
<li class="list-group-item <c:if test="${menu eq 'PPF' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/provident-fund-calculator">  PPF</a></li>

<li class="list-group-item <c:if test="${menu eq 'Employees PF' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/employees-provident-fund-calculator">  Employees PF</a></li>
<li class="list-group-item <c:if test="${menu eq 'Goal Setting' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/goal-setting-calculator">  Goal Setting</a></li>
<li class="list-group-item <c:if test="${menu eq 'Composite Financial Goal' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/composite-financial-goal-planner-calculator">  Composite Financial Goal</a></li>

<li class="list-group-item <c:if test="${menu eq 'Children Education' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/children-education-planner">  Children Education</a></li>
<%-- <li class="list-group-item <c:if test="${menu eq 'Networth' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/networth-calculator">  Networth</a></li>
<li class="list-group-item <c:if test="${menu eq 'Compounding' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/compounding-calculator">  Compounding</a></li>

<li class="list-group-item <c:if test="${menu eq 'Spending Less' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/save-more-by-spending-less-calculator">  Spending Less</a></li>
<li class="list-group-item <c:if test="${menu eq 'Future Value' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/future-value-calculator">  Future Value</a></li>
<li class="list-group-item <c:if test="${menu eq 'Human Life Value' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/human-life-value-calculator">  Human Life Value</a></li>

<li class="list-group-item <c:if test="${menu eq 'Mutual Fund Sip Calculator Step Up' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/mutual-fund-sip-calculator-step-up">  Mutual Fund Sip Calculator Step Up</a></li> --%>
</ul>