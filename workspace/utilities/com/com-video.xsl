<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:import href="../lib/video.xsl" />

<!-- COMPONENT: com-video -->
	<xsl:template name="com-video" match="entry | item" mode="com-video">
		<xsl:param name="webm" select="webm" />
		<xsl:param name="mp4" select="mp4" />
		<xsl:param name="image" select="image" />
		<xsl:param name="alt" select="alt" />
		<xsl:param name="use-image-dimensions" select="false()" />
		<xsl:param name="is-autoplay" select="autoplay = 'Yes'" />
		<xsl:param name="is-looping" select="loop = 'Yes'" />
		<xsl:param name="has-controls" select="not($is-autoplay)" />
		<xsl:param name="ext-attr" />

		<xsl:variable name="has-webm" select="string-length($webm) != 0" />
		<xsl:variable name="has-mp4" select="string-length($mp4) != 0" />
		<xsl:variable name="has-video" select="$has-mp4 or $has-webm" />
		<xsl:variable name="has-image" select="string-length($image) != 0" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="overflow-hidden" />
			<!-- OPTION: use-image-dimensions -->
			<xsl:choose>
				<xsl:when test="$use-image-dimensions">
					<add class="relative" />
				</xsl:when>
				<xsl:otherwise>
					<add class="absolute fill" />
				</xsl:otherwise>
			</xsl:choose>
			<add class="js-com-video" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="com-video" />
		</xsl:variable>

		<xsl:variable name="attr-video-ctn">
			<add class="absolute fill" />
			<!-- AUTO VIDEO -->
			<add class="js-auto-video" />
			<add data-video-loaded-state-follower=".js-image" />
			<add data-video-loaded-state-follower-common-ancestor=".js-com-video" />
			<add data-playing-state-follower=".js-image" />
			<add data-playing-state-follower-common-ancestor=".js-com-video" />
			<add dev-element="video-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-video">
			<add class="width-full height-full bg-color-black" />
			<!-- OPTION: is-autoplay -->
			<xsl:if test="$is-autoplay">
				<set autoplay="autoplay" />
				<set playsinline="" />
				<set muted="muted" />
			</xsl:if>
			<!-- OPTION: is-looping -->
			<xsl:if test="$is-looping">
				<set loop="loop" />
			</xsl:if>
			<!-- OPTION: has-controls -->
			<xsl:if test="$has-controls">
				<set controls="controls" />
			</xsl:if>
			<add dev-element="video" />
		</xsl:variable>

		<xsl:variable name="attr-image-ctn">
			<add class="js-image" />
			<add class="transition-opacity transition-duration-faster" />
			<add class="transition-ease-standard-out" />
			<add data-video-loaded-state-add-class="transparent" />
			<add dev-element="image-ctn" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Video -->
				<xsl:if test="$has-video">
					<xsl:call-template name="video">
						<xsl:with-param name="webm" select="$webm"/>
						<xsl:with-param name="mp4" select="$mp4" />
						<xsl:with-param name="attr" select="$attr-video-ctn" />
						<xsl:with-param name="video-attr" select="$attr-video" />
					</xsl:call-template>
				</xsl:if>
				<!-- Image -->
				<xsl:if test="$has-image">
					<xsl:call-template name="image">
						<xsl:with-param name="image" select="$image"/>
						<xsl:with-param name="type" select="'cover'" />
						<xsl:with-param name="alt" select="$alt" />
						<xsl:with-param name="attr-ctn" select="$attr-image-ctn" />
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
