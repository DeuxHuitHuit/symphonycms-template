<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- COMPONENT: site-header =====================================================================-->
	<xsl:template name="site-header">
		<xsl:param name="attr" />

	<!-- STYLES ____________________________________________________________ -->
		<!-- site-header-->
		<xsl:variable name="site-header-default-style">
			
		</xsl:variable>

		<!-- site-header-logo-link -->
		<xsl:variable name="site-header-logo-link-extend-style">
			<!--add dev-extended-by="site-header" /-->
		</xsl:variable>

		<!-- site-nav -->
		<xsl:variable name="site-nav-extend-style">
			<!--add dev-extended-by="site-header" /-->
		</xsl:variable>

		<!-- site-lang-links -->
		<xsl:variable name="site-lang-links-extend-style">
			<!--add dev-extended-by="site-header" /-->
		</xsl:variable>
	<!-- ___________________________________________________________________/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<add role="menubar" />

			<xsl:copy-of select="$site-header-default-style"/>
			<xsl:copy-of select="$attr"/>
			<add dev-component="site-header" />
		</xsl:variable>

		<xsl:variable name="computed-site-header-logo-link-attr">
			<xsl:copy-of select="$site-header-logo-link-extend-style" />
		</xsl:variable>

		<xsl:variable name="computed-site-nav-attr">
			<xsl:copy-of select="$site-nav-extend-style"/>
		</xsl:variable>

		<xsl:variable name="computed-site-lang-links-attr">
			<xsl:copy-of select="$site-lang-links-extend-style" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'header'" />
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content">

				<!-- COMP: Menu admin -->
				<xsl:call-template name="menu-admin" />

				<!-- COMP: Site header logo and link to home page -->
				<xsl:call-template name="site-header-logo-link" >
					<xsl:with-param name="attr" select="$computed-site-header-logo-link-attr"/>
					<xsl:with-param name="content" >
						
						<!-- TPLT: site-header-logo -->
						<xsl:call-template name="site-header-logo" />
					</xsl:with-param>
				</xsl:call-template>

				<!-- COMP: site-nav -->
				<xsl:call-template name="site-nav" >
					<xsl:with-param name="attr" select="$computed-site-nav-attr"/>
				</xsl:call-template>

				<!-- COMP: Alt languages buttons-->
				<xsl:call-template name="site-lang-links" >
					<xsl:with-param name="attr" select="$computed-site-lang-links-attr"/>
				</xsl:call-template>
			</xsl:with-param> <!-- End header -->
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

<!-- TPLT: site-header-logo =====================================================================-->
	<xsl:template name="site-header-logo" >
		
	</xsl:template>

</xsl:stylesheet>
