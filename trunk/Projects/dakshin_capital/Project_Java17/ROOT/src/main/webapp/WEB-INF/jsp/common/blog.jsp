<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- content Start -->

    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
            <h1 class="mb-2 bread">Blog</h1>
            <p class="breadcrumbs"><span class="mr-2"><a href="/">Home <i class="ion-ios-arrow-forward"></i></a></span> <span>Blog <i class="ion-ios-arrow-forward"></i></span></p>
          </div>
        </div>
      </div>
    </section>
    
        <section class="ftco-section bg-light">
		<div class="container">
		<div class="row">
          <c:forEach items="${blogsList}" var="blogs">
          <div class="col-md-6 col-lg-4 ftco-animate">
            <div class="blog-entry">
              <a href="/blog/${fn:replace(blogs.title,' ','-')}" class="block-20 d-flex align-items-end" style='background-image: url("https://mfportfolio.dakshincapital.com/resources/images/blogs/${blogs.title_folder}/${blogs.photo}");'>
								<div class="meta-date text-center p-2">
                  <span class="day"><fmt:formatDate pattern="dd" value="${blogs.create_date}" /></span>
                  <span class="mos"><fmt:formatDate pattern="MMM" value="${blogs.create_date}" /></span>
                  <span class="yr"><fmt:formatDate pattern="yyyy" value="${blogs.create_date}" /></span>
                </div>
              </a>
              <div class="text bg-white p-4">
                <h3 class="heading">
	                <a class="d-inline-block" href="<c:url value="/blog/${fn:replace(blogs.title,' ','-')}"/>">
	                <h2><c:out value="${fn:substring(blogs.title,0,60)}" /></h2>
	                </a>
                </h3>
                <p><c:out value="${fn:substring(blogs.short_content,0,149)}" /> ...</p>
                <div class="d-flex align-items-center mt-4">
	                <p class="mb-0"><a href="<c:url value="/blog/${fn:replace(blogs.title,' ','-')}"/>" class="btn btn-primary">Read More <span class="ion-ios-arrow-round-forward"></span></a></p>
	                <p class="ml-auto mb-0">
	                	<a href="#" class="mr-2"><span class="fa fa-user"></span>&nbsp;<c:out value="${blogs.author_name}" /></a>
	                	<!-- <a href="#" class="meta-chat"><span class="ti-bookmark"></span> 3</a> -->
	                </p>
                </div>
              </div>
            </div>
          </div>
          </c:forEach>
          
        </div>
        
        <div class="row mt-3 text-center">
        <c:if test="${blogsPageCount > 1}">
                  <nav class="col blog-pagination justify-content-center d-flex block-27 text-center">
                      <ul class="pagination">
                      
					<c:choose>
						<c:when test="${pageid eq 1}">
							<li class="disabled"><a href="#" class="" aria-label="Previous">&lt;</a></li>
						</c:when>
						<c:otherwise>
							<li class=""><a href="<c:url value="?pageid=${pageid - 1}"/>" class="" aria-label="Previous">&lt;</a></li>
						</c:otherwise>
					</c:choose>
					                               
			                         <c:forEach begin="${beginPaginatorId}" end="${endPaginatorId}" step="1" varStatus="loop">
			                          <c:choose>
			  						<c:when test="${loop.index == pageid}">
			  							<li class="page-item active"><a href="<c:url value="?pageid=${loop.index}"/>" class=""><c:out value="${loop.index}"/> <span class="sr-only">(current)</span></a></li>
			  						</c:when>
			  						 <c:otherwise>
			  							<li class="page-item"><a href="<c:url value="?pageid=${loop.index}"/>" class=""><c:out value="${loop.index}"/> <span class="sr-only">(current)</span></a></li>
						     </c:otherwise>
					    </c:choose>
			                         </c:forEach>
			                         
			                         <c:choose>
					     <c:when test="${pageid eq blogsPageCount}">
					      	<li class="page-item disabled"><a href="#" class="" aria-label="Next">&gt;</a></li>
					     </c:when>
					     <c:otherwise>
					      	<li class="page-item"><a href="<c:url value="?pageid=${pageid + 1}"/>" class="" aria-label="Next">&gt;</a></li>
					     </c:otherwise>
				    </c:choose>
                      </ul>
                  </nav>
         </c:if>
	        </div>
		</div>
		</section>

<!-- content End -->