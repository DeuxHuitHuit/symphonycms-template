<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
	Copy the text inside the input on click of the button

	Content
		label: Label of the button
		confirmation: Text displayed after the copy as been successfully copied
		copy-text: Text to be copied (invisible)

	Dependencies
		modules/auto-copy-on-click.js
 -->

<!-- COMPONENT: button-copy -->
	<xsl:template name="button-copy">
		<xsl:param name="label" select="$ui/copy" />
		<xsl:param name="confirmation" select="$ui/copy-success" />
		<xsl:param name="copy-text" select="$current-url" />
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="relative" />
			<add class="js-copy-ctn" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="button-copy" />
		</xsl:variable>

		<xsl:variable name="attr-copy-text">
			<add class="absolute pointer-events-none" />
			<add class="transparent" />
			<add value="{$copy-text}" />
			<add class="js-text-to-copy" />
			<add dev-element="copy-text" />
		</xsl:variable>

		<xsl:variable name="attr-button">
			<add class="cursor-pointer" />
			<add class="inline-block" />
			<add class="transition-color" />
			<add class="transition-duration-fast" />
			<add class="transition-ease-standard-out" />
			<add class="js-copy-on-click-btn" />
			<add data-message-delay="1500" />
			<add dev-element="button" />
		</xsl:variable>

		<xsl:variable name="attr-confirmation">
			<add class="absolute top-full transparent" />
			<add class="color-accent-text" />
			<add class="transition-opacity" />
			<add class="transition-duration-fast" />
			<add class="transition-ease-standard-out" />
			<add data-visible-state-rem-class="transparent" />
			<add class="js-confirm-message" />
			<add dev-element="confirmation" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Copy text -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-copy-text" />
					<xsl:with-param name="element" select="'input'" />
				</xsl:call-template>
				<!-- Button -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-button" />
					<xsl:with-param name="element" select="'button'" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>
				<!-- Confirmation -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-confirmation" />
					<xsl:with-param name="content" select="$confirmation" />
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
