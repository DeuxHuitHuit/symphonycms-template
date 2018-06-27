<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="master-share-metas">
		<xsl:if test="string-length($meta-description) != 0">
			<meta name="description" content="{$meta-description}" />
		</xsl:if>
		<xsl:call-template name="meta-twitter-card" />
		<xsl:call-template name="meta-open-graph" />
	</xsl:template>

</xsl:stylesheet>
