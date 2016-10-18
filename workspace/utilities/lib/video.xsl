<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- interesting attribute to add to video element:
	- autoplay
	- loop
	- muted
	- controls (shows browser video controls)
	- poster
	- preload

	for more detail: https://developer.mozilla.org/en/docs/Web/HTML/Element/video
-->

<!-- tag video avec wrapper. important pour le js -->
<xsl:template name="video">
	<xsl:param name="mp4" select="''" />
	<xsl:param name="ogv" select="''" />
	<xsl:param name="webm" select="''" />
	<xsl:param name="attr" select="''" />
	<xsl:param name="video-attr" select="''" />

	<xsl:if test="string-length($mp4) != 0 or string-length($ogv) != 0 or string-length($webm) != 0">
		<xsl:call-template name="element">
			<xsl:with-param name="attr" >
				<add class="js-video-ctn" />

				<xsl:copy-of select="$attr" />

				<add dev-component="video" />
			</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="video-tag">
					<xsl:with-param name="mp4" select="$mp4" />
					<xsl:with-param name="ogv" select="$ogv" />
					<xsl:with-param name="webm" select="$webm" />
					<xsl:with-param name="attr">
						<add class="relative" />

						<xsl:copy-of select="$video-attr" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<!-- tag video uniquement -->
<xsl:template name="video-tag">
	<xsl:param name="mp4" select="''" />
	<xsl:param name="ogv" select="''" />
	<xsl:param name="webm" select="''" />
	<xsl:param name="attr" select="''" />

	<xsl:if test="string-length($mp4) != 0 or string-length($ogv) != 0 or string-length($webm) != 0">
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'video'" />
			<xsl:with-param name="attr" >
				<add class="js-video" />
				
				<add preload="none" />

				<xsl:copy-of select="$attr" />

				<add dev-component="video-tag" />
			</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:if test="string-length($mp4) != 0">
					<source src="/workspace{$mp4/@path}/{$mp4/filename}" type="video/mp4" />
				</xsl:if>

				<xsl:if test="string-length($ogv) != 0">
					<source src="/workspace{$ogv/@path}/{$ogv/filename}" type="video/ogg" />
				</xsl:if>

				<xsl:if test="string-length($webm) != 0">
					<source src="/workspace{$webm/@path}/{$webm/filename}" type="video/webm" />
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>