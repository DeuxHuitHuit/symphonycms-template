<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

	<xsl:template name="toolkit-language">
		<xsl:call-template name="main-section">
			<xsl:with-param name="name" select="'language-graphique'" />
			<xsl:with-param name="attr" >
				<add class="flexbox min-width-full" />
			</xsl:with-param>
			<xsl:with-param name="content">
				
				<xsl:call-template name="toolkit-language-aside" />

				<div class="toolkit-right-panel" style="padding-bottom: 40px;">
					<!-- Couleurs -->
					<xsl:call-template name="toolkit-article">
						<xsl:with-param name="name" select="'mix-couleurs'"/>
						<xsl:with-param name="title" select="'Mix couleurs'" />
						<xsl:with-param name="content">

						</xsl:with-param>
					</xsl:call-template>

					<!-- Typographie -->
					<xsl:call-template name="toolkit-article">
						<xsl:with-param name="attr" >
							<add class="width-full" />
						</xsl:with-param>
						<xsl:with-param name="name" select="'typographie'"/>
						<xsl:with-param name="title" select="'Typographie'" />
						<xsl:with-param name="content">

							<xsl:for-each select="exsl:node-set($plates)/*[@type = 'typo'] ">
								<div class="border-box">
								<h2 class="toolkit-h2-style">
									<xsl:value-of select="@name" />
								</h2>
								<div class="width-1_2 inline-block border-box valign-middle">
									<div class="toolkit-typo-value">
										<xsl:variable name="extract-font-family">
											<xsl:call-template name="lookup-value-from-text-list">
												<xsl:with-param name="nodes" select="*"/>
												<xsl:with-param name="prefix" select="'font-'" />
												<xsl:with-param name="searchNodes" select="$theme-node/typographie/fonts/*" />
											</xsl:call-template>
										</xsl:variable>

										<!-- Info about the plate -->
										<table>
											<tr>
												<td>Class</td>
												<td>
													<code><xsl:value-of select="*" /></code>
												</td>
											</tr>
											<xsl:if test="string-length($extract-font-family) != 0">
												<tr>
													<td>Font</td>
													<td>
														<xsl:copy-of select="$extract-font-family" />
													</td>
												</tr>
											</xsl:if>
											<xsl:if test="contains(*, 'text-')">
												<tr>
													<td>Size</td>
													<td>
														<xsl:call-template name="lookup-value-from-text-list">
															<xsl:with-param name="nodes" select="*"/>
															<xsl:with-param name="prefix" select="'text-'" />
															<xsl:with-param name="searchNodes" select="$theme-node/typographie/fonts-size/*" />
														</xsl:call-template>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test="contains(*, 'line-height')">
												<tr>
													<td>Line-height</td>
													<td>
														<xsl:call-template name="lookup-value-from-text-list">
															<xsl:with-param name="nodes" select="*"/>
															<xsl:with-param name="prefix" select="'line-height-'" />
															<xsl:with-param name="searchNodes" select="$theme-node/typographie/line-height/*" />
														</xsl:call-template>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test="contains(*, 'font-weight')">
												<tr>
													<td>Weight</td>
													<td>
														
													</td>
												</tr>
											</xsl:if>
											<xsl:if test="contains(*, 'color-')">
												<tr>
													<td>Color</td>
													<td>
														
													</td>
												</tr>
											</xsl:if>
										</table>
									</div>
								</div>
									<div class="width-1_2 inline-block border-box valign-top">
										<div class="site-theme">
											<span >
												<xsl:attribute name="class">
													<xsl:value-of select="." />
												</xsl:attribute>
												<xsl:value-of select="$alphabet"/>
											</span>
										</div>
									</div>
									
								</div>
							</xsl:for-each>
						</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>

		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.0/jquery.min.js" ></script>
	</xsl:template>

	<xsl:template name="lookup-value-from-text-list">
		<xsl:param name="nodes" />
		<xsl:param name="prefix" />
		<xsl:param name="searchNodes" />

		<xsl:for-each select="$nodes">
			<xsl:for-each select="str:tokenize(., ' ')">
				<xsl:if test="starts-with(., $prefix)">

					<xsl:variable name="class-value" select="substring(., string-length($prefix) + 1)" />
					<!-- <xsl:value-of select="$class-value" /> -->
					<xsl:if test="count($searchNodes[name() = $class-value]) = 1">
						<xsl:value-of select="$searchNodes[name() = $class-value]/@value" />
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="toolkit-language-aside">
		<aside class="toolkit-aside">
			<h1>
				<xsl:text>Language graphique</xsl:text>
			</h1>

			<nav>
				<a href="#couleurs" >Mix couleurs</a>
				<a href="#typographie" >Typographie</a>
				<a href="#markdown" >Markdown</a>
				<a href="#liens" >Liens</a>
			</nav>
		</aside>
	</xsl:template>

	<xsl:variable name="alphabet" select="'aàbcçdeéëêfghijklmnopqrstuvwxyz AÀBCÇDEÉËÊFGHIJKLMNOPQRSTUVWXYZ'" />
</xsl:stylesheet>