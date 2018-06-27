<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="meta-image">

		<xsl:choose>
			<xsl:when test="string-length($page-image) != 0">
				<xsl:copy-of select="$page-image" />
			</xsl:when>
			<xsl:when test="string-length($site-image)">
				<xsl:copy-of select="$site-image" />
			</xsl:when>
			<xsl:otherwise>
				<image size="0 KB" bytes="0" path="" type="">
					<filename></filename>
					<meta creation="" width="" height="" />
				</image>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

</xsl:stylesheet>
