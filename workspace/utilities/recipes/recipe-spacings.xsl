<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="gutter" select="'broader'" />
<xsl:variable name="security-spacing" select="'broader'" />


	<!-- Spacing Recipe -->
	<xsl:variable name="security-padding" 
		type="spacing">
		<xsl:text>padding-horizontal-</xsl:text>
		<xsl:value-of select="$security-spacing"/> 
	</xsl:variable>

	<xsl:variable name="security-margin" 
		type="spacing">
		<xsl:text>margin-horizontal-</xsl:text>
		<xsl:value-of select="$security-spacing"/> 
	</xsl:variable>
	<xsl:variable name="security-padding-full" 
		type="spacing">
		<xsl:text>padding-</xsl:text>
		<xsl:value-of select="$security-spacing"/> 
	</xsl:variable>	

	<xsl:variable name="guttered-item" 
		type="spacing">
		<xsl:text>border-box </xsl:text>
		<xsl:text>padding-left-</xsl:text>
		<xsl:value-of select="$gutter"/> 
		<xsl:text> padding-top-</xsl:text>
		<xsl:value-of select="$gutter"/>
	</xsl:variable>

	<xsl:variable name="guttered-container" 
		type="spacing">
		<xsl:text>margin-left-minus-</xsl:text>
		<xsl:value-of select="$gutter"/> 
		<xsl:text> margin-top-minus-</xsl:text>
		<xsl:value-of select="$gutter"/>
	</xsl:variable>

</xsl:stylesheet>