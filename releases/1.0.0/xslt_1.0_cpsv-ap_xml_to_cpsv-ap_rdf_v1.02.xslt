<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
 	version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:adms="http://www.w3.org/ns/adms#" 
	xmlns:dcat="http://www.w3.org/ns/dcat#"
	xmlns:dct="http://purl.org/dc/terms/" 
	xmlns:eli="http://data.europa.eu/eli/ontology#" 
	xmlns:foaf="http://xmlns.com/foaf/0.1/" 
	xmlns:frbr="http://purl.org/vocab/frbr/core#" 
	xmlns:locn="http://www.w3.org/ns/locn/" 
	xmlns:org="http://www.w3.org/ns/org#" 
	xmlns:owl="http://www.w3.org/2002/07/owl#" 
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
	xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
	xmlns:vann="http://purl.org/vocab/vann/" 
	xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:cpsvap="http://data.europa.eu/cv/" 
	xmlns:cva="http://www.w3.org/ns/corevocabulary/AggregateComponents"   
 
	xmlns:schema="http://schema.org/" 
	xmlns:sdmx="http://purl.org/linked-data/sdmx/2009/dimension#" 
	xml:base="http://cpsv.testproject.eu/id/BEL/"
	xpath-default-namespace="http://www.w3.org/ns/corevocabulary/BasicComponents">

	<xsl:output encoding="UTF-8" indent="yes" media-type="text/xml" method="xml" omit-xml-declaration="no" />
	

	<xsl:param name="lang">
		<xsl:text>en</xsl:text>
	</xsl:param>
	<xsl:param name="rightsStatement_en">
		<xsl:text>© All rights reserved.</xsl:text>
	</xsl:param>

	<!-- Global parameters -->
	<xsl:param name="XMLSchemaDate">http://www.w3.org/2001/XMLSchema#date</xsl:param>
	<xsl:param name="locnAddress">http://www.w3.org/ns/locn/Address</xsl:param>
	<xsl:param name="Agent">http://xmlns.com/foaf/0.1/Agent</xsl:param>


	
<!-- Main Funtion -->
	<xsl:template match="/*">
		<rdf:RDF>
			<!-- CorePublicService class -->
			<rdf:Description rdf:about="{./PublicServiceID}">
				<rdf:type rdf:resource="http://data.europa.eu/cv/PublicService" />
				<dct:title>
 					<xsl:value-of select="./PublicServiceName" />
				 </dct:title>
				<dct:description>
 					<xsl:value-of select="./PublicServiceDescription" />
				 </dct:description>
				<xsl:if test="./PublicServiceKeyword">
					<dcat:keyword>
						<xsl:value-of select="./PublicServiceKeyword" />
					</dcat:keyword>
				</xsl:if>
				<xsl:if test="./PublicServiceLanguageCode">
					<dct:language rdf:resource="{./PublicServiceLanguageCode}" />
				</xsl:if>
				<xsl:if test="./ProcessingTimeDate">
					<cpsvap:ProcessingTime rdf:datatype="{$XMLSchemaDate}">
						 <xsl:value-of select="./ProcessingTimeDate" />
					 </cpsvap:ProcessingTime>
				</xsl:if>
				<xsl:if test="./PublicServiceSectorCode">
					<cpsvap:sector rdf:resource="{./PublicServiceSectorCode}" />
				</xsl:if>
				<xsl:if test="./PublicServiceTypeCode">
					<dct:type rdf:resource="{./PublicServiceTypeCode}" />
				</xsl:if>


				<xsl:for-each select="./cva:PublicServiceGroupedByBusinessEvent">
					<dct:isPartOf rdf:resource="{./BusinessEventID}" />
				</xsl:for-each>	

				<xsl:for-each select="./cva:RequiresCorePublicService">
					<dct:requires rdf:resource="{./PublicServiceID}" />
				</xsl:for-each>
				
				<xsl:for-each select="./cva:RelatedCorePublicService">
					<dct:relation rdf:resource="{./PublicServiceID}" />
				</xsl:for-each>
				
				<xsl:for-each select="./cva:PublicServiceHasCost">
					<cpsvap:hasCost rdf:resource="{./CostID}" />
				</xsl:for-each>

				<xsl:for-each select="./cva:PublicServiceTemporalPeriodOfTime">
					<dct:temporal rdf:resource="{./PeriodOfTimeID}" />
				</xsl:for-each>
				
				<xsl:for-each select="./cva:PublicServiceSpatialCoreLocation">
					<dct:spatial rdf:resource="{./LocationGeographicID}" />
				</xsl:for-each>	
				
				<xsl:for-each select="./cva:PublicServicePhysicallyAvailableAtCoreLocation">
					<cpsvap:physicallyAvailableAt rdf:resource="{./LocationGeographicID}" />
				</xsl:for-each>	
				
				<xsl:for-each select="./cva:PublicServiceHasFormalFramework">
					<cpsvap:hasFormalFramework rdf:resource="{./FormalFrameworkID}" />
				</xsl:for-each>
				
				<xsl:for-each select="./cva:PublicServiceFollowsRule">
					<cpsvap:follows rdf:resource="{./RuleID}" />
				</xsl:for-each>
				
				<xsl:for-each select="./cva:PublicServiceHasChannel">
					<cpsvap:hasChannel rdf:resource="{./ChannelID}" />
				</xsl:for-each>
							
				<xsl:for-each select="./cva:PublicServiceHasInput">
					<cpsvap:hasInput rdf:resource="{./InputID}" />
				</xsl:for-each>
						
				<xsl:for-each select="./cva:PublicServiceProducesOutput">
					<cpsvap:produces rdf:resource="{./OutputID}" />
				</xsl:for-each>	
				
				<xsl:variable name="AgentID" select="./cva:PublicServiceHasCompetentAuthorityFormalOrganisation/cva:FormalOrganisationHasAgent/AgentID" />
				<cpsvap:hasCompetentAuthority rdf:resource="{$AgentID}" />

			</rdf:Description>
			<!-- End CorePublicService class -->


			<!-- Business Event class -->
			<xsl:for-each select="//cva:PublicServiceGroupedByBusinessEvent">
				<rdf:Description rdf:about="{./BusinessEventID}">
					<rdf:type rdf:resource="http://data.europa.eu/cv/BusinessEvent" />
					<dct:title>
 						<xsl:value-of select="./BusinessEventName" />
					 </dct:title>
					<xsl:if test="./BusinessEventDescription">
						<dct:description>
 							<xsl:value-of select="./BusinessEventDescription" />
						 </dct:description>
					</xsl:if>
					<xsl:if test="./BusinessEventLanguageCode">
						<dct:language  rdf:resource="{./BusinessEventLanguageCode}"  />
					</xsl:if>
					<xsl:if test="./BusinessEventTypeCode">
						<dct:type  rdf:resource="{./BusinessEventTypeCode}"  />
					</xsl:if>
					<xsl:if test="./BusinessEventProcessingTimeDate">
						<cpsvap:processingTime rdf:datatype="{$XMLSchemaDate}">
 							<xsl:value-of select="./BusinessEventProcessingTimeDate" />
						 </cpsvap:processingTime>
					</xsl:if>
					<xsl:if test="./cva:BusinessEventHasCost">
						<cpsvap:hasCost  rdf:resource="{./cva:BusinessEventHasCost/CostID}"  />
					</xsl:if>
				</rdf:Description>
				<!-- Cost of a Business Event -->
				<xsl:if test="./cva:BusinessEventHasCost">
					<xsl:for-each select="./cva:BusinessEventHasCost">
						<rdf:Description rdf:about="{./CostID}">
							<rdf:type rdf:resource="http://data.europa.eu/cv/Cost" />
							<xsl:if test="./CostValueAmount">
								<cpsvap:monetary_value rdf:datatype="http://www.w3.org/2001/XMLSchema#double">
									 <xsl:value-of select="./CostValueAmount" />
								 </cpsvap:monetary_value>
							</xsl:if>
							<xsl:if test="./CostDescription">
								<dct:description>
 									<xsl:value-of select="./CostDescription" />
								 </dct:description>
							</xsl:if>
							<xsl:if test="./CostCurrencyCode">
								<cpsvap:currency  rdf:resource="{./CostCurrencyCode}"  />
							</xsl:if>
							<xsl:if test="./cva:CostIsDefinedByFormalOrganisation">
								<cpsvap:idDefinedBy  rdf:resource="{./cva:CostIsDefinedByFormalOrganisation/cva:FormalOrganisationHasAgent/AgentID}"  />
							</xsl:if>
						</rdf:Description>
						<!-- Formal Organisation of a Cost -->
						<xsl:for-each select="./cva:CostIsDefinedByFormalOrganisation">
							<rdf:Description rdf:about="{./cva:FormalOrganisationHasAgent/AgentID}">
								<rdf:type rdf:resource="http://www.w3.org/ns/org#FormalOrganization" />
								<dct:title>
									<xsl:value-of select="./cva:FormalOrganisationHasAgent/AgentName" />
								</dct:title>
								<xsl:if test="./cva:FormalOrganisationHasAgent/AgentTypeCode">
									<dct:type rdf:resource="{./cva:FormalOrganisationHasAgent/AgentTypeCode}" />
								</xsl:if>
								<xsl:if test="./FormalOrganisationAdministrativeLevelCode">
									<cpsvap:AdministrativeLevel rdf:resource="{./FormalOrganisationAdministrativeLevelCode}" />
								</xsl:if>
								<xsl:if test="./FormalOrganisationAlternativeName">
									<foaf:name> <xsl:value-of select="./FormalOrganisationAlternativeName" /> </foaf:name>
								</xsl:if>
								<xsl:if test="./FormalOrganisationTypeCode">
									<dct:type rdf:resource="{./FormalOrganisationTypeCode}" />
								</xsl:if>
								<xsl:if test="./FormalOrganisationHomepageID">
									<foaf:homepage rdf:resource="{./FormalOrganisationHomepageID}" />
								</xsl:if>
								<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
									<locn:address rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress/CoreAddressIDName}" />
								</xsl:if>
								<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentPlaysRoleCorePublicService">
									<cpsvap:hasRole rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
								</xsl:if>
								<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService">
									<cpsvap:uses rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
								</xsl:if>
							</rdf:Description>
							
							<!-- Address of an agent -->
							<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
								<xsl:apply-templates select="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>
			<!-- End Business Event class -->

		
			<!-- Channel class -->
			<xsl:for-each select="//cva:PublicServiceHasChannel">
				<rdf:Description rdf:about="{./ChannelID}">
					<rdf:type rdf:resource="http://data.europa.eu/cv/Channel" />
					<xsl:if test="./ChannelTypeCode">
						<dct:type rdf:resource="{./ChannelTypeCode}" />
					</xsl:if>
					<xsl:if test="./cva:ChannelOwnedByFormalOrganisation">
						<xsl:for-each select="./cva:ChannelOwnedByFormalOrganisation">
							<cpsvap:ownedBy rdf:resource="{./cva:FormalOrganisationHasAgent/AgentID}" />
						</xsl:for-each>
					</xsl:if>
				</rdf:Description>
				<xsl:if test="./cva:ChannelOwnedByFormalOrganisation">
					<xsl:for-each select="./cva:ChannelOwnedByFormalOrganisation">
						<rdf:Description rdf:about="{./cva:FormalOrganisationHasAgent/AgentID}">
							<rdf:type rdf:resource="http://www.w3.org/ns/org#FormalOrganization" />
							<dct:title>
								<xsl:value-of select="./cva:FormalOrganisationHasAgent/AgentName" />
							</dct:title>
							<xsl:if test="./cva:FormalOrganisationHasAgent/AgentTypeCode">
								<dct:type rdf:resource="{./cva:FormalOrganisationHasAgent/AgentTypeCode}" />
							</xsl:if>
							<xsl:if test="./FormalOrganisationAdministrativeLevelCode">
								<cpsvap:AdministrativeLevel rdf:resource="{./FormalOrganisationAdministrativeLevelCode}" />
							</xsl:if>
							<xsl:if test="./FormalOrganisationAlternativeName">
								<foaf:name> <xsl:value-of  select="./cva:FormalOrganisationHasAgent/AgentID"/> </foaf:name>
							</xsl:if>
							<xsl:if test="./FormalOrganisationTypeCode">
								<dct:type rdf:resource="{./FormalOrganisationTypeCode}" />
							</xsl:if>
							<xsl:if test="./FormalOrganisationHomepageID">
								<foaf:homepage rdf:resource="{./FormalOrganisationHomepageID}" />
							</xsl:if>
							<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
								<locn:address rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress/CoreAddressIDName}" />
							</xsl:if>
							<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentPlaysRoleCorePublicService">
								<cpsvap:hasRole rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
							</xsl:if>
							<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService">
								<cpsvap:uses rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
							</xsl:if>
						</rdf:Description>
						
						<!-- Address of an agent -->
						<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
							<xsl:apply-templates select="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>
			<!-- End Channel class -->
			
			
			<!-- Input class -->
			
			<xsl:for-each select="//cva:PublicServiceHasInput">
				<rdf:Description rdf:about="{./InputID}">
					<rdf:type rdf:resource="http://data.europa.eu/cv/Input" />
					<dct:title> <xsl:value-of select="./InputName" /> </dct:title>
					<xsl:if test="./InputRelatedDocumentationURIID">
						<foaf:page rdf:resource="{./InputRelatedDocumentationURIID}" />
					</xsl:if>
					<xsl:if test="./InputTypeCode">
						<dct:type rdf:resource="{./InputTypeCode}" />
					</xsl:if>
					<xsl:if test="./InputDescription">
						<dct:description> <xsl:value-of select="./InputDescription" /> </dct:description>
					</xsl:if>
				</rdf:Description>
			</xsl:for-each>
			<!-- End input class -->
			
			<!-- Output class -->
			<xsl:for-each select="//cva:PublicServiceProducesOutput">
				<rdf:Description rdf:about="{./OutputID}">
					<rdf:type rdf:resource="http://data.europa.eu/cv/Output" />
					<dct:title> <xsl:value-of select="./OutputName" /> </dct:title>
					<xsl:if test="./OutputTypeCode">
						<dct:type rdf:resource="{./OutputTypeCode}" />
					</xsl:if>
					<xsl:if test="./OutputDescription">
						<dct:description> <xsl:value-of select="./OutputDescription" /> </dct:description>
					</xsl:if>
				</rdf:Description>
			</xsl:for-each>
			<!-- End Output class -->
	
			<!--Period Of Time class -->
			<xsl:for-each select="//cva:PublicServiceTemporalPeriodOfTime">
				<rdf:Description rdf:about="{./PeriodOfTimeID}">
					<rdf:type rdf:resource="http://purl.org/dc/terms/PeriodOfTime" />
					<cpsvap:startDateTime rdf:datatype="{$XMLSchemaDate}"> <xsl:value-of select="./PeriodOfTimeStartDate" /> </cpsvap:startDateTime>
					<cpsvap:endDateTime rdf:datatype="{$XMLSchemaDate}"> <xsl:value-of select="./PeriodOfTimeEndDate" /> </cpsvap:endDateTime>
				</rdf:Description>
			</xsl:for-each>
			<!-- End Period Of Time class -->

			<!-- PhysicallyAvailableAt relation + Location class -->
			<xsl:for-each select="./cva:PublicServicePhysicallyAvailableAtCoreLocation">
				<rdf:Description rdf:about="{./LocationGeographicID}">
					<rdf:type rdf:resource="http://purl.org/dc/terms/Location" />
					<xsl:if test="./LocationGeographicName">
						<locn:GeographicName> <xsl:value-of select="./LocationGeographicName" /> </locn:GeographicName>
					</xsl:if>
					<xsl:if test="./cva:CoreLocationHasCoreAddress">
						<xsl:for-each select="./cva:CoreLocationHasCoreAddress">
							<locn:address  rdf:resource="{./CoreAddressIDName}" />
						</xsl:for-each>
					</xsl:if>
				</rdf:Description>
		
				<!--Address of a location-->
				<xsl:for-each select="./cva:CoreLocationHasCoreAddress">
					<rdf:Description rdf:about="{./CoreAddressIDName}">
						<rdf:type rdf:resource="http://www.w3.org/ns/locn#Address" />
						<locn:fullAddress> <xsl:value-of select="./CoreAddressFullAddress" /> </locn:fullAddress>
						<xsl:if test="./CoreAddressAddressArea">
							<locn:addressArea> <xsl:value-of select="./CoreAddressAddressArea" /> </locn:addressArea>
						</xsl:if>
						<xsl:if test="./CoreAddressAdminUnitLocationOne">
							<locn:adminUnitL1> <xsl:value-of select="./CoreAddressAdminUnitLocationOne" /> </locn:adminUnitL1>
						</xsl:if>
						<xsl:if test="./CoreAddressAdminUnitLocationTwo">
							<locn:adminUnitL2> <xsl:value-of select="./CoreAddressAdminUnitLocationTwo" /> </locn:adminUnitL2>
						</xsl:if>
						<xsl:if test="./CoreAddressLocatorDesignator">
							<locn:locatorDesignator> <xsl:value-of select="./CoreAddressLocatorDesignator" /> </locn:locatorDesignator>
						</xsl:if>
						<xsl:if test="./CoreAddressLocatorName">
							<locn:locatorName> <xsl:value-of select="./CoreAddressLocatorName" /> </locn:locatorName>
						</xsl:if>
						<xsl:if test="./CoreAddressPostOfficeBox">
							<locn:poBox> <xsl:value-of select="./CoreAddressPostOfficeBox" /> </locn:poBox>
						</xsl:if>
						<xsl:if test="./CoreAddressPostCode">
							<locn:postCode> <xsl:value-of select="./CoreAddressPostCode" /> </locn:postCode>
						</xsl:if>
						<xsl:if test="./CoreAddressPostName">
							<locn:postName> <xsl:value-of select="./CoreAddressPostName" /> </locn:postName>
						</xsl:if>
						<xsl:if test="./CoreAddressThoroughfare">
							<locn:thoroughfare> <xsl:value-of select="./CoreAddressThoroughfare" /> </locn:thoroughfare>
						</xsl:if>
					</rdf:Description>
				</xsl:for-each>
			</xsl:for-each>
			<!-- PhysicallyAvailableAt relation + Location class -->
			
			<!-- Spatial relation + Location class -->
			<xsl:for-each select="./cva:PublicServiceSpatialCoreLocation">
				<rdf:Description rdf:about="{./LocationGeographicID}">
					<rdf:type rdf:resource="http://purl.org/dc/terms/Location" />
					<locn:GeographicName> <xsl:value-of select="./LocationGeographicName" /> </locn:GeographicName>
					<xsl:if test="./cva:CoreLocationHasCoreAddress">
						<xsl:for-each select="./cva:CoreLocationHasCoreAddress">
							<locn:address  rdf:resource="{./CoreAddressIDName}" />
						</xsl:for-each>
					</xsl:if>
				</rdf:Description>
				<!--Address of a location-->
				<xsl:if test="./cva:CoreLocationHasCoreAddress">
					<xsl:for-each select="./cva:CoreLocationHasCoreAddress">
						<rdf:Description rdf:about="{./CoreAddressIDName}">
							<rdf:type rdf:resource="http://www.w3.org/ns/locn#Address" />
							<locn:fullAddress> <xsl:value-of select="./CoreAddressFullAddress" /> </locn:fullAddress>
							<xsl:if test="./CoreAddressAddressArea">
								<locn:addressArea> <xsl:value-of select="./CoreAddressAddressArea" /> </locn:addressArea>
							</xsl:if>
							<xsl:if test="./CoreAddressAdminUnitLocationOne">
								<locn:adminUnitL1> <xsl:value-of select="./CoreAddressAdminUnitLocationOne" /> </locn:adminUnitL1>
							</xsl:if>
							<xsl:if test="./CoreAddressAdminUnitLocationTwo">
								<locn:adminUnitL2> <xsl:value-of select="./CoreAddressAdminUnitLocationTwo" /> </locn:adminUnitL2>
							</xsl:if>
							<xsl:if test="./CoreAddressLocatorDesignator">
								<locn:locatorDesignator> <xsl:value-of select="./CoreAddressLocatorDesignator" /> </locn:locatorDesignator>
							</xsl:if>
							<xsl:if test="./CoreAddressLocatorName">
								<locn:locatorName> <xsl:value-of select="./CoreAddressLocatorName" /> </locn:locatorName>
							</xsl:if>
							<xsl:if test="./CoreAddressPostOfficeBox">
								<locn:poBox> <xsl:value-of select="./CoreAddressPostOfficeBox" /> </locn:poBox>
							</xsl:if>
							<xsl:if test="./CoreAddressPostCode">
								<locn:postCode> <xsl:value-of select="./CoreAddressPostCode" /> </locn:postCode>
							</xsl:if>
							<xsl:if test="./CoreAddressPostName">
								<locn:postName> <xsl:value-of select="./CoreAddressPostName" /> </locn:postName>
							</xsl:if>
							<xsl:if test="./CoreAddressThoroughfare">
								<locn:thoroughfare> <xsl:value-of select="./CoreAddressThoroughfare" /> </locn:thoroughfare>
							</xsl:if>
						</rdf:Description>
					</xsl:for-each>
				</xsl:if>				
			</xsl:for-each>
			<!-- End Spatial relation + Location class -->
			
			
			<!-- Rule class -->
			<xsl:for-each select="//cva:PublicServiceFollowsRule">
				<rdf:Description rdf:about="{./RuleID}">
					<rdf:type rdf:resource="http://data.europa.eu/cv/Rule" />
					<dct:description> <xsl:value-of select="./RuleDescription" /> </dct:description>
					<dct:title> <xsl:value-of select="./RuleName" /> </dct:title>
					<xsl:if test="./RuleLanguageCode">
						<dct:language rdf:resource="{./RuleLanguageCode}" />
					</xsl:if>
					<xsl:if test="./cva:ImplementsFormalFramework">
						<cpsvap:implements rdf:resource="{./cva:ImplementsFormalFramework/FormalFrameworkID}" />
					</xsl:if>
				</rdf:Description>
				<xsl:if test="./cva:ImplementsFormalFramework">
					<xsl:apply-templates select="./cva:ImplementsFormalFramework" />
				</xsl:if>
			</xsl:for-each>
			<!-- End Rule class -->
			
			
			<!-- Formal Organisation of Has Competent Authority -->
			<xsl:apply-templates select="./cva:PublicServiceHasCompetentAuthorityFormalOrganisation"/>

			
			<!-- Formal Framework -->			
			<xsl:apply-templates select="./cva:PublicServiceHasFormalFramework"/>
			
			<!-- Cost class -->
			<xsl:for-each select="./cva:PublicServiceHasCost">
				<rdf:Description rdf:about="{./CostID}">
					<rdf:type rdf:resource="http://data.europa.eu/cv/Cost" />
					<xsl:if test="./CostValueAmount">
						<cpsvap:monetary_value  rdf:datatype="http://www.w3.org/2001/XMLSchema#double"> <xsl:value-of select="./CostValueAmount" /> </cpsvap:monetary_value>
					</xsl:if>
					<xsl:if test="./CostDescription">
						<dct:description> <xsl:value-of select="./CostDescription" /> </dct:description>
					</xsl:if>
					<xsl:if test="./CostCurrencyCode">
						<cpsvap:currency  rdf:resource="./CostCurrencyCode" />
					</xsl:if>
					<xsl:if test="./cva:CostIsDefinedByFormalOrganisation">
						<cpsvap:idDefinedBy  rdf:resource="{./cva:CostIsDefinedByFormalOrganisation/cva:FormalOrganisationHasAgent/AgentID}" />
					</xsl:if>
				</rdf:Description>
				<!-- Formal Organisation of a Cost -->
				<xsl:for-each select="./cva:CostIsDefinedByFormalOrganisation">
					<rdf:Description rdf:about="{./cva:FormalOrganisationHasAgent/AgentID}">
						<rdf:type rdf:resource="http://www.w3.org/ns/org#FormalOrganization" />
						<dct:title>
							<xsl:value-of select="./cva:FormalOrganisationHasAgent/AgentName" />
						</dct:title>
						<xsl:if test="./cva:FormalOrganisationHasAgent/AgentTypeCode">
							<dct:type rdf:resource="{./cva:FormalOrganisationHasAgent/AgentTypeCode}" />
						</xsl:if>
						<xsl:if test="./FormalOrganisationAdministrativeLevelCode">
							<cpsvap:AdministrativeLevel rdf:resource="{./FormalOrganisationAdministrativeLevelCode}" />
						</xsl:if>
						<xsl:if test="./FormalOrganisationAlternativeName">
							<foaf:name> <xsl:value-of select="./FormalOrganisationAlternativeName" /> </foaf:name>
						</xsl:if>
						<xsl:if test="./FormalOrganisationTypeCode">
							<dct:type rdf:resource="{./FormalOrganisationTypeCode}" />
						</xsl:if>
						<xsl:if test="./FormalOrganisationHomepageID">
							<foaf:homepage rdf:resource="{./FormalOrganisationHomepageID}" />
						</xsl:if>
						<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
							<locn:address rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress/CoreAddressIDName}" />
						</xsl:if>
						<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentPlaysRoleCorePublicService">
							<cpsvap:hasRole rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
						</xsl:if>
						<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService">
							<cpsvap:uses rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
						</xsl:if>
					</rdf:Description>
					
					<!-- Address of an agent -->
					<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
						<xsl:apply-templates select="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:for-each>
			<!-- End Cost class -->
			
		</rdf:RDF>
	</xsl:template>
	<!-- End Main Funtion -->
	
	<!-- Function - FormalFramework of a Rule -->
	<xsl:template match="cva:ImplementsFormalFramework">
		<rdf:Description rdf:about="{./FormalFrameworkID}">
			<rdf:type rdf:resource="http://data.europa.eu/cv/FormalFramework" />
			<eli:id_local> <xsl:value-of select="./FormalFrameworkName" /> </eli:id_local>
			<xsl:if test="./FormalFrameworkDescription">
				<dct:description> <xsl:value-of select="./FormalFrameworkDescription" /> </dct:description>
			</xsl:if>
			<xsl:if test="./FormalFrameworkLanguageCode">
				<eli:language  rdf:resource="{./FormalFrameworkLanguageCode}"  />
			</xsl:if>
			<xsl:if test="./FormalFrameworkStatus">
				<adms:status> <xsl:value-of select="./FormalFrameworkStatus" /> </adms:status> 
			</xsl:if>
			<xsl:if test="./FormalFrameworkSubjectCode">
				<eli:is_about  rdf:resource="{./FormalFrameworkSubjectCode}" />
			</xsl:if>
			<xsl:if test="./FormalFrameworkTerritorialApplicationCode">
				<eli:relevant_for  rdf:resource="{./FormalFrameworkTerritorialApplicationCode}"/>
			</xsl:if>
			<xsl:if test="./FormalFrameworkTypeCode">
				<eli:type_document  rdf:resource="{./FormalFrameworkTypeCode}" />
			</xsl:if>
			<xsl:if test="./cva:RelatedFormalFramework">
				<cpsvap:relation  rdf:resource="{./cva:RelatedFormalFramework/FormalFrameworkID}" />
			</xsl:if>
			<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation">
				<dct:creator  rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentID}" />
			</xsl:if>
		</rdf:Description>
		<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation">
			<rdf:Description rdf:about="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentID}">
				<rdf:type rdf:resource="http://data.europa.eu/cv/PublicOrganisation" />
				<dct:title>
					<xsl:value-of select="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentName" />
				</dct:title>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentTypeCode">
					<dct:type rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentTypeCode}" />
				</xsl:if>
				<xsl:if test="./PublicOrganisationTypeCode">
					<dct:type rdf:resource="{./PublicOrganisationTypeCode}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationAdministrativeLevelCode">
					<cpsvap:AdministrativeLevel rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationAdministrativeLevelCode}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationAlternativeName">
					<foaf:name>
						<xsl:value-of select="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationAlternativeName" />
					</foaf:name>
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationTypeCode">
					<dct:type rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationTypeCode}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationHomepageID">
					<foaf:homepage rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationHomepageID}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
					<locn:address rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress/CoreAddressIDName}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentPlaysRoleCorePublicService">
					<cpsvap:hasRole rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService">
					<cpsvap:uses rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
				</xsl:if>
			</rdf:Description>
			<!-- Address of an agent -->
			<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
			
				<xsl:variable name="aux" select="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress"></xsl:variable>
				<rdf:Description rdf:about="{$aux/CoreAddressIDName}">
					<rdf:type rdf:resource="http://www.w3.org/ns/locn#Address" />
					<locn:fullAddress> <xsl:value-of select="$aux/CoreAddressFullAddress" /> </locn:fullAddress>
					<xsl:if test="$aux/CoreAddressAddressArea">
						<locn:addressArea> <xsl:value-of select="$aux/CoreAddressAddressArea" /> </locn:addressArea>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressAdminUnitLocationOne">
						<locn:adminUnitL1> <xsl:value-of select="$aux/CoreAddressAdminUnitLocationOne" /> </locn:adminUnitL1>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressAdminUnitLocationTwo">
						<locn:adminUnitL2> <xsl:value-of select="$aux/CoreAddressAdminUnitLocationTwo" /> </locn:adminUnitL2>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressLocatorDesignator">
						<locn:locatorDesignator> <xsl:value-of select="$aux/CoreAddressLocatorDesignator" /> </locn:locatorDesignator>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressLocatorName">
						<locn:locatorName> <xsl:value-of select="$aux/CoreAddressLocatorName" /> </locn:locatorName>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressPostOfficeBox">
						<locn:poBox> <xsl:value-of select="$aux/CoreAddressPostOfficeBox" /> </locn:poBox>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressPostCode">
						<locn:postCode> <xsl:value-of select="$aux/CoreAddressPostCode" /> </locn:postCode>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressPostName">
						<locn:postName> <xsl:value-of select="$aux/CoreAddressPostName" />	</locn:postName>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressThoroughfare">
						<locn:thoroughfare> <xsl:value-of select="$aux/CoreAddressThoroughfare" /> </locn:thoroughfare>
					</xsl:if>
				</rdf:Description>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!-- End Function - FormalFramework of a Rule -->


	<!-- Function - FormalFramework of a Public Service -->
	<xsl:template match="cva:PublicServiceHasFormalFramework">
		<rdf:Description rdf:about="{./FormalFrameworkID}">
			<rdf:type rdf:resource="http://data.europa.eu/cv/FormalFramework" />
			<eli:id_local> <xsl:value-of select="./FormalFrameworkName" /> </eli:id_local>
			<xsl:if test="./FormalFrameworkDescription">
				<dct:description> <xsl:value-of select="./FormalFrameworkDescription" /> </dct:description>
			</xsl:if>
			<xsl:if test="./FormalFrameworkLanguageCode">
				<eli:language  rdf:resource="{./FormalFrameworkLanguageCode}" />
			</xsl:if>
			<xsl:if test="./FormalFrameworkStatus">
				<adms:status> <xsl:value-of select="./FormalFrameworkStatus" /> </adms:status> 
			</xsl:if>
			<xsl:if test="./FormalFrameworkSubjectCode">
				<eli:is_about  rdf:resource="{./FormalFrameworkSubjectCode}"  />
			</xsl:if>
			<xsl:if test="./FormalFrameworkTerritorialApplicationCode">
				<eli:relevant_for  rdf:resource="{./FormalFrameworkTerritorialApplicationCode}" />
			</xsl:if>
			<xsl:if test="./FormalFrameworkTypeCode">
				<eli:type_document  rdf:resource="{./FormalFrameworkTypeCode}"  />
			</xsl:if>
			<xsl:if test="./cva:RelatedFormalFramework">
				<dct:relation  rdf:resource="{./cva:RelatedFormalFramework/FormalFrameworkID}" />
			</xsl:if>
			<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation">
				<dct:creator  rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentID}" />
			</xsl:if>
		</rdf:Description>
		<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation">
			<rdf:Description rdf:about="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentID}">
				<rdf:type rdf:resource="http://data.europa.eu/cv/PublicOrganisation" />
				<dct:title>
					<xsl:value-of select="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentName" />
				</dct:title>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentTypeCode">
					<dct:type rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/AgentTypeCode}" />
				</xsl:if>

				<xsl:if test="./PublicOrganisationTypeCode">
					<dct:type rdf:resource="{./PublicOrganisationTypeCode}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationAdministrativeLevelCode">
					<cpsvap:AdministrativeLevel rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationAdministrativeLevelCode}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationAlternativeName">
					<foaf:name>
						<xsl:value-of select="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationAlternativeName" />
					</foaf:name>
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationTypeCode">
					<dct:type rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationTypeCode}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationHomepageID">
					<foaf:homepage rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/FormalOrganisationHomepageID}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
					<locn:address rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress/CoreAddressIDName}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentPlaysRoleCorePublicService">
					<cpsvap:hasRole rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
				</xsl:if>
				<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService">
					<cpsvap:uses rdf:resource="{./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
				</xsl:if>
			</rdf:Description>
			<!-- Address of an agent -->
			<xsl:if test="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
				<!-- Address of an agent -->
				<xsl:variable name="aux" select="./cva:FormalFrameworkHasCreatorPublicOrganisation/cva:PublicOrganisationIsFormalOrganisation/cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress"></xsl:variable>
				<rdf:Description rdf:about="{$aux/CoreAddressIDName}">
					<rdf:type rdf:resource="http://www.w3.org/ns/locn#Address" />
					<locn:fullAddress> <xsl:value-of select="$aux/CoreAddressFullAddress" /> </locn:fullAddress>
					<xsl:if test="$aux/CoreAddressAddressArea">
						<locn:addressArea> <xsl:value-of select="$aux/CoreAddressAddressArea" /> </locn:addressArea>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressAdminUnitLocationOne">
						<locn:adminUnitL1> <xsl:value-of select="$aux/CoreAddressAdminUnitLocationOne" /> </locn:adminUnitL1>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressAdminUnitLocationTwo">
						<locn:adminUnitL2> <xsl:value-of select="$aux/CoreAddressAdminUnitLocationTwo" /> </locn:adminUnitL2>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressLocatorDesignator">
						<locn:locatorDesignator> <xsl:value-of select="$aux/CoreAddressLocatorDesignator" /> </locn:locatorDesignator>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressLocatorName">
						<locn:locatorName> <xsl:value-of select="$aux/CoreAddressLocatorName" /> </locn:locatorName>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressPostOfficeBox">
						<locn:poBox> <xsl:value-of select="$aux/CoreAddressPostOfficeBox" /> </locn:poBox>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressPostCode">
						<locn:postCode> <xsl:value-of select="$aux/CoreAddressPostCode" /> </locn:postCode>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressPostName">
						<locn:postName> <xsl:value-of select="$aux/CoreAddressPostName" /> </locn:postName>
					</xsl:if>
					<xsl:if test="$aux/CoreAddressThoroughfare">
						<locn:thoroughfare> <xsl:value-of select="$aux/CoreAddressThoroughfare" /> </locn:thoroughfare>
					</xsl:if>
				</rdf:Description>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!-- End Function - FormalFramework of a Public Service -->

	<!-- Funtion - Address of an Formal Organisation -->
	<xsl:template match="cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
		<!-- Address of an agent -->
		<rdf:Description rdf:about="{./CoreAddressIDName}">
			<rdf:type rdf:resource="http://www.w3.org/ns/locn#Address" />
			<locn:fullAddress>
				<xsl:value-of select="./CoreAddressFullAddress" />
			</locn:fullAddress>
			<xsl:if test="./CoreAddressAddressArea">
				<locn:addressArea> <xsl:value-of select="./CoreAddressAddressArea" /> </locn:addressArea>
			</xsl:if>
			<xsl:if test="./CoreAddressAdminUnitLocationOne">
				<locn:adminUnitL1> <xsl:value-of select="./CoreAddressAdminUnitLocationOne" /> </locn:adminUnitL1>
			</xsl:if>
			<xsl:if test="./CoreAddressAdminUnitLocationTwo">
				<locn:adminUnitL2> <xsl:value-of select="./CoreAddressAdminUnitLocationTwo" /> </locn:adminUnitL2>
			</xsl:if>
			<xsl:if test="./CoreAddressLocatorDesignator">
				<locn:locatorDesignator> <xsl:value-of select="./CoreAddressLocatorDesignator" /> </locn:locatorDesignator>
			</xsl:if>
			<xsl:if test="./CoreAddressLocatorName">
				<locn:locatorName> <xsl:value-of select="./CoreAddressLocatorName" /> </locn:locatorName>
			</xsl:if>
			<xsl:if test="./CoreAddressPostOfficeBox">
				<locn:poBox> <xsl:value-of select="./CoreAddressPostOfficeBox" /> </locn:poBox>
			</xsl:if>
			<xsl:if test="./CoreAddressPostCode">
				<locn:postCode> <xsl:value-of select="./CoreAddressPostCode" /> </locn:postCode>
			</xsl:if>
			<xsl:if test="./CoreAddressPostName">
				<locn:postName> <xsl:value-of select="./CoreAddressPostName" /> </locn:postName>
			</xsl:if>
			<xsl:if test="./CoreAddressThoroughfare">
				<locn:thoroughfare> <xsl:value-of select="./CoreAddressThoroughfare" /> </locn:thoroughfare>
			</xsl:if>
		</rdf:Description>
	</xsl:template>
	<!-- End Funtion - Address of an Formal Organisation -->

	<!-- Function - Has Competent Authority -->
	<xsl:template match="cva:PublicServiceHasCompetentAuthorityFormalOrganisation">
		<rdf:Description rdf:about="{./cva:FormalOrganisationHasAgent/AgentID}">
			<rdf:type rdf:resource="http://www.w3.org/ns/org#FormalOrganization" />
			<dct:title> <xsl:value-of select="./cva:FormalOrganisationHasAgent/AgentName" /> </dct:title>
			<xsl:if test="./cva:FormalOrganisationHasAgent/AgentTypeCode">
				<dct:type rdf:resource="{./cva:FormalOrganisationHasAgent/AgentTypeCode}" />
			</xsl:if>
			<xsl:if test="./FormalOrganisationAdministrativeLevelCode">
				<cpsvap:AdministrativeLevel rdf:resource="{./FormalOrganisationAdministrativeLevelCode}" />
			</xsl:if>
			<xsl:if test="./FormalOrganisationAlternativeName">
				<foaf:name> <xsl:value-of select="./FormalOrganisationAlternativeName" /> </foaf:name>
			</xsl:if>
			<xsl:if test="./FormalOrganisationTypeCode">
				<dct:type rdf:resource="{./FormalOrganisationTypeCode}" />
			</xsl:if>
			<xsl:if test="./FormalOrganisationHomepageID">
				<foaf:homepage rdf:resource="{./FormalOrganisationHomepageID}" />
			</xsl:if>
			<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
				<locn:address rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress/CoreAddressIDName}" />
			</xsl:if>
			<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentPlaysRoleCorePublicService">
				<cpsvap:hasRole rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
			</xsl:if>
			<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService">
				<cpsvap:uses rdf:resource="{./cva:FormalOrganisationHasAgent/cva:AgentUsesCorePublicService/PublicServiceID}" />
			</xsl:if>
		</rdf:Description>
		
		<!-- Address of an agent -->
		<xsl:if test="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress">
			<xsl:apply-templates select="./cva:FormalOrganisationHasAgent/cva:AgentHasCoreAddress"/>
		</xsl:if>
	</xsl:template>	
	<!-- End Function - Has Competent Authority -->
	
</xsl:stylesheet>
