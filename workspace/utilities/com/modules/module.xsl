<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="module">
		<xsl:param name="content" />
		<xsl:param name="transition-name" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-ctn" />


		<!-- STYLES -->
		<xsl:variable name="attr">
			<!-- Security -->
			<add class="width-full border-box" />
			<add class="padding-horizontal-security" />
			<!-- Interval -->
			<xsl:apply-templates select="." mode="util-module-interval-attr" />
			<!-- Transition -->
			<xsl:call-template name="util-transition-scroll-attr">
				<xsl:with-param name="name" select="$transition-name" />
			</xsl:call-template>
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="module" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<!-- Alignment -->
			<add class="margin-horizontal-auto" />
			<!-- Width -->
			<xsl:apply-templates select="." mode="util-module-width-attr" />
			<xsl:copy-of select="$ext-attr-ctn" />
			<add dev-element="ctn" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'section'" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-ctn" />
					<xsl:with-param name="content" select="$content" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>
</xsl:stylesheet>
