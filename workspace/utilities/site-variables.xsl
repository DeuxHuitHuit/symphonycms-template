<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt">

<!-- data -->
<xsl:variable name="data" select="/data" />

<!-- Default site name with current language -->
<xsl:variable name="site-name">
	<xsl:call-template name="default-site-name" />
</xsl:variable>

<!-- site metas -->
<xsl:variable name="site-title" select="$site-name" />
<xsl:variable name="site-description" select="$config/site-description" />
<xsl:variable name="site-image" select="$config/site-image" />

<!-- page metas -->
<xsl:variable name="page-title" select="/data/plh-page/page/item[@lang = $current-language]" />
<xsl:variable name="page-description" select="$site-description"/>
<xsl:variable name="page-image" select="$site-image" />

<!-- html metas -->
<xsl:variable name="meta-title">
	<xsl:call-template name="meta-title" />
</xsl:variable>
<xsl:variable name="meta-description">
	<xsl:call-template name="meta-description" />
</xsl:variable>
<xsl:variable name="util-meta-image">
	<xsl:call-template name="meta-image" />
</xsl:variable>
<xsl:variable name="meta-image" select="exslt:node-set($util-meta-image)/*" />
<xsl:variable name="append-site-title" select="count(/data/params/page-types/item[@handle = 'index']) != 1" />

<!-- twitter metas-->
<xsl:variable name="twitter-card-site" select="$config/twitter-url" />
<xsl:variable name="twitter-card-creator" select="$config/twitter-user" />
<xsl:variable name="twitter-card-domain" select="$config/twitter-site-domain" />
<xsl:variable name="twitter-title" select="$meta-title" />
<xsl:variable name="twitter-image" select="$meta-image" />
<xsl:variable name="twitter-description" select="$meta-description" />

<!-- facebook metas -->
<xsl:variable name="facebook-app-id" select="$config/facebook-page-id" />
<xsl:variable name="og-title" select="$meta-title" />
<xsl:variable name="og-image" select="$meta-image" />
<xsl:variable name="og-description" select="$meta-description" />
<xsl:variable name="og-type" select="'website'" />
<xsl:variable name="og-url" select="concat($current-url, '/')" />

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
