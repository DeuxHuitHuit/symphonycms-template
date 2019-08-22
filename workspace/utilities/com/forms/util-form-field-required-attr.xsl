<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- DEFAULT -->
	<xsl:template match="item" mode="util-form-field-required-attr" priority="1">
		<xsl:copy-of select="$recipe-font-caption" />
		<add class="absolute color-accent right" />
		<add dev-required-attr="default" />
	</xsl:template>


<!-- NONE (custom modules)-->
	<xsl:template match="*" mode="util-form-field-required-attr" priority="0">
		<add dev-required-attr="none" />
	</xsl:template>

</xsl:stylesheet>
