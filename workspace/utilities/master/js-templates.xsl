<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="javascript/*/file" mode="local">
		<script src="{$js-path}{.}"></script>
	</xsl:template>

	<xsl:template match="javascript/*/file" mode="cdn">
		<script src="{.}"></script>
	</xsl:template>

	<xsl:template match="javascript/*/file" mode="cdn-async">
		<script src="{.}" async="" defer=""></script>
	</xsl:template>
</xsl:stylesheet>
