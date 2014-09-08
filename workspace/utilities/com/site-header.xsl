<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="site-header">
	<header class="site-header">
		<xsl:call-template name="menu-admin" />
		<a>
			<xsl:attribute name="href">
				<xsl:call-template name="create-page-url-by-id">
					<xsl:with-param name="id" select="$page-index-id" />
				</xsl:call-template>
			</xsl:attribute>
			
			<h2>
				<!-- Logo -->
				
				<!-- Nom du site -->
				<span><xsl:value-of select="$config/site-titre/item[@lang=$url-language]" /></span>
			</h2>
		</a>
	</header>
</xsl:template>

</xsl:stylesheet>
