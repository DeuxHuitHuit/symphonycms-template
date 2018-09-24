<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="default-edit-button-ctn-style">
		<add class="fixed bottom left" />
		<add class="padding-left-thinnest" />
		<add class="padding-bottom-thinnest" />
	</xsl:variable>

	<xsl:variable name="default-edit-button-link-style">
		<add class="inline-block" />
		<add class="padding-thinnest" />

		<add class="color-true-black bg-color-true-white" />
		
		<add class="border-solid" />
	</xsl:variable>

	<xsl:template match="entry" mode="edit-btn">
		<xsl:call-template name="edit-btn" />
	</xsl:template>

	<xsl:template name="edit-btn">
		<xsl:param name="section" select="../section/@handle" />
		<xsl:param name="entry-id" select="@id" />

		<xsl:param name="element" select="'div'" />
		<xsl:param name="content" select="'EDIT'" />

		<xsl:param name="attr" />
		<xsl:param name="attr-link" />

		<xsl:if test="$is-logged-in = true()">
				
			<xsl:variable name="computed-attr">
				<xsl:copy-of select="$default-edit-button-ctn-style" />
				<xsl:copy-of select="$attr" />
				<add dev-core="edit-btn" />
			</xsl:variable>

			<xsl:variable name="computed-attr-link">
				<xsl:copy-of select="$default-edit-button-link-style" />
				<xsl:copy-of select="$attr-link" />
				<add dev-element="link" />
			</xsl:variable>
			
			<xsl:variable name="computed-url">
				<xsl:text>/symphony/publish/</xsl:text>
				<xsl:value-of select="$section"/>
				<xsl:text>/edit/</xsl:text>
				<xsl:value-of select="$entry-id" />
				<xsl:text>/</xsl:text>
			</xsl:variable>

			<xsl:call-template name="element">
				<xsl:with-param name="element" select="$element"/>
				<xsl:with-param name="attr" select="$computed-attr"/>
				<xsl:with-param name="content">
					
					<xsl:call-template name="button">
						<xsl:with-param name="url" select="$computed-url" />
						<xsl:with-param name="attr" select="$computed-attr-link" />
						<xsl:with-param name="content" select="$content" />
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
