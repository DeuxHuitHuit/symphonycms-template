<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	exclude-result-prefixes="str">

<!-- COMPONENT: util-form-rules -->
	<xsl:template name="util-form-rules">
		<xsl:if test="required = 'Yes'">
			<xsl:text>required</xsl:text>
		</xsl:if>
		<xsl:for-each select="validation/item">
			<xsl:text>,</xsl:text>
			<xsl:choose>
				<xsl:when test="./@handle = 'phone'">
					<xsl:text>phoneUs</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="str:replace(./@handle, '-', '_')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
