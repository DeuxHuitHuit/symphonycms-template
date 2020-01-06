<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">

<!-- 
	Presents all sharing options available for the site.
	Uses the native share when supported.

	Content
		title: Title of the component
		label-share: Used for the native share button
		url: Url to shar (current by default)
		share-links-node: Node of all available sharing method generated url

	Dependencies
		modules/auto-native-share.js
 -->

<!-- COMPONENT: nav-share -->
	<xsl:template name="nav-share">
		<xsl:param name="title" select="$ui/share-desktop" />
		<xsl:param name="label-share" select="$ui/share-desktop" />
		<xsl:param name="url" select="$current-url" />
		<xsl:param name="share-links-node">
			<xsl:call-template name="util-share-links-node">
				<xsl:with-param name="url" select="$url" />
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="ext-attr" />

		<xsl:variable name="share-links" select="exsl:node-set($share-links-node)/links/item" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add class="js-nav-share" />
			<add dev-component="nav-share" />
		</xsl:variable>

		<xsl:variable name="attr-title">
			<add class="margin-bottom-thinnest" />
			<add class="js-native-share-follower" />
			<add data-native-share-state-add-class="display-none" />
			<add dev-element="title" />
		</xsl:variable>

		<xsl:variable name="attr-links-ctn">
			<add class="padding-horizontal-thinner" />
			<add class="padding-vertical-thin" />
			<add class="border-top-solid border-bottom-solid" />
			<add class="border-slimmest border-color-main-stroke" />
			<add class="js-native-share" />
			<add data-native-share-state-follower=".js-native-share-follower" />
			<add data-native-share-state-follower-common-ancestor=".js-nav-share" />
			<add dev-element="links-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-grid">
			<add class="flexbox justify-content-space-between" />
			<xsl:copy-of select="$recipe-gutter-h-button" />
			<xsl:copy-of select="$recipe-gutter-v-button" />
			<add dev-element="grid" />
		</xsl:variable>

		<xsl:variable name="attr-item">
			<xsl:copy-of select="$recipe-gutter-h-button-item" />
			<xsl:copy-of select="$recipe-gutter-v-button-item" />
			<add class="js-native-share-follower" />
			<add data-native-share-state-add-class="display-none" />
			<add dev-element="item" />
		</xsl:variable>

		<xsl:variable name="attr-mobile-label">
			<add class="display-none" />
			<xsl:copy-of select="$attr-item" />
			<set data-native-share-state-add-class="block" />
			<set data-native-share-state-rem-class="display-none" />
			<add dev-element="mobile-label" />
		</xsl:variable>

		<xsl:variable name="attr-copy-url">
			<xsl:copy-of select="$attr-item" />
			<add dev-element="copy-url" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'nav'" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Title -->
				<xsl:call-template name="heading">
					<xsl:with-param name="attr" select="$attr-title" />
					<xsl:with-param name="level" select="'2'" />
					<xsl:with-param name="content" select="$title" />
				</xsl:call-template>
				<!-- Links ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-links-ctn" />
					<xsl:with-param name="content">
						<!-- Grid -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-grid" />
							<xsl:with-param name="content">
								<!-- Mobile label -->
								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$attr-mobile-label" />
									<xsl:with-param name="content" select="$label-share" />
								</xsl:call-template>
								<!-- BUTTON: copy -->
								<xsl:call-template name="button-copy">
									<xsl:with-param name="ext-attr" select="$attr-copy-url" />
									<xsl:with-param name="copy-text" select="$url" />
								</xsl:call-template>
								<!-- Share links -->
								<xsl:apply-templates select="$share-links" mode="nav-share-item">
									<xsl:with-param name="url" select="$url" />
									<xsl:with-param name="ext-attr" select="$attr-item" />
								</xsl:apply-templates>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
