<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	xmlns:date="http://exslt.org/dates-and-times"
	exclude-result-prefixes="exslt date">

	<xsl:variable name="pages" select="$data/pages//page" />
	<xsl:variable name="gtm-id" select="$config/gtm-id" />
	<xsl:variable name="facebook-app-id" select="$config/facebook-app-id" />
	<xsl:variable name="twitter-domain" select="$config/twitter-domain" />
	<xsl:variable name="organization" select="$data/organization/entry[1]" />
	<xsl:variable name="append-site-title" select="true()" />
	<xsl:variable name="append-site-title-char" select="' - '" />

	<xsl:variable name="menus" select="$data/menus/entry[1]" />
	<xsl:variable name="ui" select="$data/interface/entry[1]" />
	<xsl:variable name="form-config" select="$data/form-config/entry[1]" />

	<!-- Utils -->
	<!-- <xsl:variable name="non-normalized" select="' ABCDEFGHIJKLMNOPQRSTUVWXYZÁÀÂÄÉÈÊËÍÌÎÏÓÒÔÖÚÙÛÜÇáàâäéèêëíìîïóòôöúùûüç&amp;?.'" /> -->
	<!-- <xsl:variable name="normalized" select="'-abcdefghijklmnopqrstuvwxyzaaaaeeeeiiiioooouuuucaaaaeeeeiiiioooouuuuc'" /> -->
	<!-- <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ'" /> -->
	<!-- <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ'" /> -->
	<!-- <xsl:variable name="now" select="date:seconds(concat($params/today, 'T', $params/current-time, ':00', $params/timezone))" /> -->
	<!-- <xsl:decimal-format name="french" decimal-separator="," grouping-separator=" " /> -->
	<!-- <xsl:decimal-format name="english" decimal-separator="." grouping-separator="," /> -->

	<!-- Date formats -->
	<xsl:variable name="date-format">
		<xsl:choose>
			<xsl:when test="$url-language = 'en'">M D, Y</xsl:when>
			<xsl:otherwise>d M Y</xsl:otherwise>
		</xsl:choose>
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

	<!-- Assets Path -->
	<xsl:variable name="css-path" select="'/workspace/assets/css/'" />
	<xsl:variable name="js-path" select="'/workspace/assets/js/'" />
	<xsl:variable name="img-path" select="'/workspace/assets/img/'" />

	<!-- Current Page Handle -->
	<xsl:variable name="full-page-handle">
		<xsl:call-template name="create-page-handle-by-id">
			<xsl:with-param name="id" select="$current-page-id" />
		</xsl:call-template>
		<xsl:if test="count(/data/params/page-types/item[substring-before(.,'-models-') = 'f288']) &gt; 0">
			<xsl:if test="string-length(/data/params/handle) != 0"><xsl:text>-detail</xsl:text></xsl:if>
		</xsl:if>
	</xsl:variable>

	<!-- Site URLs -->
	<xsl:variable name="page-index-id" select="'1'" />
	<xsl:variable name="page-index-url">
		<xsl:call-template name="create-page-url-by-id">
			<xsl:with-param name="id" select="$page-index-id" />
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="page-ajax-form-id" select="'4'" />
	<xsl:variable name="page-ajax-form-url">
		<xsl:call-template name="create-page-url-by-id">
			<xsl:with-param name="id" select="$page-ajax-form-id" />
		</xsl:call-template>
	</xsl:variable>

</xsl:stylesheet>
