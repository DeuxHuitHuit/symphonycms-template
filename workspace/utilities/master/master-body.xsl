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
		<xsl:variable name="computed-attr">
			<add class="{$url-language}" />
			<add class="page-{$full-page-handle}" />
			<add class="site-base-color" />
			<add class="min-width-screen-min" />
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
			<set data-response-url="{$response-url}" />
			<xsl:call-template name="page-attr" />
		</xsl:variable>

		<xsl:variable name="attr-bg-transition">
			<add class="bg-color-white fixed fill z-index-max-minus-5 display-none" />
			<add id="bg-transition" />
			<add dev-element="bg-transition" />
		</xsl:variable>

		<xsl:variable name="attr-bg-transition-modal">
			<add id="bg-transition-modal" />
			<add class="fixed fill z-index-max-minus-6" />
			<add class="display-none" />
			<xsl:call-template name="bg-transition-modal-attr" />
			<add dev-element="bg-transition-modal" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'body'"/>
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content">
				<!-- GTM -->
				<xsl:if test="$debug != true() and string-length($gtm-ctn) != 0">
					<xsl:call-template name="gtm-body">
						<xsl:with-param name="ctn" select="$gtm-ctn" />
					</xsl:call-template>
				</xsl:if>
				
				<a href="#site-pages" class="visually-hidden js-tab-reset">Skip to content</a>
				<a href="#site-nav" class="visually-hidden">Skip to navigation</a>
				
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
								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$computed-page-attr" />
									<xsl:with-param name="content">
										<!-- Content -->
										<xsl:apply-templates select="data" />
									</xsl:with-param>
								</xsl:call-template> <!-- end page -->
							</xsl:with-param>
						</xsl:call-template> <!-- End site-pages -->

						<!-- Site footer -->
						<xsl:call-template name="site-footer" />
					</xsl:with-param> <!-- End site -->
				</xsl:call-template>

				<!-- SITE LOADER -->
				<xsl:call-template name="site-loader" />
				
				<!-- BG TRANSITION -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-bg-transition" />
				</xsl:call-template>
				
				<!-- BG TRANSITION modal -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-bg-transition-modal" />
				</xsl:call-template>
				
				<!-- Block user agent -->
				<xsl:call-template name="block-user-agent-light">
					<xsl:with-param name="text" select="$config/navigateurs-non-supportes" />
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
	<xsl:template name="body-attr"></xsl:template>
<!-- PAGE ATTR HOLE =========================================================-->
	<xsl:template name="page-attr"></xsl:template>
<!-- BG-TRANSITION-modal ATTR HOLE =========================================================-->
	<xsl:template name="bg-transition-modal-attr"></xsl:template>
</xsl:stylesheet>
