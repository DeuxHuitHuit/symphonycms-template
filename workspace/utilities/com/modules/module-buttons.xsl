<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: module-buttons -->
	<xsl:template name="module-buttons" match="item[@section = 'module-buttons']" mode="module">
		<xsl:param name="buttons" select="buttons/item" />
		<xsl:param name="ext-attr" />

		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="module-buttons" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<add dev-extended-by="module-buttons" />
		</xsl:variable>

		<xsl:variable name="attr-grid">
			<add class="flexbox justify-content-center" />
			<xsl:copy-of select="$recipe-gutter-h-button" />
			<xsl:copy-of select="$recipe-gutter-v-button" />
			<add dev-element="grid" />
		</xsl:variable>

		<xsl:variable name="attr-item">
			<xsl:copy-of select="$recipe-gutter-h-button-item" />
			<xsl:copy-of select="$recipe-gutter-v-button-item" />
			<add dev-element="item" />
		</xsl:variable>

		<!-- STRUCTURE -->
		<xsl:call-template name="module">
			<xsl:with-param name="ext-attr" select="$attr" />
			<xsl:with-param name="ext-attr-ctn" select="$attr-ctn" />
			<xsl:with-param name="transition-name" select="'transition-module-buttons'" />
			<xsl:with-param name="content">
				<!-- Grid -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-grid" />
					<xsl:with-param name="content">
						<!-- Items -->
						<xsl:apply-templates select="$buttons" mode="button-main">
							<xsl:with-param name="ext-attr" select="$attr-item" />
						</xsl:apply-templates>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
