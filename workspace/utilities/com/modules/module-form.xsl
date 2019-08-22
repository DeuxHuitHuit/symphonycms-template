<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: module-form -->
	<xsl:template name="module-form" match="item[@section = 'module-form']" mode="module">
		<xsl:param name="form" select="form/item[1]" />
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="module-form" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<add dev-extended-by="module-form" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="module">
			<xsl:with-param name="ext-attr" select="$attr" />
			<xsl:with-param name="ext-attr-ctn" select="$attr-ctn" />
			<xsl:with-param name="transition-name" select="'transition-module-form'" />
			<xsl:with-param name="content">
				<xsl:apply-templates select="$form" mode="form-dyn" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
