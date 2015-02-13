<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../lib/nav-link.xsl" />

<xsl:template match="fl-languages/supported-languages/item" mode="revert-language" >
	<xsl:param name="full-name" select="''" />
	<xsl:param name="class" select="''" />
	<xsl:param name="text" select="''" />
	
	<a data-lg="{@handle}" class="js-alt-lg-link lang-alt-btn {$class}" data-action="full">
		<xsl:attribute name="href">
			<xsl:call-template name="page-alt-link-url">
				<xsl:with-param name="lg" select="@handle" />
			</xsl:call-template>
		</xsl:attribute>
		
		<xsl:choose>
			<xsl:when test="string-length($text) != 0">
				<xsl:value-of select="$text/item[@lang = current()/@handle]" />
			</xsl:when>
			<xsl:when test="string-length($full-name) != 0">
				<xsl:value-of select="." />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring(.,1,2)" />
			</xsl:otherwise>
		</xsl:choose>
	</a>
</xsl:template>

</xsl:stylesheet>