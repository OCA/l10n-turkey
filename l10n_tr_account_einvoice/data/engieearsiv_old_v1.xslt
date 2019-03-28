<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:un:unece:uncefact:documentation:2" xmlns:clm54217="urn:un:unece:uncefact:codelist:specification:54217:2001" xmlns:clm5639="urn:un:unece:uncefact:codelist:specification:5639:1988" xmlns:clm66411="urn:un:unece:uncefact:codelist:specification:66411:2001" xmlns:clmIANAMIMEMediaType="urn:un:unece:uncefact:codelist:specification:IANAMIMEMediaType:2003" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="cac cbc ccts clm54217 clm5639 clm66411 clmIANAMIMEMediaType fn link n1 qdt udt xbrldi xbrli xdt xlink xs xsd xsi">
	<xsl:decimal-format name="european" decimal-separator="," grouping-separator="." NaN=""/>
	<xsl:output version="4.0" omit-xml-declaration="yes" method="html" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
	<xsl:param name="SV_OutputFormat" select="'HTML'"/>
	<xsl:variable name="XML" select="/"/>
	<xsl:template match="/">
		<html>
			<head>
				<title/>
				<style type="text/css"> 
				body{background-color:#FFFFFF;font-family:'Tahoma', "Times New Roman", Times, serif;font-size:11px;color:#666666;}
				h1, h2{padding-bottom:3px;padding-top:3px;margin-bottom:5px;text-transform:uppercase;font-family:Arial, Helvetica, sans-serif;}
				h1{font-size:1.4em;text-transform:none;}
				h2{font-size:1em;color:brown;}
				h3{font-size:1em;color:#333333;text-align:justify;margin:0;padding:0;}
				h4{font-size:1.1em;font-style:bold;font-family: Arial, Helvetica, sans-serif;color:#000000;margin:0;padding:0;}
				hr{height:2px;color:#000000;background-color:#000000;border-bottom:1px solid #000000;}
				p, ul, ol{margin-top:1.5em;}
				ul, ol{margin-left:3em;}
				blockquote{margin-left:3em;margin-right:3em;font-style:italic; }
				a{text-decoration:none;color:#70A300;}
				a:hover{border:none;color:#70A300;}
				#despatchTable{border-collapse:collapse;font-size:11px;float:right;border-color:gray;}
				#ettnTable{border-collapse:collapse;font-size:11px;border-color:gray;}
				#customerPartyTable{border-width:0px;border-style:inset;border-color:gray;border-collapse:collapse;}
				#customerIDTable{border-width:2px;border-style:inset;border-color:gray;border-collapse:collapse; }
				#customerIDTableTd{border-width:2px;border-style:inset;border-color:gray;border-collapse:collapse;}
				#lineTable{border-width:2px;border-style:inset;border-color:black;border-collapse:collapse;}
				#lineTableTd{font-size:10px;border-width:1px;padding:1px;border-style:inset;border-color:black;background-color:white;}
				#IADETD{font-size:11px;border-width:2px;padding:1px;border-style:inset;border-color:black;background-color:white;}
				#lineTableTr{border-width:1px;padding:0px;border-style:inset;border-color:black;background-color:white;}
				#lineTableDummyTd{border-width:0px;border-color:white;padding:1px;border-style:inset;border-color:black;background-color:white;}
				#lineTableBudgetTd{border-width:0px;border-spacing:0px;padding:1px;border-style:inset;border-color:black;background-color:white;}
				#notesTable{border-width:0px;border-style:inset;border-color:black;border-collapse:collapse;}
				#notesTableTd{border-width:0px;border-style:inset;border-color:black;border-collapse:collapse;}
				#KutuTable{border-width:2px;border-style:inset;border-color:black;border-collapse:collapse;}
				#KutuTableTd{border-width:1px;border-style:inset;border-color:black;border-collapse:collapse;}
				#IadeTable{border-width:2px;border-style:inset;border-color:black;border-collapse:collapse;}
				#IadeTableTd{border-width:0px;border-style:inset;border-color:black;border-collapse:collapse;}
				table{border-spacing:0px;}
				#budgetContainerTable{border-width:0px;border-spacing:0px;border-style:inset;border-color:black;border-collapse:collapse;
				td{border-color:gray;}
				#iptal{font-size: 150pt;opacity: 0.5;color: red;position: absolute;top: 550px;left: 220px;}
				.checkboxFive {
	width: 25px;
	margin: 20px 100px;
	position: relative;
}
.checkboxFive label {
	cursor: pointer;
	position: absolute;
	width: 25px;
	height: 25px;
	top: 0;
  	left: 0;
	background: #eee;
	border:1px solid #ddd;
}
.checkboxFive label:after {
	opacity: 0.2;
	content: '';
	position: absolute;
	width: 9px;
	height: 5px;
	background: transparent;
	top: 6px;
	left: 7px;
	border: 3px solid #333;
	border-top: none;
	border-right: none;

	transform: rotate(-45deg);
}
.checkboxFive label:hover::after {
	opacity: 0.5;
}

 
.checkboxFive input[type=checkbox]:checked + label:after {
	opacity: 1;
}
</style>
				<title>e-Arşiv</title>
			</head>
			<body style="margin-left=0.6in; margin-right=0.6in; margin-top=0.79in; margin-bottom=0.79in">
				<xsl:for-each select="$XML">
								<table style="border-color:blue; " border="0" cellspacing="0px" width="800" cellpadding="0px">
						<tbody>
							<tr valign="top">
								<td width="40%">
								<img align="left" valign="top" src="data:image/png;base64,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">
					</img>
								</td>
							</tr>
						</tbody></table>
					<table style="border-color:blue; " border="0" cellspacing="0px" width="800" cellpadding="0px">
						<tbody>
							<tr valign="top">
								<td width="40%">
									<br/>
									<table align="center"  width="100%" id="KutuTable"  >
										<tbody>
										 
											<tr align="left"   >
												<xsl:for-each select="//n1:Invoice">
													<xsl:for-each select="cac:AccountingSupplierParty">
														<xsl:for-each select="cac:Party">
															<td align="left">
																<xsl:if test="cac:PartyName">
																	<xsl:value-of select="cac:PartyName/cbc:Name"/>
																	<br/>
																</xsl:if>
																<xsl:for-each select="cac:Person">
																	<xsl:for-each select="cbc:Title">
																		<xsl:apply-templates/>
																		<span>
																			<xsl:text>&#160;</xsl:text>
																		</span>
																	</xsl:for-each>
																	<xsl:for-each select="cbc:FirstName">
																		<xsl:apply-templates/>
																		<span>
																			<xsl:text>&#160;</xsl:text>
																		</span>
																	</xsl:for-each>
																	<xsl:for-each select="cbc:MiddleName">
																		<xsl:apply-templates/>
																		<span>
																			<xsl:text>&#160;</xsl:text>
																		</span>
																	</xsl:for-each>
																	<xsl:for-each select="cbc:FamilyName">
																		<xsl:apply-templates/>
																		<span>
																			<xsl:text>&#160;</xsl:text>
																		</span>
																	</xsl:for-each>
																	<xsl:for-each select="cbc:NameSuffix">
																		<xsl:apply-templates/>
																	</xsl:for-each>
																</xsl:for-each>
															</td>
														</xsl:for-each>
													</xsl:for-each>
												</xsl:for-each>
											</tr>
											<tr align="left">
												<!--<b>Merkez</b>-->
												<xsl:for-each select="//n1:Invoice">
													<xsl:for-each select="cac:AccountingSupplierParty">
														<xsl:for-each select="cac:Party">
															<td align="left">
																<xsl:for-each select="cac:PostalAddress">
																	<xsl:for-each select="cbc:StreetName">
																		<xsl:apply-templates/>
																		<span>
																			<xsl:text>&#160;</xsl:text>
																		</span>
																	</xsl:for-each>
																	<xsl:for-each select="cbc:BuildingName">
																		<xsl:apply-templates/>
																	</xsl:for-each>
																	<xsl:if test="cbc:BuildingNumber">
																		<span>
																			<xsl:text> No:</xsl:text>
																		</span>
																		<xsl:for-each select="cbc:BuildingNumber">
																			<xsl:apply-templates/>
																		</xsl:for-each>
																		<span>
																			<xsl:text>&#160;</xsl:text>
																		</span>
																	</xsl:if>
																	<br/>
																	<xsl:for-each select="cbc:PostalZone">
																		<xsl:apply-templates/>
																		<span>
																			<xsl:text>&#160;</xsl:text>
																		</span>
																	</xsl:for-each>
																	<xsl:for-each select="cbc:CitySubdivisionName">
																		<xsl:apply-templates/>
																	</xsl:for-each>
																	<span>
																		<xsl:text>/ </xsl:text>
																	</span>
																	<xsl:for-each select="cbc:CityName">
																		<xsl:apply-templates/>
																		<span>
																			<xsl:text>&#160;</xsl:text>
																		</span>
																	</xsl:for-each>
																</xsl:for-each>
															</td>
														</xsl:for-each>
													</xsl:for-each>
												</xsl:for-each>
											</tr>
											<xsl:if test="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone or //n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telefax">
												<tr align="left">
													<xsl:for-each select="//n1:Invoice">
														<xsl:for-each select="cac:AccountingSupplierParty">
															<xsl:for-each select="cac:Party">
																<td align="left">
																	<xsl:for-each select="cac:Contact">
																		<xsl:if test="cbc:Telephone">
																			<span>
																				<xsl:text>Tel: </xsl:text>
																			</span>
																			<xsl:for-each select="cbc:Telephone">
																				<xsl:apply-templates/>
																			</xsl:for-each>
																		</xsl:if>
																		<xsl:if test="cbc:Telefax">
																			<span>
																				<xsl:text> Fax: </xsl:text>
																			</span>
																			<xsl:for-each select="cbc:Telefax">
																				<xsl:apply-templates/>
																			</xsl:for-each>
																		</xsl:if>
																		<span>
																			<xsl:text>&#160;</xsl:text>
																		</span>
																	</xsl:for-each>
																</td>
															</xsl:for-each>
														</xsl:for-each>
													</xsl:for-each>
												</tr>
											</xsl:if>
											<xsl:for-each select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cbc:WebsiteURI">
												<tr align="left">
													<td>
														<xsl:text>Web Sitesi: </xsl:text>
														<xsl:value-of select="."/>
													</td>
												</tr>
											</xsl:for-each>
											<xsl:for-each select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail">
												<tr align="left">
													<td>
														<xsl:text>E-Posta: </xsl:text>
														<xsl:value-of select="."/>
													</td>
												</tr>
											</xsl:for-each>
											<tr align="left">
												<xsl:for-each select="//n1:Invoice">
													<xsl:for-each select="cac:AccountingSupplierParty">
														<xsl:for-each select="cac:Party">
															<td align="left">
																<span>
																	<xsl:text>Vergi Dairesi: </xsl:text>
																</span>
																<xsl:for-each select="cac:PartyTaxScheme">
																	<xsl:for-each select="cac:TaxScheme">
																		<xsl:for-each select="cbc:Name">
																			<xsl:apply-templates/>
																		</xsl:for-each>
																	</xsl:for-each>
																	<span>
																		<xsl:text>&#160; </xsl:text>
																	</span>
																</xsl:for-each>
															</td>
														</xsl:for-each>
													</xsl:for-each>
												</xsl:for-each>
											</tr>
											<xsl:for-each select="//n1:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification">
												<tr align="left">
													<td>
														<xsl:value-of select="cbc:ID/@schemeID"/>
														<xsl:text>: </xsl:text>
														<xsl:value-of select="cbc:ID"/>
													</td>
												</tr>
											</xsl:for-each>
										</tbody>
									</table>
									 
								</td>
								<td width="20%" align="center" valign="middle">
									<br/>
									<br/>
									<img style="width:91px;" align="middle" alt="E-Fatura Logo" src="data:image/jpeg;base64,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"/>
									<h1 align="center">
										<span style="font-weight:bold;">
											<xsl:text>e-Arşiv Fatura</xsl:text>
										</span>
									</h1>
								</td>
								<td width="220px">
								<table valign="top" align="right" >
								<tr>
								<td>
								<table id="KutuTable"  width="260px" valign="top" align="right" height="13">
										<tbody>
											<xsl:if test="//n1:Invoice/cbc:InvoiceTypeCode">
												<tr style="height:13px;">
													<td align="left">
														<span style="font-weight:bold;">
															<xsl:text>Fatura Tipi:</xsl:text>
														</span>
													</td>
													<td align="left">
														<xsl:for-each select="//n1:Invoice">
															<xsl:for-each select="cbc:InvoiceTypeCode">
																<xsl:apply-templates/>
															</xsl:for-each>
														</xsl:for-each>
													</td>
												</tr>
											</xsl:if>
											<tr>
												<td align="left">
													<span style="font-weight:bold;">
														<xsl:text>Belge No:</xsl:text>
													</span>
												</td>
												<td align="left">
													<xsl:for-each select="//n1:Invoice">
														<xsl:for-each select="cbc:ID">
															<xsl:apply-templates/>
														</xsl:for-each>
													</xsl:for-each>
												</td>
											</tr>
											<tr>
												<td align="left">
													<span style="font-weight:bold;">
														<xsl:text>Fatura Tarihi:</xsl:text>
													</span>
												</td>
												<td align="left">
													<xsl:for-each select="//n1:Invoice">
														<xsl:for-each select="cbc:IssueDate">
															<xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/>
														</xsl:for-each>
														<xsl:text> </xsl:text>
														<xsl:for-each select="cbc:IssueTime">
															<xsl:value-of select="substring(.,1,5)"/>
														</xsl:for-each>
													</xsl:for-each>
												</td>
											</tr>
											<tr>
												<td align="left">
													<span style="font-weight:bold;">
														<xsl:text>Düzenlenme Tarihi:</xsl:text>
													</span>
												</td>
												<td align="left">
													<xsl:for-each select="//n1:Invoice">
														<xsl:for-each select="cac:AdditionalDocumentReference">
															<xsl:if test="cbc:ID = 'duzenlemeTarihi'">
																<xsl:for-each select="cbc:IssueDate">
																	<xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/>
																</xsl:for-each>
															</xsl:if>
														</xsl:for-each>
														<xsl:text> </xsl:text>
													</xsl:for-each>
												</td>
											</tr>
											<tr>
												<td align="left">
													<span style="font-weight:bold;">
														<xsl:text>Düzenlenme Zamanı:</xsl:text>
													</span>
												</td>
												<td align="left">
													<xsl:for-each select="//n1:Invoice">
														<xsl:for-each select="cac:AdditionalDocumentReference">
															<xsl:if test="cbc:ID = 'duzenlemeTarihi'">
																<xsl:value-of select="cbc:DocumentType"/>
															</xsl:if>
														</xsl:for-each>
														<xsl:text> </xsl:text>
													</xsl:for-each>
												</td>
											</tr>
											<xsl:for-each select="//n1:Invoice/cac:DespatchDocumentReference">
												<tr>
													<td align="left">
														<span style="font-weight:bold;">
															<xsl:text>İrsaliye No:</xsl:text>
														</span>
														<span>
															<xsl:text>&#160;</xsl:text>
														</span>
													</td>
													<td align="left">
														<xsl:value-of select="cbc:ID"/>
													</td>
												</tr>
												<tr>
													<td align="left">
														<span style="font-weight:bold;">
															<xsl:text>İrsaliye Tarihi:</xsl:text>
														</span>
													</td>
													<td align="left">
														<xsl:for-each select="cbc:IssueDate">
															<xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/>
														</xsl:for-each>
													</td>
												</tr>
											</xsl:for-each>
											<xsl:if test="//n1:Invoice/cac:OrderReference">
												<tr>
													<td align="left">
														<span style="font-weight:bold;">
															<xsl:text>Sipariş No:</xsl:text>
														</span>
													</td>
													<td align="left">
														<xsl:for-each select="//n1:Invoice/cac:OrderReference">
															<xsl:for-each select="cbc:ID">
																<xsl:apply-templates/>
															</xsl:for-each>
														</xsl:for-each>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test="//n1:Invoice/cac:OrderReference/cbc:IssueDate">
												<tr>
													<td align="left">
														<span style="font-weight:bold;">
															<xsl:text>Sipariş Tarihi:</xsl:text>
														</span>
													</td>
													<td align="left">
														<xsl:for-each select="//n1:Invoice/cac:OrderReference">
															<xsl:for-each select="cbc:IssueDate">
																<xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/>
															</xsl:for-each>
														</xsl:for-each>
													</td>
												</tr>
											</xsl:if>
											<xsl:for-each select ="//n1:Invoice/cac:AdditionalDocumentReference">
												<xsl:if test ="cbc:ID = 'faturaIptal' and cbc:DocumentType = '1'">
													<tr condition="//n1:Invoice/cac:OrderReference"> 
														<td align="left" id="lineTableTd">
															<strong style="color: rgb(105, 105, 105); font-family: verdana, geneva, sans-serif; font-size: 10px;">İptal Tarihi:</strong>
														</td> 
														<td id="lineTableTd">
															<span style="color: rgb(105, 105, 105);">
																<span style="font-size: 10px;">
																	<span style="font-family: verdana,geneva,sans-serif;">
																		<xsl:for-each select="cbc:IssueDate">
																			<xsl:value-of select="substring(.,9,2)"	/>-<xsl:value-of select="substring(.,6,2)" />-<xsl:value-of select="substring(.,1,4)" />
																		</xsl:for-each>
																		<div id="iptal">İptal</div>
																	</span>
																</span>
															</span>
														</td> 
													</tr>
												</xsl:if> 
											</xsl:for-each>
										</tbody>
										
									</table>
						 
								</td>
								</tr>
								<tr>
								<td><br/></td>
								</tr>
								<tr>
								<td>
								<table id="KutuTable" width="260px" align="right" >
									
									<tr style="height:13px;">
										<td align="left" valign="top">
											<span style="font-weight:bold;">
												<xsl:text>ETTN: </xsl:text>
											</span>
										</td>
										<td align="left" width="220px">
											<xsl:for-each select="//n1:Invoice">
												<xsl:for-each select="cbc:UUID">
													<xsl:apply-templates/>
												</xsl:for-each>
											</xsl:for-each>
										</td>
									</tr>
								</table>
								</td>
								</tr>
								</table>
								
									</td>
							</tr>
							<tr style="height:118px; " valign="top">
								<td width="40%" align="right" valign="bottom">
								
								
									<table id="customerPartyTable" align="left" border="0" height="50%"  >
										<tbody>
											<tr style="height:71px; ">
												<td>
													 
													<table id="KutuTable"  align="center"  >
														<tbody>
															<tr>
																<xsl:for-each select="//n1:Invoice">
																	<xsl:for-each select="cac:AccountingCustomerParty">
																		<xsl:for-each select="cac:Party">
																			<td style="width:469px; " align="left">
																	<!--			<span style="font-weight:bold;">
																					<xsl:text>SAYIN</xsl:text>
																				</span>-->
																			</td>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</tr>
															<tr>
																<xsl:for-each select="//n1:Invoice">
																	<xsl:for-each select="cac:AccountingCustomerParty">
																		<xsl:for-each select="cac:Party">
																			<td style="width:469px; " align="left">
																			<span style="font-weight:bold;">
																					<xsl:text>Nihai Tüketici: </xsl:text>
																				</span>
																				<xsl:if test="cac:PartyName">
																					<xsl:value-of select="cac:PartyName/cbc:Name"/>
																					<br/>
																				</xsl:if>
																				<xsl:for-each select="cac:Person">
																					<xsl:for-each select="cbc:Title">
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</xsl:for-each>
																					<xsl:for-each select="cbc:FirstName">
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</xsl:for-each>
																					<xsl:for-each select="cbc:MiddleName">
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</xsl:for-each>
																					<xsl:for-each select="cbc:FamilyName">
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</xsl:for-each>
																					<xsl:for-each select="cbc:NameSuffix">
																						<xsl:apply-templates/>
																					</xsl:for-each>
																				</xsl:for-each>
																			</td>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</tr>
															<tr>
																<xsl:for-each select="n1:Invoice">
																	<xsl:for-each select="cac:AccountingCustomerParty">
																		<xsl:for-each select="cac:Party">
																			<td style="width:469px; " align="left">
																				<xsl:for-each select="cac:PostalAddress">
																					<xsl:for-each select="cbc:StreetName">
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</xsl:for-each>
																					<xsl:for-each select="cbc:BuildingName">
																						<xsl:apply-templates/>
																					</xsl:for-each>
																					<xsl:for-each select="cbc:BuildingNumber">
																						<span>
																							<xsl:text> No:</xsl:text>
																						</span>
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</xsl:for-each>
																					<br/>
																					<xsl:for-each select="cbc:Room">
																						<span>
																							<xsl:text>Kapı No:</xsl:text>
																						</span>
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</xsl:for-each>
																					<br/>
																					<xsl:for-each select="cbc:PostalZone">
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</xsl:for-each>
																					<xsl:for-each select="cbc:CitySubdivisionName">
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>/ </xsl:text>
																						</span>
																					</xsl:for-each>
																					<xsl:for-each select="cbc:CityName">
																						<xsl:apply-templates/>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</xsl:for-each>
																				</xsl:for-each>
																			</td>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</tr>
															<xsl:for-each select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cbc:WebsiteURI">
																<tr align="left">
																	<td>
																		<xsl:text>Web Sitesi: </xsl:text>
																		<xsl:value-of select="."/>
																	</td>
																</tr>
															</xsl:for-each>
															<xsl:for-each select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail">
																<tr align="left">
																	<td>
																		<xsl:text>E-Posta: </xsl:text>
																		<xsl:value-of select="."/>
																	</td>
																</tr>
															</xsl:for-each>
															<xsl:for-each select="//n1:Invoice">
																<xsl:for-each select="cac:AccountingCustomerParty">
																	<xsl:for-each select="cac:Party">
																		<xsl:for-each select="cac:Contact">
																			<xsl:if test="cbc:Telephone or cbc:Telefax">
																				<tr align="left">
																					<td style="width:469px; " align="left">
																						<xsl:for-each select="cbc:Telephone">
																							<span>
																								<xsl:text>Tel: </xsl:text>
																							</span>
																							<xsl:apply-templates/>
																						</xsl:for-each>
																						<xsl:for-each select="cbc:Telefax">
																							<span>
																								<xsl:text> Fax: </xsl:text>
																							</span>
																							<xsl:apply-templates/>
																						</xsl:for-each>
																						<span>
																							<xsl:text>&#160;</xsl:text>
																						</span>
																					</td>
																				</tr>
																			</xsl:if>
																			<xsl:if test="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name">
																				<tr align="left">
																					<td>
																						<span>
																							<xsl:text>Vergi Dairesi: </xsl:text>
																							<xsl:value-of select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name"/>
																						</span>
																					</td>
																				</tr>
																			</xsl:if>
																		</xsl:for-each>
																	</xsl:for-each>
																</xsl:for-each>
															</xsl:for-each>
															<xsl:for-each select="//n1:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification">
																<tr align="left">
																	<td>
																		<xsl:value-of select="cbc:ID/@schemeID"/>
																		<xsl:text>: </xsl:text>
																		<xsl:value-of select="cbc:ID"/>
																	</td>
																</tr>
															</xsl:for-each>
														</tbody>
													</table>
													
												</td>
											</tr>
										</tbody>
									</table>
									<br/>
								</td>
								<td width="20%">
								<img width="80%" valign="top" align="right" src="data:image/gif;base64,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" /></td>
								<td width="40%"  align="right" valign="top"  >
									
						
										</td>
										
							</tr>
							<tr align="left">
									</tr>
						</tbody>
					</table>
					<div id="lineTableAligner">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</div>
					<table   width="800">
						<tbody>
						<tr>
						<td colspan="6" width="65%" ></td>
						<td colspan="4"  width="35%" ID="IADETD" >
						&#160;&#160;&#160;&#160;&#160;İADE BÖLÜMÜ
						</td>
						
						</tr>
						</tbody>
						</table>
					<table border="1" id="lineTable" width="800">
						<tbody>
						 
							<tr id="lineTableTr">
								<!--<td id="lineTableTd" style="width:2%"  align="center">
									<span style="font-weight:bold;">
										<xsl:text>Sıra No</xsl:text>
									</span>
								</td>
								-->
								<td id="lineTableTd" style="width:10%"  align="center">
									<span style="font-weight:bold;">
										<xsl:text>Stok Kodu</xsl:text>
									</span>
								</td>
								<td id="lineTableTd" style="width:20%" align="center">
									<span style="font-weight:bold;">
										<xsl:text>Açıklama</xsl:text>
									</span>
								</td>
								<!--<td id="lineTableTd" style="width:7%" align="center">
									<span style="font-weight:bold;">
										<xsl:text>Satır Açıklaması</xsl:text>
									</span>
								</td>
								-->
								<td id="lineTableTd" style="width:5%"  align="center">
									<span style="font-weight:bold;">
										<xsl:text>KDV</xsl:text>
									</span>
								</td>
								<td id="lineTableTd" style="width:10%"  align="center">
									<span style="font-weight:bold;">
										<xsl:text>Adet</xsl:text>
									</span>
								</td>
								<td id="lineTableTd" style="width:10%" align="center">
									<span style="font-weight:bold;">
										<xsl:text>Birim Fiyat</xsl:text>
									</span>
								</td>
							 
								<td id="lineTableTd" style="width:10%" align="center">
									<span style="font-weight:bold;">
										<xsl:text>Tutar</xsl:text>
									</span>
								</td>
								<td id="lineTableTd" style="width:5%" align="center">
									<span style="font-weight:bold;">
										<xsl:text>İade</xsl:text>
									</span>
								</td>
								<td id="lineTableTd" style="width:10%" align="center">
									<span style="font-weight:bold;">
										<xsl:text>İade Miktarı</xsl:text>
									</span>
								</td>
								<td id="lineTableTd" style="width:10%" align="center">
									<span style="font-weight:bold;">
										<xsl:text>Birim Fiyat</xsl:text>
									</span>
								</td>
								<td id="lineTableTd" style="width:10%" align="center">
									<span style="font-weight:bold;">
										<xsl:text>Tutar</xsl:text>
									</span>
								</td>
							</tr>
							<xsl:if test="count(//n1:Invoice/cac:InvoiceLine) &gt;= 20">
								<xsl:for-each select="//n1:Invoice/cac:InvoiceLine">
									<xsl:apply-templates select="."/>
								</xsl:for-each>
							</xsl:if>
							<xsl:if test="count(//n1:Invoice/cac:InvoiceLine) &lt; 20">
							<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[1]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[1]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[1]/cbc:ID = 1">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
											<!--	 <xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[2]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[2]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[1]/cbc:ID = 1">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[3]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[3]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[2]/cbc:ID = 2">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[4]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[4]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[3]/cbc:ID = 3">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[5]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[5]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[4]/cbc:ID = 4">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[6]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[6]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[5]/cbc:ID = 5">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[7]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[7]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[6]/cbc:ID = 6">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[8]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[8]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[7]/cbc:ID = 7">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[9]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[9]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[8]/cbc:ID = 8">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[10]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[10]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[9]/cbc:ID = 9">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[11]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[11]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[10]/cbc:ID = 10">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[12]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[12]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[11]/cbc:ID = 11">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[13]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[13]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[12]/cbc:ID = 12">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[14]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[14]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[13]/cbc:ID = 13">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[15]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[15]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[14]/cbc:ID = 14">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[16]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[16]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[15]/cbc:ID = 15">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[17]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[17]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[16]/cbc:ID = 16">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[18]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[18]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[17]/cbc:ID = 17">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[19]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[19]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[18]/cbc:ID = 18">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[20]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[20]"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:choose>
											<xsl:when test="//n1:Invoice/cac:InvoiceLine[19]/cbc:ID = 19">
												<xsl:call-template name="geneliskonto" />
											</xsl:when>
											<xsl:otherwise>
												<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
											</xsl:otherwise>
										</xsl:choose>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[21]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[21]"/>
									</xsl:when>
									<xsl:otherwise>
										<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="//n1:Invoice/cac:InvoiceLine[22]">
										<xsl:apply-templates select="//n1:Invoice/cac:InvoiceLine[22]"/>
									</xsl:when>
									<xsl:otherwise>
										<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</tbody>
					</table>
				</xsl:for-each>
				<br/>
				<br/>
				<table>
				<tr>
				<td  width="530px" >
				<table id="notesTable" width="530px" align="left" height="120">
					<tbody>
						<tr align="left">
							<td id="notesTableTd">
								<xsl:if test="//n1:Invoice/cac:PaymentMeans/cbc:InstructionNote">
									<b>&#160;&#160;&#160;&#160;&#160; Ödeme Notu:&#160;&#160;</b>
									<xsl:value-of select="//n1:Invoice/cac:PaymentMeans/cbc:InstructionNote"/>
									<br/>
								</xsl:if>
								<xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
									<xsl:if test="normalize-space(cac:TaxCategory/cbc:TaxExemptionReason)">
										<b>&#160;&#160;&#160;&#160;&#160; Vergi muafiyet sebebi:&#160;&#160;</b>
										<xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReason"/>
										<br/>
									</xsl:if>
								</xsl:for-each>
								<xsl:if test="//n1:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:PaymentNote">
									<b>&#160;&#160;&#160;&#160;&#160; Hesap Açıklaması:&#160;&#160;</b>
									<xsl:value-of select="//n1:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:PaymentNote"/>
									<br/>
								</xsl:if>
								<xsl:if test="//n1:Invoice/cac:PaymentTerms/cbc:Note">
									<b>&#160;&#160;&#160;&#160;&#160; Ödeme Koşulu:&#160;&#160;</b>
									<xsl:value-of select="//n1:Invoice/cac:PaymentTerms/cbc:Note"/>
									<br/>
								</xsl:if>
								<br/>
								<br/>
								<xsl:if test="//n1:Invoice/cbc:Note">
									<b>&#160;&#160;&#160;&#160;&#160; Genel Açıklamalar</b>
									<br/>
									<xsl:for-each select="//n1:Invoice/cbc:Note">
										<b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</b>
										<xsl:value-of select="."/>
										<br/>
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="cbc:ID = 'internetSatisBilgi/gonderiBilgileri/gonderiTasiyan/gercekKisi/tckn'">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<b>Taşıyıcı TCKN: </b>
													<xsl:value-of select="cbc:DocumentType"/>
													<br/>
												</xsl:if>
												<xsl:if test="cbc:ID = 'internetSatisBilgi/gonderiBilgileri/gonderiTasiyan/tuzelKisi/vkn'">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<b>Taşıyıcı VKN: </b>
													<xsl:value-of select="cbc:DocumentType"/>
													<br/>
												</xsl:if>
												<xsl:if test="cbc:ID = 'internetSatisBilgi/gonderiBilgileri/gonderiTasiyan/gercekKisi/adiSoyadi'">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<b>Taşıyıcı Adı Soyadı: </b>
													<xsl:value-of select="cbc:DocumentType"/>
													<br/>
												</xsl:if>
												<xsl:if test="cbc:ID = 'internetSatisBilgi/gonderiBilgileri/gonderiTasiyan/tuzelKisi/unvan'">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<b>Taşıyıcı Unvanı: </b>
													<xsl:value-of select="cbc:DocumentType"/>
													<br/>
												</xsl:if>
                <br/>
                <xsl:if test="//n1:Invoice/cac:BillingReference/cac:AdditionalDocumentReference/cbc:DocumentTypeCode = 'OKCBF'">
                  <b>&#160;&#160;&#160;&#160;&#160; Okc Bilgi Fişi Detayları</b>
                  <br/>
                  <xsl:for-each select="//n1:Invoice/cac:BillingReference">
                    <b>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</b>
                    <b>
                      <xsl:text>Fiş No:</xsl:text>
                    </b>
                    <xsl:value-of select="//n1:Invoice/cbc:ID"/>
                    <xsl:text>, </xsl:text>
                    <b>
                      <xsl:text>Fiş Tarihi:</xsl:text>
                    </b>
                    <xsl:for-each select="cac:AdditionalDocumentReference/cac:ValidityPeriod/cbc:StartDate">
                      <xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/>
                    </xsl:for-each>
                    <xsl:text>, </xsl:text>
                    <b>
                      <xsl:text>Fiş Saati:</xsl:text>
                    </b>
                    <xsl:value-of select="cac:AdditionalDocumentReference/cac:ValidityPeriod/cbc:StartTime"/>
                    <xsl:text>, </xsl:text>
                    <b>
                      <xsl:text>Fiş Tipi:</xsl:text>
                    </b>
                    <xsl:value-of select="cac:AdditionalDocumentReference/cbc:DocumentDescription"/>
                    <xsl:text>, </xsl:text>
                    <b>
                      <xsl:text>Z Rapor No:</xsl:text>
                    </b>
                    <xsl:value-of select="cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference/cbc:URI"/>
                    <xsl:text>, </xsl:text>
                    <b>
                      <xsl:text>Seri No:</xsl:text>
                    </b>
                    <xsl:value-of select="cac:AdditionalDocumentReference/cac:IssuerParty/cbc:EndpointID"/>
                    <br/>
                  </xsl:for-each>
                </xsl:if>                
								<br/>
							
								
							</td>
						</tr>
					</tbody>
				</table>
				</td>
				<td width="270px" valign="top" >
						<table id="" width="270px">
					<tr id="" align="right">
						<td id="" align="left"  >
						
						</td>
						<td id="" align="right" width="270px">
							<span style="font-weight:bold;">
								<xsl:text>FATURA TOPLAMI</xsl:text>
							</span>
						</td>
						<td id="" style="width:81px; " align="right">
							<span>
								<xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount, '###.##0,00', 'european')"/>
								<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID">
									<xsl:text> </xsl:text>
									<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID='TRY'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID!='TRY'">
										<xsl:value-of select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID"/>
									</xsl:if>
								</xsl:if>
							</span>
						</td>
					</tr>
					<xsl:if test="not(//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount=0)">
					<tr id="" align="right">
						<td id=""/>
						<td id="" align="right" width="270px">
							<span style="font-weight:bold;">
								<xsl:text>Toplam İskonto</xsl:text>
							</span>
						</td>
						<td id="lineTableBudgetTd" width="81px" align="right">
							<span>
								<xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount, '###.##0,00', 'european')"/>
								<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID">
									<xsl:text> </xsl:text>
									<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID='TRY'">
										<xsl:text>TL</xsl:text>
									</xsl:if>
									<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID!='TRY'">
										<xsl:value-of select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID"/>
									</xsl:if>
								</xsl:if>
							</span>
						</td>
					</tr>
					</xsl:if>
					<xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
						<xsl:choose>
							<xsl:when test="not(cbc:Percent = 0.0000) or not(cbc:TaxAmount = 0)">
								<tr id="budgetContainerTr" align="right">
									<td id="budgetContainerDummyTd"/>
									<td id="lineTableBudgetTd" width="270px" align="right">
										<span style="font-weight:bold; ">
											<xsl:choose>
												<xsl:when test="cac:TaxCategory/cac:TaxScheme/cbc:Name=''">
													<xsl:text>Diğer Vergiler Toplamı </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text> </xsl:text>
													<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:if test ="cbc:Percent">
												<xsl:text>(%</xsl:text>
												<xsl:value-of select=" format-number(cbc:Percent, '###.##0,00', 'european')"/>
												<xsl:text>)</xsl:text>
											</xsl:if>
										</span>
									</td>
									<td id="lineTableBudgetTd" style="width:82px; " align="right">
										<xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
											<xsl:text> </xsl:text>
											<xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
											<xsl:if test="../../cbc:TaxAmount/@currencyID">
												<xsl:text> </xsl:text>
												<xsl:if test="../../cbc:TaxAmount/@currencyID='TRY'">
													<xsl:text>TL</xsl:text>
												</xsl:if>
												<xsl:if test="../../cbc:TaxAmount/@currencyID!='TRY'">
													<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
												</xsl:if>
											</xsl:if>
										</xsl:for-each>
									</td>
								</tr>
							</xsl:when>
							<xsl:when test="cbc:Percent = 0.0000 or cbc:TaxAmount = 0">
								<tr id="budgetContainerTr" align="right">
									<td id="budgetContainerDummyTd"/>
									<td id="lineTableBudgetTd" width="270px" align="right">
										<span style="font-weight:bold;">
											<xsl:choose>
												<xsl:when test="cac:TaxCategory/cac:TaxScheme/cbc:Name=''">
													<xsl:text>Diğer Vergiler Toplamı </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>Hesaplanan </xsl:text>
													<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:if test ="cbc:Percent">
												<xsl:text>(%</xsl:text>
												<xsl:value-of select=" format-number(cbc:Percent, '###.##0,00', 'european')"/>
												<xsl:text>)</xsl:text>
											</xsl:if>
										</span>
									</td>
									<td id="lineTableBudgetTd" style="width:82px; " align="right">
										<xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
											<xsl:text> </xsl:text>
											<xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
											<xsl:if test="../../cbc:TaxAmount/@currencyID">
												<xsl:text> </xsl:text>
												<xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRY'">
													<xsl:text>TL</xsl:text>
												</xsl:if>
												<xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRY'">
													<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
												</xsl:if>
											</xsl:if>
										</xsl:for-each>
									</td>
								</tr>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
					<xsl:for-each select="//n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal">
						<xsl:if test="not(cbc:Percent = 0.0000) or not(cbc:TaxAmount = 0)">
							<tr id="budgetContainerTr" align="right">
								<td id="budgetContainerDummyTd"/>
								<td id="lineTableBudgetTd" width="270px" align="right">
									<span style="font-weight:bold; ">
										<xsl:choose>
											<xsl:when test="cac:TaxCategory/cac:TaxScheme/cbc:Name=''">
												<xsl:text>Diğer Vergiler Toplamı </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>Tevkifat (</xsl:text>
												<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>
												<xsl:text>-</xsl:text>
												<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
												<xsl:text>)</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:if test ="cbc:Percent">
											<xsl:text>(%</xsl:text>
											<xsl:value-of select=" format-number(cbc:Percent, '###.##0,00', 'european')"/>
											<xsl:text>)</xsl:text>
										</xsl:if>
									</span>
								</td>
								<td id="lineTableBudgetTd" style="width:82px; " align="right">
									<xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
										<xsl:text> </xsl:text>
										<xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
										<xsl:if test="../../cbc:TaxAmount/@currencyID">
											<xsl:text> </xsl:text>
											<xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRY'">
												<xsl:text>TL</xsl:text>
											</xsl:if>
											<xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRY'">
												<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
											</xsl:if>
										</xsl:if>
									</xsl:for-each>
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>
          <xsl:if test = "n1:Invoice/cac:InvoiceLine[cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme]">
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd"/>
              <td id="lineTableBudgetTd" width="270px" align="right">
                <span style="font-weight:bold; ">
                  <xsl:text>Tevkifata Tabi İşlem Tutarı</xsl:text>
                </span>
              </td>
              <td id="lineTableBudgetTd" style="width:82px; " align="right">
                <xsl:if test = "n1:Invoice/cac:InvoiceLine[cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme]">
                  <xsl:value-of
										select="format-number(sum(n1:Invoice/cac:InvoiceLine[cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme]/cbc:LineExtensionAmount), '###.##0,00', 'european')"/>
                </xsl:if>
                <xsl:if test = "//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=&apos;9015&apos;">
                  <xsl:value-of
										select="format-number(sum(n1:Invoice/cac:InvoiceLine[cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:LineExtensionAmount), '###.##0,00', 'european')"/>
                </xsl:if>
                <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode = 'TRL' or n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                  <xsl:text>TL</xsl:text>
                </xsl:if>
                <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode != 'TRL' and n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                  <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                </xsl:if>
              </td>
            </tr>
            <tr id="budgetContainerTr" align="right">
              <td id="budgetContainerDummyTd"/>
              <td id="lineTableBudgetTd" width="270px" align="right">
                <span style="font-weight:bold; ">
                  <xsl:text>Tevkifata Tabi İşlem Üzerinden Hes. KDV</xsl:text>
                </span>
              </td>
              <td id="lineTableBudgetTd" style="width:82px; " align="right">
                <xsl:if test = "n1:Invoice/cac:InvoiceLine[cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme]">
                  <xsl:value-of
										select="format-number(sum(n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme]/cbc:TaxableAmount), '###.##0,00', 'european')"/>
                </xsl:if>
                <xsl:if test = "//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=&apos;9015&apos;">
                  <xsl:value-of
										select="format-number(sum(n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:TaxableAmount), '###.##0,00', 'european')"/>
                </xsl:if>
                <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode = 'TRL' or n1:Invoice/cbc:DocumentCurrencyCode = 'TRY'">
                  <xsl:text>TL</xsl:text>
                </xsl:if>
                <xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode != 'TRL' and n1:Invoice/cbc:DocumentCurrencyCode != 'TRY'">
                  <xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
                </xsl:if>
              </td>
            </tr>
          </xsl:if>
          <!--<tr id="budgetContainerTr" align="right">
						<td id="budgetContainerDummyTd"/>
						<td id="lineTableBudgetTd" width="270px" align="right">
							<span style="font-weight:bold;">
								<xsl:text>Vergiler Dahil Toplam Tutar</xsl:text>
							</span>
						</td>
						<td id="lineTableBudgetTd" style="width:82px; " align="right">
							<xsl:for-each select="//n1:Invoice">
								<xsl:for-each select="cac:LegalMonetaryTotal">
									<xsl:for-each select="cbc:TaxInclusiveAmount">
										<xsl:value-of select="format-number(., '###.##0,00', 'european')"/>
										<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID">
											<xsl:text> </xsl:text>
											<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID='TRY'">
												<xsl:text>TL</xsl:text>
											</xsl:if>
											<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID!='TRY'">
												<xsl:value-of select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID"/>
											</xsl:if>
										</xsl:if>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</td>
					</tr>
					-->
					<tr id="budgetContainerTr" align="right">
						<td id="budgetContainerDummyTd"/>
						<td id="lineTableBudgetTd" width="270px" align="right">
							<span style="font-weight:bold;">
								<xsl:text>GENEL TOPLAM</xsl:text>
							</span>
						</td>
						<td id="lineTableBudgetTd" style="width:82px; " align="right">
							<xsl:for-each select="//n1:Invoice">
								<xsl:for-each select="cac:LegalMonetaryTotal">
									<xsl:for-each select="cbc:PayableAmount">
										<xsl:value-of select="format-number(., '###.##0,00', 'european')"/>
										<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID">
											<xsl:text> </xsl:text>
											<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID='TRY'">
												<xsl:text>TL</xsl:text>
											</xsl:if>
											<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID!='TRY'">
												<xsl:value-of select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/>
											</xsl:if>
										</xsl:if>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:for-each>
						</td>
					</tr>
				</table>
				<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID != 'TRY'">
					<table id="budgetContainerTable" width="800px">
						<tr id="budgetContainerTr2" align="right">
							<td id="budgetContainerDummyTd"/>
							<td id="lineTableBudgetTd" width="270px" align="right">
								<span style="font-weight:bold;">
									<xsl:text>Döviz Kuru</xsl:text> 
								</span>
							</td>
							<td id="lineTableBudgetTd" width="082px" align="right">
								<xsl:value-of select="format-number(//n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,0000', 'european')"/>
								<xsl:text> </xsl:text>
								<xsl:text>TL</xsl:text>
							</td>
						</tr>
						<tr id="budgetContainerTr" align="right">
							<td id="budgetContainerDummyTd"/>
							<td id="lineTableBudgetTd" width="270px" align="right">
								<span style="font-weight:bold;">
									<xsl:text>Malzeme/Hizmet Toplam Tutarı</xsl:text>
								</span>
							</td>
							<td id="lineTableBudgetTd" width="082px" align="right">
								<span>
									<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
										<xsl:if test="cbc:DocumentType = 'LINEEXTENSIONAMOUNT'">
											<xsl:value-of select="cbc:ID"/>
										</xsl:if>
									</xsl:for-each>
									<xsl:text> </xsl:text>
									<xsl:text>TL</xsl:text>
								</span>
							</td>
						</tr>
						        
					 
						<xsl:if test="not(cbc:AllowanceTotalAmount=0)">
						<tr id="budgetContainerTr" align="right">
							<td id="budgetContainerDummyTd"/>
							<td id="lineTableBudgetTd" width="270px" align="right">
								<span style="font-weight:bold;">
									<xsl:text>Toplam İskonto</xsl:text>
								</span>
							</td>
							<td id="lineTableBudgetTd" width="082px" align="right">
								<span>
									<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
										<xsl:if test="cbc:DocumentType = 'ALLOWANCETOTALAMOUNT'">
											<xsl:value-of select="cbc:ID"/>
										</xsl:if>
									</xsl:for-each>
									<xsl:text> </xsl:text>
									<xsl:text>TL</xsl:text>
								</span>
							</td>
						</tr>
						</xsl:if>
					 
						<xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
							<xsl:if test="not(cbc:TaxAmount=0)">
								<tr id="budgetContainerTr" align="right">
									<td id="budgetContainerDummyTd"/>
									<td id="lineTableBudgetTd" width="270px" align="right">
										<span style="font-weight:bold; ">
											<xsl:choose>
												<xsl:when test="cac:TaxCategory/cac:TaxScheme/cbc:Name=''">
													<xsl:text>Diğer Vergiler Toplamı </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>Hesaplanan </xsl:text>
													<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:if test="(cbc:Percent='')">
												<xsl:text> </xsl:text>
											</xsl:if>
											<xsl:if test="cbc:Percent !=''">
												<xsl:text>(%</xsl:text>
												<xsl:value-of select=" format-number(cbc:Percent, '###.##0,00', 'european')"/>
												<xsl:text>)</xsl:text>
											</xsl:if>
										</span>
									</td>									
									<td id="lineTableBudgetTd" style="width:82px; " align="right">
										<xsl:text> </xsl:text>
										<xsl:variable name="var_Percent" select="cbc:Percent"/>
										<xsl:variable name="var_TaxTypeCode" select="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>
										<xsl:variable name="var_Name" select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>


										<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
											<xsl:if test="(cbc:DocumentTypeCode = $var_TaxTypeCode) and (not(cbc:ID=0))" >                        
												<xsl:choose>
													<xsl:when test="(cbc:DocumentType = $var_Percent) and (cbc:DocumentDescription = $var_Name)">
														<xsl:value-of select="format-number(cbc:ID, '###.##0,00', 'european')"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:if test="not($var_Percent) and not(cbc:DocumentType) and (cbc:DocumentDescription = $var_Name)">
															<xsl:value-of select="format-number(cbc:ID, '###.##0,00', 'european')"/>
														</xsl:if>                           
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>                   
										</xsl:for-each>

										<xsl:text>&#160;TL</xsl:text>                 
									</td>
								</tr>
							</xsl:if>
						</xsl:for-each>        
						<xsl:for-each select="//n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal">
							<xsl:if test="not(cbc:TaxAmount = 0)">
								<tr id="budgetContainerTr" align="right">
									<td id="budgetContainerDummyTd"/>
									<td id="lineTableBudgetTd" width="270px" align="right">
										<span style="font-weight:bold; ">
											<xsl:choose>
												<xsl:when test="cac:TaxCategory/cac:TaxScheme/cbc:Name=''">
													<xsl:text>Diğer Vergiler Toplamı </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>Tevkifat (</xsl:text>
													<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>
													<xsl:text>-</xsl:text>
													<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
													<xsl:text>)</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:if test="(cbc:Percent='')">
												<xsl:text> </xsl:text>
											</xsl:if>
											<xsl:if test="cbc:Percent !=''">
												<xsl:text>(%</xsl:text>
												<xsl:value-of select="format-number(cbc:Percent, '###.##0,00', 'european')"/>
												<xsl:text>)</xsl:text>
											</xsl:if>
										</span>
									</td>
									<td id="lineTableBudgetTd" style="width:82px; " align="right">
										<xsl:text> </xsl:text>
										<xsl:variable name="var_Percent" select="cbc:Percent"/>
										<xsl:variable name="var_TaxTypeCode" select="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>
										<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
											<xsl:if test="cbc:DocumentTypeCode = $var_TaxTypeCode">
												<xsl:value-of select="format-number(cbc:ID, '###.##0,00', 'european')"/>
											</xsl:if>
										</xsl:for-each>
										<xsl:text> </xsl:text>
										<xsl:text>TL</xsl:text>
									</td>
								</tr>
							</xsl:if>
						</xsl:for-each>
						<!--<tr id="budgetContainerTr" align="right">
							<td id="budgetContainerDummyTd"/>
							<td id="lineTableBudgetTd" width="270px" align="right">
								<span style="font-weight:bold;">
									<xsl:text>Vergiler Dahil Toplam Tutar</xsl:text>
								</span>
							</td>
							<td id="lineTableBudgetTd" width="082px" align="right">
								<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
									<xsl:if test="cbc:DocumentType = 'TAXINCLUSIVEAMOUNT'">
										<xsl:value-of select="cbc:ID"/>
									</xsl:if>
								</xsl:for-each>
								<xsl:text> </xsl:text>
								<xsl:text>TL</xsl:text>
							</td>
						</tr>
						-->
						<tr id="budgetContainerTr2" align="right">
							<td id="budgetContainerDummyTd"/>
							<td id="lineTableBudgetTd" width="270px" align="right">
								<span style="font-weight:bold;">
									<xsl:text>GENEL TOPLAM</xsl:text>
								</span>
							</td>
							<td id="lineTableBudgetTd" width="082px" align="right">
								<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
									<xsl:if test="cbc:DocumentType = 'PAYABLEAMOUNT'">
										<xsl:value-of select="cbc:ID"/>
									</xsl:if>
								</xsl:for-each>
								<xsl:text> </xsl:text>
								<xsl:text>TL</xsl:text>
							</td>
						</tr>
					</table>
				</xsl:if>
				
				</td> 
				</tr>
				</table>
		<br/>
					<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
									<xsl:if test="cbc:ID = 'EINVOICE'">
										<xsl:if test="cbc:DocumentType=3">
										<br/> 
											<b>&#160;&#160;&#160;&#160;&#160; MÜŞTERİ İADE BİLGİLERİ</b> 
											<table Id="KutuTable" width="800px">
											<tr>
											<td width="20%"><B>Müşteri Adı - Soyadı:</B></td>
											<td width="40%"><B></B></td>
											<td width="20%"><B>Tarih:</B></td>
											<td width="20%"><B></B></td>
											</tr>
											<tr>
											<td width="20%"><B>Müşteri Adresi:</B></td>
											<td width="40%"><B></B></td>
											<td width="20%"><B>Müşteri İmzası:</B></td>
											<td width="20%"><B></B></td>
											</tr>
											<tr>
											<td colspan="4"><br/><br/></td>
											</tr>
											</table>
																 
                      &#160;&#160;&#160;&#160;&#160; LÜTFEN İADELER İÇİN BU FATURAYI KULLANIN. <br/>
											 
											<br/> 	 
																						 
                      &#160;&#160;&#160;&#160;&#160; DETAYLI BİLGİ İÇİN, WWW.ENGIEEVDE.COM.TR <br/>
											 
											<br/>  
                      &#160;&#160;&#160;&#160;&#160; Bu satış internet üzerinden yapılmıştır.<br/>
											 
											<br/> 
											<xsl:for-each select="//n1:Invoice/cac:AdditionalDocumentReference">
												<xsl:if test="cbc:ID = 'internetSatisBilgi/webAdresi'">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<b>Satış İşleminin Yapıldığı Web Adresi: </b>
													<xsl:value-of select="cbc:DocumentType"/>
													<br/>
												</xsl:if>
												<xsl:if test="cbc:ID = 'internetSatisBilgi/odemeAracisiAdi'">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<b>Ödeme Aracısı: </b>
													<xsl:value-of select="cbc:DocumentType"/>
													<br/>
												</xsl:if>
												<xsl:if test="cbc:ID = 'internetSatisBilgi/odemeSekli'">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<b>Ödeme Şekli: </b>
													<xsl:value-of select="cbc:DocumentType"/>
													<br/>
												</xsl:if>
												<xsl:if test="cbc:ID = 'internetSatisBilgi/odemeTarihi'">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<b>Ödeme Tarihi: </b>
													<xsl:value-of select="cbc:DocumentType"/>
													<br/>
												</xsl:if>
												<xsl:if test="cbc:ID = 'internetSatisBilgi/gonderiBilgileri/gonderimTarihi'">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<b>Gönderim Tarihi: </b>
													<xsl:value-of select="cbc:DocumentType"/>
													<br/>
												</xsl:if>
												
											</xsl:for-each> 
											
											<br/>
											<br/>                       
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
								
								
								<xsl:if test="not(//n1:Invoice/cac:DespatchDocumentReference)">
									<div style="text-align:center">İrsaliye yerine geçer.</div>
								</xsl:if>


								<xsl:if test="//n1:Invoice/cac:AdditionalDocumentReference/cbc:DocumentType='ELEKTRONIK'">
									<div style="text-align:center">e-Arşiv izni kapsamında elektronik ortamda iletilmiştir.</div>
								</xsl:if>
								<br/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="dateFormatter">
		<xsl:value-of select="substring(.,9,2)"/>-<xsl:value-of select="substring(.,6,2)"/>-<xsl:value-of select="substring(.,1,4)"/>
	</xsl:template>
	<xsl:template match="//n1:Invoice/cac:InvoiceLine">
		<tr id="lineTableTr" valign="top">
			<xsl:choose>
				<xsl:when test="./cac:AllowanceCharge">
					<!--Sıra No-->
					<td id="lineTableTd">
						<table border="0">
							<tbody>
								<tr>
									<td>
										<xsl:value-of select="./cbc:ID"/>
									</td>
								</tr>
								<xsl:for-each select="cac:AllowanceCharge">
									<tr>
										<td>
											<xsl:text>&#160;</xsl:text>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</td>
					<!--Malzeme/Hizmet Kodu-->
					<td id="lineTableTd">
						<table border="0">
							<tbody>
								<tr>
									<td>
										<span>
											<xsl:value-of select="./cac:Item/cbc:Name"/>
										</span>
									</td>
								</tr>
								<xsl:for-each select="cac:AllowanceCharge">
									<tr>
										<td>
											<xsl:text>&#160;</xsl:text>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</td>
					<!--Malzeme/Hizmet Açıklaması-->
					<td id="lineTableTd">
						<table border="0">
							<tbody>
								<tr>
									<td>
										<span>
											<xsl:choose>
												<xsl:when test="./cac:Item/cbc:Description">
													<xsl:value-of select="./cac:Item/cbc:Description"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>&#160;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</span>
									</td>
								</tr>
								<xsl:for-each select="cac:AllowanceCharge">
									<tr>
										<td>
											<b>
												<xsl:text>&#160;&#160;&#160;&#160;&#160;</xsl:text>
                        <xsl:value-of select="cbc:AllowanceChargeReason"/>
												
											</b>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</td>
					<!--Satır Açıklaması--> 
					<td id="lineTableTd">
						<table border="0">
							<tbody>
								<tr>
									<td>
										<xsl:for-each select="./cbc:Note">
											<span>
												<xsl:value-of select="."/> 
											</span>
											<br/>
										</xsl:for-each>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
					<!--Miktar-->
					<td id="lineTableTd" align="right">
						<table border="0" width="100%">
							<tbody>
								<tr>
									<td>
										<span>
											<xsl:value-of select="format-number(./cbc:InvoicedQuantity, '###.##0,##', 'european')"/>
											<xsl:if test="./cbc:InvoicedQuantity/@unitCode">
												<xsl:for-each select="./cbc:InvoicedQuantity">
													<xsl:text> </xsl:text>
													<xsl:choose>
														<xsl:when test="@unitCode='C62'">
															<span>
																<xsl:text>Adet</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='26'">
															<span>
																<xsl:text>Ton</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='BX'">
															<span>
																<xsl:text>Kutu</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='LTR'">
															<span>
																<xsl:text>LT</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='EA'">
															<span>
																<xsl:text>Adet</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='NIU'">
															<span>
																<xsl:text>Adet</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='KGM'">
															<span>
																<xsl:text>KG</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='KJO'">
															<span>
																<xsl:text>kJ</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='GRM'">
															<span>
																<xsl:text>GR</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='MGM'">
															<span>
																<xsl:text>MG</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='NT'">
															<span>
																<xsl:text>Net Ton</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='GT'">
															<span>
																<xsl:text>GT</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='MTR'">
															<span>
																<xsl:text>M</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='MMT'">
															<span>
																<xsl:text>MM</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='KTM'">
															<span>
																<xsl:text>KM</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='MLT'">
															<span>
																<xsl:text>ML</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='MMQ'">
															<span>
																<xsl:text>MM³</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='CLT'">
															<span>
																<xsl:text>CL</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='CMK'">
															<span>
																<xsl:text>CM²</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='CMQ'">
															<span>
																<xsl:text>CM³</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='CMT'">
															<span>
																<xsl:text>CM</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='MTK'">
															<span>
																<xsl:text>M²</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='MTQ'">
															<span>
																<xsl:text>M³</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='DAY'">
															<span>
																<xsl:text> Gün</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='MON'">
															<span>
																<xsl:text> Ay</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='PA'">
															<span>
																<xsl:text> Paket</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='KWH'">
															<span>
																<xsl:text> KWH</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='INH'">
															<span>
																<xsl:text>IN</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='FOT'">
															<span>
																<xsl:text>FT</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='MMK'">
															<span>
																<xsl:text>MM²</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='INK'">
															<span>
																<xsl:text>IN²</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='FTK'">
															<span>
																<xsl:text>FT²</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='INQ'">
															<span>
																<xsl:text>IN³</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='FTQ'">
															<span>
																<xsl:text>FT³</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='ONZ'">
															<span>
																<xsl:text>OZ</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='LBR'">
															<span>
																<xsl:text>LB</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='B4'">
															<span>
																<xsl:text>Varil</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='28'">
															<span>
																<xsl:text>KG</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='BG'">
															<span>
																<xsl:text>Çuval</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='BE'">
															<span>
																<xsl:text>Deste</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='BJ'">
															<span>
																<xsl:text>Kova</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='BK'">
															<span>
																<xsl:text>Sepet</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='BL'">
															<span>
																<xsl:text>Balya</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='BO'">
															<span>
																<xsl:text>Şişe</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='CO'">
															<span>
																<xsl:text>Damacana</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='CQ'">
															<span>
																<xsl:text>Kartuş</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='CS'">
															<span>
																<xsl:text>Kasa</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='CT'">
															<span>
																<xsl:text>Karton</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='RO'">
															<span>
																<xsl:text>Rulo</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='11'">
															<span>
																<xsl:text>Takım</xsl:text>
															</span>
														</xsl:when>
														<xsl:when test="@unitCode='2W'">
															<span>
																<xsl:text>Sepet</xsl:text>
															</span>
														</xsl:when>
														<xsl:otherwise>
															<span>
																<xsl:value-of select="@unitCode"/>
															</span>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</xsl:if>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
					<!--Birim Fiyatı-->
					<td id="lineTableTd" align="right">
						<table border="0">
							<tbody>
								<tr>
									<td align="right">
										<span>
											<xsl:text>&#160;</xsl:text>
											<xsl:value-of select="format-number(./cac:Price/cbc:PriceAmount, '###.##0,0000####', 'european')"/>
											<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID">
												<xsl:text> </xsl:text>
												<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRY&quot;">
													<xsl:text>TL</xsl:text>
												</xsl:if>
												<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRY&quot;">
													<xsl:value-of select="./cac:Price/cbc:PriceAmount/@currencyID"/>
												</xsl:if>
											</xsl:if>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
					<!--İskonto Oranı-->
					<td id="lineTableTd" align="right">
						<table border="0" width="100%">
							<tbody>
								<tr>
									<td>
										<xsl:text>&#160;</xsl:text>
									</td>
								</tr>
								<xsl:for-each select="cac:AllowanceCharge">
									<tr>
										<td align="right">
											<span style="font-size:9px;">
												<b>
																<xsl:text>%</xsl:text>
																<xsl:value-of select="format-number(./cbc:MultiplierFactorNumeric*100, '###.##0,00', 'european')"/>
												</b>
											</span>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</td>
					<!--İskonto Tutarı-->
					<td id="lineTableTd" align="right">
						<table width="100%">
							<tbody>
								<tr>
									<td>
										<xsl:text>&#160;</xsl:text>
									</td>
								</tr>
								<xsl:for-each select="cac:AllowanceCharge">
									<tr>
										<td align="right">
											<span style="font-size:9px;">
												<b>
													<xsl:value-of select="format-number(./cbc:Amount, '###.##0,00', 'european')"/>
													<xsl:if test="./cbc:Amount/@currencyID">
														<xsl:text> </xsl:text>
														<xsl:if test="./cbc:Amount/@currencyID = 'TRY'">
															<xsl:text>TL</xsl:text>
														</xsl:if>
														<xsl:if test="./cbc:Amount/@currencyID != 'TRY'">
															<xsl:value-of select="./cbc:Amount/@currencyID"/>
														</xsl:if>
													</xsl:if>
												</b>
											</span>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</td>
					<!--KDV Oranı-->
					<td id="lineTableTd" align="right">
						<table border="0" width="100%">
							<tbody>
								<tr>
									<td align="right">
										<span>
											<xsl:text>&#160;</xsl:text>
											<xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
												<xsl:if test="cbc:TaxTypeCode='0015' ">
													<xsl:text> </xsl:text>
													<xsl:if test="../../cbc:Percent">
														<xsl:text> %</xsl:text>
														<xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')" />
													</xsl:if>
												</xsl:if>
											</xsl:for-each>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
					<!--KDV Tutarı-->
					<td id="lineTableTd" align="right">
						<table border="0" width="100%">
							<tbody>
								<tr>
									<td align="right">
										<span>
											<xsl:text>&#160;</xsl:text>
											<xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
												<xsl:if test="cbc:TaxTypeCode='0015' ">
													<xsl:text> </xsl:text>
													<xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
													<xsl:if test="../../cbc:TaxAmount/@currencyID">
														<xsl:text> </xsl:text>
														<xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRY'">
															<xsl:text>TL</xsl:text>
														</xsl:if>
														<xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRY'">
															<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
														</xsl:if>
													</xsl:if>
												</xsl:if>
											</xsl:for-each>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
					<!--Diğer Vergiler-->
					<td id="lineTableTd" align="left">
						<table border="0" width="100%">
							<tbody>
								<xsl:if test="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme and ./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode!='0015'">
									<tr>
										<td>
											<span>
												<xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
													<xsl:if test="cbc:TaxTypeCode!='0015' ">
														<xsl:text> (</xsl:text>
														<xsl:value-of select="cbc:Name"/>
														<xsl:text>)</xsl:text>
														<xsl:if test="../../cbc:Percent">
															<xsl:text> (%</xsl:text>
															<xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')"/>
															<xsl:text>)=</xsl:text>
														</xsl:if>
														<xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
														<xsl:if test="../../cbc:TaxAmount/@currencyID">
															<xsl:text> </xsl:text>
															<xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRY'">
																<xsl:text>TL</xsl:text>
															</xsl:if>
															<xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRY'">
																<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
															</xsl:if>
														</xsl:if>
													</xsl:if>
												</xsl:for-each>
											</span>
										</td>
									</tr>
								</xsl:if>
								<xsl:for-each select="./cac:WithholdingTaxTotal/cac:TaxSubtotal">
									<xsl:if test="not(cbc:TaxAmount = 0)">
										<tr>
											<td>
												<xsl:choose>
													<xsl:when test="cac:TaxCategory/cac:TaxScheme/cbc:Name=''">
														<xsl:text>Diğer Vergiler Toplamı </xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>Tevkifat (</xsl:text>
														<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode"/>
														<xsl:text>-</xsl:text>
														<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
														<xsl:text>)</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
												<xsl:if test="cbc:Percent !=''">
													<xsl:text>(%</xsl:text>
													<xsl:value-of select=" format-number(cbc:Percent, '###.##0,00', 'european')"/>
													<xsl:text>)= </xsl:text>
												</xsl:if>
												<xsl:value-of select="format-number(../cbc:TaxAmount, '###.##0,00', 'european')"/>
												<xsl:if test="../cbc:TaxAmount/@currencyID">
													<xsl:if test="../cbc:TaxAmount/@currencyID = 'TRY'">
														<xsl:text>TL</xsl:text>
													</xsl:if>
													<xsl:if test="../cbc:TaxAmount/@currencyID != 'TRY'">
														<xsl:value-of select="../cbc:TaxAmount/@currencyID"/>
													</xsl:if>
												</xsl:if>
											</td>
										</tr>
									</xsl:if>
								</xsl:for-each>
							</tbody>
						</table>
					</td>
					<!--Vergi Muafiyet Sebebi-->
					<td id="lineTableTd">
						<table border="0" width="100%">
							<tbody>
								<tr>
									<td>
										<span>
											<xsl:if test="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:TaxExemptionReason">
												<xsl:value-of select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:TaxExemptionReason"/>
											</xsl:if>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
					<!--Malzeme/Hizmet Tutarı-->
					<td id="lineTableTd" align="right">
						<table border="0" width="100%">
							<tbody>
								<tr>
									<td align="right">
										<span>
											<xsl:text>&#160;</xsl:text>
											<xsl:value-of select="format-number(./cbc:LineExtensionAmount, '###.##0,00', 'european')"/>
											<xsl:if test="./cbc:LineExtensionAmount/@currencyID">
												<xsl:text> </xsl:text>
												<xsl:if test="./cbc:LineExtensionAmount/@currencyID = 'TRY'">
													<xsl:text>TL</xsl:text>
												</xsl:if>
												<xsl:if test="./cbc:LineExtensionAmount/@currencyID != 'TRY'">
													<xsl:value-of select="./cbc:LineExtensionAmount/@currencyID"/>
												</xsl:if>
											</xsl:if>
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</xsl:when>
				<xsl:otherwise>
					 
					<!--Malzeme/Hizmet Kodu-->
					<td id="lineTableTd">
						<span>
							<xsl:text>&#160;</xsl:text>
							<xsl:value-of select="./cac:Item/cbc:Name"/>
						</span>
					</td>
					<!--Malzeme/Hizmet Açıklaması-->
					<td id="lineTableTd">
						<span>
							<xsl:text>&#160;</xsl:text>
							<xsl:value-of select="./cac:Item/cbc:Description"/>
						</span>
					</td>
					 <!--KDV Oranı-->
					<td id="lineTableTd" align="right">
						<span>
							<xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
								<xsl:if test="cbc:TaxTypeCode='0015' ">
									<xsl:text> </xsl:text>
									<xsl:if test="../../cbc:Percent">
										<xsl:text> %</xsl:text>
										<xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')"/>
										<xsl:text>&#160;</xsl:text>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
						</span>
					</td>
					<!--Miktar-->
					<td id="lineTableTd" align="right">
						<span>
							<xsl:value-of select="format-number(./cbc:InvoicedQuantity, '###.##0,##', 'european')"/>
							<xsl:if test="./cbc:InvoicedQuantity/@unitCode">
								<xsl:for-each select="./cbc:InvoicedQuantity">
									<xsl:text> </xsl:text>
									<xsl:choose>
										<xsl:when test="@unitCode='C62'">
											<span>
												<xsl:text>Adet</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='26'">
											<span>
												<xsl:text>Ton</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='BX'">
											<span>
												<xsl:text>Kutu</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='LTR'">
											<span>
												<xsl:text>LT</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='EA'">
											<span>
												<xsl:text>Adet</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='NIU'">
											<span>
												<xsl:text>Adet</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='KGM'">
											<span>
												<xsl:text>KG</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='KJO'">
											<span>
												<xsl:text>kJ</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='GRM'">
											<span>
												<xsl:text>GR</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='MGM'">
											<span>
												<xsl:text>MG</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='NT'">
											<span>
												<xsl:text>Net Ton</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='GT'">
											<span>
												<xsl:text>GT</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='MTR'">
											<span>
												<xsl:text>M</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='MMT'">
											<span>
												<xsl:text>MM</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='KTM'">
											<span>
												<xsl:text>KM</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='MLT'">
											<span>
												<xsl:text>ML</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='MMQ'">
											<span>
												<xsl:text>MM³</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='CLT'">
											<span>
												<xsl:text>CL</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='CMK'">
											<span>
												<xsl:text>CM²</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='CMQ'">
											<span>
												<xsl:text>CM³</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='CMT'">
											<span>
												<xsl:text>CM</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='MTK'">
											<span>
												<xsl:text>M²</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='MTQ'">
											<span>
												<xsl:text>M³</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='DAY'">
											<span>
												<xsl:text> Gün</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='MON'">
											<span>
												<xsl:text> Ay</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='PA'">
											<span>
												<xsl:text> Paket</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='KWH'">
											<span>
												<xsl:text> KWH</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='INH'">
											<span>
												<xsl:text>IN</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='FOT'">
											<span>
												<xsl:text>FT</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='MMK'">
											<span>
												<xsl:text>MM²</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='INK'">
											<span>
												<xsl:text>IN²</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='FTK'">
											<span>
												<xsl:text>FT²</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='INQ'">
											<span>
												<xsl:text>IN³</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='FTQ'">
											<span>
												<xsl:text>FT³</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='ONZ'">
											<span>
												<xsl:text>OZ</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='LBR'">
											<span>
												<xsl:text>LB</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='B4'">
											<span>
												<xsl:text>Varil</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='28'">
											<span>
												<xsl:text>KG</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='BG'">
											<span>
												<xsl:text>Çuval</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='BE'">
											<span>
												<xsl:text>Deste</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='BJ'">
											<span>
												<xsl:text>Kova</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='BK'">
											<span>
												<xsl:text>Sepet</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='BL'">
											<span>
												<xsl:text>Balya</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='BO'">
											<span>
												<xsl:text>Şişe</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='CO'">
											<span>
												<xsl:text>Damacana</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='CQ'">
											<span>
												<xsl:text>Kartuş</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='CS'">
											<span>
												<xsl:text>Kasa</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='CT'">
											<span>
												<xsl:text>Karton</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='RO'">
											<span>
												<xsl:text>Rulo</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='11'">
											<span>
												<xsl:text>Takım</xsl:text>
											</span>
										</xsl:when>
										<xsl:when test="@unitCode='2W'">
											<span>
												<xsl:text>Sepet</xsl:text>
											</span>
										</xsl:when>
										<xsl:otherwise>
											<span>
												<xsl:value-of select="@unitCode"/>
											</span>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</span>
					</td>
					<!--Birim Fiyatı-->
					<td id="lineTableTd" align="right">
						<span>
							<xsl:text>&#160;</xsl:text>
							<xsl:value-of select="format-number(./cac:Price/cbc:PriceAmount, '###.##0,0000####', 'european')"/>
							<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID">
								<xsl:text> </xsl:text>
								<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRY&quot;">
									<xsl:text>TL</xsl:text>
								</xsl:if>
								<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRY&quot;">
									<xsl:value-of select="./cac:Price/cbc:PriceAmount/@currencyID"/>
								</xsl:if>
							</xsl:if>
						</span>
					</td>
				 
					
					 <!--Malzeme/Hizmet Tutarı-->
					<td id="lineTableTd" align="right">
					
						<span>
							<xsl:value-of select="format-number(./cbc:LineExtensionAmount, '###.##0,00', 'european')"/>
							<xsl:if test="./cbc:LineExtensionAmount/@currencyID">
								<xsl:text> </xsl:text>
								<xsl:if test="./cbc:LineExtensionAmount/@currencyID = 'TRY' ">
									<xsl:text>TL</xsl:text>
									<xsl:text>&#160;</xsl:text>
								</xsl:if>
								<xsl:if test="./cbc:LineExtensionAmount/@currencyID != 'TRY'">
									<xsl:value-of select="./cbc:LineExtensionAmount/@currencyID"/>
									<xsl:text>&#160;</xsl:text>
								</xsl:if>
							</xsl:if>
						</span>
					</td>
				<td>
 	<div class="checkboxFive">  		
<input type="checkbox" value ="1" id ="checkboxFiveInput" name="" />
<label for="checkboxFiveInput"> </label></div>

				</td>
				<td></td>
				<td></td>
				<td></td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>
	<xsl:template name="geneliskonto">
		<xsl:choose>
			<xsl:when test="//n1:Invoice/cac:AllowanceCharge">
				<tr id="lineTableTr" >
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="left">
						<span>
							<table border="0">
								<tbody>
									<xsl:for-each select="//n1:Invoice/cac:AllowanceCharge">
										<tr>
											<td>
												<xsl:text>&#160;&#160;&#160;&#160;&#160;</xsl:text>
                        <span style="font-size:9px;">
                          <b>
                            <xsl:value-of select="cbc:AllowanceChargeReason"/>
                          </b>
                        </span>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
              <xsl:text>&#160;</xsl:text>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
              <table border="0">
                <tbody>
                  <xsl:for-each select="//n1:Invoice/cac:AllowanceCharge">
                    <tr>
                      <td align="right">
                        <span style="font-size:9px;">
                          <b>
                            <xsl:text>%</xsl:text>
                            <xsl:value-of select="format-number(./cbc:MultiplierFactorNumeric*100, '###.##0,00', 'european')"/>
                          </b>
                        </span>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
							<table border="0">
								<tbody>
									<xsl:for-each select="//n1:Invoice/cac:AllowanceCharge">
										<tr>
											<td align="right">
												<span style="font-size:9px;">
													<b>
														<xsl:value-of select="format-number(cbc:Amount, '###.##0,00', 'european')"/>
														<xsl:if test="cbc:Amount/@currencyID">
															<xsl:text> </xsl:text>
															<xsl:if test="cbc:Amount/@currencyID = 'TRY'">
																<xsl:text>TL</xsl:text>
															</xsl:if>
															<xsl:if test="cbc:Amount/@currencyID != 'TRY'">
																<xsl:value-of select="cbc:Amount/@currencyID"/>
															</xsl:if>
														</xsl:if>
													</b>
												</span>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</td>
					<td id="lineTableTd" style="border-top:thick double black; border-top-width:3px;" align="right">
						<span>
							<xsl:text>&#160;</xsl:text>
						</span>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<!--	<xsl:apply-templates select="//n1:Invoice"/>-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="//n1:Invoice">
		<tr id="lineTableTr">
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			 
		</tr>
	</xsl:template>
</xsl:stylesheet>