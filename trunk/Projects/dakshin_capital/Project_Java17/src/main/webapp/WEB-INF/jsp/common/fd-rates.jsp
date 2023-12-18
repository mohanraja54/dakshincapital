<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
	table.tableizer-table {
		font-size: 14px;
		border: 1px solid #CCC; 
		font-family: Arial, Helvetica, sans-serif;
		margin-bottom: 20px;
	} 
	.tableizer-table td {
		padding: 4px;
		margin: 3px;
		border: 1px solid #CCC;
	}
	.tableizer-table th {
		background-color: #01135c; 
		color: #FFF;
		font-weight: bold;
		text-align: center;
		border: 2px solid white;
		height: 50px;
	}
	
	.secondhead td {
		background-color: #F6BB19; 
		color: #000;
		font-weight: bold;
		text-align: center;
		border: 2px solid white;
		height: 50px;
	}
	.emptyrow td {
		background-color: #CCC;
		padding: 0px;
		margin: 0px;
		border: none;
		font-size: 1px;
	}
	.noBorder {
		border:none !important;
	}
	.schemeName {
		color: #01135c;
		font-weight: bold;
	}
	.redText {
		color: red;
	}
	.rightborder {
		border-right: 1px solid #ccc !important;
	}
</style>

<div class="breadcrumb-container">
	<div class="container">
		<ol class="breadcrumb pull-right" style="padding: 8px 0px;">			
			<li><a class="link-dark" href="/">Home</a></li>
			<li class="active">FD Rates</li>	
		</ol>
	</div>
</div>

<div class="container content">

<div class="sec-title">
		<h2>Interest Rates</h2>
</div>
<div class="table-responsive">
<table class="tableizer-table">
   <thead>
      <tr class="tableizer-firstrow">
         <th colspan="4">&nbsp;</th>
         <th colspan="2">Monthly </th>
         <th colspan="2">Quarterly</th>
         <th colspan="2">Half Yearly</th>
         <th colspan="2">Yearly</th>
         <th colspan="2">CDY</th>
      </tr>
   </thead>
   <tbody>
      <tr class="secondhead">
         <td>Sl #</td>
         <td>Name Of the Company </td>
         <td>W.E.F</td>
         <td>Min. Invst Period (Months)</td>
         <td>Amt (Rs.)</td>
         <td>ROI (%)</td>
         <td>Amt (Rs.)</td>
         <td>ROI (%)</td>
         <td>Amt (Rs.)</td>
         <td>ROI (%)</td>
         <td>Amt (Rs.)</td>
         <td>ROI (%)</td>
         <td>Amt (Rs.)</td>
         <td>ROI (%)</td>
      </tr>
      <tr>
         <td>1</td>
         <td class="schemeName">BAJAJ FINANCE LIMITED</td>
         <td class="schemeName">03/09/2019</td>
         <td>12-23</td>
         <td class="noBorder">&nbsp;</td>
         <td>7.72</td>
         <td class="noBorder">&nbsp;</td>
         <td>7.77</td>
         <td class="noBorder">&nbsp;</td>
         <td>7.85</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.00</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.00</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: 0.25% extra for Senior Citizen</td>
         <td>&nbsp;</td>
         <td>24-35</td>
         <td class="noBorder">25000</td>
         <td>7.77</td>
         <td class="noBorder">25000</td>
         <td>7.82</td>
         <td class="noBorder">25000</td>
         <td>7.89</td>
         <td class="noBorder">25000</td>
         <td>8.05</td>
         <td class="noBorder">25000</td>
         <td>8.05</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card photocopy, Photo & Address proof required of all Investors </td>
         <td>&nbsp;</td>
         <td>36-60</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.05</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.10</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.18</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.35</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.35</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">SPECIAL SCHEME </td>
         <td>&nbsp;</td>
         <td>15</td>
         <td>100000</td>
         <td>7.77</td>
         <td>100000</td>
         <td>7.82</td>
         <td>100000</td>
         <td>7.89</td>
         <td>100000</td>
         <td>8.05</td>
         <td>100000</td>
         <td>8.05</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <!-- <tr>
         <td>2</td>
         <td class="schemeName">Dewan Housing Finance Corp Ltd. Aashray Deposit+</td>
         <td class="schemeName">19/11/2018</td>
         <td>12</td>
         <td class="noBorder">&nbsp;</td>
         <td>7.95</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.00</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.05</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.25</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.25</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: 0.40% extra for Senior Citizen</td>
         <td>&nbsp;</td>
         <td>24</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.20</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.25</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.30</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.50</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.50</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card photocopy, Photo & Address proof required of all Investors </td>
         <td>&nbsp;</td>
         <td>36</td>
         <td class="noBorder">20000</td>
         <td>8.65</td>
         <td class="noBorder">5000</td>
         <td>8.70</td>
         <td class="noBorder">5000</td>
         <td>8.80</td>
         <td class="noBorder">5000</td>
         <td>9.00</td>
         <td class="noBorder">5000</td>
         <td>9.00</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText"></td>
         <td>&nbsp;</td>
         <td>40</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.65</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.70</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.80</td>
         <td class="noBorder">&nbsp;</td>
         <td>9.00</td>
         <td class="noBorder">&nbsp;</td>
         <td>9.00</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>48-84</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.65</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.70</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.80</td>
         <td class="noBorder">&nbsp;</td>
         <td>9.00</td>
         <td class="noBorder">&nbsp;</td>
         <td>9.00</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>96-120</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.65</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.70</td>
         <td class="noBorder">&nbsp;</td>
         <td>8.80</td>
         <td class="noBorder">&nbsp;</td>
         <td>9.00</td>
         <td class="noBorder">&nbsp;</td>
         <td>9.00</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>3</td>
         <td class="schemeName">Dewan Housing Finance Corp Ltd. (Swayam Siddha Deposit)</td>
         <td class="schemeName">19/11/2018</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText" style="font-weight:bold;">Exclusively for Women</td>
         <td>&nbsp;</td>
         <td class="noBorder rightborder">18</td>
         <td class="noBorder rightborder">20000</td>
         <td class="noBorder rightborder">8.00</td>
         <td class="noBorder rightborder">5000</td>
         <td class="noBorder rightborder">8.05</td>
         <td class="noBorder rightborder">5000</td>
         <td class="noBorder rightborder">8.10</td>
         <td class="noBorder rightborder">5000</td>
         <td class="noBorder rightborder">8.30</td>
         <td class="noBorder rightborder">5000</td>
         <td class="noBorder rightborder">8.30</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: 0.40% extra for Senior Citizen(60yrs+)</td>
         <td>&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
         <td class="noBorder rightborder">&nbsp;</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>4</td>
         <td class="schemeName">Dewan Housing Finance Corp Ltd. Aashray Deposit+</td>
         <td class="schemeName">19/11/2018</td>
         <td>13 Months</td>
         <td>50000</td>
         <td>7.95</td>
         <td>50000</td>
         <td>8.00</td>
         <td>50000</td>
         <td>8.05</td>
         <td>50000</td>
         <td>8.25</td>
         <td>50000</td>
         <td>8.25</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card photocopy, Photo & Address proof required of all Investors </td>
         <td>&nbsp;</td>
         <td>14 Months</td>
         <td>20000</td>
         <td>8.00</td>
         <td>10000</td>
         <td>8.05</td>
         <td>10000</td>
         <td>8.10</td>
         <td>10000</td>
         <td>8.30</td>
         <td>10000</td>
         <td>8.30</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: On 14 months days 0.25% extra for Senior Citizen, 13 months is only for Non-Individual & 0.25 extra on 1 crore Deposit in 365 days</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr> -->
      <tr>
         <td>2</td>
         <td class="schemeName">HDFC LTD (Individual) - Regular Deposits</td>
         <td class="schemeName">04/10/2019</td>
         <td>12-23</td>
         <td>40000</td>
         <td>7.25</td>
         <td>20000</td>
         <td>7.30</td>
         <td>20000</td>
         <td>7.37</td>
         <td>20000</td>
         <td>NA</td>
         <td>20000</td>
         <td>7.52</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: 0.25% extra for Senior Citizen</td>
         <td>&nbsp;</td>
         <td>24-35</td>
         <td>&nbsp;</td>
         <td>7.25</td>
         <td>&nbsp;</td>
         <td>7.30</td>
         <td>&nbsp;</td>
         <td>7.37</td>
         <td>&nbsp;</td>
         <td>7.52</td>
         <td>&nbsp;</td>
         <td>7.52</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: These rates are applicable for deposits &lt; Rs.1 crore</td>
         <td>&nbsp;</td>
         <td>36-59</td>
         <td>&nbsp;</td>
         <td>7.25</td>
         <td>&nbsp;</td>
         <td>7.30</td>
         <td>&nbsp;</td>
         <td>7.37</td>
         <td>&nbsp;</td>
         <td>7.52</td>
         <td>&nbsp;</td>
         <td>7.52</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card photocopy, Photo & Address proof required of all Investors </td>
         <td>&nbsp;</td>
         <td>60-84</td>
         <td>&nbsp;</td>
         <td>7.25</td>
         <td>&nbsp;</td>
         <td>7.30</td>
         <td>&nbsp;</td>
         <td>7.37</td>
         <td>&nbsp;</td>
         <td>7.52</td>
         <td>&nbsp;</td>
         <td>7.52</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>3</td>
         <td class="schemeName">HDFC PREMIUM DEPOSITS</td>
         <td class="schemeName">04/10/2019</td>
         <td>15</td>
         <td>40000</td>
         <td>7.30</td>
         <td>20000</td>
         <td>7.35</td>
         <td>20000</td>
         <td>7.42</td>
         <td>20000</td>
         <td>NA</td>
         <td>20000</td>
         <td>7.57</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: 0.25% extra for Senior Citizen</td>
         <td>&nbsp;</td>
         <td>30</td>
         <td>&nbsp;</td>
         <td>7.35</td>
         <td>&nbsp;</td>
         <td>7.40</td>
         <td>&nbsp;</td>
         <td>7.47</td>
         <td>&nbsp;</td>
         <td>7.62</td>
         <td>&nbsp;</td>
         <td>7.62</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>22/44</td>
         <td>&nbsp;</td>
         <td>7.40</td>
         <td>&nbsp;</td>
         <td>7.45</td>
         <td>&nbsp;</td>
         <td>7.52</td>
         <td>&nbsp;</td>
         <td>7.67</td>
         <td>&nbsp;</td>
         <td>7.67</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>4</td>
         <td class="schemeName">HDFC PREMIUM DEPOSITS- INDV</td>
         <td class="schemeName">04/10/2019</td>
         <td>33/66</td>
         <td>40000</td>
         <td>7.45</td>
         <td>20000</td>
         <td>7.50</td>
         <td>20000</td>
         <td>7.57</td>
         <td>20000</td>
         <td>7.72</td>
         <td>20000</td>
         <td>7.82</td>
      </tr>
      <tr class="emptyrow">
         <td class="redText">Note: 0.25 extra for Senior Citizen</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
       <tr>
         <td>5</td>
         <td class="schemeName">JKTYRE INDUSTRIES</td>
         <td class="schemeName"></td>
         <td>12</td>
         <td>NA</td>
         <td>NA</td>
         <td>25000</td>
         <td>8.00</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>25000</td>
         <td>8.24</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: 0.50% extra for Senior Citizen deposit</td>
         <td>&nbsp;</td>
         <td>24</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>8.25</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>8.87</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>36</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>8.35</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>9.38</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>6</td>
         <td class="schemeName">LIC HOUSING FINANCE CO. LTD</td>
         <td class="schemeName">26/10/2019</td>
         <td>12</td>
         <td>200000</td>
         <td>7.25</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>10000</td>
         <td>7.50</td>
         <td>10000</td>
         <td>7.50</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: 0.10% extra for Senior Citizen deposit up to 50000/-</td>
         <td>&nbsp;</td>
         <td>18</td>
         <td>&nbsp;</td>
         <td>7.25</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>7.50</td>
         <td>&nbsp;</td>
         <td>7.50</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: 0.25% extra for Senior Citizen deposit up to 51000/-</td>
         <td>&nbsp;</td>
         <td>24</td>
         <td>&nbsp;</td>
         <td>7.25</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>7.55</td>
         <td>&nbsp;</td>
         <td>7.55</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card photocopy and Address proof required of all Investors </td>
         <td>&nbsp;</td>
         <td>36</td>
         <td>&nbsp;</td>
         <td>7.35</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>7.60</td>
         <td>&nbsp;</td>
         <td>7.60</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>60</td>
         <td>&nbsp;</td>
         <td>7.35</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>7.60</td>
         <td>&nbsp;</td>
         <td>7.60</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>7</td>
         <td class="schemeName">Mahindra & Mahindra Financial Services Ltd.</td>
         <td class="schemeName">22/08/2019</td>
         <td>12</td>
         <td>NA</td>
         <td>NA</td>
         <td>50000</td>
         <td>7.55</td>
         <td>25000</td>
         <td>7.60</td>
         <td>NA</td>
         <td>NA</td>
         <td>5000</td>
         <td>7.75</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: Senior Citizen will get 0.25% extra</td>
         <td>&nbsp;</td>
         <td>18</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>7.55</td>
         <td>&nbsp;</td>
         <td>7.60</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>7.95</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card photocopy, Photo and Address proof required of all Investors </td>
         <td>&nbsp;</td>
         <td>24</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>7.90</td>
         <td>&nbsp;</td>
         <td>7.95</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>8.73</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>36</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>8.25</td>
         <td>&nbsp;</td>
         <td>8.30</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>9.15</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>48,60</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>8.25</td>
         <td>&nbsp;</td>
         <td>8.30</td>
         <td>&nbsp;</td>
         <td>NA</td>
         <td>&nbsp;</td>
         <td>9.58-10.00</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>8</td>
         <td class="schemeName">PNB Housing Finance Ltd.</td>
         <td class="schemeName">22/10/2019</td>
         <td>15</td>
         <td>25000</td>
         <td>7.80</td>
         <td>10000</td>
         <td>7.85</td>
         <td>10000</td>
         <td>7.90</td>
         <td>10000</td>
         <td>8.10</td>
         <td>10000</td>
         <td>8.21</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>22</td>
         <td>&nbsp;</td>
         <td>7.85</td>
         <td>&nbsp;</td>
         <td>7.90</td>
         <td>&nbsp;</td>
         <td>7.95</td>
         <td>&nbsp;</td>
         <td>8.15</td>
         <td>&nbsp;</td>
         <td>8.41</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: 0.25% extra for Senior Citizen</td>
         <td>&nbsp;</td>
         <td>30</td>
         <td>&nbsp;</td>
         <td>7.90</td>
         <td>&nbsp;</td>
         <td>7.95</td>
         <td>&nbsp;</td>
         <td>8.00</td>
         <td>&nbsp;</td>
         <td>8.20</td>
         <td>&nbsp;</td>
         <td>8.73</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>44</td>
         <td>&nbsp;</td>
         <td>8.05</td>
         <td>&nbsp;</td>
         <td>8.10</td>
         <td>&nbsp;</td>
         <td>8.15</td>
         <td>&nbsp;</td>
         <td>8.35</td>
         <td>&nbsp;</td>
         <td>9.33</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>9</td>
         <td class="schemeName">PNB Housing Finance Ltd.</td>
         <td class="schemeName">22/10/2019</td>
         <td>12</td>
         <td>25000</td>
         <td>7.75</td>
         <td>10000</td>
         <td>7.80</td>
         <td>10000</td>
         <td>7.85</td>
         <td>10000</td>
         <td>8.05</td>
         <td>10000</td>
         <td>8.05</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: Senior Citizen will get 0.25% extra</td>
         <td>&nbsp;</td>
         <td>24</td>
         <td>&nbsp;</td>
         <td>7.80</td>
         <td>&nbsp;</td>
         <td>8.85</td>
         <td>&nbsp;</td>
         <td>7.90</td>
         <td>&nbsp;</td>
         <td>8.10</td>
         <td>&nbsp;</td>
         <td>8.43</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card photocopy, Photo & Address proof required of all Investors </td>
         <td>&nbsp;</td>
         <td>36</td>
         <td>&nbsp;</td>
         <td>7.90</td>
         <td>&nbsp;</td>
         <td>7.95</td>
         <td>&nbsp;</td>
         <td>8.00</td>
         <td>&nbsp;</td>
         <td>8.20</td>
         <td>&nbsp;</td>
         <td>8.89</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>48-59</td>
         <td>&nbsp;</td>
         <td>8.05</td>
         <td>&nbsp;</td>
         <td>8.10</td>
         <td>&nbsp;</td>
         <td>8.15</td>
         <td>&nbsp;</td>
         <td>8.35</td>
         <td>&nbsp;</td>
         <td>9.46</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>60-71</td>
         <td>&nbsp;</td>
         <td>8.15</td>
         <td>&nbsp;</td>
         <td>8.20</td>
         <td>&nbsp;</td>
         <td>8.25</td>
         <td>&nbsp;</td>
         <td>8.45</td>
         <td>&nbsp;</td>
         <td>10.00</td>
      </tr>
      <tr>
         <td> </td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>72-120</td>
         <td>&nbsp;</td>
         <td>8.00-7.95</td>
         <td>&nbsp;</td>
         <td>8.05-8.00</td>
         <td>&nbsp;</td>
         <td>8.10-8.05</td>
         <td>&nbsp;</td>
         <td>8.30-8.25</td>
         <td>&nbsp;</td>
         <td>10.23-12.09</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>10</td>
         <td class="schemeName">Shriram Transport Finance-UNNATI Fixed Deposit</td>
         <td class="schemeName">01/11/2019</td>
         <td>12</td>
         <td>10000</td>
         <td>7.72</td>
         <td>10000</td>
         <td>7.77</td>
         <td>10000</td>
         <td>7.85</td>
         <td>10000</td>
         <td>8.00</td>
         <td>5000</td>
         <td>8.00</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Photo, PAN Card photocopy and Address proof required of all Investor </td>
         <td>&nbsp;</td>
         <td>24</td>
         <td>&nbsp;</td>
         <td>7.95</td>
         <td>&nbsp;</td>
         <td>8.00</td>
         <td>&nbsp;</td>
         <td>8.08</td>
         <td>&nbsp;</td>
         <td>8.25</td>
         <td>&nbsp;</td>
         <td>8.59</td>
      </tr>
      <tr>
         <td> </td>
         <td class="redText">Note: Additional benefit for Sr.Citizen 0.23%(M&Q), 0.24%(H), 0.25%(Y &C)</td>
         <td>&nbsp;</td>
         <td>36-60</td>
         <td>&nbsp;</td>
         <td>8.42-8.65</td>
         <td>&nbsp;</td>
         <td>8.48-8.71</td>
         <td>&nbsp;</td>
         <td>8.57-8.81</td>
         <td>&nbsp;</td>
         <td>8.75-9.00</td>
         <td>&nbsp;</td>
         <td>9.54-10.77</td>
      </tr>
      <tr>
         <th colspan="3">54EC</th>
         <th></th>
         <th colspan="2">Monthly </th>
         <th colspan="2">Quarterly</th>
         <th colspan="2">Half Yearly</th>
         <th colspan="2">Yearly</th>
         <th colspan="2">CDY</th>
      </tr>
      <tr class="secondhead">
         <td>&nbsp;</td>
         <td>Name Of the Company </td>
         <td>W.E.F</td>
         <td>Min.Invst Period (Months)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
      </tr>
      <tr>
         <td>1</td>
         <td class="schemeName">Rural Electrification Corporation limited (code: 027)</td>
         <td class="schemeName">01/04/2018</td>
         <td>60</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>10000</td>
         <td>5.75</td>
         <td>NA</td>
         <td>NA</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card and Address proof (AADHAR) photocopy required of all Investors </td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
		<tr>
         <td>2</td>
         <td class="schemeName">Indian Railway Finance Corp Ltd (CODE: 024)</td>
         <td class="schemeName">01/04/2018</td>
         <td>60</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>10000</td>
         <td>5.75</td>
         <td>NA</td>
         <td>NA</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card and Address proof (AADHAR) photocopy required of all Investors </td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>3</td>
         <td class="schemeName">PFC Capital Gain Bonds (CODE: P021)</td>
         <td class="schemeName">01/04/2018</td>
         <td>60</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>10000</td>
         <td>5.75</td>
         <td>NA</td>
         <td>NA</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">PAN Card and Address proof (AADHAR) photocopy required of all Investors </td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <th colspan="3">GOI BONDS</th>
         <th></th>
         <th colspan="2"> Monthly </th>
         <th colspan="2">Quarterly</th>
         <th colspan="2">Half Yearly</th>
         <th colspan="2">Yearly</th>
         <th colspan="2">CDY</th>
      </tr>
      <tr class="secondhead">
         <td>&nbsp;</td>
         <td>Name Of the Company </td>
         <td>W.E.F</td>
         <td>Min.Invst Period (Months)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
         <td>Amount(Rs.)</td>
         <td>ROI(%)</td>
      </tr>
      <tr>
         <td>1</td>
         <td class="schemeName">State Bank Of India 7.75% Savings (Taxable) Bonds, 2018</td>
         <td>&nbsp;</td>
         <td>84</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>1000</td>
         <td>7.75</td>
         <td>NA</td>
         <td>NA</td>
         <td>1000</td>
         <td>7.75</td>
      </tr>
      <tr class="emptyrow">
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
      </tr>
      <tr>
         <td>2</td>
         <td class="schemeName">HDFC Bank GOI 7.75% Savings (Taxable) Bonds 2018</td>
         <td>&nbsp;</td>
         <td>84</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>NA</td>
         <td>1000</td>
         <td>7.75</td>
         <td>NA</td>
         <td>NA</td>
         <td>1000</td>
         <td>7.75</td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td class="redText">Note: PAN Card photocopy Required</td>
         <td class="redText" colspan="12">Interest UP TO 10000/- No TDS</td>         
      </tr>
   </tbody>
</table>
</div>
<p>Disclaimer:</p>
<p>1. The above Rates of Interest are subject to change any time at the sole discretion of the  company.</p>
<p>2. Data displayed here is as received from the respective companies.</p>
<p>3. In case of any change in interest rates, Eastern Financiers (EF) will not be responsible. Investors are requested to check the prevailing interest rates on the date of deposit with the respective companies / EF Relationship Manager / EF Branch.</p>
<p style="margin-bottom:50px;">4. Investors should check the credit rating / relevant ratings of the Fixed Deposits instruments they are investing in. Eastern Financiers shall not be responsible for timely payment of interest / principal by the FD issuer.</p>
</div>