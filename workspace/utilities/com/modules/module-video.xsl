<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: module-video -->
	<xsl:template name="module-video" match="item[@section='module-video']" mode="module">
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="module-video" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<add class="relative overflow-hidden" />
			<add dev-extended-by="module-video" />
		</xsl:variable>

		<xsl:variable name="attr-video">
			<add dev-element="video" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="module">
			<xsl:with-param name="ext-attr" select="$attr" />
			<xsl:with-param name="ext-attr-ctn" select="$attr-ctn" />
			<xsl:with-param name="transition-name" select="'transition-module-video'" />
			<xsl:with-param name="content">
				<xsl:call-template name="com-video">
					<xsl:with-param name="ext-attr" select="$attr-video" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
