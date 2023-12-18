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
            <h1 class="mb-2 bread">NRI Corner</h1>
            <p class="breadcrumbs">
            	<span class="mr-2"><a href="/">Home <i class="ion-ios-arrow-forward"></i></a></span>
            	<span class="mr-2"><a href="/faq/nri-corner">FAQ <i class="ion-ios-arrow-forward"></i></a></span> 
            	<span>NRI Corner<i class="ion-ios-arrow-forward"></i></span>
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
								<button id="btn_head2" class="btn btn-primary btn-block  btnCol active" onclick="show_div(1)">NRI CORNER</button>
							</div>
							<div class="col-lg-2">
								<button id="btn_head1" class="btn btn-primary btn-block btnCol" onclick="show_div(2)">MUTUAL FUNDS</button>
							</div>
							<div class="col-lg-3">
								<button id="btn_head3" class="btn btn-primary btn-block btnCol" onclick="show_div(3)">FINANCIAL PLANNING</button>
							</div>
						</div>
            	
            			<h3>NRI CORNER</h3>
            			<hr/>
            			<p style="padding-bottom:20px;">As an Indian staying overseas, if you want to take advantage of the high returns over long term from your home country, you can do so by investing in various kinds of mutual funds by following some simple steps. Despite India being a developing country, the prospects of Indian equity markets, continue to be one of the best in the world and its long-term growth story remains intact. But before you go ahead with the procedures for investing in mutual funds, it is important for you to know who according to the Indian law is considered a non-resident Indian (NRI) and how they can invest or manage their mutual funds in India.</p>
					    <div class="row">
					        <div class="col-12">
					            <div class="accordion" id="faqExample">
					                
					                <div class="card">
					                    <div class="card-header p-2" id="headingOne">
					                        <h5 class="mb-0">
					                            <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
					                               Who is a NRI?
					                            </button>
					                          </h5>
					                    </div>
					
					                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#faqExample">
					                        <div class="card-body">
					                            <p>According to the Foreign Exchange Management Act (FEMA), 1999, "an NRI is a person resident outside India who is either a citizen of India or a person of Indian origin (PIO)."</p>
												<p>A person who has been in India for 182 days or more during a financial year and 265 days or more during the preceding four financial years qualifies as a NRI. NRIs can continue to enjoy non - resident status in India if their presence in India is more than 60 days but less than 182 days in a financial year, even if their stay in India during the past four financial year is 365 days or more.</p>												
												<p>Also, a person who has been deputed in a job overseas for more than 6 months, also qualifies for non-resident status.</p>												
												<p>However, those who stay abroad on business visits or medical treatment, study or such other purposes which do not indicate or mean an intention to stay there for an indefinite period are not considered NRI.</p>
					                        </div>
					                    </div>
					                </div>
					                
					                
					                <div class="card">
					                    <div class="card-header p-2" id="headingTwo">
					                        <h5 class="mb-0">
					                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
					                           Who is a person of Indian origin (PIO)?
					                        </button>
					                      </h5>
					                    </div>
					                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#faqExample">
					                        <div class="card-body">
					                            <p>A Person of Indian Origin (PIO) means a citizen of any country (other than Bangladesh or Pakistan), if he or she at any time has held an Indian passport or</p>
												<p>He or she or either of his/her parents or grandparents was a citizen of India by virtue of the constitution of India</p>
												<p>He or she is a spouse of an Indian citizen</p>
					                        </div>
					                    </div>
					                </div>
					                
					                
					                
					                <div class="card">
					                    <div class="card-header p-2" id="headingThree">
					                        <h5 class="mb-0">
					                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
					                              What is a PIO Card and how to get it?
					                            </button>
					                          </h5>
					                    </div>
					                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#faqExample">
					                        <div class="card-body">
					                            <p>Person of Indian Origin (PIO) Cards are issued by Ministry of External Affairs, Government of India to persons of Indian origin through Indian missions abroad. Specific information on rules, forms, particular offices, missions is available here <a target="_blank" href="http://mha.nic.in/pioscheme">http://mha.nic.in/pioscheme</a></p>
					                        </div>
					                    </div>
					                </div>
					                
					                
					                <div class="card">
					                    <div class="card-header p-2" id="heading4">
					                        <h5 class="mb-0">
					                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
					                               What are the different types of rupee accounts that are permitted and can be maintained by NRIs?
					                            </button>
					                          </h5>
					                    </div>
					                    <div id="collapse4" class="collapse" aria-labelledby="heading4" data-parent="#faqExample">
					                        <div class="card-body">
					                            <p>A NRI can maintain three types of rupee accounts in India as mentioned below -</p>
												<p>NRE: Non-Resident (External) Rupee Account</p>
												<p>NRO: Non-Resident (Ordinary) Rupee Account</p>
												<p>FCNR- B: Foreign Currency (Non -Resident)</p>
					                        </div>
					                    </div>
					                </div>
					            
					            <div class="card">
									<div class="card-header p-2" id="heading5">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
											    What are NRE and NRO accounts?
											</button>
										  </h5>
									</div>
									<div id="collapse5" class="collapse" aria-labelledby="heading5" data-parent="#faqExample">
										<div class="card-body">
											<p>Non-Resident (External) Rupee (NRE) Account - NRE is a rupee bank account from which funds are freely repatriable. It can be opened with either fund remitted from abroad or local funds maintained in NRE/ FCNR accounts, which can be remitted abroad. The deposits can be used for all legitimate purposes. The balance in the account is freely repatriable. Interest credited to the NRE accounts is exempt from tax in the hands of the NRI</p>
											<p>Non-Resident Ordinary Rupee (NRO) Account - NRO is a rupee bank account and can be opened with funds either remitted from abroad or generated in India. The amounts in such an account generally cannot be repatriable. However, funds in NRO accounts can be remitted abroad subject to/as per various directives in force at the time of repatriation. However, funds in NRO bank account can be remitted abroad subject to/as per various directives in force at the time of repatriation.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading6">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse6" aria-expanded="false" aria-controls="collapse6">
											     What is the distinction between NRE and NRO accounts?					
											</button>
										  </h5>
									</div>
									<div id="collapse6" class="collapse" aria-labelledby="heading6" data-parent="#faqExample">
										<div class="card-body">
											<p>Balances held in NRE accounts can be repatriated abroad freely, while funds in NRO accounts cannot be remitted abroad but have to be used only for local payments in rupees. Funds due to the non-resident accountholder which do not qualify, under the Exchange Control regulations, for remittance outside India are required to be credited to NRO accounts.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading7">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse7" aria-expanded="false" aria-controls="collapse7">
											      Which Mutual Fund houses (AMCs) accept deposit from NRIs or PIOs?				
											</button>
										  </h5>
									</div>
									<div id="collapse7" class="collapse" aria-labelledby="heading7" data-parent="#faqExample">
										<div class="card-body">
											<p>All the Asset Management Companies (AMCs) in India don't allow NRIs especially from US and Canada because of the cumbersome compliance requirements under Foreign Account Tax Compliance Act (FATCA) in these countries. However following fund houses do accept investments from NRIs from US and Canada -</p>
											<p>Aditya Birla Sun Life Mutual Fund
											ICICI Prudential Mutual Fund
											UTI Mutual Fund
											SBI Mutual Fund
											IDFC Mutual Fund
											Nippon India Mutual Fund
											Sundaram Mutual Fund
											L&T Mutual Fund
											PPFAS mutual fund</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading8">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse8" aria-expanded="false" aria-controls="collapse8">
											       What about NRIs from the rest of the world (excepting US and Canada)?		
											</button>
										  </h5>
									</div>
									<div id="collapse8" class="collapse" aria-labelledby="heading8" data-parent="#faqExample">
										<div class="card-body">
											<p>NRIs from other countries can invest in almost any scheme of any mutual fund in India. They are allowed to invest in mutual funds in India on a repatriable or non-repatriable basis subject to regulations prescribed under the Foreign Exchange Management Act (FEMA). For general NRIs (not from USA and Canada) the process of investing in Indian mutual funds is as</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading9">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse9" aria-expanded="false" aria-controls="collapse9">
											        How the dividends and redemption proceeds are paid to NRIs?		
											</button>
										  </h5>
									</div>
									<div id="collapse9" class="collapse" aria-labelledby="heading9" data-parent="#faqExample">
										<div class="card-body">
											<p>Normally, dividends and redemptions are paid through direct credit to the designated bank account provided by the NRI in the scheme.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading10">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse10" aria-expanded="false" aria-controls="collapse10">
											        Is the indexation benefit allowed to NRIs?	
											</button>
										  </h5>
									</div>
									<div id="collapse10" class="collapse" aria-labelledby="heading10" data-parent="#faqExample">
										<div class="card-body">
											<p>Yes, the indexation benefit is allowed to NRIs. Generally indexation benefit is required to be taken into account, in context to mutual fund, while calculating long term capital gains taxes for debt mutual funds.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading11">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse11" aria-expanded="false" aria-controls="collapse11">
											         What is the taxation of mutual funds for NRIs?	
											</button>
										  </h5>
									</div>
									<div id="collapse11" class="collapse" aria-labelledby="heading11" data-parent="#faqExample">
										<div class="card-body">
											<p><b>Equity or Equity oriented Mutual Funds:</b> Short term capital gains (holding period < 1 year) are taxed at 15%. Apart from tax @ 15%, 15% surcharge + 3% Cess is also payable. Thus, making it a total of 17.7675%.</p>
											<p>Long term capital gains (investments held for more than 1 year) are however completely exempt from capital gains taxes.</p>
											<p>Tax is deducted at source (TDS) @17.7675% in case of short term capital gains.</p>
											<p><b>Debt Funds:</b> Short term capital gains (holding period < 3 years) are taxed as per income tax slab of the NRI investor. A 15% surcharge + 3% Cess is also payable. For example - If a NRI is in 30% tax bracket, he or she will have to pay 35.535% of taxes.</p>
											<p>Tax is deducted at source (TDS) @35.535% in case of short term capital gains (in case of 30% tax bracket).</p>
											<p>Long term capital gains (holding period > 3 years) are taxed (provided the funds are listed) at 20% after indexation. Surcharge and cess are also payable @15% + 3% respectively. Thus, the total tax is 23.69%.</p>
											<p>Tax is deducted at source (TDS) @23.69% in case of long term capital gains in case of debt funds.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading12">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse12" aria-expanded="false" aria-controls="collapse12">
											          Is mutual fund dividends tax free for NRIs?			
											</button>
										  </h5>
									</div>
									<div id="collapse12" class="collapse" aria-labelledby="heading12" data-parent="#faqExample">
										<div class="card-body">
											<p>Dividends are tax-free in the hands of the NRI investors. However in case of dividends received from debt or hybrid debt oriented mutual funds (MIPs), the mutual fund houses pay dividend distribution tax (DDT) @ rate of 28.84% before distributing dividends.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading13">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse13" aria-expanded="false" aria-controls="collapse13">
											           How and when Tax is deducted (TDS) at source in case of NRIs?			
											</button>
										  </h5>
									</div>
									<div id="collapse13" class="collapse" aria-labelledby="heading13" data-parent="#faqExample">
										<div class="card-body">
											<p>Tax is deducted at source (TDS) @17.7675% in case of short term capital gains arising out of equity or equity oriented mutual funds.</p>
											<p>Tax is deducted at source (TDS) @35.535% in case of short term capital gains (Example - If the NRI is in 30% tax bracket).</p>
											<p>Tax is deducted at source (TDS) @23.69% in case of long term capital gains in case of debt funds. No TDS is done in case of long term capital gains arising out of equity mutual fund investments.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading14">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse14" aria-expanded="false" aria-controls="collapse14">
											            When certificate of TDS is issued to NRIs?			
											</button>
										  </h5>
									</div>
									<div id="collapse14" class="collapse" aria-labelledby="heading14" data-parent="#faqExample">
										<div class="card-body">
											<p>Like resident individuals, TDS certificates (Form 16A) are issued on a quarterly basis to NRIs and emailed to their registered email ID with the AMC or sent through post. The same can also be viewed online after registering with TRACES (TDS reconciliation Analysis and Correction Enabling System) <a href="https://nriservices.tdscpc.gov.in/nriapp/login.xhtml">https://nriservices.tdscpc.gov.in/nriapp/login.xhtml</a></p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading15">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse15" aria-expanded="false" aria-controls="collapse15">
											             What are the KYC and FATCA requirements in case of NRIs?						
											</button>
										  </h5>
									</div>
									<div id="collapse15" class="collapse" aria-labelledby="heading15" data-parent="#faqExample">
										<div class="card-body">
											<p>NRIs will need to submit following documents to the AMC (mutual fund house) or the R&T agent for fulfilling the mutual funds KYC requirements -</p>
											<p> Self attested copy of PAN
											 Self attested copy of Passport/ PIO Card
											 Address proof (both Indian and overseas)
											 Passport size photograph
											 Duly filled in KYC Form along with colour passport size photograph</p>
											<p>Additional information required for FATCA (Foreign Account Tax Compliance Act) -</p>
											<p> Tax number of country of residency (Other than India)
											 Income Slab
											 Occupation
											 Total net worth
											 Declaration, if you are politically exposed or not</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading16">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse16" aria-expanded="false" aria-controls="collapse16">
											               How to get In-person verification (IPV) done if the NRI is not in India? 						
											</button>
										  </h5>
									</div>
									<div id="collapse16" class="collapse" aria-labelledby="heading16" data-parent="#faqExample">
										<div class="card-body">
											<p>NRI can approach authorized officials of overseas branches of Scheduled Commercial Banks registered in India, notary public, Court Magistrate, Judge, Indian Embassy/Consulate General in the country of their residency. Such individuals are permitted to do IPV along with verification of originals.</p>
								
											<p>Once IPV and mandatory document verification is completed, you can send the KYC form along with the aforementioned documents to their mutual fund distributor or the fund house (AMC) or the mutual fund R&T agents (CAMS or Karvy). On submission, the KYC information will be updated in the system in a few weeks.</p>
								
											<p>The KYC details can be viewed by entering the PAN number here - <a href="https://www.cvlkra.com/kycpaninquiry.aspx ">https://www.cvlkra.com/kycpaninquiry.aspx</a></p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading17">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse17" aria-expanded="false" aria-controls="collapse17">
											                Can NRIs invest through Power of Attorney? 						
											</button>
										  </h5>
									</div>
									<div id="collapse17" class="collapse" aria-labelledby="heading17" data-parent="#faqExample">
										<div class="card-body">
											<p>After the NRI has made the initial investments, it may not be possible for him to keep track of his money and take investment decisions based on market movements that at times may call for additional purchases, switches or redemptions etc. even when he is away.</p>
											<p>Mutual funds allow a power of attorney (POA) holder to take these decisions on the behalf of the NRI investor. All that the POA holder needs to do is to submit the original POA or an attested copy of it to the fund house (AMC). The POA should have signatures of both the NRI and the POA holder. The POA holders signature will be verified for processing any such transaction.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading18">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse18" aria-expanded="false" aria-controls="collapse18">
											                 Can a NRI make a nomination in his investments?						
											</button>
										  </h5>
									</div>
									<div id="collapse18" class="collapse" aria-labelledby="heading18" data-parent="#faqExample">
										<div class="card-body">
											<p>An NRI can make a resident Indian or NRI/PIO his nominee in the mutual fund schemes in which he has invested. An NRI can also be the nominee for investments made by a local resident Indian individual. Fund houses also allow an NRI to have a joint holding with a resident Indian or another NRI / PIO in a scheme.</p>
										</div>
									</div>
								</div>
								
								<div class="card">
									<div class="card-header p-2" id="heading19">
										<h5 class="mb-0">
											<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse19" aria-expanded="false" aria-controls="collapse19">
											                  Can a NRI invest in Mutual Fund Tax Savings Schemes?						
											</button>
										  </h5>
									</div>
									<div id="collapse19" class="collapse" aria-labelledby="heading19" data-parent="#faqExample">
										<div class="card-body">
											<p>Yes, a NRI/PIO can invest in ELSS (Equity Linked Savings Schemes) of Mutual Funds if he or she is willing to avail tax rebate under Section 80C of The Income Tax Act 1961. Currently the limit is Rs. 150,000 (Rupees One Lac Fifty Thousand only) per annum.</p>
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
