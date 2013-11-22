<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Numero de version -->
<xsl:variable name="version">
	<xsl:text>0.1</xsl:text>
	<xsl:if test="$debug = true()">
		<xsl:text>-</xsl:text>
		<xsl:value-of select="$today" />
		<!--xsl:text>-</xsl:text>
		<xsl:value-of select="$current-time" /-->
	</xsl:if>
</xsl:variable>

<!-- Debug flag -->
<xsl:variable name="debug" select="contains($root, '288dev.com')" />

<!-- Lang flag -->
<xsl:variable name="multi-langues" >
	<xsl:choose>
		<xsl:when test="count(/data/fl-languages/supported-languages/item) &gt; 1">
			<xsl:text>yes</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>no</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<!-- Site reference code -->
<xsl:variable name="site-ref" select="'TODO: FILL IN'" />

<!-- Handle de la page courrante -->
<xsl:variable name="full-page-handle">
	<xsl:choose>
		<xsl:when test="$multi-langues = 'yes'">
			<xsl:apply-templates select="/data/plh-page//page [@id=$current-page-id]" mode="full-page-handle-creator" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/data/pages/page [@id = $current-page-id]/@handle" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<!-- loggued in info -->
<xsl:variable name="is-loggued-in" select="/data/events/login-info/@logged-in = 'true'" />

<!-- Url language -->
<xsl:variable name="url-language" >
	<xsl:choose>
		<xsl:when test="$multi-langues = 'yes'">
			<xsl:value-of select="/data/events/flang-redirect/current-language/@handle" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="'fr'" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<!-- Metas variable -->
<xsl:variable name="metas" select="/data/site-config/entry[1]" />

<!-- Facebook Language based on url-language -->
<xsl:variable name="facebook-language">
	<xsl:choose>
		<xsl:when test="$url-language = 'fr'">
			<xsl:text>fr_CA</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>en_US</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<!-- Facebook script -->
<xsl:variable name="facebook-script">
	<xsl:choose>
		<xsl:when test="$debug = true()">all/debug</xsl:when>
		<xsl:otherwise>all</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

</xsl:stylesheet>