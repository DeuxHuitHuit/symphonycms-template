<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- IMPORT-->
	<!-- site-imports -->
	<xsl:import href="../site-imports.xsl" />
	
	<!-- Extensions -->
	<xsl:import href="../../../extensions/block_user_agent/utilities/block_user_agent.xsl" />
	<xsl:import href="../../../extensions/datetime/utilities/datetime.xsl" />


<!-- COMPONENT MASTER-BODY ==================================================-->
	<xsl:template name="master-body">
	
	<!-- STYLES 															 -->
	<xsl:variable name="body-style">
		
	</xsl:variable>

	<xsl:variable name="site-style">
		
	</xsl:variable>
	<!--																	/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<!-- body -->
		<xsl:variable name="computed-attr" >
			<add class="{$url-language}" />
			<add class="page-{$full-page-handle}" />
			<add data-version="{$version}" />
			<xsl:copy-of select="$body-style" />
			<xsl:call-template name="body-attr" />
		</xsl:variable>

		<!-- site -->
		<xsl:variable name="computed-site-attr">
			<add id="site" />
			<xsl:copy-of select="$site-style" />
		</xsl:variable>

		<!-- site-pages -->
		<xsl:variable name="computed-site-pages-attr">
			<add id="site-pages" />
		</xsl:variable>

		<!-- page -->
		<xsl:variable name="computed-page-attr">
			<add id="page-{$full-page-handle}" />
			<add class="page" />
			<xsl:call-template name="page-attr" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'body'"/>
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content">
				
				<!-- Site -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$computed-site-attr"/>
					<xsl:with-param name="content">

						<!-- Site header -->
						<xsl:call-template name="site-header" />
						
						<!-- Site Pages -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$computed-site-pages-attr"/>
							<xsl:with-param name="content">

								<!-- Page -->
								<xsl:call-template name="element" >
									<xsl:with-param name="attr" select="$computed-page-attr" />
									<xsl:with-param name="content" >
										
										<!-- page-content -->
										<xsl:apply-templates select="data" />
									</xsl:with-param>
								</xsl:call-template> <!-- end page -->
							</xsl:with-param>
						</xsl:call-template> <!-- End site-pages -->

						<!-- Site footer -->
						<xsl:call-template name="site-footer" />
					</xsl:with-param> <!-- End site -->
				</xsl:call-template>

				<!-- load progress -->
				<div id="load-progress"></div>
				
				<!-- Block user agent -->
				<xsl:call-template name="block-user-agent-light">
					<xsl:with-param name="text" select="$config/navigateurs-non-supportes-titre" />
					<xsl:with-param name="client-side-detection" select="true()" />
				</xsl:call-template>
				
				<!-- JS -->
				<xsl:call-template name="master-js">
					<xsl:with-param name="extra-js">

						<!-- Register URL for the site-->
						<xsl:call-template name="framework-288-url-creator" /> 
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> <!-- End body -->
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>


<!-- BODY ATTR HOLE =========================================================-->
	<xsl:template name="body-attr" ></xsl:template>
<!-- PAGE ATTR HOLE =========================================================-->
	<xsl:template name="page-attr" ></xsl:template>
</xsl:stylesheet>
