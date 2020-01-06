<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- FIELD: list item (multiselect) -->
	<xsl:template match="item[@section = 'form-field-option-list' and multiselect = 'Yes']/options/item" mode="util-form-field-input-attr" priority="5">
		<xsl:call-template name="util-form-field-checkbox-input-attr" />
		<add dev-input-attr="list-multiselect" />
	</xsl:template>
<!-- FIELD: list item -->
	<xsl:template match="item[@section = 'form-field-option-list' and multiselect != 'Yes']/options/item" mode="util-form-field-input-attr" priority="5">
		<xsl:call-template name="util-form-field-radio-input-attr" />
		<add dev-input-attr="list" />
	</xsl:template>

<!-- FIELD: radio -->
	<xsl:template name="util-form-field-radio-input-attr" match="item[@section = 'form-field-radio']" mode="util-form-field-input-attr" priority="4">
		<xsl:copy-of select="$recipe-font-text" />
		<add class="appearance-none" />
		<add class="border-solid border-slimmest" />
		<add class="border-color-main-stroke" />
		<add class="border-radius-full" />
		<add class="square-3_4em" />
		<add dev-input-attr="radio" />
	</xsl:template>

<!-- FIELD: checkbox -->
	<xsl:template name="util-form-field-checkbox-input-attr" match="item[@section = 'form-field-checkbox']" mode="util-form-field-input-attr" priority="4">
		<xsl:copy-of select="$recipe-font-text" />
		<add class="appearance-none square-1em" />
		<add class="border-solid border-slimmest" />
		<add class="border-color-main-stroke" />
		<add class="square-3_4em" />
		<add dev-input-attr="checkbox" />
	</xsl:template>

<!-- DEFAULT -->
	<xsl:template match="item" mode="util-form-field-input-attr" priority="1">
		<xsl:copy-of select="$recipe-font-text" />
		<add class="width-full padding-thinner border-box" />
		<add class="border-solid border-slimmest" />
		<add class="border-color-main-stroke" />
		<add dev-input-attr="default" />
	</xsl:template>


<!-- NONE (custom modules)-->
	<xsl:template match="*" mode="util-form-field-input-attr" priority="0">
		<add dev-input-attr="none" />
	</xsl:template>

</xsl:stylesheet>
