<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

	<xsl:import href="toolkit-helper.xsl" />
	<xsl:import href="toolkit-accueil.xsl" />
	<xsl:import href="toolkit-variables-graphique.xsl" />
	<xsl:import href="toolkit-language.xsl" />

	<xsl:variable name="theme" select="document('../../assets/css/vars/theme.xml')" />
	<xsl:variable name="theme-default" select="document('../../assets/css/vars/theme.xml')" />
	<xsl:variable name="theme-node" select="exsl:node-set($theme)//theme[@type='site']" />

	<xsl:variable name="properties">
		<!-- Colors -->
		<color           class-prefix="color-"          themable="yes"/>
		<fill            class-prefix="fill-"           themable="yes"/>
		<stroke          class-prefix="stroke-"         themable="yes"/>
		<bacground-color class-prerix="bg-color"        themable="yes" />

		<!-- fonts -->
		<font            class-prefix="font-"           themable="yes"/>
		<font-size       class-prefix="text-"           themable="yes"/>
		<line-height     class-prefix="line-height-"    themable="yes"/>
		<letter-spacing  class-prefix="letter-spacing-" themable="yes"/>
		<font-weight     class-prefix="font-weight-"/>

		<!-- opacity -->
		<opacity         class-prefix=""                themable="yes"/>
		
		<!-- Bordure -->

		<!-- Layout -->
		<margin />
		<padding />
		<min-width />
		<width />
		<max-width />
		<min-height />
		<height />
		<max-height />
	</xsl:variable>

	<xsl:variable name="plates-files" select="document('../../utilities/recipes/recipes.xsl')" />
	<xsl:variable name="plates">
		<xsl:for-each select="$plates-files//*[local-name() = 'import']">
			<xsl:copy-of select="document(@href)//*[local-name() = 'variable']" />
		</xsl:for-each>
	</xsl:variable>

	<xsl:variable name="colors" >
		<xsl:for-each select="$theme-node/colors/type[@name = 'core-variables']">
			<xsl:copy-of select="." />
		</xsl:for-each>

		<xsl:for-each select="$theme-node/colors/type[@name != 'core-variables']">
			<xsl:copy-of select="." />
		</xsl:for-each>
	</xsl:variable>

	<xsl:template name="toolkit">
		<header class="toolkit-header fixed top left z-index-10 right flexbox border-box bg-color-true-white">
			<figure>
				<!-- Logo -->
				<xsl:call-template name="dhh-logo" />
			</figure>

			<nav class="flexbox flex-center">
				<a href="?">Index</a>
				<a href="?page=variables-graphique">Variables graphique</a>
				<a href="?page=language-graphique">Language graphique</a>
			</nav>
		</header>

		<main>
			<!-- Accueil -->
			<xsl:call-template name="toolkit-accueil" />

			<!-- variables graphique -->
			<xsl:call-template name="toolkit-variables-graphique" />

			<!-- Language graphique -->
			<xsl:call-template name="toolkit-language" />
		</main>
		<footer class="toolkit-footer">
			<p><strong>DESIGN VIEWER (nom temporaire)</strong> — <em>visualiseur de système graphique</em> — Tous droits réservés © 2017 Deux Huit Huit</p>
		</footer>
	</xsl:template>
</xsl:stylesheet>
