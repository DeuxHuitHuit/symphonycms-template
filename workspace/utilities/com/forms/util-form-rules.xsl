<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	exclude-result-prefixes="str">

<!-- COMPONENT: util-form-rules -->
	<xsl:template name="util-form-rules">
		<xsl:if test="required = 'Yes'">
			<xsl:text>required</xsl:text>
			<xsl:if test="count(validation/item) != 0">,</xsl:if>
		</xsl:if>
		<xsl:for-each select="validation/item">
			<xsl:choose>
				<xsl:when test="./@handle = 'phoneus' or ./@handle = 'phone' or ./@handle = 'tel'">
					<xsl:text>phoneUs</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="str:replace(./@handle, '-', '_')" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
