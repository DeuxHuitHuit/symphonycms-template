<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Debug flag -->
<xsl:variable name="debug" select="contains($root, '288dev.com')" />

<!-- Site reference code -->
<xsl:variable name="site-ref" select="'TODO: FILL IN'" />

<xsl:variable name="version">
	<xsl:text>0.1</xsl:text>
	<xsl:if test="$debug = true()">
		<xsl:text>-</xsl:text>
		<xsl:value-of select="$today" />
		<!--xsl:text>-</xsl:text>
		<xsl:value-of select="$current-time" /-->
	</xsl:if>
</xsl:variable>

<xsl:variable name="full-page-handle">
	<!-- xsl:apply-templates select="/data/plh-page//page [@id=$current-page-id]" mode="full-page-handle-creator" /-->
	<xsl:value-of select="/data/pages/page [@id = $current-page-id]/@handle" />
</xsl:variable>

<xsl:variable name="is-loggued-in" select="/data/events/login-info/@logged-in = 'true'" />

<!--xsl:variable name="url-language" select="/data/events/flang-redirect/current-language/@handle"/-->
<xsl:variable name="url-language" select="'fr'"/>

<xsl:variable name="metas" select="/data/site-config/entry[1]" />

<xsl:variable name="facebook-language">
	<xsl:if test="$url-language = 'fr'">
		<xsl:text>fr_CA</xsl:text>
	</xsl:if>
	<xsl:if test="$url-language = 'en'">
		<xsl:text>en_US</xsl:text>
	</xsl:if>
</xsl:variable>

</xsl:stylesheet>