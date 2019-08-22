<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: button-submit -->
	<xsl:template name="button-submit" match="entry | item" mode="button-submit">
		<xsl:param name="label" select="submit" />
		<xsl:param name="default-label" select="$form-config/submit" />
		<xsl:param name="ext-attr" />

		<xsl:variable name="has-label" select="string-length($label) != 0" />

		<xsl:variable name="computed-label">
			<xsl:choose>
				<xsl:when test="$has-label">
					<xsl:value-of select="$label" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$default-label" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="block" />
			<xsl:copy-of select="$ext-attr" />
			<add dev-component="button-submit" />
		</xsl:variable>

		<xsl:variable name="attr-button">
			<add class="cursor-pointer" />
			<add class="transition-form-submit" />
			<add class="js-form-btn-submit" />
		</xsl:variable>

		<!-- BUTTON: button -->
		<xsl:call-template name="button-main">
			<xsl:with-param name="label" select="$computed-label" />
			<xsl:with-param name="url" select="''" />
			<xsl:with-param name="ext-attr" select="$attr" />
			<xsl:with-param name="ext-attr-button" select="$attr-button" />
		</xsl:call-template>

	</xsl:template>
</xsl:stylesheet>
