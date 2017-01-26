<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="master-css">
		<xsl:param name="less-file" select="'browser'" />
		
		<xsl:choose>
			<xsl:when test="$debug = true()">
				<link rel="stylesheet/less" type="text/css" href="{$css-path}dev/{$less-file}.{$version}.less" />
				<script>less = { env: 'development', useFileCache: false }; </script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/less.js/2.7.2/less.min.js"></script>
				<xsl:if test="count(/data/params/url-watch) != 0">
					<script>less.watchTimer = 3; less.watch();</script>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<link rel="stylesheet" type="text/css" href="{$css-path}{$site-ref}.min.{$version}.css" integrity="{/data/sri/file[@filename=concat($site-ref, '.min.css')]/@integrity}" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
