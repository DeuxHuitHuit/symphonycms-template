<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 

	PAGE-DESCRIPTION overwrite example :

	<xsl:template name="page-description">
		<xsl:param name="description" select="myCoolDescription"/>
		<xsl:value-of select="$description" />
	</xsl:template>

	OVERWRITING PAGE-DESCRIPTION WILL AFFECT DESCRIPTION TAG, OPEN-GRAPH AND TWITTER-CARD

-->

	<xsl:template name="page-description">
		<xsl:param name="description" />
		<xsl:value-of select="$description" />
	</xsl:template>

</xsl:stylesheet>
