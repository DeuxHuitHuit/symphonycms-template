<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: button-link -->
	<xsl:template name="button-link" match="entry | item" mode="button-link">
		<xsl:param name="label" select="label" />
		<xsl:param name="url">
			<xsl:call-template name="util-auto-url" />
		</xsl:param>
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-button" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="button-link" />
		</xsl:variable>

		<xsl:variable name="attr-button">
			<add class="inline-block" />
			<add class="color-accent-text" />
			<add class="border-bottom-solid border-slimmest" />
			<add class="border-color-accent-stroke" />
			<add class="border-color-accent-stroke-darker-on-hover" />
			<add class="transition-border-color" />
			<add class="transition-duration-fast" />
			<add class="transition-ease-standard-out" />
			<xsl:copy-of select="$ext-attr-button" />
			<add dev-element="button" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'span'" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: button -->
				<xsl:call-template name="button">
					<xsl:with-param name="url" select="$url" />
					<xsl:with-param name="attr" select="$attr-button" />
					<xsl:with-param name="failover-element" select="'button'" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
