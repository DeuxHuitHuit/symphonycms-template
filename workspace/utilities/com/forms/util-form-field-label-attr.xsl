<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- FIELD: list item -->
	<xsl:template match="item[@section = 'form-field-option-list']/options/item" mode="util-form-field-label-attr" priority="5">
		<xsl:call-template name="util-form-field-checkbox-radio-label-attr" />
		<add dev-label-attr="list" />
	</xsl:template>

<!-- FIELD: radio & checkbox -->
	<xsl:template name="util-form-field-checkbox-radio-label-attr" match="item[@section = 'form-field-radio'] | item[@section = 'form-field-checkbox']" mode="util-form-field-label-attr" priority="4">
		<xsl:copy-of select="$recipe-font-text" />
		<add class="margin-left-thinnest" />
		<add class="cursor-pointer" />
		<add dev-label-attr="checkbox-or-radio" />
	</xsl:template>

<!-- DEFAULT -->
	<xsl:template match="item" mode="util-form-field-label-attr" priority="1">
		<xsl:copy-of select="$recipe-font-intertitle" />
		<add class="font-weight-bold" />
		<add class="block margin-bottom-thinnest" />
		<add dev-label-attr="default" />
	</xsl:template>


<!-- NONE (custom modules)-->
	<xsl:template match="*" mode="util-form-field-label-attr" priority="0">
		<add dev-label-attr="none" />
	</xsl:template>

</xsl:stylesheet>
