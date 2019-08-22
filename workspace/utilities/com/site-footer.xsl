<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: site-footer -->
	<xsl:template name="site-footer">
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="flexbox justify-content-end" />
			<add class="padding-vertical-broad" />
			<add class="padding-horizontal-security" />
			<xsl:copy-of select="$recipe-gutter-h-card" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="site-footer" />
		</xsl:variable>

		<xsl:variable name="attr-social-ctn">
			<xsl:copy-of select="$recipe-gutter-h-card-item" />
			<add dev-element="social-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-credits-ctn">
			<xsl:copy-of select="$recipe-gutter-h-card-item" />
			<add dev-element="credits-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-credits-label">
			<add dev-element="credits-label" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'footer'" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Social ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-social-ctn" />
					<xsl:with-param name="content">
						<!-- Nav social -->
						<xsl:call-template name="nav-social" />
					</xsl:with-param>
				</xsl:call-template>
				<!-- Credits ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-credits-ctn" />
					<xsl:with-param name="content">
						<!-- Credits label -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-credits-label" />
							<xsl:with-param name="content">
								<xsl:choose>
									<xsl:when test="$url-language = 'fr'">
										<xsl:text>Crédits</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>Credits</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<!-- Copyright 288 -->
						<xsl:call-template name="copyright-288" />
					</xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
