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
<xsl:import href="../site-variables.xsl" />
<xsl:import href="master-head.xsl" />
<xsl:import href="master-body.xsl" />

<!-- LIB -->
<xsl:import href="../lib/create-page-url.xsl" />
<xsl:import href="../lib/date-time.xsl" />
<xsl:import href="../lib/fx-url-creator.xsl" />
<xsl:import href="../lib/ga.xsl" />
<xsl:import href="../lib/ninja.xsl" />
<xsl:import href="../lib/ie.xsl" />
<xsl:import href="../lib/nav-link.xsl" />
<xsl:import href="../lib/svg-icons.xsl" />
<xsl:import href="../lib/svg-socials-icons.xsl" />
<xsl:import href="../lib/pages-erreurs.xsl" />
<xsl:import href="../lib/iframe-copyright-288.xsl" />

<xsl:import href="../lib/prefetch.xsl" />

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
		<xsl:call-template name="master-head" />

		<!-- html body -->
		<xsl:call-template name="master-body" />
		
	</html>

	<!-- Comment for debug -->
	<xsl:comment>
		<xsl:value-of select="concat(' cache-stamp: ', $today, 'T', $current-time, ' ')" />
	</xsl:comment>
	
</xsl:template>

</xsl:stylesheet>