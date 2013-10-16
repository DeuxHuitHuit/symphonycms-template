<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
	<!ENTITY nbsp "&#160;">
	<!ENTITY dot "&#8901;">
	<!ENTITY left "&#9668;">
	<!ENTITY right "&#9658;">
	<!ENTITY dquote "&#34;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- MASTER -->
<xsl:import href="variables.xsl" />
<xsl:import href="favicon.xsl" />
<xsl:import href="js.xsl" />
<xsl:import href="css.xsl" />

<!-- LIB -->
<xsl:import href="lib/create-page-url.xsl" />
<xsl:import href="lib/date-time.xsl" />
<xsl:import href="lib/fx-url-creator.xsl" />
<xsl:import href="lib/ga.xsl" />
<xsl:import href="lib/ie.xsl" />

<!-- COMPONENTS -->
<xsl:import href="com/page-title.xsl" />
<xsl:import href="com/page-meta.xsl" />
<xsl:import href="com/site-footer.xsl" />
<xsl:import href="com/site-header.xsl" />
<xsl:import href="com/menu-admin.xsl" />

<xsl:output method="html" 
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no" />

<xsl:template match="/">
<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html public "✰"<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
<html lang="{$url-language}">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE8" />
	<meta name="viewport" content="initial-scale=1" />
	
	<xsl:call-template name="page-title-header" />
	
	<xsl:call-template name="page-metas" />
	
	<xsl:call-template name="favicon" />
	
	<xsl:if test="$debug != true()">
		<xsl:call-template name="ga">
			<xsl:with-param name="ua" select="'UA-33016559-2'" />
			<xsl:with-param name="domain" select="''" />
		</xsl:call-template>
	</xsl:if>
</head>
<body class="{$url-language}">
	<div id="site">
		<xsl:call-template name="site-header" />
		
		<div id="site-pages">
			<div id="page-{$full-page-handle}" class="page">
				<xsl:apply-templates select="data" />
			</div>
		</div>
		
		<xsl:call-template name="site-footer" />
	</div>
	
	<xsl:call-template name="master-js">
		<xsl:with-praram name="extra-js">
			<!-- Register URL for the site-->
			<xsl:call-template name="framework-288-url-creator" /> 
		</xsl:with-praram>
	</xsl:call-template>
</body>
</html>
</xsl:template>

</xsl:stylesheet>