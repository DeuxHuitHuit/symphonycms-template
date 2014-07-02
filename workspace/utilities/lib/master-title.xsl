<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Template to override for custom title -->
<xsl:template name="master-title">
	<xsl:call-template name="default-master-title" />
</xsl:template>


<!-- output <title> and <meta title> -->
<xsl:template name="master-title-header">

	<xsl:variable name="master-title">
		<xsl:call-template name="master-title" />
	</xsl:variable>
	
	<xsl:variable name="title">
	
		<!-- Use Master title if available or $website-name -->
		<xsl:choose>
			<xsl:when test="string-length($master-title)">
				<xsl:value-of select="$master-title" />
			</xsl:when>
			
			<xsl:otherwise>
				<xsl:value-of select="$website-name" />
			</xsl:otherwise>
			
		</xsl:choose>
	</xsl:variable>
	
	<title><xsl:value-of select="$title" /></title>
	<meta name="title" content="{$title}" />
</xsl:template>


<!-- Default master title template -->
<xsl:template name="default-master-title">
	<xsl:variable name="cur-page-title">
		<xsl:call-template name="page-title" />
	</xsl:variable>
	
	<xsl:if test="string-length($cur-page-title) != 0 and count(/data/params/page-types/item[@handle = 'index']) = 0">
		<xsl:value-of select="$cur-page-title"/>
		<xsl:text> - </xsl:text>
	</xsl:if>
	
	<xsl:choose>
		<xsl:when test="string-length($site-name) != 0">
			<xsl:value-of select="$site-name" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$website-name" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>