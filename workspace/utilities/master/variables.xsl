<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Site reference code -->
<xsl:variable name="site-ref" select="/data/package/name" />

<!-- Numero de version -->
<xsl:variable name="version">
	<xsl:value-of select="/data/package/version" />
	<xsl:if test="$debug = true()">
		<xsl:text>-</xsl:text>
		<xsl:value-of select="$today" />
	</xsl:if>
</xsl:variable>

<!-- Debug flag -->
<xsl:variable name="debug" select="
	contains($root, '.288dev.com') and
	count(/data/params/url-no-debug) = 0 and
	count(/data/params/url-nodebug) = 0 and
	count(/data/params/url-ndbg) = 0 and
	/data/params/use-build != 'yes'" />

<!-- Lang flag For multi langue -->
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

<!-- Handle de la page courrante -->
<xsl:variable name="full-page-handle">
	<xsl:call-template name="create-page-handle-by-id">
		<xsl:with-param name="id" select="$current-page-id" />
	</xsl:call-template>
</xsl:variable>

<!-- loggued in info -->
<xsl:variable name="is-loggued-in" select="/data/events/login-info/@logged-in = 'true'" />

<!-- Url language -->
<xsl:variable name="url-language" >
	<xsl:choose>
		<xsl:when test="$multi-langues = 'yes' and count(/data/fl-languages/current-language) = 1">
			<xsl:value-of select="/data/fl-languages/current-language/@handle" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$default-langue" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<!-- Metas/config variable -->
<xsl:variable name="config" select="/data/site-config/entry[1]" />

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
