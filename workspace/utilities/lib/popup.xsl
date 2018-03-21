<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="popup">
	<xsl:param name="attr" />
	<xsl:param name="attr-bg" />
	<xsl:param name="attr-content" />
	<xsl:param name="attr-close-btn" />
	<xsl:param name="poped" select="false()" />
	<xsl:param name="display-close-button" select="true()" />
	<xsl:param name="close-btn-url" select="concat(/data/params/current-path, '/')" />
	<xsl:param name="close-btn-is-optional" select="false()" />
	<xsl:param name="content" />
	<xsl:param name="bg-poped-add-class" select="'pointer-events-all'" />
	<xsl:param name="bg-poped-rem-class" select="'transparent'" />
	<xsl:param name="content-poped-add-class" select="'pointer-events-all'" />
	<xsl:param name="content-poped-rem-class" select="'transparent'" />
	<xsl:param name="element-bg" select="'div'" />

	<!-- STYLISTICS _________________________________________________________ -->
	<xsl:variable name="s-popup">
		<add class="fixed fill z-index-max-minus-4" />
		<add class="pointer-events-none" />

		<xsl:call-template name="set-popup-poped-state">
			<xsl:with-param name="flag" select="$poped" />
			<xsl:with-param name="add-class" select="''" />
			<xsl:with-param name="rem-class" select="''" />
		</xsl:call-template>
		<add data-popup-poped-state-follower=".js-popup-bg, .js-popup-content" />
	</xsl:variable>

	<xsl:variable name="s-bg">
		<add class="absolute fill" />
		<add class="transition-opacity transition-duration-faster transition-ease-out-quad" />

		<xsl:call-template name="set-popup-poped-state">
			<xsl:with-param name="flag" select="$poped" />
			<xsl:with-param name="add-class" select="$bg-poped-add-class" />
			<xsl:with-param name="rem-class" select="$bg-poped-rem-class" />
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="s-content">
		<add class="absolute fill" />
		<add class="transition-opacity transition-duration-faster transition-ease-out-quad" />

		<xsl:call-template name="set-popup-poped-state">
			<xsl:with-param name="flag" select="$poped" />
			<xsl:with-param name="add-class" select="$content-poped-add-class" />
			<xsl:with-param name="rem-class" select="$content-poped-rem-class" />
		</xsl:call-template>
	</xsl:variable>

	<!-- ___________________________________________________________________/-->

	<!-- STRUCTURE DIAGRAM 												   >
		|- SELF :  popup
				popup background
				popup content
					btn close															/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
	<xsl:variable name="computed-attr">
		<xsl:copy-of select="$s-popup"/>
		<add class="js-popup" />
		<add data-inner-scroll-selector=".js-popup-content" />

		<xsl:copy-of select="$attr"/>
		<add dev-component="popup" />
	</xsl:variable>

	<xsl:variable name="computed-attr-bg">
		<xsl:copy-of select="$s-bg"/>
		<xsl:copy-of select="$attr-bg"/>
		<!-- FOR POPUP ANIMATION -->
		<add class="js-popup-bg" />
		<add dev-element="popup-bg" />
	</xsl:variable>

	<xsl:variable name="computed-attr-content">
		<xsl:copy-of select="$s-content"/>

		<!-- FOR POPUP ANIMATION -->
		<add class="js-popup-content" />
		<add class="overflow-hidden" />
		<set role="dialog" aria-modal="true" />
		<xsl:copy-of select="$attr-content"/>
		<add dev-element="popup-content" />
	</xsl:variable>

	<xsl:variable name="computed-attr-close-btn">
		<xsl:copy-of select="$attr-close-btn"/>
	</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE 															 -->
	<xsl:call-template name="element">
		<xsl:with-param name="attr" select="$computed-attr" />
		<xsl:with-param name="content">
			<!-- Bg -->
			<xsl:call-template name="element">
				<xsl:with-param name="element" select="$element-bg" />
				<xsl:with-param name="attr" select="$computed-attr-bg"/>
			</xsl:call-template>

			<!-- Popup Content -->
			<xsl:call-template name="element">
				<xsl:with-param name="attr" select="$computed-attr-content"/>
				<xsl:with-param name="content">

					<!-- Popup Content -->
					<xsl:call-template name="content">
						<xsl:with-param name="content" select="$content" />
					</xsl:call-template>
					<!-- Close button -->
					<xsl:if test="/data/params/amp = 'No' and $display-close-button">
						<xsl:call-template name="popup-close-button">
							<xsl:with-param name="attr" select="$computed-attr-close-btn"/>
							<xsl:with-param name="url" select="$close-btn-url" />
							<xsl:with-param name="is-optional" select="$close-btn-is-optional" />
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
	<!--																	/-->
</xsl:template>

<xsl:template name="popup-close-button">
	<xsl:param name="attr" />
	<xsl:param name="url" />
	<xsl:param name="content">
		<i class="block width-broader width-broad-from-xs width-thin-from-sm">
			<xsl:call-template name="icon-close" />
		</i>
	</xsl:param>
	<xsl:param name="is-optional" select="false()" />

	<xsl:variable name="s-close-btn">
		<add class="cursor-pointer pointer-events-all" />
		<add class="js-popup-close-btn" />
	</xsl:variable>

	<xsl:variable name="computed-attr">
		<xsl:copy-of select="$s-close-btn"/>
		<add data-action="toggle" />
		<add data-auto-modal-popup-selector=".js-popup" />
		<add data-toggle-fallback-url="{$page-index-url}" />

		<xsl:copy-of select="$attr" />
		<add dev-component="popup-close-btn" />
	</xsl:variable>

	<!-- Close button -->
	<xsl:call-template name="button">
		<xsl:with-param name="is-optional" select="$is-optional" />
		<xsl:with-param name="attr" select="$computed-attr"/>
		<xsl:with-param name="url" select="$url" />
		<xsl:with-param name="content" select="$content" />
	</xsl:call-template>
</xsl:template>

<!-- template to set poped state -->
<xsl:template name="set-popup-poped-state">
	<xsl:param name="flag" select="false()" />
	<xsl:param name="add-class" select="''" />
	<xsl:param name="rem-class" select="''" />

	<xsl:choose>
		<xsl:when test="$flag">
			<add class="{$add-class}" />
			<rem class="{$rem-class}" />
			<add class="is-popup-poped" />
		</xsl:when>
		<xsl:otherwise>
			<rem class="{$add-class}" />
			<add class="{$rem-class}" />
		</xsl:otherwise>
	</xsl:choose>

	<add data-popup-poped-state-add-class="{$add-class}" />
	<add data-popup-poped-state-rem-class="{$rem-class}" />
</xsl:template>
</xsl:stylesheet>
