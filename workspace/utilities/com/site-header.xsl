<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="site-header">
	<header class="site-header" role="menubar">
		<xsl:call-template name="menu-admin" />
		<a role="menuitem">
			<xsl:attribute name="href">
				<xsl:call-template name="create-page-url-by-id">
					<xsl:with-param name="id" select="$page-index-id" />
				</xsl:call-template>
			</xsl:attribute>
			
			<h1>
				<!-- Logo -->
				
				<!-- Nom du site -->
				<span><xsl:value-of select="$config/site-titre/item[@lang=$url-language]" /></span>
			</h1>
		</a>
		
		<!-- Nav -->
		<xsl:call-template name="site-nav" />
		
		<!-- Alt langs -->
		<xsl:apply-templates select="/data/fl-languages/supported-languages/item[@handle != $url-language]" mode="revert-language">
			<xsl:with-param name="class" select="'js-nav-link-button'" />
		</xsl:apply-templates>
	</header>
</xsl:template>

</xsl:stylesheet>
