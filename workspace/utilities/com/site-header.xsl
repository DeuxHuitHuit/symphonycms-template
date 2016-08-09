<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="site-header">
	<xsl:param name="attr" />

	<xsl:variable name="computed-attr">
		<add class="js-site-header" />
		<add role="menubar" />
	</xsl:variable>

	<header>
		<xsl:call-template name="attr" >
			<xsl:with-param name="attr" select="$computed-attr" />
		</xsl:call-template>

		<xsl:call-template name="menu-admin" />

		<xsl:call-template name="site-header-logo-link" >
			<!--xsl:with-param name="url" select="$page-index-url"/-->
			<!--xsl:with-param name="attr" /-->
			<!--xsl:with-param name="heading-attr" /-->
			<!--xsl:with-param name="span-attr">
				<add class="hidden" />
			</xsl:with-param-->
			<xsl:with-param name="content" >
				<xsl:call-template name="site-header-logo" />
			</xsl:with-param>
		</xsl:call-template>

		<!-- Nav -->
		<xsl:call-template name="site-nav" >
			<!-- Add Extra attributes to the nav container -->
			<!--xsl:with-param name="attr" / -->

			<!-- Add Extra attributes to all link container -->
			<!--xsl:with-param name="link-ctn-attr" /-->

			<!-- Add Extra attributes to all link -->
			<!--xsl:with-param name="link-attr" /-->
		</xsl:call-template>

		<!-- Alt languages buttons-->
		<xsl:call-template name="site-lang-links" >
			<!-- Include or not the current language -->
			<!--xsl:param name="include-current-language" select="false()"/-->

			<!-- True for 2 letters content --> 
			<!--xsl:with-param name="use-short-content" select="true()"/>-->

			<!-- Override content algo-->
			<!--xsl:with-param name="content" /-->

			<!-- Add Extra attributes to all links -->
			<!--xsl:with-param name="attr" /-->
		</xsl:call-template>

	</header>
</xsl:template>

<xsl:template name="site-header-logo-link">
	<xsl:param name="url" select="$page-index-url"/>
	<xsl:param name="attr" />
	<xsl:param name="heading-attr" />
	<xsl:param name="span-attr" >
		<add class="hidden" />
	</xsl:param>
	<xsl:param name="content" />
	
	<xsl:variable name="computed-attr" >
		<add role="menuitem" />
		<xsl:copy-of select="$attr" />
	</xsl:variable>

	<xsl:call-template name="button">
		<xsl:with-param name="attr" select="$computed-attr" />
		<xsl:with-param name="url" select="$url" />
		<xsl:with-param name="content">

			<h1>
				<xsl:call-template name="attr" >
					<xsl:with-param name="attr" select="$heading-attr"/>
				</xsl:call-template>

				<!-- Logo -->
				<xsl:call-template name="content" >
					<xsl:with-param name="content" select="$content"/>
				</xsl:call-template>

				<!-- Nom du site -->
				<span>
					<xsl:call-template name="attr" >
						<xsl:with-param name="attr" select="$span-attr" />
					</xsl:call-template>

					<xsl:call-template name="content" >
						<xsl:with-param name="content"  select="$config/site-titre"/>
					</xsl:call-template>
				</span>
			</h1>

		</xsl:with-param>
	</xsl:call-template>

</xsl:template>

<xsl:template name="site-header-logo" >
	
</xsl:template>

</xsl:stylesheet>
