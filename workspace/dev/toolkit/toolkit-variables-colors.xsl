<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

	<xsl:template name="toolkit-variables-color-editor">
		<!-- Data for colors -->
		<xsl:apply-templates select="exsl:node-set($colors)" mode="toolkit-color-type-item" />
	</xsl:template>

<!-- COLOR TYPE -->
	<xsl:template match="*" mode="toolkit-color-type-item">
		<xsl:if test="count(*) != 0">
			<div style="margin-top: 2rem; border: 1px solid ; ">
				<header class="toolkit-color-type-item-header">
					<h3>
						<xsl:value-of select="@title" />
					</h3>
				</header>

				<xsl:apply-templates select="*" mode="toolkit-color-item" />
			</div>
		</xsl:if>
	</xsl:template>

<!-- COLOR ITEM -->
	<xsl:template match="*" mode="toolkit-color-item">
		<div class="inline-block bg-color-true-white vertical-align-top" >
			<div class="site-theme">
				<div class="js-btn-copy-color cursor-pointer" 
					data-color-name="{name()}" 
					style="width: 150px; padding-top: 100%; background-color: {@value};">
				</div>
			</div>
			
			<div class="toolkit-color-item-info">
				<h4 class="js-btn-copy cursor-pointer" 
					data-clipboard-text="@{name()}">
					<xsl:value-of select="name()" />
				</h4>
				<button 
					style="margin-bottom: 1rem;" 
					class="js-btn-copy cursor-pointer" 
					data-clipboard-text="{@value}">
					<xsl:value-of select="@value" />
				</button>

				<xsl:if test="string-length(@usage) != 0">
					<p>Description: </p>
					<ul style="padding-left: 5px; margin-top: 0px; list-style: none;">
						<li style="margin-left: -3px;">
							<text> - </text>
							<xsl:value-of select="@usage" />
						</li>
					</ul>
				</xsl:if>

				<p>Stats recipe: </p>
				<ul style="padding-left: 5px; margin-top: 0px; list-style: none;">
					<li style="margin-left: -3px;">? color    </li>
					<li style="margin-left: -3px;">? bg </li>
					<li style="margin-left: -3px;">? fill </li>
					<li style="margin-left: -3px;">? stroke </li>
				</ul>
				<p>recipes: </p>
				<ul style="padding-left: 5px; margin-top: 0px; list-style: none;">
					<li style="margin-left: -3px;">
						
					</li>
				</ul>
			</div>
		</div>
	</xsl:template>

<!-- DATA ZONE -->
	<xsl:template name="toolkit-master-color-data">
		<xsl:text>{"colorsGroup": [</xsl:text>
		<xsl:apply-templates select="exsl:node-set($colors)" mode="toolkit-color-type-data" />
		<xsl:text>]}</xsl:text>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-color-type-data">
		<xsl:if test="position() != 1">
			<xsl:text>,</xsl:text>
		</xsl:if>
		<xsl:text>{</xsl:text>
		<xsl:text>"name":"</xsl:text>
		<xsl:value-of select="@name" />
		<xsl:text>","title":"</xsl:text>
		<xsl:value-of select="@title" />
		<xsl:text>","colors":[</xsl:text>
		<xsl:apply-templates select="*" mode="toolkit-color-data" />
		<xsl:text>]}</xsl:text>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-color-data">
		<xsl:if test="position() != 1">
			<xsl:text>,</xsl:text>
		</xsl:if>
		<xsl:text>{"name":"</xsl:text>
		<xsl:value-of select="name()" />
		<xsl:text>","value":"</xsl:text>
		<xsl:value-of select="@value" />
		<xsl:text>","usage":"</xsl:text>
		<xsl:value-of select="@usage" />
		<xsl:text>"}</xsl:text>
	</xsl:template>

</xsl:stylesheet>