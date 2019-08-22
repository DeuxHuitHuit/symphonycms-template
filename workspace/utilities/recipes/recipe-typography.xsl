<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- FONT: page-title -->
<xsl:variable name="recipe-font-page-title">
	<add class="text-huge" />
	<add class="line-height-tightest" />
</xsl:variable>

<!-- FONT: module-title -->
<xsl:variable name="recipe-font-module-title">
	<add class="text-taller" />
	<add class="line-height-tightest" />
</xsl:variable>

<!-- FONT: card-title -->
<xsl:variable name="recipe-font-card-title">
	<add class="text-tall" />
	<add class="line-height-tightest" />
</xsl:variable>

<!-- FONT: intertitle -->
<xsl:variable name="recipe-font-intertitle">
	<add class="text-current" />
	<add class="line-height-tightest" />
</xsl:variable>

<!-- FONT: emphasis -->
<xsl:variable name="recipe-font-emphasis">
	<add class="text-tall" />
	<add class="line-height-normal" />
</xsl:variable>

<!-- FONT: text -->
<xsl:variable name="recipe-font-text">
	<add class="text-current" />
	<add class="line-height-normal" />
</xsl:variable>

<!-- FONT: caption -->
<xsl:variable name="recipe-font-caption">
	<add class="text-shorter" />
	<add class="line-height-normal" />
</xsl:variable>

<!-- FONT: button -->
<xsl:variable name="recipe-font-button">
	<add class="text-short" />
	<add class="line-height-tightest" />
</xsl:variable>

<!-- MARKDOWN -->

<!-- FONT: h1 -->
<xsl:variable name="recipe-font-h1">
	<xsl:copy-of select="$recipe-font-page-title" />
</xsl:variable>

<!-- FONT: h2 -->
<xsl:variable name="recipe-font-h2">
	<xsl:copy-of select="$recipe-font-module-title" />
</xsl:variable>

<!-- FONT: h3 -->
<xsl:variable name="recipe-font-h3">
	<xsl:copy-of select="$recipe-font-card-title" />
</xsl:variable>

<!-- FONT: h4 -->
<xsl:variable name="recipe-font-h4">
	<xsl:copy-of select="$recipe-font-intertitle" />
</xsl:variable>

<!-- FONT: h5 -->
<xsl:variable name="recipe-font-h5">
	<xsl:copy-of select="$recipe-font-caption" />
</xsl:variable>

<!-- FONT: h6 -->
<xsl:variable name="recipe-font-h6">
	<xsl:copy-of select="$recipe-font-caption" />
</xsl:variable>

<!-- FONT: p -->
<xsl:variable name="recipe-font-p">
	<xsl:copy-of select="$recipe-font-text" />
</xsl:variable>




</xsl:stylesheet>
