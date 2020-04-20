<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
								xmlns:exsl="http://exslt.org/common" 
								extension-element-prefixes="exsl">

	<xsl:template name="picture">
		<xsl:param name="image" select="image" />
		<xsl:param name="alt" select="alt" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-image" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<xsl:copy-of select="$ext-attr-image" />
		</xsl:variable>

		<xsl:call-template name="image">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="ext-attr" select="$attr" />
		</xsl:call-template>

		<xsl:if test="$debug">
			<pre>The XSLT template picture has been deprecated. Please use the XSLT template image.</pre>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
