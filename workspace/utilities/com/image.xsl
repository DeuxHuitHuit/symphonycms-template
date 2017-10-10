<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: image =====================================================================-->
	<xsl:template name="image">
		<xsl:param name="image" select="image" />
		<xsl:param name="alt" select="image-alt" />
		<xsl:param name="veil-opacity" select="veil-opacity" />
		<xsl:param name="type" select="'resize'" />
		<xsl:param name="enable-veil" select="false()" />
		<xsl:param name="loaded-state-add-class" select="''" />
		<xsl:param name="loaded-state-rem-class" select="''" />
		<xsl:param name="attr-ctn" />
		<xsl:param name="attr" />
		<xsl:param name="attr-veil" />

		<xsl:variable name="has-image" select="string-length($image) != 0" />
		<xsl:variable name="has-veil-opacity" select="string-length($veil-opacity) != 0" />


	<!-- STYLISTICS _________________________________________________________ -->
		<!-- image-->
		<xsl:variable name="s-ctn">
			
		</xsl:variable>

		<xsl:variable name="s-image">
			
		</xsl:variable>

		<xsl:variable name="s-veil">
			
		</xsl:variable>
	<!-- ___________________________________________________________________/-->


	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr-ctn">
			<!-- Basic classes -->
			<add class="overflow-hidden" />
			<xsl:choose>
				<xsl:when test="$is-cover or $is-contain">
					<add class="absolute fill" />
				</xsl:when>
				<xsl:otherwise>
					<add class="relative" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:copy-of select="$s-ctn"/>
			<xsl:copy-of select="$attr-ctn" />
			<add dev-element="image-ctn" />
		</xsl:variable>

		<xsl:variable name="computed-attr">
			<!-- Basic classes -->
			<xsl:choose>
				<xsl:when test="$is-cover or $is-contain">
					<add class="absolute fill" />
				</xsl:when>
				<xsl:otherwise>
					<add class="block width-full" />
				</xsl:otherwise>
			</xsl:choose>
			<!-- STATE: loaded -->
			<add class="{$loaded-state-rem-class}" />
			<add class="transition-transform-filter transition-duration-slow_faster" />
			<add data-loaded-state-add-class="{$loaded-state-add-class}" />
			<add data-loaded-state-rem-class="{$loaded-state-rem-class}" />
			<xsl:copy-of select="$s-image"/>
			<xsl:copy-of select="$attr"/>
			<add dev-component="image" />
		</xsl:variable>

		<xsl:variable name="computed-attr-veil">
			<!-- Basics classes -->
			<add class="absolute fill" />
			<xsl:if test="$has-veil-opacity">
				<add style="opacity:{$veil-opacity};" />
			</xsl:if>
			<xsl:copy-of select="$s-veil"/>
			<add dev-element="veil" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$computed-attr-ctn" />
			<xsl:with-param name="content">
				<xsl:if test="$has-image">
					<xsl:choose>
						<xsl:when test="$type = 'cover'">
							<xsl:call-template name="render-image-bg-cover">
								<xsl:with-param name="image" select="$image" />
								<xsl:with-param name="alt" select="$alt" />
								<xsl:with-param name="attr" select="$computed-attr" />
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$type = 'contain'">
							<xsl:call-template name="render-image-bg-contain">
								<xsl:with-param name="image" select="$image" />
								<xsl:with-param name="alt" select="$alt" />
								<xsl:with-param name="attr" select="$computed-attr" />
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="render-image-resize">
								<xsl:with-param name="image" select="$image" />
								<xsl:with-param name="alt" select="$alt" />
								<xsl:with-param name="attr" select="$computed-attr" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="$enable-veil">
						<!-- ELEMENT: veil -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$computed-attr-veil" />
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
			</xsl:with-param> 
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>
