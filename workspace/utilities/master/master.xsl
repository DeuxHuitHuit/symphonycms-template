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

<!-- IMPORT VARIABLES -->
	<!-- Variables -->
	<xsl:import href="variables.xsl" />
	<xsl:import href="../site-variables.xsl" />

<!-- IMPORT LIB -->
	<!-- LIB CORE ATTRIBUTES SYSTEM -->
	<xsl:import href="../lib/attr.xsl" />

	<!-- LIB CORE URL CREATOR -->
	<xsl:import href="../lib/create-page-url.xsl" />
	<xsl:import href="../lib/fx-url-creator.xsl" />

	<!-- LIB SPECIAL KIND (GOOGLE ANALYTICS) -->
	<xsl:import href="../lib/ga.xsl" />

	<!-- LIB TRANSFORMATION TOOLS -->
	<xsl:import href="../lib/ninja.xsl" />
	<xsl:import href="../lib/content.xsl" />
	<xsl:import href="../lib/append-qs-value.xsl" />

	<!-- LIB CORE UI-->
	<xsl:import href="../lib/element.xsl" />
	<xsl:import href="../lib/render-image.xsl" />

	<!-- LIB CORE UI WITH LOGIQUE -->
	<xsl:import href="../lib/button.xsl" />
	<xsl:import href="../lib/button-tel.xsl" />
	<xsl:import href="../lib/nav-link.xsl" />
	<xsl:import href="../lib/heading.xsl" />
	<xsl:import href="../lib/text.xsl" />
	
	<!-- LIB SVG -->
	<xsl:import href="../lib/svg-icons.xsl" />
	<xsl:import href="../lib/svg-socials-icons.xsl" />

	<!-- LIB PACKAGED COMPOSITION -->
	<xsl:import href="../lib/menu-admin.xsl" />
	<xsl:import href="../lib/iframe-copyright-288.xsl" />

	<!-- LIB HTML-HEAD -->
	<xsl:import href="../lib/page-title.xsl" />
	<xsl:import href="../lib/prefetch.xsl" />

<!-- IMPORT SUB TEMPLATES -->
	<xsl:import href="master-head.xsl" />
	<xsl:import href="master-body.xsl" />
	<xsl:import href="js.xsl" />

	<!-- IE TEMPLATES -->
	<!--xsl:import href="../lib/ie.xsl" /-->

<!-- XSLT CONFIG 															/-->
	<xsl:output method="html" 
		omit-xml-declaration="yes"
		encoding="UTF-8"
		indent="no" />

<!-- CORE : MASTER MATCH ========================================================================-->
	<xsl:template match="/">

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr" >
			<add lang="{$url-language}" />
			<xsl:call-template name="html-attr" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<!-- Doctype HTML -->
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>
		<xsl:text>!doctype html</xsl:text>
		<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		
		<!-- html element -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'html'" />
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content">

				<!-- html head -->
				<xsl:call-template name="master-head" />

				<!-- html body -->
				<xsl:call-template name="master-body" />

				<!-- Comment for debug -->
				<xsl:comment>
					<xsl:value-of select="concat(' cache-stamp: ', $today, 'T', $current-time, ' ')" />
				</xsl:comment>

			</xsl:with-param> <!-- End html element content-->
		</xsl:call-template>
	</xsl:template>

<!-- HTML ATTRIBUTES CUSTOM BY PAGE =========================================-->
	<xsl:template name="html-attr">
	</xsl:template>

</xsl:stylesheet>
