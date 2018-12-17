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
<xsl:variable name="default-share-page-title" >
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
<xsl:variable name="twitter-card-domain" select="$config/twitter-site-domain" />

<!-- Default langue if fl-languages not found -->
<xsl:variable name="default-langue" select="'fr'" />

<!-- Default Path -->
<xsl:variable name="css-path" select="'/workspace/assets/css/'" />
<xsl:variable name="js-path" select="'/workspace/assets/js/'" />

<!-- Site Page ID -->
<xsl:variable name="page-index-id" select="'1'" />

<!-- Site URLs -->
<xsl:variable name="page-index-url">
	<xsl:call-template name="create-page-url-by-id">
		<xsl:with-param name="id" select="$page-index-id" />
	</xsl:call-template>
</xsl:variable>

</xsl:stylesheet>
