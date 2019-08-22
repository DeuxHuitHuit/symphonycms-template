<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: button-share -->
	<xsl:template name="button-share">
		<xsl:param name="url" select="url" />
		<xsl:param name="content" />
		<xsl:param name="ga-label" select="@target" />
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<set target="_blank" />
			<set rel="noopener" />
			<set data-ga-cat="share" />
			<set data-ga-label="{$ga-label}" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="button-share" />
		</xsl:variable>

		<xsl:variable name="attr-button">
			<add class="inline-block" />
			<add class="transition-color" />
			<add class="transition-duration-fast" />
			<add class="transition-ease-standard-out" />
			<add dev-element="button" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: button -->
				<xsl:call-template name="button">
					<xsl:with-param name="url" select="$url" />
					<xsl:with-param name="attr" select="$attr-button" />
					<xsl:with-param name="content" select="$content" />
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
