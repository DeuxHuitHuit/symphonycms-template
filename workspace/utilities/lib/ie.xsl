<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="ie-cc">
	<xsl:param name="content" />
	<xsl:param name="condition" select="'IE'" />
	
	<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!--[if <xsl:value-of select="$condition" />]<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
	<xsl:copy-of select="exsl:node-set($content)/*" />
	<xsl:text disable-output-escaping="yes">&lt;</xsl:text>![endif]--<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
</xsl:template>

</xsl:stylesheet>