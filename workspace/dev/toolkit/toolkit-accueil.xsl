<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

	<xsl:template name="toolkit-accueil" >
		<xsl:call-template name="main-section">
			<xsl:with-param name="attr" >
			</xsl:with-param>
			<xsl:with-param name="content">

				<div style="padding-left: 2rem;">
					<header class="toolkit-article-header" style="padding-top: 10rem;">
						<h1>Accueil</h1>
					</header>

					<div class="toolkit-accueil-stats-language">
						<h2>Statistiques</h2>
						<table cellspacing="0">
							<tr>
								<td>Couleurs</td>
								<td>
									<xsl:value-of select="count($theme-node/colors/type[@name != 'core-variables']/*)"/>
								</td>
							</tr>
							<tr>
								<td>Opacity</td>
								<td>
									<xsl:value-of select="count($theme-node/opacity/*)" />
								</td>
							</tr>
							<tr>
								<td><strong class="inline-block" style="margin-left: -17px;">Positionnement</strong></td>
								<td></td>
							</tr>
							<tr>
								<td>Espacements</td>
								<td>
									<xsl:value-of select="count($theme-node/spacing/*)" />
								</td>
							</tr>
							<tr>
								<td>Dimensions</td>
								<td>
									<xsl:value-of select="count($theme-node/dimensions/*)" />
								</td>
							</tr>
							<tr>
								<td><strong class="inline-block" style="margin-left: -17px;">Typographie</strong></td>
								<td></td>
							</tr>
							<tr>
								<td>Fonts</td>
								<td>
									<xsl:value-of select="count($theme-node/typographie/fonts/*)" />
								</td>
							</tr>
							<tr>
								<td>Fonts size</td>
								<td>
									<xsl:value-of select="count($theme-node/typographie/fonts-size/*)" />
								</td>
							</tr>
							<tr>
								<td>Line height</td>
								<td>
									<xsl:value-of select="count($theme-node/typographie/line-height/*)" />
								</td>
							</tr>
							<tr>
								<td>Letter spacing</td>
								<td>
									<xsl:value-of select="count($theme-node/typographie/letter-spacing/*)" />
								</td>
							</tr>
							<tr>
								<td><strong class="inline-block" style="margin-left: -17px;">Bordure</strong></td>
								<td></td>
							</tr>
							<tr>
								<td>Border size</td>
								<td>
									<xsl:value-of select="count($theme-node/border/size/*)" />
								</td>
							</tr>
							<tr>
								<td>Border radius</td>
								<td>
									<xsl:value-of select="count($theme-node/border/radius/*)" />
								</td>
							</tr>
							<tr>
								<td><strong class="inline-block" style="margin-left: -17px;">Transition</strong></td>
								<td></td>
							</tr>
							<tr>
								<td>Durée</td>
								<td>
									<xsl:value-of select="count($theme-node/transition/duration/*)" />
								</td>
							</tr>
							<tr>
								<td>Ease</td>
								<td>
									<xsl:value-of select="count($theme-node/transition/ease/*)" />
								</td>
							</tr>
						</table>
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
