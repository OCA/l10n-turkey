<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:ccts="urn:un:unece:uncefact:documentation:2"
	xmlns:clm54217="urn:un:unece:uncefact:codelist:specification:54217:2001"
	xmlns:clm5639="urn:un:unece:uncefact:codelist:specification:5639:1988"
	xmlns:clm66411="urn:un:unece:uncefact:codelist:specification:66411:2001"
	xmlns:clmIANAMIMEMediaType="urn:un:unece:uncefact:codelist:specification:IANAMIMEMediaType:2003"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:link="http://www.xbrl.org/2003/linkbase"
	xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2"
	xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2"
	xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	exclude-result-prefixes="cac cbc ccts clm54217 clm5639 clm66411 clmIANAMIMEMediaType fn link n1 qdt udt xbrldi xbrli xdt xlink xs xsd xsi">
	<xsl:character-map name="a">
		<xsl:output-character character="&#133;" string=""/>
		<xsl:output-character character="&#158;" string=""/>
	</xsl:character-map>
	<xsl:decimal-format name="european" decimal-separator="," grouping-separator="." NaN=""/>
	<xsl:output version="4.0" method="html" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" use-character-maps="a"/>
	<xsl:param name="SV_OutputFormat" select="'HTML'"/>


	<xsl:template match="/">
		<html>

			<head>
				<meta charset="UTF-8"/>
				<style type="text/css">
					body {
						background-color: #FFFFFF;
						font-family: 'Arial';
						font-size: 14px;
						width: 1160px;
					}

					div#leftspace { display: table-cell;float:left;color:white; width:25px;}
					div#centercolumn { display: table-cell; width:1075px;}
					div#rightspace { display: table-cell;float:left;color:white;width:48px;}

					#delivery_Address {
					border-top-style: dashed;
					font-size: 16px;
					border-bottom-style: dashed;
					border-top-color: red;
					border-bottom-color: red;
					border-bottom-width: medium;
					margin-bottom:15px;
					}

					table {
						font-size: 14px;
					}
					table td {
						vertical-align: top;
					}
					#signature {
   						 width: 90px;
					height: 90px;
					}
					#GIBlogo {
						width: 100px;
    					height: 100px;
					}
					div#logo {
						float:left; width:370px;
					}
					div#logo img {
						height:70px;
					}
					div#header {
						width:1085px;
						display: table;
						border-bottom: solid #e7e7e7 2px;
						margin-bottom: 20px;
					    margin-top: 40px;
					}

					div#footer {
						display: table;
						width:1085px;
						clear: both;
						background-color: #e7e7e7;
						padding-top: 10px;
						padding-bottom: 10px;
					}

					div#footerleft {
						display: table;
						width: 50%;
						float: left;
					}
					div#footerleft table{
						width: 100%;
					}

					div#footerright {
						display: table;
						width: 50%;
						float: left;
					}
					div#companyinfo {
						float:right; width:650px; text-align:right;padding-top: 20px;
					}
					div#companyinfo p {
						margin:0px;
					}

					div#efaturalogo {
						float:left; width:100px;text-align: center;font-size:20px;font-weight:bold;
					}
					div#efaturalogo img{
						width:150px;
					}

					div#invoicemeta {
						float: right;width: 330px;
					}

					div#invoicemeta table {
						width:100%; margin-top: 10px; border-collapse: collapse;
					}

					div#invoicemeta table tr td.label {
						width:180px;

					}

					div#invoicemeta table tr:first-child {
						font-weight: bold;
						font-size: 1.2em;
					}

					div#invoicemeta table tr:first-child td:last-child {
						color: red;
						padding-bottom: 12px;
					}

					#DigerVergi {display: none; }
					#KDVTutar {display: none; }

					#iskonto {width: 65px;text-align: right;}
					.discountpercent {width: 65px;text-align: right;}
					#isktutar {width: 105px;text-align: right;}
					.discountedprice {width: 105px;text-align: right; }
                    #BirimFiyat {width: 105px;text-align: right;}
					.unitprice {width: 105px;text-align: right; }
                    .kdvpercent {width: 35px;text-align: right;}
					#KDVyuzde { width: 35px;text-align: right; }
					#Miktar {width: 104px;text-align: right;}
					.quantity {width: 104px;text-align: right;}
					#SatirTutar {width: 110px; text-align: right;}
					.pricesubtotal {width: 110px; text-align: right;}
					td.taxother {display: none;}
					td.kdvamount {display: none;}
					td.column {width:10px;}
					div#customer {float: left; width: 635px;}
					div#customer p {margin:0px;}

					div#lines {width: 1085px;}
					div#lines table {width: 100%; border-collapse: collapse;}
					div#lines table td.sequence{
						width: 10px;
					}
					div#lines table td{
						padding-top: 2px;
						padding-bottom: 2px;
					}

					#metatable { font-size: 18px; }
					div#lines table th{
						padding-top: 2px;
						padding-bottom: 2px;
					}
					.summarylabel { text-align: right;}

					div#lines table th{
						border: solid #e7e7e7 2px;
					}
					div#lines table td{
						border: solid #e7e7e7 2px;
					}

					div#container {
						width:1085px;
					}

					div#summary {
						width: 1085px;
						display: table;
						clear: both;
						margin-top: 20px;
					}

					div#references {
						width: 583px; float: left;
					}

					div#references table {
						width: 100%;
						border-collapse: collapse;

					}
					div#references table tr td:first-child {
						width: 140px;
						vertical-align: top;
					}


					div#totals {
						width: 472px; float: left; margin-left: 20px;
					}
						div#totals table {
						width: 100%;
					}
					div#totals table tr td{
						text-align: right;
					font-size: 1.2em;


					}

					div#notes {
						width: 1085px; float: left; margin-bottom: 20px; margin-top:0px;
					}

					div#notes table {
						width: 100%; border:solid #e7e7e7 2px;
					}

					div#notes h3 {
						margin-bottom: 4px;
					}
				</style>
			</head>


			<body>
				<div id="leftspace"><xsl:text>. &#160;</xsl:text>
				</div>
				<div id="centercolumn">


				<div id="header">

					<div id="logo" >

					</div>

					<div id="companyinfo">

			    <p style="font-weight:bold;font-size:1.4em;">FİRMA UNVANI</p>
				<p>ADRES</p>
				<p style="font-size:1.1em;"> <strong>Telefon:</strong>+90 312 395 2768   <strong>Faks:</strong>+90 850 811 5611</p>
				<p><strong>Web Sitesi:</strong>http://www.altinkaya.com.tr <strong>E-Posta:</strong>satis@altinkaya.com.tr</p>
				<p><strong>Vergi Dairesi:</strong>VD <strong>VKN: </strong>VERGİNO <strong>MERSİS:</strong>MERSİSNO </p>
		
							</div>
						</div>
		
		
						<div id="container">
		
							<div id="customer">
								<div id="delivery_Address">
		
									<div style="font-size: 18px;font-weight: bold;display: inline-block;">
										<xsl:for-each select="n1:Invoice/cac:Delivery/cac:DeliveryTerms">
											<xsl:for-each select="cbc:SpecialTerms">
											<xsl:apply-templates/>
												<xsl:text> </xsl:text>
											</xsl:for-each>
										</xsl:for-each></div>
										<xsl:for-each select="n1:Invoice/cac:Delivery/cac:DeliveryParty">
											<div style="font-size: 18px;font-weight: bold;display: initial;"> Teslimat Adresi:</div>
				
											<p>
													<xsl:call-template name="Party_Title">
														<xsl:with-param name="PartyType">OTHER</xsl:with-param>
													</xsl:call-template>
											</p>
											<xsl:call-template name="Party_Adress">
												<xsl:with-param name="PartyType">OTHER</xsl:with-param>
											</xsl:call-template>
		
											<xsl:call-template name="Party_Other">
												<xsl:with-param name="PartyType">OTHER</xsl:with-param>
											</xsl:call-template>
										</xsl:for-each>
		
								</div>
		
								<p style="font-size: 16px;font-weight: bold;">Fatura Adresi:</p>
								<div id="invoice_Address">
								<p>
									<xsl:choose>
										<xsl:when test="n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID='PARTYTYPE' and text()='TAXFREE']">
											<xsl:for-each select="n1:Invoice/cac:BuyerCustomerParty/cac:Party">
												<xsl:call-template name="Party_Title">
													<xsl:with-param name="PartyType">TAXFREE</xsl:with-param>
												</xsl:call-template>
											</xsl:for-each>
										</xsl:when>
										<xsl:otherwise>
											<xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
												<xsl:call-template name="Party_Title">
													<xsl:with-param name="PartyType">OTHER</xsl:with-param>
												</xsl:call-template>
											</xsl:for-each>
										</xsl:otherwise>
									</xsl:choose>
								</p>
		
								<xsl:choose>
									<xsl:when test="n1:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID='PARTYTYPE' and text()='TAXFREE']">
										<xsl:for-each select="n1:Invoice/cac:BuyerCustomerParty/cac:Party">
		
											<xsl:call-template name="Party_Adress">
												<xsl:with-param name="PartyType">TAXFREE</xsl:with-param>
											</xsl:call-template>
		
											<xsl:call-template name="Party_Other">
												<xsl:with-param name="PartyType">TAXFREE</xsl:with-param>
											</xsl:call-template>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="n1:Invoice/cac:AccountingCustomerParty/cac:Party">
		
											<xsl:call-template name="Party_Adress">
												<xsl:with-param name="PartyType">OTHER</xsl:with-param>
											</xsl:call-template>
		
											<xsl:call-template name="Party_Other">
												<xsl:with-param name="PartyType">OTHER</xsl:with-param>
											</xsl:call-template>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
								</div>
							</div>
		
		
		
							<div id="efaturalogo" >
		
								<svg
		   xmlns:dc="http://purl.org/dc/elements/1.1/"
		   xmlns:cc="http://creativecommons.org/ns#"
		   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		   xmlns:svg="http://www.w3.org/2000/svg"
		   xmlns="http://www.w3.org/2000/svg"
		   id="GIBlogo"
		   viewBox="0 0 2000 2000"
		   style="shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd"
		   version="1.0"
		   height="20mm"
		   width="20mm"
		   xml:space="preserve"><metadata
		     id="metadata19"><rdf:RDF><cc:Work
		         rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type
		           rdf:resource="http://purl.org/dc/dcmitype/StillImage" /><dc:title></dc:title></cc:Work></rdf:RDF></metadata><defs
		     id="defs4"><style
		       id="style2"
		       type="text/css"><![CDATA[
		    .str0 {stroke:#0F64AD;stroke-width:30}
		    .fil2 {fill:none}
		    .fil0 {fill:#E31E24}
		    .fil1 {fill:#E31E24;fill-rule:nonzero}
		    .fil3 {fill:#0F64AD;fill-rule:nonzero}
		   ]]></style></defs><g
		     id="Katman_x0020_1"><metadata
		       id="LAYERGIBLOGO" /><g
		       id="GIB_MUHUR"><path
		         d="M1406 336c-310,186 -517,526 -517,914 0,128 23,251 64,365l-340 0c-68,-140 -106,-297 -106,-464 0,-327 147,-620 379,-815l520 0zm-13 205c62,18 91,103 66,189 -25,87 -95,143 -157,125 -61,-18 -91,-103 -66,-189 25,-87 96,-142 157,-125zm-386 335l394 5 -108 742 -278 0 111 -595 -182 0 63 -152z"
		         class="fil0"
		         id="LG" /><path
		         d="M211 1418l14 -7 17 34 -31 16c-5,-1 -11,-5 -16,-10 -6,-5 -10,-11 -14,-17 -4,-8 -6,-16 -5,-24 0,-8 2,-15 7,-22 5,-6 11,-11 19,-15 8,-4 16,-6 25,-6 8,0 15,3 22,8 5,3 10,9 13,16 5,10 7,19 6,26 -1,8 -5,14 -12,20l-11 -15c4,-3 6,-6 6,-11 1,-4 0,-8 -2,-13 -4,-7 -9,-11 -15,-13 -7,-2 -14,0 -23,4 -9,5 -15,10 -18,17 -2,7 -2,13 1,20 2,3 4,6 7,9 3,3 7,5 10,6l10 -5 -10 -18zm49 103l8 16c-6,1 -12,1 -18,-1 -5,-2 -10,-6 -14,-11 -6,-9 -8,-18 -5,-27 2,-7 7,-13 14,-18 9,-6 18,-8 26,-7 8,1 14,5 19,12 6,7 7,15 5,24 -2,8 -8,15 -19,23l-24 -35c-4,3 -7,6 -7,10 -1,4 0,7 2,10 1,3 3,4 5,5 3,0 5,0 8,-1zm15 -9c4,-3 6,-6 7,-10 1,-3 0,-6 -2,-9 -2,-3 -5,-5 -8,-5 -4,-1 -8,1 -11,3l14 21zm3 67l69 -56 11 13 -69 56 -11 -13zm92 -5l12 -10 11 12 -11 11 -12 -13zm-53 50l47 -44 12 13 -47 43 -12 -12zm54 54l-12 -11 43 -47 12 10 -6 7c5,-1 8,-2 11,-1 2,0 4,1 6,3 3,3 5,6 6,10l-13 8c-1,-4 -3,-6 -4,-8 -2,-2 -4,-2 -6,-3 -2,0 -5,1 -8,3 -3,2 -8,7 -15,15l-14 14zm110 88l49 -74 15 10 -49 74 -15 -10zm54 -80l8 -14 14 9 -8 14 -14 -9zm49 141l-14 -8 5 -8c-4,2 -8,3 -12,3 -4,0 -8,-1 -11,-3 -7,-4 -11,-9 -12,-17 -2,-8 0,-16 5,-26 5,-9 11,-15 19,-18 7,-2 14,-1 21,2 6,4 10,10 12,17l15 -28 15 9 -43 77zm-23 -51c-4,6 -5,11 -5,14 0,5 2,9 7,12 3,1 7,2 11,0 4,-2 7,-5 11,-11 3,-6 5,-12 4,-16 -1,-4 -3,-7 -7,-9 -3,-2 -7,-2 -11,-1 -4,2 -7,5 -10,11zm90 33l-13 -9c5,-5 9,-8 14,-9 5,-1 12,0 19,3 7,3 12,6 15,9 2,3 4,6 4,10 0,3 -1,8 -4,14l-8 18c-2,6 -3,10 -4,12 0,3 -1,6 0,9l-16 -6c0,-1 0,-3 1,-5 0,-2 0,-2 0,-3 -4,2 -8,3 -11,3 -4,0 -7,-1 -11,-2 -6,-3 -10,-7 -12,-11 -2,-5 -2,-10 0,-15 2,-4 4,-6 6,-8 3,-2 6,-3 10,-3 3,0 8,0 14,1 7,2 13,3 16,3l1 -1c1,-4 1,-6 1,-8 -1,-2 -4,-4 -8,-5 -3,-2 -5,-2 -7,-2 -2,1 -4,2 -7,5zm16 21c-2,0 -6,-1 -10,-1 -5,-1 -8,-2 -10,-1 -3,0 -5,2 -6,4 0,2 0,4 1,7 0,2 2,3 5,5 3,1 6,1 9,0 2,0 4,-2 6,-3 1,-2 2,-4 4,-8l1 -3zm59 53l-16 -5 19 -61 15 5 -3 8c4,-3 7,-5 9,-5 3,-1 5,-1 8,0 4,1 7,3 10,6l-10 13c-2,-3 -4,-5 -6,-5 -3,-1 -5,-1 -7,0 -2,1 -4,2 -6,5 -1,3 -4,10 -7,20l-6 19zm96 4l16 6c-4,6 -8,10 -13,12 -5,2 -12,3 -18,1 -11,-2 -19,-7 -23,-15 -3,-7 -3,-14 -1,-23 2,-11 6,-18 12,-23 7,-5 15,-7 23,-5 9,2 16,6 20,14 4,7 5,17 2,30l-41 -9c-1,5 -1,10 1,13 2,3 5,5 9,6 3,0 5,0 7,-1 2,-1 4,-3 6,-6zm4 -17c1,-5 0,-9 -2,-12 -2,-2 -4,-4 -8,-5 -3,-1 -6,0 -9,2 -3,2 -5,6 -6,10l25 5zm44 28l18 -1c0,4 1,6 3,8 2,2 5,3 9,4 4,0 8,0 10,-1 2,-1 3,-3 3,-5 0,-1 0,-2 -1,-3 -1,-1 -3,-2 -5,-3 -14,-4 -22,-8 -25,-11 -5,-4 -7,-9 -6,-15 1,-6 4,-10 8,-14 5,-3 12,-4 21,-3 9,1 15,4 19,7 4,3 6,8 7,14l-16 1c0,-3 -1,-5 -3,-7 -2,-1 -4,-2 -8,-3 -4,0 -8,0 -10,1 -1,1 -2,2 -2,3 0,2 0,3 1,4 2,1 7,3 15,6 9,3 15,7 18,10 3,4 5,8 4,13 -1,6 -4,11 -9,14 -6,4 -13,5 -23,4 -8,-1 -15,-4 -19,-8 -5,-4 -8,-9 -9,-15zm99 -46l1 -16 17 0 -1 16 -17 0zm-1 72l1 -64 17 1 -1 64 -17 -1zm131 -93l35 -5c7,-1 12,-2 16,-2 3,0 7,1 9,3 3,1 6,3 8,6 2,3 4,6 4,10 1,4 1,8 -1,11 -2,4 -5,7 -8,9 6,1 10,3 13,7 4,3 6,7 7,12 0,4 0,8 -1,12 -2,4 -4,8 -7,10 -3,3 -6,5 -11,6 -3,1 -10,2 -21,4l-30 4 -13 -87zm20 12l3 20 12 -2c6,-1 11,-1 12,-2 3,-1 6,-2 7,-4 1,-2 2,-4 2,-7 -1,-3 -2,-5 -4,-7 -1,-1 -4,-2 -7,-2 -1,0 -7,1 -15,2l-10 2zm5 35l4 23 16 -2c6,-1 10,-2 12,-3 3,-1 5,-2 6,-4 1,-2 2,-5 1,-8 0,-3 -1,-5 -3,-6 -1,-2 -3,-3 -6,-4 -2,0 -8,0 -16,1l-14 3zm101 -27l-15 2c-1,-6 1,-12 4,-16 4,-4 9,-7 17,-9 7,-2 13,-3 17,-2 4,0 7,2 10,4 2,2 4,7 6,14l5 19c2,6 3,10 4,12 1,2 3,5 5,7l-16 5c0,-1 -1,-2 -3,-4 0,-1 -1,-2 -1,-2 -2,3 -4,6 -7,9 -3,2 -6,4 -9,5 -7,1 -12,1 -17,-1 -5,-3 -8,-7 -9,-12 -1,-3 -1,-7 0,-10 1,-3 2,-6 5,-8 3,-2 7,-5 12,-8 7,-3 12,-6 15,-8l-1 -2c-1,-3 -2,-5 -4,-6 -2,-1 -5,-1 -9,1 -3,0 -5,2 -7,3 -1,2 -2,4 -2,7zm26 7c-2,2 -5,4 -10,6 -4,2 -7,4 -8,5 -1,2 -2,4 -1,7 0,2 2,4 4,5 2,1 5,1 7,1 3,-1 6,-3 8,-6 1,-2 2,-4 2,-6 0,-2 0,-4 -2,-8l0 -4zm52 -3l15 -8c2,2 4,4 7,5 2,1 6,0 9,-1 4,-2 7,-4 9,-6 1,-1 1,-3 0,-5 0,-1 -1,-2 -2,-2 -1,-1 -3,-1 -6,0 -14,2 -23,2 -28,1 -6,-1 -10,-5 -12,-10 -2,-6 -2,-11 1,-16 3,-5 8,-9 17,-13 8,-3 15,-4 20,-3 5,1 9,4 13,9l-14 9c-2,-3 -4,-4 -6,-4 -2,-1 -5,-1 -8,1 -4,1 -7,3 -9,5 0,1 -1,3 0,4 0,1 1,2 3,2 1,1 7,0 16,-1 9,-2 16,-2 21,0 4,1 7,5 9,10 2,5 2,11 -1,17 -3,5 -9,10 -18,13 -8,4 -15,4 -22,3 -6,-1 -10,-5 -14,-10zm27 34l-3 -6c4,-1 8,-2 11,-4 4,-1 6,-3 7,-4 1,-2 1,-3 0,-5 0,-1 -1,-2 -3,-2 -1,-1 -3,-1 -6,0 -2,1 -4,3 -7,4l0 -6c2,-2 5,-4 9,-5 4,-2 8,-2 12,-1 3,1 5,3 6,6 1,3 1,7 -1,10 -2,4 -7,7 -14,10 -5,2 -8,3 -11,3zm72 -56l-40 -79 15 -7 21 42 7 -29 19 -10 -9 31 39 26 -16 8 -27 -19 -4 11 10 19 -15 7zm69 -88l-14 6c-2,-6 -3,-12 -1,-17 2,-4 6,-9 13,-14 7,-4 12,-7 16,-7 4,-1 7,0 10,1 3,2 6,5 10,11l11 17c3,5 6,8 8,10 2,2 4,4 7,5l-14 10c-1,-1 -2,-2 -4,-4 -1,0 -1,-1 -1,-1 -1,4 -3,8 -4,11 -2,3 -5,5 -8,7 -5,4 -11,5 -16,5 -5,-1 -9,-4 -12,-8 -2,-3 -3,-7 -3,-10 -1,-3 0,-6 2,-9 2,-3 5,-7 9,-11 6,-6 9,-10 11,-13l-1 -1c-2,-3 -4,-5 -6,-5 -2,0 -5,1 -8,4 -3,1 -5,3 -5,5 -1,2 -1,4 0,8zm26 -2c-1,2 -3,5 -7,8 -3,4 -5,6 -6,8 -1,2 0,5 1,7 1,2 3,3 6,3 2,1 4,0 7,-1 2,-2 4,-5 5,-8 1,-2 1,-5 0,-7 0,-1 -1,-4 -4,-7l-2 -3zm111 -45l-13 10 -21 -25c-4,-5 -8,-8 -9,-9 -2,-2 -4,-2 -6,-2 -2,0 -4,1 -6,3 -2,1 -4,4 -4,7 -1,2 -1,5 0,8 1,2 4,6 8,12l19 22 -13 11 -41 -50 12 -10 6 8c0,-9 3,-17 9,-22 3,-3 6,-4 10,-5 3,-1 6,-1 8,-1 3,1 5,2 8,4 2,1 4,4 7,8l26 31zm31 -29l-62 -63 12 -12 62 63 -12 12zm42 -43l-48 -43 11 -12 49 42 -12 13zm42 -42l14 -14c2,1 3,1 5,1 2,0 4,-2 6,-5 2,-3 4,-6 4,-9 0,-2 0,-3 -1,-5 -1,-1 -3,-3 -6,-6l-7 -5c2,8 1,15 -4,21 -5,7 -12,10 -21,10 -7,-1 -14,-3 -20,-9 -9,-6 -14,-13 -15,-21 -1,-7 0,-14 5,-20 5,-6 11,-9 20,-9l-7 -6 10 -12 45 35c6,4 10,8 12,11 3,4 4,7 4,10 0,3 0,6 -1,10 -2,4 -4,8 -8,13 -6,8 -12,13 -18,14 -6,2 -11,1 -16,-3 0,0 -1,-1 -1,-1zm-21 -35c6,4 11,6 15,6 4,0 7,-2 9,-5 3,-3 4,-7 3,-11 -1,-4 -4,-8 -9,-12 -5,-4 -10,-6 -14,-6 -4,0 -8,2 -10,5 -3,4 -3,7 -3,11 1,4 4,8 9,12zm-29 -54l5 -7c4,4 6,8 7,12 0,5 -1,9 -4,14 -4,4 -8,6 -12,7 -5,1 -9,0 -14,-3l5 -7c3,2 5,2 7,2 2,-1 5,-2 7,-5 2,-2 2,-5 2,-7 0,-2 -1,-5 -3,-6zm106 3l-54 -34 9 -14 54 34 -9 14z"
		         class="fil1"
		         id="GIB" /><path
		         d="M1793 1476c-167,279 -468,449 -793,449 -354,0 -676,-202 -831,-520"
		         class="fil2"
		         id="GY" /><path
		         d="M183 566c161,-302 475,-491 817,-491 336,0 646,182 809,477"
		         class="fil2"
		         id="YU" /><path
		         d="M272 582l-63 -38 -14 22 -12 -7 36 -61 13 8 -14 22 63 38 -9 16zm27 -45l-14 -9 10 -14 14 10 -10 13zm125 -193l17 -8c4,9 6,17 5,25 -1,8 -5,15 -12,21 -9,8 -19,12 -30,12 -11,-1 -21,-7 -31,-17 -10,-10 -15,-21 -15,-32 0,-12 5,-21 14,-30 7,-7 16,-11 25,-11 6,0 12,2 18,6l-10 15c-4,-3 -8,-4 -12,-4 -4,1 -8,3 -12,6 -4,4 -7,10 -6,16 0,6 4,13 11,21 8,8 15,12 21,13 6,1 11,-1 16,-6 3,-3 5,-7 6,-11 0,-5 -1,-10 -5,-16zm56 -3l-11 -13 14 -11 10 14 -13 10zm81 -59l-41 -78 24 -13 42 46 -14 -60 23 -13 41 79 -14 7 -33 -61 17 69 -15 8 -48 -53 33 61 -15 8zm175 -80l-18 7 -14 -16 -33 12 0 22 -18 6 2 -95 17 -6 64 70zm-42 -21l-23 -27 0 35 23 -8zm62 15l-22 -85 17 -5 18 71 43 -11 4 15 -60 15zm82 -20l-17 -86 17 -4 18 87 -18 3zm-18 -94l-3 -16 16 -3 3 15 -16 4zm86 83l-4 -37 -36 -48 21 -2 24 33 17 -36 20 -2 -28 54 3 37 -17 1zm69 -5l1 -89 66 2 0 15 -48 -1 0 19 44 1 0 15 -45 -1 0 24 49 1 0 15 -67 -1zm163 -78l35 6c7,1 12,3 15,4 4,1 7,3 9,5 2,2 4,5 5,8 2,4 2,7 1,11 -1,4 -2,8 -5,11 -3,3 -6,5 -10,6 5,2 8,6 10,10 2,4 3,9 2,14 -1,4 -2,7 -5,11 -2,3 -5,6 -9,7 -3,2 -8,3 -12,2 -3,0 -10,-1 -22,-3l-29 -5 15 -87zm15 17l-3 20 11 3c7,1 11,1 13,2 3,0 6,-1 8,-2 2,-2 3,-4 4,-7 0,-2 0,-5 -1,-6 -2,-2 -4,-4 -7,-5 -1,0 -6,-1 -14,-3l-11 -2zm-6 35l-4 23 16 3c7,1 11,2 12,2 3,0 5,-1 7,-2 2,-2 4,-4 4,-7 1,-3 0,-5 0,-7 -1,-2 -3,-4 -5,-5 -2,-2 -8,-3 -16,-4l-14 -3zm149 79l-18 -6 -1 -21 -34 -11 -13 17 -18 -6 60 -74 18 6 6 95zm-20 -43l-2 -35 -21 27 23 8zm39 51l35 -81 17 7 -16 36 49 -21 22 10 -45 18 10 63 -21 -9 -5 -48 -19 8 -11 24 -16 -7zm157 84l-16 -10 4 -21 -30 -19 -17 13 -16 -10 75 -57 16 10 -16 94zm-9 -47l6 -35 -27 22 21 13zm25 58l54 -70 14 10 -7 70 36 -47 13 10 -54 70 -14 -11 7 -68 -35 46 -14 -10zm79 63l62 -62 13 13 -52 51 31 32 -11 10 -43 -44zm58 61l66 -60 12 14 -66 59 -12 -13zm81 48l12 -9 22 31 -28 21c-5,-1 -11,-4 -18,-8 -6,-4 -11,-9 -16,-15 -5,-7 -8,-15 -9,-23 -1,-8 1,-15 4,-22 4,-7 10,-13 17,-18 7,-5 15,-9 23,-10 8,-1 16,1 23,4 6,3 11,8 16,15 7,9 10,17 10,25 -1,7 -3,14 -9,21l-13 -13c3,-3 4,-7 4,-12 0,-4 -1,-8 -4,-12 -5,-7 -10,-10 -17,-11 -7,-1 -14,2 -22,7 -9,7 -14,13 -15,20 -2,7 0,13 4,19 2,3 5,6 9,8 3,2 6,4 10,5l9 -7 -12 -16zm72 -39l5 6c-5,3 -10,4 -14,3 -5,-1 -8,-3 -11,-8 -4,-4 -5,-8 -4,-13 0,-5 3,-9 7,-12l5 7c-3,1 -4,3 -4,6 0,2 1,4 3,7 2,3 4,4 6,5 2,0 4,0 7,-1zm-63 111l76 -46 9 15 -75 47 -10 -16z"
		         class="fil3"
		         id="TC" /><circle
		         r="992"
		         cy="1000"
		         cx="1000"
		         class="fil2 str0"
		         id="D" /></g></g></svg>
		
								<xsl:for-each select="n1:Invoice/cbc:ProfileID">
									<xsl:if test="contains(string(.),'EARSIVFATURA') =true()">
										<xsl:text>e-ARŞİV</xsl:text><br></br><xsl:text>FATURA</xsl:text>
									</xsl:if>
									<xsl:if test="contains(string(.),'TICARIFATURA') =true()">
										<xsl:text>e-FATURA</xsl:text>
									</xsl:if>
									<xsl:if test="contains(string(.),'TEMELFATURA') =true()">
										<xsl:text>e-FATURA</xsl:text>
									</xsl:if>
									<xsl:if test="contains(string(.),'IHRACAT') =true()">
										<xsl:text>e-FATURA</xsl:text>
									</xsl:if>
									<xsl:if test="contains(string(.),'YOLCUBERABERFATURA') =true()">
										<xsl:text>e-FATURA</xsl:text>
									</xsl:if>
								</xsl:for-each>
		
						<p>İMZA</p>
		
					</div>



					<div id="invoicemeta">

						<table id="metatable">

							<tr>
								<td class="label">Fatura No</td>
								<td class="column">:</td>
								<td align="right">
									<xsl:for-each select="n1:Invoice/cbc:ID">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
							</tr>

							<tr>
								<td class="label">Fatura Tarihi</td>
								<td class="column">:</td>
								<td align="right">
									<xsl:for-each select="n1:Invoice/cbc:IssueDate">
										<xsl:value-of select="substring(.,9,2)"/>.<xsl:value-of select="substring(.,6,2)"/>.<xsl:value-of select="substring(.,1,4)"/>
									</xsl:for-each>
								</td>
							</tr>

							<tr>
								<td class="label">Düzenleme Saati</td>
								<td class="column">:</td>
								<td align="right">
									<xsl:for-each select="n1:Invoice/cbc:IssueTime">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
							</tr>
							<tr>
								<td class="label">Fatura Tipi</td>
								<td class="column">:</td>
								<td align="right">
									<xsl:for-each select="n1:Invoice/cbc:InvoiceTypeCode">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
							</tr>
							<tr>
								<td class="label">Senaryo</td>
								<td class="column">:</td>
								<td align="right">
									<xsl:for-each select="n1:Invoice/cbc:ProfileID">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
							</tr>
							<tr style="display:none">
								<td class="label">Özelleştirme NO</td>
								<td class="column">:</td>
								<td align="right">
									<xsl:for-each select="n1:Invoice/cbc:CustomizationID">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
							</tr>
								<xsl:for-each select="n1:Invoice/cac:PaymentTerms">
								<tr>
								<td class="label"><xsl:text>Vade Tarihi</xsl:text></td>
								<td class="column"><xsl:text>:</xsl:text></td>
								<td align="right">
									<xsl:value-of select="substring(./cbc:PaymentDueDate,9,2)"/>.<xsl:value-of select="substring(./cbc:PaymentDueDate,6,2)"/>.<xsl:value-of select="substring(./cbc:PaymentDueDate,1,4)"/>
								</td>
							</tr>

							</xsl:for-each>


						</table>

					</div>
				</div>

				<div id="lines" >
					<table>
						<thead>
							<tr style="background-color:#e7e7e7">
								<th id="Sira">#</th>
								<xsl:if test="contains(string(.),'IHRACAT') =true()">
									<th id="gtip">GTİP No</th>
								</xsl:if>
								<th id="Urun">[Ürün Kodu] Açıklama</th>
								
								<th id="Miktar">Miktar</th>
								<th id="Birim Fiyat">Birim Fiyat</th>

								<th id="iskonto">İsk.(%)</th>

								<th id="isktutar">İsk. Fiyat</th>
								<th id="KDVyuzde">KDV</th>
								<th id="KDVTutar">KDV</th>

								<th id="DigerVergi">Diğer Vergiler</th>
								<th id="SatirTutar">Tutar</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="//n1:Invoice/cac:InvoiceLine">
								<tr>

									<xsl:apply-templates select="."/>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</div>


				<div  id="summary">

					<table id="summarytable">
						<tbody>
							<tr>
								<td>
									<div id="references">

										<table>
											<tbody>
														<tr>
								<td class="summarylabel"><b>ETTN :</b></td>
								<td align="left">
									<xsl:for-each select="n1:Invoice/cbc:UUID">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
							</tr>
												<xsl:for-each select="n1:Invoice/cac:PaymentTerms">
													<tr >
														<td class="summarylabel">
															<b>
																<xsl:text>Ödeme Şekli :</xsl:text>
															</b>
														</td>
														<td align="left">
															<xsl:value-of select="cbc:Note"/>
															<xsl:text>/</xsl:text>
															<xsl:value-of select="substring(./cbc:PaymentDueDate,9,2)"/>.<xsl:value-of select="substring(./cbc:PaymentDueDate,6,2)"/>.<xsl:value-of select="substring(./cbc:PaymentDueDate,1,4)"/>


														</td>

													</tr>
												</xsl:for-each>
												<xsl:for-each select="n1:Invoice/cac:DespatchDocumentReference">
													<tr >
														<td class="summarylabel">
															<b>
																<xsl:text>İrsaliye No/Tarihi :</xsl:text>
															</b>
														</td>
														<td >
															<xsl:value-of select="cbc:ID"/>/
															<xsl:for-each select="cbc:IssueDate">
																<xsl:value-of select="substring(.,9,2)"/>.<xsl:value-of select="substring(.,6,2)"/>.<xsl:value-of select="substring(.,1,4)"/>
															</xsl:for-each>
														</td>

													</tr>
												</xsl:for-each>

												<xsl:for-each select="//n1:Invoice/cbc:Note">
													<xsl:if test="contains(string(.),'#ORDER') =true()">
														<tr >
															<td class="label">
																<b>
																	<xsl:text>Sipariş No:</xsl:text>
																</b>
															</td>
															<td >
																<xsl:variable name="textResult">
																	<xsl:call-template name="parcala">
																		<xsl:with-param name="csv">
																			<xsl:value-of select="."/>
																		</xsl:with-param>
																		<xsl:with-param name="isaret" select="'#ORDER'"/>
																	</xsl:call-template>
																</xsl:variable>

																<xsl:value-of select="$textResult"/>

															</td>



														</tr>

													</xsl:if>
												</xsl:for-each>


								<xsl:for-each select="n1:Invoice/cac:Delivery">
									<tr><td class="summarylabel">
										<b><xsl:text>Kargo Takip No :</xsl:text></b></td>
									<td align="left">
										<xsl:for-each select="cbc:TrackingID">
									<xsl:apply-templates/>

									</xsl:for-each>
										</td>
									</tr>
								</xsl:for-each>
								<xsl:for-each select="n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyName">
									<tr><td class="summarylabel">
										<b><xsl:text>Taşıyıcı Ünvan :</xsl:text></b></td>
									<td align="left">
										<xsl:for-each select="cbc:Name">
									<xsl:apply-templates/>

									</xsl:for-each>
										</td>
									</tr>
								</xsl:for-each>
								<xsl:for-each select="n1:Invoice/cac:Delivery/cac:CarrierParty/cac:PartyIdentification">
									<tr><td class="summarylabel">
										<b><xsl:text>Taşıyıcı VKN :</xsl:text></b></td>
									<td align="left">
										<xsl:for-each select="cbc:ID">
									<xsl:apply-templates/>

									</xsl:for-each>
										</td>
									</tr>
								</xsl:for-each>


												<xsl:for-each select="n1:Invoice/cac:TaxRepresentativeParty/cac:PartyIdentification/cbc:ID[@schemeID='ARACIKURUMVKN']">
													<tr>
														<td class="label">
															<b>
																<xsl:text>Aracı Kurum Unvan/VKN:</xsl:text>
															</b>
														</td>
														<td style="width:110px;" align="left">
															<xsl:value-of select="."/>/<xsl:value-of select="../../cac:PartyName/cbc:Name"/>
														</td>
													</tr>
												</xsl:for-each>
												<xsl:for-each select="//n1:Invoice/cac:PricingExchangeRate">
													<tr>
														<td class="label">
															<b>KUR:</b>
														</td>
														<td>
															<xsl:value-of select="./cbc:CalculationRate"/>
														</td>
													</tr>
												</xsl:for-each>
											</tbody>
										</table>


									</div>
								</td>
								<td>
									<div id="totals">

										<table >
											<tbody>
												<tr>
													<td>Toplam Tutar</td>
													<td class="column">:</td>
													<td align="left">
														<xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount">
															<xsl:call-template name="Curr_Type"/>
														</xsl:for-each>
													</td>
												</tr>
												<xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
													<xsl:if test="cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode = '4171'">
														<tr>
															<td>
																Teslim Bedeli
															</td>
															<td class="column">:</td>

															<td>
																<xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount">
																	<xsl:call-template name="Curr_Type"/>
																</xsl:for-each>
															</td>
														</tr>
														<tr >
															<td >
																KDV Matrahı
															</td>
															<td class="column">:</td>

															<td >
																<xsl:value-of select="format-number(sum(//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=0015]/cbc:TaxableAmount), '###.##0,00', 'european')"/>
																<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID">
																	<xsl:text> </xsl:text>
																	<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID = 'TRL' or //n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID = 'TRY'">
																		<xsl:text>TL</xsl:text>
																	</xsl:if>
																	<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID != 'TRL' and //n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID != 'TRY'">
																		<xsl:value-of select="//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID"/>
																	</xsl:if>
																</xsl:if>
															</td>
														</tr>
														<tr>
															<td>

																Tevkifat Dahil Toplam Tutar

															</td>
															<td class="column">:</td>

															<td >
																<xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount">
																	<xsl:call-template name="Curr_Type"/>
																</xsl:for-each>
															</td>
														</tr>
														<tr>
															<td>
																Tevkifat Hariç Toplam Tutar
															</td>
															<td class="column">:</td>

															<td >
																<xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
																	<xsl:call-template name="Curr_Type"/>
																</xsl:for-each>
															</td>
														</tr>
													</xsl:if>
												</xsl:for-each>
												<tr >
													<td>
														Toplam İskonto
													</td>
													<td class="column">:</td>
													<td>
														<xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount">
															<xsl:call-template name="Curr_Type"/>
														</xsl:for-each>
													</td>
												</tr>

												<xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
													<tr>

														<td>

															<xsl:text>Hesaplanan </xsl:text>
															<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
															<xsl:text>(%</xsl:text>
															<xsl:value-of select="cbc:Percent"/>
															<xsl:text>)</xsl:text>

														</td>
														<td class="column">:</td>

														<td>
															<xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
																<xsl:text> </xsl:text>
																<xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
																<xsl:if test="../../cbc:TaxAmount/@currencyID">
																	<xsl:text> </xsl:text>
																	<xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRL' or ../../cbc:TaxAmount/@currencyID = 'TRY'">
																		<xsl:text>TL</xsl:text>
																	</xsl:if>
																	<xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRL' and ../../cbc:TaxAmount/@currencyID != 'TRY'">
																		<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
																	</xsl:if>
																</xsl:if>
															</xsl:for-each>
														</td>
													</tr>
												</xsl:for-each>

												<xsl:for-each select="n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal">
													<tr>
														<td >

															<xsl:text>Hesaplanan KDV Tevkifat</xsl:text>
															<xsl:text>(%</xsl:text>
															<xsl:value-of select="cbc:Percent"/>
															<xsl:text>)</xsl:text>

														</td>
														<td class="column">:</td>
														<td >
															<xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
																<xsl:text> </xsl:text>
																<xsl:value-of select="format-number(../../cbc:TaxAmount, '###.##0,00', 'european')"/>
																<xsl:if test="../../cbc:TaxAmount/@currencyID">
																	<xsl:text> </xsl:text>
																	<xsl:if test="../../cbc:TaxAmount/@currencyID = 'TRL' or ../../cbc:TaxAmount/@currencyID = 'TRY'">
																		<xsl:text>TL</xsl:text>
																	</xsl:if>
																	<xsl:if test="../../cbc:TaxAmount/@currencyID != 'TRL' and ../../cbc:TaxAmount/@currencyID != 'TRY'">
																		<xsl:value-of select="../../cbc:TaxAmount/@currencyID"/>
																	</xsl:if>
																</xsl:if>
															</xsl:for-each>
														</td>
													</tr>
												</xsl:for-each>


												<xsl:if test="sum(n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:TaxableAmount)>0">
													<tr >
														<td>
															Tevkifata Tabi İşlem Tutarı
														</td>
														<td class="column">:</td>
														<td >
															<xsl:value-of select="format-number(sum(n1:Invoice/cac:InvoiceLine[cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:LineExtensionAmount), '###.##0,00', 'european')"/>
															<xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
																<xsl:text>TL</xsl:text>
															</xsl:if>
															<xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
																<xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
															</xsl:if>
														</td>
													</tr>
													<tr>
														<td>
															Tevkifata Tabi İşlem Üzerinden Hes. KDV
														</td>
														<td class="column">:</td>

														<td >
															<xsl:value-of select="format-number(sum(n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:TaxableAmount), '###.##0,00', 'european')"/>
															<xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode = 'TRL'">
																<xsl:text>TL</xsl:text>
															</xsl:if>
															<xsl:if test="n1:Invoice/cbc:DocumentCurrencyCode != 'TRL'">
																<xsl:value-of select="n1:Invoice/cbc:DocumentCurrencyCode"/>
															</xsl:if>
														</td>
													</tr>
												</xsl:if>

												<xsl:if test = "n1:Invoice/cac:InvoiceLine[cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme]">
													<tr >
														<td >
															Tevkifata Tabi İşlem Tutarı
														</td>
														<td class="column">:</td>

														<td >
															<xsl:if test="n1:Invoice/cac:InvoiceLine[cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme]">
																<xsl:value-of select="format-number(sum(n1:Invoice/cac:InvoiceLine[cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme]/cbc:LineExtensionAmount), '###.##0,00', 'european')"/>
															</xsl:if>
															<xsl:if test="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=&apos;9015&apos;">
																<xsl:value-of select="format-number(sum(n1:Invoice/cac:InvoiceLine[cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:LineExtensionAmount), '###.##0,00', 'european')"/>
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

														<td >
															Tevkifata Tabi İşlem Üzerinden Hes. KDV
														</td>
														<td class="column">:</td>

														<td >
															<xsl:if test="n1:Invoice/cac:InvoiceLine[cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme]">
																<xsl:value-of select="format-number(sum(n1:Invoice/cac:WithholdingTaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme]/cbc:TaxableAmount), '###.##0,00', 'european')"/>
															</xsl:if>
															<xsl:if test="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=&apos;9015&apos;">
																<xsl:value-of select="format-number(sum(n1:Invoice/cac:TaxTotal/cac:TaxSubtotal[cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=9015]/cbc:TaxableAmount), '###.##0,00', 'european')"/>
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

												<tr >

													<td >
														Vergiler Dahil Toplam Tutar
													</td>
													<td class="column">:</td>

													<td >
														<xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount">
															<xsl:call-template name="Curr_Type"/>
														</xsl:for-each>
													</td>
												</tr>

												<tr >

													<td >
														Ödenecek Tutar
													</td>
													<td class="column">:</td>

													<td >
														<xsl:for-each select="n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
															<xsl:call-template name="Curr_Type"/>
														</xsl:for-each>
													</td>
												</tr>


												<xsl:if test="//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID != 'TRL' and //n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID != 'TRY'">
													<tr>
														<td >
															Mal Hizmet Toplam Tutarı(TL)
														</td>
														<td class="column">:</td>

														<td >
															<xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')"/>
															<xsl:text> TL</xsl:text>
														</td>
													</tr>
													<xsl:for-each select="n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
														<tr>

															<td>

																<xsl:text></xsl:text>
																<xsl:value-of select="cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
																<xsl:text>(%</xsl:text>
																<xsl:value-of select="cbc:Percent"/>
																<xsl:text>)(TL)</xsl:text>

															</td>
															<td class="column">:</td>

															<td>
																<xsl:for-each select="cac:TaxCategory/cac:TaxScheme">
																	<xsl:value-of select="format-number(../../cbc:TaxAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')"/>
																	<xsl:text>TL</xsl:text>

																</xsl:for-each>
															</td>
														</tr>
													</xsl:for-each>
													<tr >

														<td >
															Vergiler Dahil Toplam Tutar(TL)
														</td>
														<td class="column">:</td>

														<td >
															<xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')"/>
															<xsl:text> TL</xsl:text>
														</td>
													</tr>
													<tr align="right">

														<td >
															Ödenecek Tutar(TL)
														</td>
														<td class="column">:</td>

														<td >
															<xsl:value-of select="format-number(//n1:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount * //n1:Invoice/cac:PricingExchangeRate/cbc:CalculationRate, '###.##0,00', 'european')"/>
															<xsl:text> TL</xsl:text>
														</td>
													</tr>
												</xsl:if>

												<tr>
													<td colspan="3" style="text-align:right;font-size:14px;">

														<xsl:for-each select="//n1:Invoice/cbc:Note">
															<xsl:if test="contains(string(.),'#YALNIZ') =true()">
																<span>
																	<xsl:variable name="textResult">
																		<xsl:call-template name="parcala">
																			<xsl:with-param name="csv">
																				<xsl:value-of select="."/>
																			</xsl:with-param>
																			<xsl:with-param name="isaret" select="'#YALNIZ'"/>
																		</xsl:call-template>
																	</xsl:variable>
																	<xsl:variable name="textResultFinal">
																		<xsl:call-template name="string-replace-all">
																			<xsl:with-param name="text" select="$textResult" />
																			<xsl:with-param name="replace" select="'TRY'" />
																			<xsl:with-param name="by" select="'TL'" />
																		</xsl:call-template>
																	</xsl:variable>
																	<b>YALNIZ:</b> <xsl:value-of select="$textResultFinal"/>

																</span>
															</xsl:if>
														</xsl:for-each>

													</td>
												</tr>
											</tbody>
										</table>

									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="notes">
					<h3>NOTLAR</h3>
					<table>
						<tbody>
							<xsl:for-each select="//n1:Invoice/cac:TaxTotal/cac:TaxSubtotal">
							<tr>
								<td>

										<xsl:if
											test="cbc:Percent=0 and cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode=&apos;0015&apos;">
											<b>Vergi İstisna Muafiyet Sebebi: </b>
											<xsl:value-of select="cac:TaxCategory/cbc:TaxExemptionReason"/>
											<br/>
										</xsl:if>

								</td>
							</tr>
							</xsl:for-each>
							<xsl:for-each select="//n1:Invoice/cbc:Note">
								<xsl:if test="contains(string(.),'#') !=true()">

									<tr>
										<td>
											<xsl:value-of select="string(.)"/>
										</td>
									</tr>

								</xsl:if>
							</xsl:for-each>
						</tbody>

					</table>
				</div>

				<div id="footer">

					<div id="footerleft" >

						
					</div>
					<div id="footerright" >
						<table style="width:500px;font-weight:bold;font-size:1.2em;">
							<tbody>
									<tr>
										<td style="text-align:center;width:250px;">TESLİM EDEN</td>
										<td style="text-align:center;width:250px;">TESLİM ALAN</td>
									</tr>
									<tr style="height:50px;">
										<td>  </td>
										<td>  </td>
									</tr>
							</tbody>
						</table>
						<div style="text-align:left;padding-left:40px;">Bu belge irsaliye yerine geçer.</div>



					</div>
				</div>
				</div>

<div id="rightspace"><xsl:text>. &#160;</xsl:text>
				</div>
			</body>


		</html>
	</xsl:template>


	<xsl:template match="//n1:Invoice/cac:InvoiceLine">
		<td class="sequence">
			<span>
				<xsl:value-of select="./cbc:ID"/>
			</span>
		</td>
		<xsl:if test="contains(string(.),'IHRACAT') =true()">
			<td id="gtip">
				<xsl:value-of select="./cac:Delivery/cac:Shipment/cac:GoodsItem/cbc:RequiredCustomsID"/>
			</td>
		</xsl:if>
		<td class="product">
			<span>


			<xsl:if test="./cac:Item/cac:SellersItemIdentification/cbc:ID">
				<xsl:text>[</xsl:text>
				<xsl:value-of select="./cac:Item/cac:SellersItemIdentification/cbc:ID"/>
				<xsl:text>]</xsl:text>
			</xsl:if>
				<xsl:text>&#160;</xsl:text>
				<xsl:value-of select="./cac:Item/cbc:Name"/>
			</span>
		</td>
		<td class="quantity">
			<span>
				<xsl:value-of select="format-number(./cbc:InvoicedQuantity, '###.###,##', 'european')"/>
				<xsl:if test="./cbc:InvoicedQuantity/@unitCode">
					<xsl:for-each select="./cbc:InvoicedQuantity">
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="@unitCode  = 'C62'">
								<span>
									<xsl:text>Adet</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = '26'">
								<span>
									<xsl:text>Ton</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'BX'">
								<span>
									<xsl:text>Kutu</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'LTR'">
								<span>
									<xsl:text>LT</xsl:text>
								</span>
							</xsl:when>

							<xsl:when test="@unitCode  = 'NIU'">
								<span>
									<xsl:text>Adet</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'KGM'">
								<span>
									<xsl:text>KG</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'KJO'">
								<span>
									<xsl:text>kJ</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'GRM'">
								<span>
									<xsl:text>G</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'MGM'">
								<span>
									<xsl:text>MG</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'NT'">
								<span>
									<xsl:text>Net Ton</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'GT'">
								<span>
									<xsl:text>GT</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'MTR'">
								<span>
									<xsl:text>M</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'MMT'">
								<span>
									<xsl:text>MM</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'KTM'">
								<span>
									<xsl:text>KM</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'MLT'">
								<span>
									<xsl:text>ML</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'MMQ'">
								<span>
									<xsl:text>MM3</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'CLT'">
								<span>
									<xsl:text>CL</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'CMK'">
								<span>
									<xsl:text>CM2</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'CMQ'">
								<span>
									<xsl:text>CM3</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'CMT'">
								<span>
									<xsl:text>CM</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'MTK'">
								<span>
									<xsl:text>M2</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'MTQ'">
								<span>
									<xsl:text>M3</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'DAY'">
								<span>
									<xsl:text>Gün</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'MON'">
								<span>
									<xsl:text>Ay</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'PA'">
								<span>
									<xsl:text>Paket</xsl:text>
								</span>
							</xsl:when>
							<xsl:when test="@unitCode  = 'KWH'">
								<span>
									<xsl:text>KWH</xsl:text>
								</span>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
			</span>
		</td>
		<td class="unitprice">
			<xsl:value-of select="format-number(./cac:Price/cbc:PriceAmount, '###.####0,0000', 'european')"/>
			<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID">
				<xsl:text> </xsl:text>
				<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRL&quot; or ./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRY&quot;">
					<xsl:text>TL</xsl:text>
				</xsl:if>
				<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRL&quot; and ./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRY&quot;">
					<xsl:value-of select="./cac:Price/cbc:PriceAmount/@currencyID"/>
				</xsl:if>
			</xsl:if>
		</td>
		<td class="discountpercent">
			<xsl:text>&#160;</xsl:text>
			<xsl:if test="./cac:AllowanceCharge/cbc:MultiplierFactorNumeric">
				<xsl:text> %</xsl:text>
				<xsl:value-of select="format-number(./cac:AllowanceCharge/cbc:MultiplierFactorNumeric * 100, '###.###0,000', 'european')"/>
			</xsl:if>
		</td>
		<td class="discountedprice">
			<xsl:if test="./cac:AllowanceCharge/cbc:MultiplierFactorNumeric">

				<xsl:value-of select="format-number(./cac:Price/cbc:PriceAmount * (1 - ./cac:AllowanceCharge/cbc:MultiplierFactorNumeric), '###.####0,0000', 'european')"/>
				<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID">
					<xsl:text> </xsl:text>
					<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRL&quot; or ./cac:Price/cbc:PriceAmount/@currencyID = &quot;TRY&quot;">
						<xsl:text>TL</xsl:text>
					</xsl:if>
					<xsl:if test="./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRL&quot; and ./cac:Price/cbc:PriceAmount/@currencyID != &quot;TRY&quot;">
						<xsl:value-of select="./cac:Price/cbc:PriceAmount/@currencyID"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>

		</td>
		<td class="kdvpercent">
			<xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
				<xsl:if test="cbc:TaxTypeCode='0015' ">
					<xsl:text> </xsl:text>
					<xsl:if test="../../cbc:Percent">
						<xsl:text>%</xsl:text>
						<xsl:value-of select="../../cbc:Percent"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</td>
		<td class="kdvamount">
			<xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
				<xsl:if test="cbc:TaxTypeCode='0015' ">
					<xsl:text> </xsl:text>
					<xsl:for-each select="../../cbc:TaxAmount">
						<xsl:call-template name="Curr_Type"/>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>
		</td>
		<td class="taxother">
			<xsl:for-each select="./cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
				<xsl:if test="cbc:TaxTypeCode!='0015' ">
					<xsl:text> </xsl:text>
					<xsl:value-of select="cbc:Name"/>
					<xsl:if test="../../cbc:Percent">
						<xsl:text> (%</xsl:text>
						<xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')"/>
						<xsl:text>)=</xsl:text>
					</xsl:if>
					<xsl:for-each select="../../cbc:TaxAmount">
						<xsl:call-template name="Curr_Type"/>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="./cac:WithholdingTaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
				<xsl:text>KDV TEVKİFAT </xsl:text>
				<xsl:if test="../../cbc:Percent">
					<xsl:text> (%</xsl:text>
					<xsl:value-of select="format-number(../../cbc:Percent, '###.##0,00', 'european')"/>
					<xsl:text>)=</xsl:text>
				</xsl:if>
				<xsl:for-each select="../../cbc:TaxAmount">
					<xsl:call-template name="Curr_Type"/>
					<xsl:text>&#10;</xsl:text>
				</xsl:for-each>
			</xsl:for-each>
		</td>
		<td class="pricesubtotal">


			<xsl:for-each select="./cbc:LineExtensionAmount">
				<xsl:call-template name="Curr_Type"/>

			</xsl:for-each>

		</td>
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
			<td id="lineTableTd" align="right">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd" align="right">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd" align="right">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd" align="right">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd" align="right">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd" align="right">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd" align="right">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
			<td id="lineTableTd" align="right">
				<span>
					<xsl:text>&#160;</xsl:text>
				</span>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="Party_Title" >
		<xsl:param name="PartyType" />
		<td style="width:469px; " align="left">
			<xsl:if test="cac:PartyName">
				<xsl:value-of select="cac:PartyName/cbc:Name"/>
			</xsl:if>
			<xsl:for-each select="cac:Person">
				<xsl:text>, </xsl:text>
				<xsl:for-each select="cbc:Title">
					<xsl:apply-templates/>
					<xsl:text>&#160;</xsl:text>
				</xsl:for-each>
				<xsl:for-each select="cbc:FirstName">
					<xsl:apply-templates/>
					<xsl:text>&#160;</xsl:text>
				</xsl:for-each>
				<xsl:for-each select="cbc:MiddleName">
					<xsl:apply-templates/>
					<xsl:text>&#160; </xsl:text>
				</xsl:for-each>
				<xsl:for-each select="cbc:FamilyName">
					<xsl:apply-templates/>
					<xsl:text>&#160;</xsl:text>
				</xsl:for-each>
				<xsl:for-each select="cbc:NameSuffix">
					<xsl:apply-templates/>
				</xsl:for-each>
				<xsl:if test="$PartyType='TAXFREE'">
					<br/>
					<xsl:text>Pasaport No: </xsl:text>
					<xsl:value-of select="cac:IdentityDocumentReference/cbc:ID"/>
					<br/>
					<xsl:text>Ülkesi: </xsl:text>
					<xsl:value-of select="cbc:NationalityID"/>
				</xsl:if>
			</xsl:for-each>
		</td>
	</xsl:template>
	<xsl:template name="Party_Adress" >
		<xsl:param name="PartyType" />

		<xsl:for-each select="cac:PostalAddress">
			<p>
				<xsl:for-each select="cbc:District">
					<xsl:text></xsl:text>
					<xsl:apply-templates/>
					<xsl:text>,</xsl:text>
				</xsl:for-each>
				<xsl:for-each select="cbc:StreetName">
					<xsl:apply-templates/>
					<xsl:text>&#160;</xsl:text>
				</xsl:for-each>
				<xsl:for-each select="cbc:BuildingName">
					<xsl:apply-templates/>
				</xsl:for-each>
				<xsl:for-each select="cbc:BuildingNumber">
					<xsl:text> No:</xsl:text>
					<xsl:apply-templates/>
					<xsl:text>&#160;</xsl:text>
				</xsl:for-each>

				<xsl:for-each select="cbc:Room">
					<xsl:text>Kapı No:</xsl:text>
					<xsl:apply-templates/>
					<xsl:text>&#160;</xsl:text>
				</xsl:for-each>
			</p>
			<p>
				<xsl:for-each select="cbc:PostalZone">
					<xsl:apply-templates/>
					<xsl:text>, </xsl:text>
					</xsl:for-each>

				<xsl:for-each select="cbc:Region">
					<xsl:apply-templates/>
                    <xsl:text>, </xsl:text>
				</xsl:for-each>

				<xsl:for-each select="cbc:CitySubdivisionName">
					<xsl:apply-templates/>
				</xsl:for-each>
				<xsl:for-each select="cbc:CityName">
					<xsl:text> / </xsl:text>
					<xsl:apply-templates/>
				</xsl:for-each>
				<xsl:if test="$PartyType='TAXFREE'">
					<xsl:text> / </xsl:text>
					<xsl:value-of select="cac:Country/cbc:Name"/>

				</xsl:if>
			</p>
		</xsl:for-each>


	</xsl:template>
	<xsl:template name='Party_Other'>
		<xsl:param name="PartyType" />
		<p>
			<xsl:for-each select="cbc:WebsiteURI">
				<strong><xsl:text>Web Sitesi: </xsl:text></strong>
				<xsl:value-of select="."/>
			</xsl:for-each>
			<xsl:for-each select="cac:Contact/cbc:ElectronicMail">

				<strong><xsl:text> E-Posta: </xsl:text></strong>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</p>

		<xsl:for-each select="cac:Contact">
			<p>
				<xsl:if test="cbc:Telephone or cbc:Telefax">

					<xsl:for-each select="cbc:Telephone">
						<strong><xsl:text>Tel: </xsl:text></strong>
						<xsl:apply-templates/>
					</xsl:for-each>
					<xsl:for-each select="cbc:Telefax">
						<strong><xsl:text> Fax: </xsl:text></strong>
						<xsl:apply-templates/>
					</xsl:for-each>

				</xsl:if>
			</p>
		</xsl:for-each>
		<xsl:if test="$PartyType!='TAXFREE'">
			<p>
				<xsl:for-each select="cac:PartyTaxScheme/cac:TaxScheme/cbc:Name">

					<strong>
						<xsl:text>Vergi Dairesi: </xsl:text>
					</strong>
					<xsl:apply-templates/>

				</xsl:for-each>
				<xsl:for-each select="cac:PartyIdentification">
					<xsl:text> </xsl:text>
					<strong>
						<xsl:value-of select="cbc:ID/@schemeID"/>
						<xsl:text>: </xsl:text>
					</strong>
					<xsl:value-of select="cbc:ID"/>

				</xsl:for-each>
			</p>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Curr_Type">
		<xsl:value-of select="format-number(., '###.##0,00', 'european')"/>
		<xsl:if	test="@currencyID">
			<xsl:text> </xsl:text>
			<xsl:choose>
				<xsl:when test="@currencyID = 'TRL' or @currencyID = 'TRY'">
					<xsl:text>TL</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@currencyID"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="parcala">
		<xsl:param name="csv"/>
		<xsl:param name="isaret"/>
		<xsl:variable name="first-item" select="normalize-space( substring-before( concat( $csv, '|'), '|'))"/>
		<xsl:if test="$first-item">
			<xsl:if test="normalize-space(substring-after(concat($first-item, ''), $isaret))">
				<xsl:value-of select="normalize-space(substring-after(concat($first-item, ''), $isaret))"/>
			</xsl:if>
			<xsl:call-template name="parcala">
				<xsl:with-param name="csv" select="substring-after($csv,'|')"/>
				<xsl:with-param name="isaret" select="$isaret"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="string-replace-all">
		<xsl:param name="text" />
		<xsl:param name="replace" />
		<xsl:param name="by" />
		<xsl:choose>
			<xsl:when test="contains($text, $replace)">
				<xsl:value-of select="substring-before($text,$replace)" />
				<xsl:value-of select="$by" />
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="substring-after($text,$replace)" />
					<xsl:with-param name="replace" select="$replace" />
					<xsl:with-param name="by" select="$by" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>