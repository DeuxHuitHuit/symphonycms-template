<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

	<xsl:template name="toolkit-recettes">
		<xsl:call-template name="main-section">
			<xsl:with-param name="name" select="'recettes-graphique'" />
			<xsl:with-param name="attr" >
				<add class="flexbox min-width-full" />
			</xsl:with-param>
			<xsl:with-param name="content">

				<xsl:call-template name="toolkit-recettes-aside" />

				<div class="flex-grow-1" style="padding-top: 10rem;">

					<!-- Couleurs -->
					<!-- <xsl:call-template name="toolkit-article">
						<xsl:with-param name="name" select="'couleurs'"/>
						<xsl:with-param name="title" select="'Couleurs'" />
						<xsl:with-param name="content">

							<xsl:call-template name="toolkit-color-editor" />
						</xsl:with-param>
					</xsl:call-template> -->

					<!-- Typographie -->
					<!-- <xsl:call-template name="toolkit-article">
						<xsl:with-param name="name" select="'typographie'"/>
						<xsl:with-param name="title" select="'Typographie'" />
						<xsl:with-param name="content">

							<xsl:call-template name="toolkit-typographie-editor" />
						</xsl:with-param>
					</xsl:call-template> -->
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="toolkit-recettes-aside">
		<aside class="toolkit-aside min-height-full-viewport border-box">
			<h1>
				<xsl:text>Recettes graphique</xsl:text>
			</h1>

			<nav>
				<a href="#couleurs" >Couleurs</a>
				<a href="#typographie">Typographie</a>
			</nav>
		</aside>
	</xsl:template>
</xsl:stylesheet>
