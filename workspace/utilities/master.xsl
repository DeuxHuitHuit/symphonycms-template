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
	 
<xsl:variable name="is-loggued-in" select="/data/events/login-info/@logged-in = 'true'" />
<xsl:variable name="url-language" select="'fr'"/>
<xsl:variable name="metas" select="/data/metas/entry[1]" />

<xsl:template match="/">
<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html public "✰"<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
<html lang="{$url-language}">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE8" />
	
	<xsl:call-template name="page-title-header" />
	
	<xsl:call-template name="page-metas" />
	
	<link rel="shortcut icon" href="{$root}/favicon.ico" />
	<link rel="icon" href="{$root}/favicon.ico" />
	<link rel="icon" type="images/png" href="{$root}/favicon.png" />
	<link rel="apple-touch-icon" href="{$root}/favicon.png" type="image/png" />
	<link rel="pavatar" href="{$root}/favicon.png" type="image/png" />
	  
	<link rel="stylesheet/less" type="text/css" href="/workspace/assets/css/main.less" />
	<script>less = { env: 'development' }; </script>
	<script src="/workspace/assets/js/lib/less-1.3.0.min.js"></script>
	<!--script>//less.watch();</script-->
	<xsl:call-template name="extra-css" />

	<xsl:call-template name="ga">
		<xsl:with-param name="ua" select="''" />
	</xsl:call-template>
</head>

<body class="{$url-language} page-{$current-page}">
	<div id="site">
		
	</div>

	<!-- scripts -->	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="/workspace/assets/js/lib/jquery.easing.1.3.js"></script>
	<script src="/workspace/assets/js/lib/jquery.sizing.min.js"></script>
	<script src="/workspace/assets/js/main.js"></script>
	
	<xsl:call-template name="extra-js" />
	
</body>
</html>
</xsl:template>

<xsl:template name="page-metas"></xsl:template>
<xsl:template name="extra-js"></xsl:template>
<xsl:template name="extra-css"></xsl:template>
</xsl:stylesheet>