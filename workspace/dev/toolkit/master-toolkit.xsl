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
<xsl:import href="../../utilities/master/variables.xsl" />
<xsl:import href="../../utilities/site-variables.xsl" />

<xsl:import href="../../utilities/master/favicon.xsl" />
<xsl:import href="../../utilities/master/css.xsl" />
<xsl:import href="../../utilities/master/js-templates.xsl" />

<!-- LIB -->
<xsl:import href="../../utilities/lib/element.xsl" />
<xsl:import href="../../utilities/lib/attr.xsl" />
<xsl:import href="../../utilities/lib/page-title.xsl" />
<xsl:import href="../../utilities/lib/master-title.xsl" />
<xsl:import href="../../utilities/lib/create-page-url.xsl" />
<xsl:import href="../../../extensions/datetime/utilities/datetime.xsl" />

<xsl:import href="../../utilities/lib/fx-url-creator.xsl" />
<xsl:import href="../../utilities/lib/ga.xsl" />
<xsl:import href="../../utilities/lib/ninja.xsl" />
<xsl:import href="../../utilities/lib/ie.xsl" />
<xsl:import href="../../utilities/lib/svg-icons.xsl" />
<xsl:import href="../../utilities/lib/svg-socials-icons.xsl" />
<xsl:import href="../../utilities/lib/iframe-copyright-288.xsl" />
<xsl:import href="../../utilities/lib/render-image.xsl" />
<xsl:import href="../../utilities/lib/button.xsl" />
<xsl:import href="../../utilities/lib/content.xsl" />
<xsl:import href="../../utilities/lib/heading.xsl" />
<xsl:import href="../../utilities/lib/text.xsl" />
<xsl:import href="../../utilities/lib/append-qs-value.xsl" />

<xsl:import href="../../utilities/recipes/recipes.xsl" />

<xsl:output method="html" 
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no" />

<xsl:template match="/">

	<!-- Doctype -->
	<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
	
	<!-- Html -->
	<html lang="{$url-language}">

		<!-- html head -->
		<head>
	
			<!-- General metas -->
			<meta charset="utf-8" />
			<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE9" />
			<meta name="viewport" content="initial-scale=1" />
			
			<!-- Master title (title and meta title) -->
			<xsl:call-template name="master-title-header" />
			
			<!-- Favicon -->
			<xsl:call-template name="favicon" />
			
			<!-- Master css -->
			<xsl:call-template name="master-css">
				<xsl:with-param name="less-file" select="'toolkit'" />
			</xsl:call-template>
			
		</head>

		<!-- html body -->
		<body class="bg-color-lightest-grey">
			
			<xsl:apply-templates select="data" />
			
		</body>

		<!-- js -->
		<xsl:apply-templates select="/data/javascript/cdn-before/file" mode="cdn" />
		<!-- Local libs -->
		<xsl:apply-templates select="/data/javascript/libs/file" mode="local" />
		<!-- FX -->
		<script src="{$js-path}core/framework.{$version}.js"></script>
		<script>
			<xsl:text>(function(){</xsl:text>
				<xsl:text>App.debug(true);</xsl:text>
			<xsl:text>})();</xsl:text>
		</script>
		

		<!-- Local sources -->
		<xsl:apply-templates select="/data/javascript/sources/file" mode="local" />
		<xsl:apply-templates select="/data/javascript/dev/file" mode="local" />
	</html>

	<!-- Comment for debug -->
	<xsl:comment>
		<xsl:value-of select="concat(' cache-stamp: ', $today, 'T', $current-time, ' ')" />
	</xsl:comment>
	
</xsl:template>

</xsl:stylesheet>