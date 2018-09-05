<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
	When you want 2 elements side by side, and one of them (aside) is sticky.

	Content
		aside: The sticky element. Max height of viewport by default
		main: Content that flows normally on the page.
 -->


<!-- COMPONENT: struct-aside-sticky -->
	<xsl:template name="struct-aside-sticky">
		<xsl:param name="content-aside" />
		<xsl:param name="content-main" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-aside" />
		<xsl:param name="ext-attr-main" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="relative flexbox" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="struct-aside-sticky" />
		</xsl:variable>

		<xsl:variable name="attr-aside">
			<add class="sticky top" />
			<add class="max-height-full-viewport" />
			<add class="overflow-y-auto overflow-scrolling-touch" />
			<xsl:copy-of select="$ext-attr-aside" />
			<add dev-element="aside" />
		</xsl:variable>

		<xsl:variable name="attr-main">
			<xsl:copy-of select="$ext-attr-main" />
			<add dev-element="main" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Aside -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-aside" />
					<xsl:with-param name="element" select="'aside'" />
					<xsl:with-param name="content" select="$content-aside" />
				</xsl:call-template>
				<!-- Main -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-main" />
					<xsl:with-param name="element" select="'main'" />
					<xsl:with-param name="content" select="$content-main" />
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
