<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="ga.xsl" />
<xsl:import href="date-time.xsl" />
<xsl:import href="page-title.xsl" />
<xsl:import href="ie.xsl" />

<xsl:output method="html"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no" />

<xsl:variable name="debug" select="contains($root, '288dev.com')" />
<xsl:variable name="version">
	<xsl:text>0.1</xsl:text>
	<xsl:if test="$debug = true()">
		<xsl:text>-</xsl:text>
		<xsl:value-of select="$today" />
		<xsl:text>-</xsl:text>
		<xsl:value-of select="$current-time" />
	</xsl:if>
</xsl:variable>
<xsl:variable name="debug" select="contains($root, '288dev.com')" />
<xsl:variable name="is-loggued-in" select="/data/events/login-info/@logged-in = 'true'" />
<xsl:variable name="url-language" select="/data/events/flang-redirect/current-language/@handle"/>

<xsl:variable name="metas" select="/data/metas/entry[1]" />

<xsl:template name="admin-menu">
	<xsl:if test="/data/events/login-info/@logged-in = 'true'">
		<a id="top-admin" href="/symphony/">ADMIN</a>
		<a id="top-debug" href="?debug">debug</a>
		<a id="top-logout" href="/symphony/logout/">déconnection</a>
	</xsl:if>
</xsl:template>

<xsl:template match="/">
<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html public "✰"<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
<html lang="{$url-language}">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE8" />
	
	<xsl:call-template name="page-title-header" />
	
	<xsl:call-template name="page-metas" />
	
	<link rel="shortcut icon"     href="{$root}/favicon.ico" />
	<link rel="icon"              href="{$root}/favicon.ico" />
	<link rel="icon"              href="{$root}/favicon.png" type="images/png" />
	<link rel="apple-touch-icon"  href="{$root}/favicon.png" type="image/png" />
	<link rel="pavatar"           href="{$root}/favicon.png" type="image/png" />
	
	<xsl:choose>
		<xsl:when test="$debug = true()">
			<link rel="stylesheet/less" type="text/css" href="/workspace/assets/css/main.less?v={$version}" />
			<script>less = { env: 'development' }; </script>
			<script src="//cdnjs.cloudflare.com/ajax/libs/less.js/1.3.1/less.min.js"></script>
			<script>less.watch();</script>
		</xsl:when>
		<xsl:otherwise>
			<link rel="stylesheet" type="text/css" href="/workspace/assets/css/main.css?v={$version}" />
		</xsl:otherwise>
	</xsl:choose>
	
	
	<xsl:call-template name="extra-css" />

	<xsl:call-template name="ga">
		<xsl:with-param name="ua" select="''" />
	</xsl:call-template>
</head>

<body class="{$url-language} page-{$current-page}">
	<div id="site">
		<xsl:apply-templates select="data" />
	</div>

	<!-- scripts -->	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
	<script src="/workspace/assets/js/lib/jquery.sizing.min.js?v={$version}"></script>
	<script src="/workspace/assets/js/main.js?v={$version}"></script>
	
	<xsl:call-template name="extra-js" />
	
</body>
</html>
</xsl:template>

<xsl:template name="page-metas"></xsl:template>
<xsl:template name="extra-js"></xsl:template>
<xsl:template name="extra-css"></xsl:template>
</xsl:stylesheet>