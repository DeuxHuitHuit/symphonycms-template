<?xml version="1.0" encoding="UTF-8"?>
<!-- See: http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references -->
<!DOCTYPE stylesheet [
	<!ENTITY nbsp "&#160;">
	<!ENTITY dot "&#8901;">
	<!ENTITY left "&#9668;">
	<!ENTITY right "&#9658;">
	<!ENTITY dquote "&#34;">
	<!ENTITY copy "&#169;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- MASTER -->
<xsl:import href="variables.xsl" />
<xsl:import href="favicon.xsl" />
<xsl:import href="js.xsl" />
<xsl:import href="css.xsl" />

<!-- LIB -->
<xsl:import href="../lib/create-page-url.xsl" />
<xsl:import href="../lib/date-time.xsl" />
<xsl:import href="../lib/fx-url-creator.xsl" />
<xsl:import href="../lib/ga.xsl" />
<xsl:import href="../lib/ninja.xsl" />
<xsl:import href="../lib/ie.xsl" />

<!-- COMPONENTS -->
<xsl:import href="../com/page-title.xsl" />
<xsl:import href="../com/site-meta.xsl" />
<xsl:import href="../com/site-meta-alt-link.xsl" />
<xsl:import href="../com/site-footer.xsl" />
<xsl:import href="../com/site-header.xsl" />
<xsl:import href="../com/menu-admin.xsl" />

<!-- Extensions -->
<xsl:import href="../../../extensions/block_user_agent/utilities/block_user_agent.xsl" />

<xsl:output method="html" 
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no" />

<xsl:template match="/">
<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html public "✰"<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
<html lang="{$url-language}">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE9" />
	<meta name="viewport" content="initial-scale=1" />
	
	<xsl:call-template name="page-title-header" />
	
	<xsl:call-template name="page-metas" />
	<xsl:call-template name="page-metas-alt-link" />
	<xsl:call-template name="canonical-url" />
	
	<xsl:call-template name="favicon" />
	
	<xsl:call-template name="master-css" />
	
	<xsl:if test="$debug != true()">
		<xsl:call-template name="ga">
			<xsl:with-param name="ua" select="''" />
			<xsl:with-param name="domain" select="''" />
		</xsl:call-template>
	</xsl:if>
</head>
<body class="{$url-language} page-{$full-page-handle}" data-version="{$version}">
	<xsl:call-template name="block-user-agent">
		<xsl:with-param name="title" select="$metas/navigateurs-non-supportes-titre" />
		<xsl:with-param name="subtitle" select="$metas/navigateurs-non-supportes-texte" />
		<xsl:with-param name="close" select="$metas/navigateurs-non-supportes-poursuivre" />
	</xsl:call-template>
	<div id="site">
		<xsl:call-template name="site-header" />
		
		<div id="site-pages">
			<div id="page-{$full-page-handle}" class="page">
				<xsl:apply-templates select="data" />
			</div>
		</div>
		
		<xsl:call-template name="site-footer" />
	</div>
	
	<div id="load-progress"></div>
	
	<xsl:call-template name="master-js">
		<xsl:with-param name="extra-js">
			<!-- Register URL for the site-->
			<xsl:call-template name="framework-288-url-creator" /> 
		</xsl:with-param>
	</xsl:call-template>
</body>
</html>
<xsl:comment>
	<xsl:value-of select="concat(' cache-stamp: ', $today, 'T', $current-time, ' ')" />
</xsl:comment>
</xsl:template>

</xsl:stylesheet>