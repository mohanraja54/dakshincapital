<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
.faq p {
    padding-bottom: 10px;
}
.btnCol.active {
    background-color: #24CBE5 !important;
    border-color: #ffffff !important;
}
</style>

<script>
function show_div(id){
	if(id == 1){
		location.href = "/faq/nri-corner";
	}
	if(id == 2){
		location.href = "/faq/mutual-funds";
	}
	if(id == 3){
		location.href = "/faq/financial-planning";
	}
}
</script>

    <!-- breadcrumb start -->
	<!-- ================ -->
	<section class="hero-wrap hero-wrap-2" style="background-image: url('/images/bg_1.jpg');">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
            <h1 class="mb-2 bread">Financial Planning</h1>
            <p class="breadcrumbs">
            	<span class="mr-2"><a href="/">Home <i class="ion-ios-arrow-forward"></i></a></span>
            	<span class="mr-2"><a href="/faq/nri-corner">FAQ <i class="ion-ios-arrow-forward"></i></a></span> 
            	<span>Financial Planning<i class="ion-ios-arrow-forward"></i></span>
            </p>
          </div>
        </div>
      </div>
    </section>
	<!-- breadcrumb end -->

    <!-- about part start-->
    <section class="about_part marginTop35 marginBottom35  form-download faq">
        <div class="container">
            <div class="row justify-content-between">
            	<div class="col-md-12 marginBottom35">
            			<div class="row header_btn marginBottom35">
			       			<div class="col-lg-2">
								<button id="btn_head2" class="btn btn-primary btn-block  btnCol" onclick="show_div(1)">NRI CORNER</button>
							</div>
							<div class="col-lg-2">
								<button id="btn_head1" class="btn btn-primary btn-block btnCol" onclick="show_div(2)">MUTUAL FUNDS</button>
							</div>
							<div class="col-lg-3">
								<button id="btn_head3" class="btn btn-primary btn-block btnCol active" onclick="show_div(3)">FINANCIAL PLANNING</button>
							</div>
						</div>
            	
            			<h3>FINANCIAL PLANNING</h3>
            			<hr/>
            			<p>Every financial decision in your life should be based on some goal. The financial goal can be building a retirement nest egg, saving for your childrenâ€™s college education or their wedding, saving for a down-payment for property purchase, protecting your family from financial distress due to unforeseen risks, protecting your family from health risks, protecting your home or business from fire or other hazards., planning a foreign trip etc, but unless you have an investment objective, you will not be able to make the right decisions. Financial planning, whether formal or informal, is a process where youÂ define your goals in quantitative termsÂ and then, formulate a plan which will help you meet all the different financial goals at different stages in your life.</p>
            			<p style="padding-bottom:10px;"></p>
					    <div class="row">
					        <div class="col-12">
					            <div class="accordion" id="faqExample">
					                
					                <div class="card">
					                    <div class="card-header p-2" id="headingOne">
					                        <h5 class="mb-0">
					                            <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
					                                 What is Financial Planning?
					                            </button>
					                          </h5>
					                    </div>
					
					                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#faqExample">
					                        <div class="card-body">
					                            <p>Financial planning is no different from a structured problem solving framework. Every structured business problem solving exercises has specific steps (the same can be applied in financial planning as well). However, there are broadly 6 steps in the financial planning process. Most certified financial planners (CFPs) and financial advisers will be very familiar with these steps. However, investors should understand that, while financial planners or CFPs can play an important role in the financial planning process, the success of the financial plan ultimately depends on the investor. Therefore, it will be useful for investors to familiarize themselves with the process, so that they can work efficiently and effectively with their financial planners or advisers.</p>
					                        </div>
					                    </div>
					                </div>
					                
					                
					                <div class="card">
					                    <div class="card-header p-2" id="headingTwo">
					                        <h5 class="mb-0">
					                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
					                            Step - 1: Understanding and defining the life goals
					                        </button>
					                      </h5>
					                    </div>
					                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#faqExample">
					                        <div class="card-body">
					                            <p>The first step of financial planning process is to understand and define your specific goals. The more specific the goals are the better it is. Sometimes, you may not have enough clarity about all the financial goals in your life. An expert financial planner can help you define the goals across your savings and investment lifecycle and determine the specific numbers you need to reach for each of the specific goals. You should remember that a financial plan is not working towards a singular goal, like retirement planning, Childrenâ€™s education or marriage or buying a home etc.</p>
												<p>A financial plan includes multiple goals across your savings and investment lifecycle. However, you should establish definite time frames for achievement of each of these goals. Even though, ideally, we would like to achieve or even exceed all our financial goals, it is useful to prioritize the goals, especially if there are constraints with regards to how much you can invest and save. For example, you may prioritize your childâ€™s higher education over buying a house or some other financial goals. The financial planner will take your priority into consideration, when developing your financial plan. Once the financial goals and the priorities are determined, the financial planner or adviser will examine these goals in respect to your resources and other constraints, if any. The objective of this step is to help you define specific, realistic, actionable financial goals.</p>
					                        </div>
					                    </div>
					                </div>
					                
					                
					                
					                <div class="card">
					                    <div class="card-header p-2" id="headingThree">
					                        <h5 class="mb-0">
					                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
					                                Step - 2: Collecting and consolidating data through personal meeting
					                            </button>
					                          </h5>
					                    </div>
					                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#faqExample">
					                        <div class="card-body">
					                            <p>The second step in the financial planning process is to collect the data regarding the your income, expenses, existing fixed and financial assets, life and health insurance, lifestyle & other important expenses, your family structure and other liabilities that will form the inputs in your financial plan. The Financial planner may employ different methods to collect the data from you. Some financial planners or advisers may send you a survey form or questionnaire that you will have to filled out and send back to the financial planner.</p>
												<p>Many financial planners prefer face to face meetings with their clients to collect this data. Face to face meetings is often more effective than just sending a survey form or questionnaire. Through a face to face interaction, the financial planner or adviser can clarify certain details about you that the questionnaire may not be able to. A personal meeting also helps the investors clarify doubts, expectations or share additional details with their financial planners or advisers. We recommend that, you should have a face to face meeting, even if your financial planner does not ask for one. It is always helpful for you.</p>
												<p>Whatever the method is for interaction and data gathering, it is always beneficial for you to share as much information as possible with your financial planner. Withholding financial or other important information from him is never useful. You should remember that the role of the financial planner or adviser is very much like a family physician. Just like, we should share all medical and health related information with our family physician, we should share all our financial information or any other information that may potentially have an impact on our financial situation with our financial planner</p>
					                        </div>
					                    </div>
					                </div>
					                
					                
					                <div class="card">
					                    <div class="card-header p-2" id="heading4">
					                        <h5 class="mb-0">
					                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
					                                 Step - 3: Detailed analysis and suggestions
					                            </button>
					                          </h5>
					                    </div>
					                    <div id="collapse4" class="collapse" aria-labelledby="heading4" data-parent="#faqExample">
					                        <div class="card-body">
					                            <p>The third step of the financial planning process is the data analysis part. The financial planner will review your financial situation - assets & liabilities, current cash flow statements, debt or loan situation, existing insurance policies (both life and non-life insurance), exiting savings & investments and other legal documents (if required). Through a structured financial analysis process, the financial planner will determine your asset allocation strategy and insurance (life and health/ critical illness) needs to meet your financial objectives. The financial planner may also suggest additional life and health insurance, if he or she determines, based on your financial analysis, that you are not adequately insured.</p>
												<p>What is your responsibility at this stage? While all the work in this step is done by the financial planner, as an investor, you should also involve yourself in this process by scheduling review of the plan and making sure that you understand the analysis. After all, it is your financial plan!</p>
					                        </div>
					                    </div>
					                </div>
					            
					            <div class="card">
									<div class="card-header p-2" id="heading5">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
											     Step - 4: Asset allocation strategies and investment recommendations
											</button>
										  </h5>
									</div>
									<div id="collapse5" class="collapse" aria-labelledby="heading5" data-parent="#faqExample">
										<div class="card-body">
											<p>After the above 3 steps are covered, your financial planner will make the actual recommendation with respect to your comprehensive financial plan. This will include yourÂ asset allocation strategy based on your risk profile, alternate investment options like, mutual funds, equities, traditional debts, tax saving strategies, life and non-life insurance requirements etc. Your financial planner should schedule a meeting with you, to discuss these recommendations. This is a very important step in the whole process as you should make sure that you understand all the recommendations he or she has made and the reasons thereof.</p>
											<p>At this stage, you should ask him/ her as many questions as you would like to, regarding each strategy or product investment recommendations, because they will be crucial in meeting your financial objectives. You should note that the final investment decisions rest with you, and therefore you should ensure that you are comfortable with the financial plan drawn and its execution strategy. Recommendations can change during this step and altered based on your inputs to the financial planner.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading6">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse6" aria-expanded="false" aria-controls="collapse6">
											       Step - 5: Filing up the necessary investment forms and understanding terms & conditions				
											</button>
										  </h5>
									</div>
									<div id="collapse6" class="collapse" aria-labelledby="heading6" data-parent="#faqExample">
										<div class="card-body">
											<p>The penultimate step of the financial planning process is the implementation of the investorâ€™s financial plan. This involves the actual process of purchasing the investment and insurance or other products. At this stage various regulatory and procedural requirements need to be fulfilled, depending on the each product involved. As an investor, you may have to submit the documentation for Know Your Client (KYC), fill up the application forms for mutual funds, opening of Demat and share trading accounts for equity investing, and finalising proposal forms forÂ life and non-life insurance plans.</p>
											<p>Your financial adviser will play a big role in fulfilling these requirements, including collecting the documents for KYC and helping you in filling out the application or proposal forms. However, it is important, that you remain involved in the entire process. Even if you delegate the responsibility of filling the major portions application or proposal forms to him, make sure you verify the information in the forms post t is filled up, to ensure nothing is incorrectly stated. You should also carefully read the brochures/ scheme information documents of the products that you are investing in, so that you understand all the terms and conditions of the product(s).</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading7">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse7" aria-expanded="false" aria-controls="collapse7">
											        Step - 6: Track investments and review the financial plan regularly			
											</button>
										  </h5>
									</div>
									<div id="collapse7" class="collapse" aria-labelledby="heading7" data-parent="#faqExample">
										<div class="card-body">
											<p>The final step of the financial planning process is to monitor and tracking the progress made on your financial plan. You should review your financial plan in order to evaluate the effect of changes in your income levels, your financial situation, tax obligations, new tax rules, new products and changes in market conditions. Normally, your financial planner should schedule meetings with you at a regular frequency (once every 6 month or 12 months) to review your portfolio and discuss if any change needs to be made in your financial plan, asset allocation strategies and investments.</p>
											<p>But even if your financial planner does not schedule regular review meetings, you should insist on meeting with him/ her at some regular frequency, e.g. Semi-annually or annually etc. At the end of the day, it is your financial plan and your financial future is at stake. Therefore, the onus is really on you, to make sure that your financial plan is on track. Also, you should remember that financial planning is not a static, but a dynamic exercise. Your financial situation, goals and aspirations may change over a period of time. Therefore, you should meet with your financial planner or adviser on a regular basis, to ensure that your portfolio is doing well and at the same time, ensure that any change to your financial situation, goals or aspirations is appropriately reflected in your financial plan, and executed upon.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading8">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse8" aria-expanded="false" aria-controls="collapse8">
											         What are the benefits of Financial Planning?		
											</button>
										  </h5>
									</div>
									<div id="collapse8" class="collapse" aria-labelledby="heading8" data-parent="#faqExample">
										<div class="card-body">
											<p>There are many benefits of having a financial plan. Once you have defined the specific goals and save or invest for it, you actually start a journey which helps you reach your financial goals. A financial plan actually helps you lead a disciplined and stress free life so that you can enjoy the life to the fullest. We will now discuss the various benefits of having a financial Plan.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading9">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse9" aria-expanded="false" aria-controls="collapse9">
											          Aware about financial goals 		
											</button>
										  </h5>
									</div>
									<div id="collapse9" class="collapse" aria-labelledby="heading9" data-parent="#faqExample">
										<div class="card-body">
											<p>The first step of financial planning is toÂ define specific goals. The more specific the goals are the better. As an investor, especially if you are young, you may not have enough clarity about all the financial goals in your life. This is where an expert financial planner helps you. Through a financial planning process, the biggest benefit is that you can define the goals across your savings and investment lifecycle and save towards it for achieving the different life goals. Investing or saving without knowing the goals is like embarking on a journey without knowing the destination.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading10">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse10" aria-expanded="false" aria-controls="collapse10">
											         Emphasis on budgeting	
											</button>
										  </h5>
									</div>
									<div id="collapse10" class="collapse" aria-labelledby="heading10" data-parent="#faqExample">
										<div class="card-body">
											<p>The next benefit of financial planning is budgeting. This is probably the most important step of financial planning, but also the most ignored one. Even if you have the most detailed and well-structured financial plan, if you are not able to save enough, you will not be able to meet your financial goals. Saving habits are very personal, depending on your lifestyle, relative to your income levels.</p>
											<p>While the financial planner may not actually prepare your budget, he or she can help you give you guidance on how to prepare one. Budgeting is not a hugely time consuming exercise. While preparing your budget, you should try, as much as possible, not to skip minor details, because through a careful budgeting you may be able to identify expenses, which you can easily reduce, without any noticeable impact on your lifestyle.</p>
											<p>Remember, through budgeting even if you can make a small additional savings. It will have a big difference to your long term wealth as power of compounding helps over long term. Just to give you an example, even an additional Rs 500 monthly savings, invested in equity assets yielding 20% return, will generate a corpus in excess ofÂ RsÂ 1 Crore over 30 years. Therefore, financial plan teaches you the importance of budgeting and helps you save more.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading11">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse11" aria-expanded="false" aria-controls="collapse11">
											           Asset allocation based investing
											</button>
										  </h5>
									</div>
									<div id="collapse11" class="collapse" aria-labelledby="heading11" data-parent="#faqExample">
										<div class="card-body">
											<p>How you invest your save (debt or equity or real estate), plays a very important role in ensuring the success of your goals. Different asset classes have different risk return characteristics. Too much risk can result in loss of money, while too little risk may prevent you from meeting your long term financial objectives.Â While drawing your financial plan the emphasis is on Asset allocationÂ which is the process of balancing your risk and return objectives.</p>
											<p>It is one of the most important aspects of financial planning. You can reap rich benefits if you just follow the provided guidance on asset allocation in your financial plan. Asset allocation is the only sure shot way for you to meet your short term, medium term and long term financial objectives.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading12">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse12" aria-expanded="false" aria-controls="collapse12">
											           Know your risk			
											</button>
										  </h5>
									</div>
									<div id="collapse12" class="collapse" aria-labelledby="heading12" data-parent="#faqExample">
										<div class="card-body">
											<p>Having a financial plan helps you prepare forÂ risks. Risks are unforeseen events that can cause financial distress. The worst case contingency is an untimely death, which can result in financial distress for the family, apart from the emotional trauma. Financial planning can help us prepare for such contingencies through adequateÂ life insurance. Another contingency is serious illness that can have an impact on your savings and consequently your short term or long term financial objectives. A good financial plan will make adequate provisions forÂ health insurance and critical illness. There can also be otherÂ contingenciesÂ like temporary loss of income or major unforeseen expenditures. Financial plans helps you prepare for such contingencies.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading13">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse13" aria-expanded="false" aria-controls="collapse13">
											             Tax Planning		
											</button>
										  </h5>
									</div>
									<div id="collapse13" class="collapse" aria-labelledby="heading13" data-parent="#faqExample">
										<div class="card-body">
											<p>It is another important aspect of financial planning. When you have income, you come under the ambit of tax. Tax planning starts when a person starts working and continues almost through-out oneâ€™s life, even after retirement. Different investment products are subject to different tax treatments. Financial planning can not only help you save taxes (under Section 80C, Section 80CCD, Section 80D etc.) every year.</p>
											<p>The benefit of having a financial plan is that it helps you reduce the taxes which you have to pay on your investment income or profit, by saving in various tax planning avenues.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading14">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse14" aria-expanded="false" aria-controls="collapse14">
											             What are liquid funds?			
											</button>
										  </h5>
									</div>
									<div id="collapse14" class="collapse" aria-labelledby="heading14" data-parent="#faqExample">
										<div class="card-body">
											<p>Liquid fund are money market mutual funds and invest primarily in money market instruments like treasury bills, certificate of deposits and commercial papers and term deposits, with the objective of providing investors an opportunity to earn returns, without compromising on the liquidity of the investment. Typically they invest in money market securities that have a residual maturity of less than or equal to 91 days. This helps the fund managers of liquid funds in meeting the redemption demand from the investors.</p>
											<p>Liquid funds provide a better alternative to investors who keep their surplus money parked in a savings bank account. While savings bank accounts typically pay interest rates in the range of 4 to 5%, liquid funds can potentially give much higher returns. Compared to other mutual fund categories, these funds have very low risk. Key benefits of liquid funds are:-</p>
											<p><b>1. High liquidity:</b> Liquid funds do not have any exit load. Therefore, they can be redeemed any time after investment without any penalty.</p>
											<p><b>2. Higher returns than savings bank:</b> Liquid funds give higher returns than savings bank. Savings bank interest rate is around 4%, whereas liquid funds can give higher returns by at least a few percentage points. The returns of liquid funds rise when bond yields rise and fall when bond yield, but they can always provide higher returns than savings bank</p>
											<p><b>3. Low volatility:</b> Liquid funds are less volatile than longer term debt funds, since the underlying securities in their investment portfolio have short durations. Fixed income securities with short durations or maturities have lower interest rate risk, since the probability of the interest rates changing before the maturity of the securities is lower.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading15">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse15" aria-expanded="false" aria-controls="collapse15">
											               Advantages of starting early						
											</button>
										  </h5>
									</div>
									<div id="collapse15" class="collapse" aria-labelledby="heading15" data-parent="#faqExample">
										<div class="card-body">
											<p>If you start your financial planningÂ early in your working careersÂ it will give you a head start in meeting your financial objectives even earlier. Saving and investment is not the most important priority for many young professionals. While lifestyle is an important consideration for many young people, you should be careful to not build a liability in your personal balance sheet. Economic lessons learnt from the west over the past 2 decades have taught us that we can easily get into debt trap without even realizing. Young people should think long term, because a small amount of money savedÂ nowÂ can create wealth for you in the future.</p>
											<p>The benefit of having a financial plan earlier in your work career will put your savings and investment on autopilot mode, with minimal impact on your lifestyle. You will realize the benefits of early financial planning, when you approach important life goals, like buying your house, funding your childrenâ€™s higher education, your own retirement etc. Early start can also help you buy adequate life and health insurance at much lower premium as the premiums rise rapidly as your age increases.</p>
										</div>
									</div>
								</div>

						</div>
					        </div>
					    </div>
					    <!--/row-->
            	</div>
        </div>
        </div>
    </section>
    <!-- about part start-->
