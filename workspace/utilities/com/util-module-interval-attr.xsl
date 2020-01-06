<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- FIRST -->
	<xsl:template match="item[position() = 1]" mode="util-module-interval-attr" priority="10">
		<add dev-interval="first" />
	</xsl:template>

<!-- DEFAULT -->
	<xsl:template match="item" mode="util-module-interval-attr" priority="1">
		<xsl:copy-of select="$recipe-interval-module" />
		<add dev-interval="default" />
	</xsl:template>


<!-- NONE (custom modules)-->
	<xsl:template match="*" mode="util-module-interval-attr" priority="0">
		<add dev-interval="none" />
	</xsl:template>

</xsl:stylesheet>
