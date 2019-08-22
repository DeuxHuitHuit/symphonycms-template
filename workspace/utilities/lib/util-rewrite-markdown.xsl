<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xsl:template name="util-rewrite-markdown">
		<xsl:param name="text" select="." />
		<xsl:apply-templates select="$text/*" mode="rewrite-markdown" />
	</xsl:template>

	<xsl:template match="node()" mode="rewrite-markdown" priority="0">
		<xsl:call-template name="markdown-node">
			<xsl:with-param name="element" select="name()"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="text()" mode="rewrite-markdown" priority="0">
		<xsl:copy>
			<xsl:apply-templates select="node() | text()" mode="rewrite-markdown"/>
		</xsl:copy>
	</xsl:template>

	<!-- IFRAME -->
	<xsl:template match="iframe" mode="rewrite-markdown">
		<div class="iframe-ctn">
			<xsl:call-template name="markdown-node">
				<xsl:with-param name="element" select="'iframe'"/>
			</xsl:call-template>
		</div>
	</xsl:template>

	<!-- Regular elements -->
	<xsl:template match="p | ol | ul | blockquote" mode="rewrite-markdown">
		<xsl:call-template name="markdown-node">
			<xsl:with-param name="element" select="name()"/>
			<xsl:with-param name="ext-attr">
				<xsl:copy-of select="$recipe-font-text" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- HEADINGS -->
	<xsl:template match="h1 | h2 | h3 | h4 | h5 | h6" mode="rewrite-markdown">
		<xsl:call-template name="markdown-node">
			<xsl:with-param name="ext-attr">
				<xsl:choose>
					<xsl:when test="name() = 'h1'">
						<xsl:copy-of select="$recipe-font-h1" />
					</xsl:when>
					<xsl:when test="name() = 'h2'">
						<xsl:copy-of select="$recipe-font-h2" />
					</xsl:when>
					<xsl:when test="name() = 'h3'">
						<xsl:copy-of select="$recipe-font-h3" />
					</xsl:when>
					<xsl:when test="name() = 'h4'">
						<xsl:copy-of select="$recipe-font-h4" />
					</xsl:when>
					<xsl:when test="name() = 'h5'">
						<xsl:copy-of select="$recipe-font-h5" />
					</xsl:when>
					<xsl:when test="name() = 'h6'">
						<xsl:copy-of select="$recipe-font-h6" />
					</xsl:when>
				</xsl:choose>
				<add class="{name()}" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template> 

	<!-- LINKS -->
	<xsl:template match="a" mode="rewrite-markdown">
		<xsl:call-template name="button-link">
			<xsl:with-param name="label" select="." />
			<xsl:with-param name="url" select="@href" />
			<xsl:with-param name="ext-attr-button">
				<rem class="inline-block" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template> 


<!-- MARKDOWN NODE -->
	<xsl:template name="markdown-node">
		<xsl:param name="element" select="'div'" />
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:apply-templates select="@*" mode="markdown-node-attr" />
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="markdown-node" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="element" select="$element" />
			<xsl:with-param name="content">
				<xsl:apply-templates select="node() | text()" mode="rewrite-markdown"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="@*" mode="markdown-node-attr">
		<add>
			<xsl:attribute name="{name()}"><xsl:value-of select="." /></xsl:attribute>
		</add>
	</xsl:template>

</xsl:stylesheet>