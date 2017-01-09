<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="popup">
	<xsl:param name="attr" />
	<xsl:param name="attr-bg" />
	<xsl:param name="attr-content" />
	<xsl:param name="attr-close-btn" />
	<xsl:param name="inited" select="false()" />
	<xsl:param name="close-btn-content" select="'X'" />
	<xsl:param name="close-btn-url" select="concat(/data/params/current-path, '/')" />
	<xsl:param name="close-btn-is-optional" select="false()" />
	<xsl:param name="content" />
	
	<!-- STYLISTICS _________________________________________________________ -->
	<xsl:variable name="s-popup">
		<add class="fixed fill z-index-10000" />
		<add class="pointer-events-none" />
	</xsl:variable>

	<xsl:variable name="bg-inited-state-class">
		<xsl:text>scale-9_10 transparent</xsl:text>
	</xsl:variable>

	<xsl:variable name="s-bg">
		<add class="absolute fill" />
		<add class="transition-transform-opacity transition-duration-fast" />

		<xsl:if test="$inited = true()">
			<add class="is-popup-inited" />
			<add class="{$bg-inited-state-class}" />
		</xsl:if>

		<add data-popup-inited-state-add-class="{$bg-inited-state-class}" />
		<add data-popup-poped-state-add-class="" />
		<add data-popup-poped-state-rem-class="{$bg-inited-state-class}" />
	</xsl:variable>

	<xsl:variable name="content-inited-state-class">
		<xsl:text>scale-11_10 transparent</xsl:text>
	</xsl:variable>
	<xsl:variable name="content-poped-state-add-class">
		<xsl:text>pointer-events-all</xsl:text>
	</xsl:variable>
	<xsl:variable name="content-poped-state-rem-class">
		<xsl:text>scale-11_10 transparent</xsl:text>
	</xsl:variable>

	<xsl:variable name="s-content">
		<add class="absolute fill" />
		<add class="transition-transform-opacity transition-duration-fast" />
		
		<xsl:if test="$inited = true()">
			<add class="is-popup-inited" />
			<add class="{$content-inited-state-class}" />
		</xsl:if>

		<add data-popup-inited-state-add-class="{$content-inited-state-class}" />
		<add data-popup-poped-state-add-class="{$content-poped-state-add-class}" />
		<add data-popup-poped-state-rem-class="{$content-poped-state-rem-class}" />
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
		<add data-inner-scroll-selector="js-popup-content" />

		<xsl:copy-of select="$attr"/>
		<add dev-component="popup" />
	</xsl:variable>
	
	<xsl:variable name="computed-attr-bg">
		<xsl:copy-of select="$s-bg"/>
		
		<!-- FOR POPUP ANIMATION -->
		<add class="js-popup-bg" />
		
		<xsl:copy-of select="$attr-bg"/>
		<add dev-element="popup-bg" />
	</xsl:variable>
	
	<xsl:variable name="computed-attr-content">
		<xsl:copy-of select="$s-content"/>
		
		<!-- FOR POPUP ANIMATION -->
		<add class="js-popup-content" />
		<add class="overflow-y-scroll overflow-x-hidden" />
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
				<xsl:with-param name="attr" select="$computed-attr-bg"/>
			</xsl:call-template>
			
			<!-- Popup Content -->
			<xsl:call-template name="element">
				<xsl:with-param name="attr" select="$computed-attr-content"/>
				<xsl:with-param name="content">
					
					<xsl:call-template name="popup-close-button">
						<xsl:with-param name="attr" select="$attr-close-btn"/>
						<xsl:with-param name="url" select="$close-btn-url" />
						<xsl:with-param name="content" select="$close-btn-content" />
						<xsl:with-param name="is-optional" select="$close-btn-is-optional" />
					</xsl:call-template>
					
					<!-- content -->
					<xsl:call-template name="content">
						<xsl:with-param name="content" select="$content" />
					</xsl:call-template>
					
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
	<!--																	/-->
</xsl:template>

<xsl:template name="popup-close-button">
	<xsl:param name="attr" />
	<xsl:param name="url" />
	<xsl:param name="content"/>
	<xsl:param name="is-optional" select="false()" />

	<xsl:variable name="s-close-btn">
		<add class="cursor-pointer" />
	</xsl:variable>

	<xsl:variable name="computed-attr">
		<xsl:copy-of select="$s-close-btn"/>
		<add data-action="toggle" />
		<add data-auto-modal-popup-selector=".js-popup" />

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
</xsl:stylesheet>
