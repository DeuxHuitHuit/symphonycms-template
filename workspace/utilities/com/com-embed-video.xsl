<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: com-embed-video -->
<xsl:template name="com-embed-video">
	<xsl:param name="thumbnail" select="thumbnail" />
	<xsl:param name="custom-thumbnail" />
	<xsl:param name="is-autoplay" select="true()" />
	<xsl:param name="autoload" select="'none'" />
	<xsl:param name="title" select="''" />
	<xsl:param name="ext-attr" />
	<xsl:param name="ext-attr-video" />
	<xsl:param name="ext-attr-placeholder" />
	<xsl:param name="ext-attr-thumbnail" />
	<xsl:param name="ext-attr-button-ctn" />


	<xsl:variable name="has-thumbnail" select="string-length($thumbnail) != 0" />
	<xsl:variable name="has-custom-thumbnail" select="string-length($custom-thumbnail) != 0" />

	<!-- ATTRIBUTES -->
	<xsl:variable name="attr">
		<add class="relative z-index-1" />
		<!-- Default styles -->
		<add class="padding-bottom-9_16 bg-color-true-black" />
		<add class="js-auto-oembed-ctn" />
		<add data-playing-state-follower=".js-auto-oembed-play" />
		<xsl:copy-of select="$ext-attr" />
		<add dev-component="com-embed-video" />
	</xsl:variable>

	<xsl:variable name="attr-video">
		<add class="absolute fill" />
		<xsl:call-template name="util-oembed-attr" />
		<add data-autoload="{$autoload}" />
		<add data-rel="0" />
		<xsl:if test="$is-autoplay = true()">
			<add data-autoplay="1" />
		</xsl:if>
		<add class="js-auto-oembed-player" />
		<xsl:copy-of select="$ext-attr-video" />
		<add dev-element="video" />
	</xsl:variable>

	<xsl:variable name="attr-placeholder">
		<add class="absolute fill overflow-hidden" />
		<add class="cursor-pointer z-index-1" />
		<add class="js-auto-oembed-play" />
		<!-- STATE: playing -->
		<add class="transition-opacity transition-duration-fast transition-ease-standard-out" />
		<add data-playing-state-add-class="transparent pointer-events-none" />
		<xsl:copy-of select="$ext-attr-placeholder" />
		<add dev-element="placeholder" />
	</xsl:variable>

	<xsl:variable name="attr-custom-thumbnail">
		<add class="object-fit-cover" />
		<add dev-element="custom-thumbnail" />
	</xsl:variable>

	<xsl:variable name="attr-thumbnail">
		<add class="absolute fill" />
		<add class="bg-size-cover bg-position-center" />
		<xsl:if test="$has-thumbnail">
			<add style="background-image: url({$thumbnail});" />
		</xsl:if>
		<xsl:copy-of select="$ext-attr-thumbnail" />
		<add dev-element="thumbnail" />
	</xsl:variable>

	<xsl:variable name="attr-button-ctn">
		<add class="flexbox align-items-end" />
		<add class="absolute fill" />
		<xsl:copy-of select="$ext-attr-button-ctn" />
	</xsl:variable>


	<!-- STRUCTURE -->
	<xsl:call-template name="element">
		<xsl:with-param name="attr" select="$attr" />
		<xsl:with-param name="content">
			<!-- Video -->
			<xsl:call-template name="element">
				<xsl:with-param name="attr" select="$attr-video" />
			</xsl:call-template>
			<!-- Placeholder -->
			<xsl:call-template name="element">
				<xsl:with-param name="attr" select="$attr-placeholder" />
				<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="$has-custom-thumbnail">
							<!-- Custom Thumbnail -->
							<xsl:call-template name="picture">
								<xsl:with-param name="image" select="$custom-thumbnail" />
								<xsl:with-param name="ext-attr-image" select="$attr-custom-thumbnail" />
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$has-thumbnail">
							<!-- Thumbnail -->
							<xsl:call-template name="element">
								<xsl:with-param name="attr" select="$attr-thumbnail" />
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<!-- Button ctn -->
					<xsl:call-template name="element">
						<xsl:with-param name="attr" select="$attr-button-ctn" />
						<xsl:with-param name="content">
							<!-- BUTTON: play -->
							<!-- <xsl:call-template name="button-play" /> -->
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
