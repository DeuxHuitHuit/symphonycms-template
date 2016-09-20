<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- CORE-ELEMENT: revert-language-link =========================================================-->
	<xsl:template name="revert-language-link">
		<xsl:param name="revert-lg-handle" select="@handle"/>
		<!-- button -->
		<xsl:param name="url" />
		<xsl:param name="failover-element" select="'button'"/>
		<!-- element -->
		<xsl:param name="is-optional" select="false()" />
		<!-- attr -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" select="$default-attr-mode" />
		<!-- content -->
		<xsl:param name="content-lg" select="$url-language" />
		<xsl:param name="content" />

	<!-- MINIMAL ATTRIBUTES 												 -->
		<xsl:variable name="js-alt-lg-link-attr">
			<add data-lg="{$revert-lg-handle}" />
			<add data-action="full" />
			<add class="js-alt-lg-link" />
		</xsl:variable>
	<!--																	/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$js-alt-lg-link-attr" />
			<xsl:copy-of select="$attr" />
			<add dev-core="revert-language-link" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<xsl:call-template name="button">
			<xsl:with-param name="url" select="$url" />
			<xsl:with-param name="failover-element"	select="$failover-element" />
			<xsl:with-param name="is-optional" select="$is-optional" />
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="attr-mode" select="$attr-mode" />
			<xsl:with-param name="lg" select="$content-lg" />
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>