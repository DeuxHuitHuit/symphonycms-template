<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- THEME: Minimal -->

<xsl:variable name="svg-icons-default-fill-color" select="'#000000'" />

<xsl:variable name="svg-icons-real-height" select="'60'" />
<xsl:variable name="svg-icons-default-height" select="'60'" />


<xsl:template name="svg-icons-get-width">
	<xsl:param name="real-height" select="$svg-icons-real-height" />
	<xsl:param name="height" />
	<xsl:param name="width" />
	
	<xsl:variable name="ratio" select="number($height) div number($real-height)" />
	
	<xsl:value-of select="number($width) * number($ratio)" />
</xsl:template>

<!-- RSS -->
<xsl:template name="svg-icon-rss">
	<xsl:param name="color" select="$svg-icons-default-fill-color" />
	<xsl:param name="height" select="$svg-icons-default-height" />
	
	<xsl:variable name="width">
		<xsl:call-template name="svg-icons-get-width">
			<xsl:with-param name="width" select="'62'" />
			<xsl:with-param name="height" select="$height" />
		</xsl:call-template>
	</xsl:variable>
	
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
	class="svg-icon svg-icon-li"
	x="0px" y="0px"
	width="{$width}px" height="{$height}px"
	viewBox="0 0 61.405 60.544">
<g>
	<circle fill="{$color}" cx="8.229" cy="53.11" r="8.229"/>
	<path fill="{$color}" d="M39.771,61.339H28.114c0-15.527-12.587-28.114-28.114-28.114l0,0V21.567C21.966,21.567,39.771,39.373,39.771,61.339z"/>
	<path fill="{$color}" d="M48,61.339c0-26.51-21.49-48-48-48v-12c33.137,0,60,26.863,60,60H48z"/>
</g>
</svg>
</xsl:template>

</xsl:stylesheet>