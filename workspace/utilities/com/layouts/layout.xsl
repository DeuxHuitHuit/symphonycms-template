<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: layout -->
	<xsl:template name="layout">
		<xsl:param name="content" />
		<xsl:param name="handle">
			<xsl:call-template name="util-auto-handle" />
		</xsl:param>
		<xsl:param name="article-element">
			<xsl:choose>
				<xsl:when test="string-length($handle) != 0">
					<xsl:text>article</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>div</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-article" />

		<xsl:variable name="has-handle" select="string-length($handle) != 0" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:if test="$has-handle">
+				<add class="js-article-ctn" />
+			</xsl:if>
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="layout" />
		</xsl:variable>

		<xsl:variable name="attr-article">
			<xsl:if test="$has-handle">
+				<add class="js-article" />
+				<set data-handle="{$handle}" />
+			</xsl:if>
			<xsl:copy-of select="$ext-attr-article" />
			<add dev-element="article" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'main'" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Article -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-article" />
					<xsl:with-param name="element" select="$article-element" />
					<xsl:with-param name="content">
						<!-- Admin tools -->
						<xsl:call-template name="admin-tools" />
						<!-- Content -->
						<xsl:copy-of select="$content" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
