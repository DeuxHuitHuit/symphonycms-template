<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- FIRST -->
	<xsl:template match="item[position() = 1]" mode="util-form-field-interval-attr" priority="10">
		<add dev-interval="first" />
	</xsl:template>

<!-- FIELD: first line -->
	<xsl:template match="item[half-width = 'Yes' and position() &lt;= 2]" mode="util-form-field-interval-attr" priority="5">
		<add dev-interval="first line" />
	</xsl:template>

<!-- FIELD: list-item -->
	<xsl:template match="item[@section = 'form-field-option-list']/options/item" mode="util-form-field-interval-attr" priority="5">
		<add dev-interval="list-item" />
	</xsl:template>

<!-- DEFAULT -->
	<xsl:template match="item" mode="util-form-field-interval-attr" priority="1">
		<xsl:copy-of select="$recipe-interval-form-field" />
		<add dev-interval="default" />
	</xsl:template>


<!-- NONE (custom modules)-->
	<xsl:template match="*" mode="util-form-field-interval-attr" priority="0">
		<add dev-interval="none" />
	</xsl:template>

</xsl:stylesheet>
