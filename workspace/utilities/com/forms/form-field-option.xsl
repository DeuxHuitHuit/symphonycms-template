<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-option -->
	<xsl:template name="form-field-option" match="item[@section = 'form-option']" mode="form-field">
		<xsl:param name="label" select="label" />
		<xsl:param name="value" select="value" />
		<xsl:param name="is-disabled" select="disabled = 'Yes'" />
		<xsl:param name="is-selected" select="selected = 'Yes'" />
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add value="{$value}" />
			<!-- OPTION: is disabled -->
			<xsl:if test="$is-disabled">
				<add disabled="disabled" />
			</xsl:if>
			<!-- OPTION: is selected -->
			<xsl:if test="$is-selected">
				<add selected="selected" />
			</xsl:if>
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-option" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'option'" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content" select="$label" />
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
