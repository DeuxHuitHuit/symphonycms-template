<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- DEFAULT STYLE 																				 -->
	<xsl:variable name="form-control-icon-required-default-style">
		<add class="valign-middle bold" />
	</xsl:variable>
<!-- END DEFAULT STYLE 																			/-->

<!-- CORE ELEMENT : form-control-icon-required ==================================================-->
	<xsl:template name="form-control-icon-required">
		<xsl:param name="element" select="'span'" />
		<xsl:param name="attr"/>

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$form-control-icon-required-default-style" />
			<xsl:copy-of select="$attr" />

			<add dev-core-element="icon-required"/>
		</xsl:variable>
	<!-- 																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$element"/>
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content" select="'•'" />
		</xsl:call-template>
	<!-- 																	/-->
	</xsl:template>
</xsl:stylesheet>
