<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt">

	<xsl:import href="../lib/ninja-heading.xsl" />

<!-- CORE-ELEMENT: element ======================================================================-->
	<xsl:template name="element">
		<xsl:param name="element" select="'div'" />
		<xsl:param name="is-optional" select="false()" />
		<!-- function attr params -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" select="$default-attr-mode"/>
		<!-- function content params -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />

		<xsl:variable name="is-node-set" select="exslt:object-type($content) = 'node-set'" />

		<xsl:variable name="has-content">
			<xsl:if test="string-length($content) != 0">
				<xsl:text>yes</xsl:text>
			</xsl:if>
			<xsl:if test="$is-node-set">
				<xsl:if test="count($content/*) != 0">
					<xsl:text>yes</xsl:text>
				</xsl:if>
			</xsl:if>
			<xsl:if test="count(exslt:node-set($content)/*) != 0">
				<xsl:text>yes</xsl:text>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$attr" />
		</xsl:variable>

		<xsl:variable name="is-heading" select="$element = 'h1' or 
												$element = 'h2' or 
												$element = 'h3' or 
												$element = 'h4' or 
												$element = 'h5' or 
												$element = 'h6'"/>
	<!--																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:if test="$is-optional = false() or string-length($has-content) != 0">
			<!-- element -->
			<xsl:element name="{$element}">
				<!-- element attr -->
				<xsl:call-template name="attr">
					<xsl:with-param name="attr" select="$computed-attr"/>
					<xsl:with-param name="attr-mode" select="$attr-mode" />
				</xsl:call-template>

				<xsl:choose>
					<xsl:when test="$is-heading = true()">
						<!-- heading content -->
						<xsl:choose>
							<xsl:when test="exslt:object-type($content) = 'node-set'">

								<xsl:choose>
									<xsl:when test="count($content/item) != 0">
										<xsl:apply-templates select="$content/item[@lang = $lg]" mode="ninja-heading" >
											<xsl:with-param name="lg" select="$lg" />
										</xsl:apply-templates>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="$content" mode="ninja-heading" >
											<xsl:with-param name="lg" select="$lg" />
										</xsl:apply-templates>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:variable name="content-nodeset" select="exslt:node-set($content)" />

								<xsl:choose>
									<xsl:when test="count($content-nodeset/item) != 0">
										<xsl:apply-templates select="$content-nodeset/item[@lang = $lg]" mode="ninja-heading" >
											<xsl:with-param name="lg" select="$lg" />
										</xsl:apply-templates>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="$content-nodeset" mode="ninja-heading" >
											<xsl:with-param name="lg" select="$lg" />
										</xsl:apply-templates>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<!-- generic content -->
						<xsl:call-template name="content" >
							<xsl:with-param name="content" select="$content" />
							<xsl:with-param name="lg" select="$lg" />
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	<!--																	/-->
	</xsl:template>

<!-- CORE-ELEMENT: optional-element =============================================================-->
	<xsl:template name="optional-element">
		<xsl:param name="element" select="'div'" />
		<!-- function attr params -->
		<xsl:param name="attr" />
		<xsl:param name="attr-mode" />
		<!-- function content params -->
		<xsl:param name="lg" select="$url-language" />
		<xsl:param name="content" />

	<!-- STRUCTURE 															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$element"/>
			<xsl:with-param name="is-optional" select="true()" />
			<xsl:with-param name="attr" select="$attr"/>
			<xsl:with-param name="attr-mode" select="$attr-mode" />
			<xsl:with-param name="lg" select="$lg" />
			<xsl:with-param name="content" select="$content"/>
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>
