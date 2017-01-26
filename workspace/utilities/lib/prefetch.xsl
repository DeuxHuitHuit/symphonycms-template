<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">

	<xsl:template name="dns-prefetch">
		<xsl:variable name="domains">
			<domains>
				<domain>watermark.deuxhuithuit.com</domain>
				<domain>www.google-analytics.com</domain>
				<!--domain>www.googletagmanager.com</domain>
				<domain>maps.googleapis.com</domain>
				<domain>f.vimeocdn.com</domain>
				<domain>www.youtube.com</domain-->
			</domains>
		</xsl:variable>
		
		<xsl:apply-templates select="exsl:node-set($domains)/domains/domain" />
	</xsl:template>

	<xsl:template match="domains/domain">
		<link rel="dns-prefetch" href="//{.}" />
	</xsl:template>
</xsl:stylesheet>
