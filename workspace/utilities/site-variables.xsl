<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt">

<xsl:variable name="data" select="/data" />
<xsl:variable name="params" select="$data/params" />
<xsl:variable name="config" select="$data/site-config/entry[1]" />
<xsl:variable name="pages" select="$data/pages//page" />


<!-- Default site name with current language -->
<xsl:variable name="site-name">
	<xsl:call-template name="default-site-name" />
</xsl:variable>

<xsl:variable name="site-title" select="$site-name" />
<xsl:variable name="site-description" select="$config/description" />
<xsl:variable name="site-image" select="$config/image" />
<xsl:variable name="page-metas" select="/data/page-metas/entry[1]" />

<!-- MISC UI ELEMENTS -->
<!--<xsl:variable name="ui" select="/data/interface/entry[1]" />-->

<!-- DATES -->
<xsl:variable name="date-format">
	<xsl:choose>
		<xsl:when test="$url-language = 'en'">M D, Y</xsl:when>
		<xsl:otherwise>d M Y</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<!-- DEFAULT SHARE PAGE TITLE -->
<xsl:variable name="default-share-page-title">
	<xsl:call-template name="master-title" />
</xsl:variable>

<!-- Google Analytics -->
<xsl:variable name="ga-ua" select="''" />
<!-- Google Tag Manager -->
<xsl:variable name="gtm-ctn" select="''" />

<!-- Twitter Card -->
<xsl:variable name="twitter-card-site" select="$config/twitter-url" />
<xsl:variable name="twitter-card-creator">
	<xsl:choose>
		<xsl:when test="starts-with($config/twitter-user, '@')">
			<xsl:value-of select="$config/twitter-user" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat('@', $config/twitter-user)" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="twitter-card-domain">
	<xsl:choose>
		<xsl:when test="string-length($config/twitter-site-domain) != 0">
			<xsl:value-of select="$config/twitter-site-domain" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/data/params/http-host" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<!-- Default langue if fl-languages not found -->
<xsl:variable name="default-langue" select="'fr'" />

<!-- Default Path -->
<xsl:variable name="css-path" select="'/workspace/assets/css/'" />
<xsl:variable name="js-path" select="'/workspace/assets/js/'" />

<!-- Handle de la page courrante -->
<xsl:variable name="full-page-handle">
	<xsl:call-template name="create-page-handle-by-id">
		<xsl:with-param name="id" select="$current-page-id" />
	</xsl:call-template>
	<xsl:if test="count(/data/params/page-types/item[substring-before(.,'-models-') = 'f288']) &gt; 0">
		<xsl:if test="string-length(/data/params/handle) != 0"><xsl:text>-detail</xsl:text></xsl:if>
	</xsl:if>
</xsl:variable>

<!-- Decimal format: french -->
<xsl:decimal-format name="french" decimal-separator="," grouping-separator=" " />
<!-- Decimal format: english -->
<xsl:decimal-format name="english" decimal-separator="." grouping-separator="," />

<!-- Site Page ID -->
<xsl:variable name="page-index-id" select="'1'" />

<!-- Site URLs -->
<xsl:variable name="page-index-url">
	<xsl:call-template name="create-page-url-by-id">
		<xsl:with-param name="id" select="$page-index-id" />
	</xsl:call-template>
</xsl:variable>

</xsl:stylesheet>
