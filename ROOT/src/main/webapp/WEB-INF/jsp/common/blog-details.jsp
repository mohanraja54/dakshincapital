<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- content Start -->

    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
            <h1 class="mb-2 bread"><c:out value="${blogs.title}" /></h1>
            <p class="breadcrumbs"><span class="mr-2"><a href="/">Home <i class="ion-ios-arrow-forward"></i></a></span> <span class="mr-2"><a href="/blog">Blog <i class="ion-ios-arrow-forward"></i></a></span> <span><c:out value="${blogs.title}" /> <i class="ion-ios-arrow-forward"></i></span></p>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section">
			<div class="container">
				<div class="row">
          <div class="col-lg-8 ftco-animate">
            <h2 class="mb-3"><c:out value="${blogs.title}" /></h2>
            <p>
              <img src="<c:url value="https://mfportfolio.dakshincapital.com/resources/images/blogs/${blogs.title_folder}/${blogs.photo}"/>" alt="" class="img-fluid">
            </p>
           <c:out value="${blogs.content}" escapeXml="false"></c:out>
          </div> <!-- .col-md-8 -->

          <div class="col-lg-4 sidebar ftco-animate">
          
          	 <aside class="sidebar-box ftco-animate">
                 <h3 class="widget_title">Recent Post</h3>
                 <c:forEach items="${blogsList}" var="blogs">
                 <div class="media post_item">
                     <img src="<c:url value="/resources/images/blogs/${blogs.title_folder}/${blogs.photo}"/>" width="80" height="80" alt="post">
                     <div class="media-body">
                         <a href="/blog/${blogs.title}">
                             <h3><c:out value="${blogs.title}" /></h3>
                         </a>
                         <p><fmt:formatDate pattern="MMMM dd, yyyy" value="${blogs.create_date}" /></p>
                     </div>
                 </div>
                 </c:forEach>
             </aside>
          
           <%--  <div class="sidebar-box ftco-animate">
              <h3>Category</h3>
              <ul class="categories">
              <c:forEach items="${categoryList}" var="list">
                <li><a href="/blog/${list}">${list} <span>(${blogs.viewed_count})</span></a></li>

              </c:forEach>
              </ul>
            </div> --%>
            
            <div class="sidebar-box ftco-animate">
              <h3>MF PERFORMANCE</h3>
              <ul class="categories">
                <li><a href="/mutual-funds-research/top-performing-mutual-funds">Top Performing Mutual Funds</a></li>
                <li><a href="/mutual-funds-research/mutual-fund-sip-investment-calculator">SIP Return Calculator</a></li>
                <li><a href="/mutual-funds-research/sip-with-annual-increase">SIP with Annual Increase</a></li>
                <li><a href="/mutual-funds-research/top-dividend-paying-mutual-funds">Top Dividend Paying Mutual Funds</a></li>
                <li><a href="/mutual-funds-research/mutual-funds-performance-comparison">Mutual Funds Performance Comparison</a></li>
                <li><a href="/mutual-funds-research/top-performing-sip-plans-elss-funds">Top Performing SIP ELSS Funds</a></li>
              </ul>
            </div>

          </div><!-- END COL -->
        </div>
			</div>
		</section>

<!-- content End -->