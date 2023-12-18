<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
<div class="main_menu_top">  
<div class="bg-top navbar-light">
   	<div class="container">
   		<div class="row no-gutters py-2 d-flex align-items-center align-items-stretch">
   			<div class="col-md-4 d-flex align-items-center py-1">
   				<a class="navbar-brand" href="/"><img src="/images/logo/logo.jpg"></a>
   			</div>
    		<div class="col-lg-8 d-block py-1">
	    		<div class="row d-flex">
				    <div class="col-md d-flex topper align-items-center align-items-stretch py-md-4 col-md-4">
				    	<div class="icon d-flex justify-content-center align-items-center"><span class="icon-paper-plane"></span></div>
				    	<div class="text">
					    	<span>info@dakshincapital.com</span>
					    </div>
				    </div>
				    <div class="col-md d-flex topper align-items-center align-items-stretch py-md-4 col-md-4">
				    	<div class="icon d-flex justify-content-center align-items-center"><span class="icon-phone2"></span></div>
					    <div class="text">
					    	<span>Call Us: 044-42023300</span>
					    </div>
				    </div>
				<c:choose>
				<c:when test="${accountMap != null}">
				<div class="col-md d-flex topper align-items-center align-items-stretch py-md-3 col-md-4">
				
				<a href="/mutual-funds" class="dropdown-toggle nav-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
	            <span class="nav-label">Welcome ${accountMap.firstname}</span> <span class="caret"></span></a>
	            <ul class="dropdown-menu" style="width: 225px;">
				<c:choose>
				<c:when test="${accountMap.usertypeid eq '1'}">
				<li><a href="https://mfportfolio.dakshincapital.com/investor"><i class="fa fa-laptop fa-fw"></i> Dashboard</a></li>
				<li><a href="https://mfportfolio.dakshincapital.com/investor/profile"><i class="fa fa-user fa-fw"></i> Profile</a></li>
				<li><a href="https://mfportfolio.dakshincapital.com/investor/investor-settings"><i class="fa fa-gear fa-fw"></i> Settings</a></li>				
				</c:when>
				<c:when test="${accountMap.usertypeid eq '2' || accountMap.usertypeid eq '3' || accountMap.usertypeid eq '4'}">
				<li><a href="/"><i class="fa fa-home fa-fw"></i> Home</a></li>
				<li><a href="https://mfportfolio.dakshincapital.com/rm/investor/search"><i class="fa fa-laptop fa-fw"></i> Dashboard</a></li>
				</c:when>
				<c:when test="${accountMap.usertypeid eq '5'}">
				<li><a href="/"><i class="fa fa-home fa-fw"></i> Home</a></li>
				<li><a href="https://mfportfolio.dakshincapital.com/admin/investors"><i class="fa fa-laptop fa-fw"></i> Dashboard</a></li>
				</c:when>
				<c:otherwise>
				
				</c:otherwise>
				</c:choose>
				<li><a href="/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>	                
	            </ul>
				</div>
		        </c:when>
	       		<c:otherwise>
					<div class="col-md topper d-flex align-items-center justify-content-end col-md-2 pr-lg-2">
				    	<p class="mb-0 d-block">
				    		<a href="https://mfportfolio.dakshincapital.com" class="btn py-1 px-3 btn-primary"><span>Login</span></a>
				    	</p>
				    </div>
				     <div class="col-md topper d-flex align-items-center justify-content-end col-md-2 pl-lg-2">
				    	<p class="mb-0 d-block">
				    		<a href="https://mfportfolio.dakshincapital.com/signup" class="btn py-1 px-3 btn-primary"><span>Sign Up</span></a>
				    	</p>
				    </div>
	       		</c:otherwise>
	       		</c:choose>
			    </div>
		    </div>
	    </div>
	  </div>
   </div>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container d-flex align-items-center">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
      </button>
      <!-- <form action="#" class="searchform order-lg-last">
         <div class="form-group d-flex">
           <input type="text" class="form-control pl-3" placeholder="Search">
           <button type="submit" placeholder="" class="form-control search"><span class="ion-ios-search"></span></button>
         </div>
       </form> -->
      <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav mr-auto">
        	<li class="nav-item <c:if test="${page eq 'home' }"><c:out value="active" /></c:if>"><a href="/" class="nav-link pl-0">HOME</a></li>
        	<li class="nav-item <c:if test="${page eq 'aboutus' }"><c:out value="active" /></c:if>"><a href="/aboutus" class="nav-link">ABOUT</a></li>
        	<li class="nav-item <c:if test="${menu eq 'mf-research' }"><c:out value="active" /></c:if>"><a href="/mutual-funds-research/top-performing-mutual-funds" class="nav-link">MF RESEARCH</a></li>
        	<li class="nav-item <c:if test="${page eq 'tcalc' }"><c:out value="active" /></c:if>"><a href="/tools-and-calculators/become-a-crorepati" class="nav-link">TOOLS AND CALCULATORS</a></li>
        	<li class="nav-item <c:if test="${page eq 'blog' }"><c:out value="active" /></c:if>"><a href="/blog" class="nav-link">BLOG</a></li>
            <li class="nav-item dropdown <c:if test="${page eq 'ourproducts' }"><c:out value="active" /></c:if>">
	            <a href="/mutual-funds" class="dropdown-toggle nav-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
	            <span class="nav-label">OUR PRODUCTS</span> <span class="caret"></span></a>
	            <ul class="dropdown-menu">
	                <li class="<c:if test="${subpage eq 'mutualfunds' }"><c:out value="active" /></c:if>"><a href="/mutual-funds">Mutual Funds</a></li>
	                <li class="<c:if test="${subpage eq 'fixedincome' }"><c:out value="active" /></c:if>"><a href="/fixed-income">FD &amp; Bonds</a></li>
	                <li class="<c:if test="${subpage eq 'lifeinsurance' }"><c:out value="active" /></c:if>"><a href="/life-insurance">Life Insurance</a></li>
	                <li class="<c:if test="${subpage eq 'generalinsurance' }"><c:out value="active" /></c:if>"><a href="/general-insurance">General Insurance</a></li>
	                <li class="<c:if test="${subpage eq 'taxation' }"><c:out value="active" /></c:if>"><a href="/taxation">Taxation Service</a></li>
	            </ul>
        	</li>
        	
        	<li class="nav-item dropdown <c:if test="${page eq 'ourservices' }"><c:out value="active" /></c:if>">
	            <a href="/mutual-funds" class="dropdown-toggle nav-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
	            <span class="nav-label">OUR SERVICES</span> <span class="caret"></span></a>
	            <ul class="dropdown-menu" style="width: 275px;">
	                <li class="<c:if test="${subpage eq 'financeplan' }"><c:out value="active" /></c:if>"><a href="/finance-plan">Financial Planning</a></li>
	                <li class="<c:if test="${subpage eq 'retireplan' }"><c:out value="active" /></c:if>"><a href="/retire-plan">Retirement Planning</a></li>
	            	<li class="<c:if test="${subpage eq 'wedplan' }"><c:out value="active" /></c:if>"><a href="/wedding-plan">Education and Marriage Planning</a></li>
	                <li class="<c:if test="${subpage eq 'wealthplan' }"><c:out value="active" /></c:if>"><a href="/wealth-plan">Wealth Builder Planning</a></li>
	            </ul>
        	</li>
        	
        	<li class="nav-item dropdown <c:if test="${page eq 'faq' }"><c:out value="active" /></c:if>">
	            <a href="/mutual-funds" class="dropdown-toggle nav-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
	            <span class="nav-label">FAQ</span> <span class="caret"></span></a>
	            <ul class="dropdown-menu" style="width: 225px;">
	                <li class="<c:if test="${subpage eq 'mutual-funds' }"><c:out value="active" /></c:if>"><a href="/faq/mutual-funds">Mutual Funds</a></li>
	                <li class="<c:if test="${subpage eq 'nri-corner' }"><c:out value="active" /></c:if>"><a href="/faq/nri-corner">NRI Corner</a></li>
	            	<li class="<c:if test="${subpage eq 'financial-planning' }"><c:out value="active" /></c:if>"><a href="/faq/financial-planning">Financial Planning</a></li>	                
	            </ul>
        	</li>
        	<li class="nav-item <c:if test="${page eq 'contactus' }"><c:out value="active" /></c:if>"><a href="/contactus" class="nav-link">CONTACT US</a></li>
        </ul>
      </div>
    </div>
  </nav>
  </div>
   <!-- END nav -->