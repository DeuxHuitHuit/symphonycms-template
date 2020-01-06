<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="data" select="/data" />
	<xsl:variable name="params" select="$data/params" />
	<xsl:variable name="config" select="$data/site-config/entry[1]" />
	<xsl:variable name="site-ref" select="$data/package/name" />
	<xsl:variable name="pages" select="$data/pages/page" />
	<xsl:variable name="root" select="$data/params/root" />
	<xsl:variable name="current-page-id" select="$data/params/current-page-id" />
	<xsl:variable name="current-page" select="$data/params/current-page" />
	<xsl:variable name="this-year" select="$params/this-year" />
	<xsl:variable name="today" select="$params/today" />

	<xsl:variable name="current-time" select="$params/current-time" />
	<xsl:variable name="website-name" select="$params/website-name" />
	<xsl:variable name="page-title" select="$params/page-title" />
	<xsl:variable name="current-url" select="$params/current-url" />
	<xsl:variable name="current-path" select="$params/current-path" />
	<xsl:variable name="workspace" select="$params/workspace" />

<!-- Dev env -->
<xsl:variable name="dev" select="contains($root, '.288dev.com') or contains($root, '.288dev.local')" />

<!-- Build Number -->
<xsl:variable name="build">
	<xsl:if test="
		/data/params/use-dev != 'yes' and
		string-length(/data/build/last) != 0">
		<xsl:value-of select="/data/build/last" />
	</xsl:if>
</xsl:variable>

<!-- Version Number -->
<xsl:variable name="version">
	<xsl:value-of select="/data/package/version" />
	<xsl:if test="string-length($build) != 0">
		<xsl:text>.</xsl:text>
		<xsl:value-of select="$build" />
	</xsl:if>
	<xsl:if test="$debug = true()">
		<xsl:text>-</xsl:text>
		<xsl:value-of select="$today" />
	</xsl:if>
</xsl:variable>

<!-- Debug flag -->
<xsl:variable name="debug" select="
	$dev = true() and
	count(/data/params/url-no-debug) = 0 and
	count(/data/params/url-nodebug) = 0 and
	count(/data/params/url-ndbg) = 0 and
	(count(/data/params/use-dev) = 0 or /data/params/use-dev = 'yes')" />

<!-- Response url : Used by the framework to track server redirection -->
<xsl:variable name="response-url">
	<xsl:value-of select="/data/params/current-path" />
	<xsl:if test="/data/params/current-path != '/'">
		<xsl:text>/</xsl:text>
	</xsl:if>
	<xsl:if test="string-length(/data/params/current-query-string) != 0">
		<xsl:text>?</xsl:text>
		<xsl:value-of select="/data/params/current-query-string" disable-output-escaping="yes" />
	</xsl:if>
</xsl:variable>

<!-- Lang flag -->
<xsl:variable name="is-multilingual" select="count(/data/fl-languages/supported-languages/item) &gt; 1" />

<!-- logged in info -->
<xsl:variable name="is-logged-in" select="/data/events/login-info/@logged-in = 'true'" />

<!-- Url language -->
<xsl:variable name="url-language">
	<xsl:choose>
		<xsl:when test="$is-multilingual and count(/data/fl-languages/current-language) = 1">
			<xsl:value-of select="/data/fl-languages/current-language/@handle" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="'en'" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

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
