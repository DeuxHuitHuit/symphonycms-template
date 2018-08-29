<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
	When you want a drawer behavior.

	Content
		fake-trigger: Visually beside the Trigger but does not change slide state. Useful to add a button for exemple.
		trigger: Changes the state of the slide
		slide: The element that slides up or down

	Options
		is-open: Determines weither or not the slide is open or not

	Dependencies
		modules/change-state.js
		modules/slide.js
		modules/auto-slide-click.js
 -->

<!-- COMPONENT: struct-drawer -->
	<xsl:template name="struct-drawer">
		<xsl:param name="content-fake-trigger" />
		<xsl:param name="content-trigger" />
		<xsl:param name="content-slide" />
		<xsl:param name="is-open" select="false()" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-trigger-ctn" />
		<xsl:param name="ext-attr-trigger" />
		<xsl:param name="ext-attr-slide" />

		<xsl:variable name="has-fake-trigger" select="string-length($content-fake-trigger) != 0" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="transition-drawer" />
			<!-- SLIDE (click): item -->
			<add class="js-auto-slide-click-item" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="struct-drawer" />
		</xsl:variable>

		<xsl:variable name="attr-trigger-ctn">
			<xsl:if test="$has-fake-trigger">
				<add class="flexbox" />
			</xsl:if>
			<add class="transition-trigger-ctn" />
			<xsl:copy-of select="$ext-attr-trigger-ctn" />
			<add dev-element="trigger-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-trigger">
			<add class="transition-trigger" />
			<!-- OPTION: is-open -->
			<xsl:if test="$is-open">
				<add class="is-auto-slide-click" />
			</xsl:if>
			<!-- SLIDE (click): trigger -->
			<add class="js-auto-slide-click-trigger" />
			<add data-auto-slide-click-state-notify-on="autoSlideClick.toggleOn" />
			<xsl:copy-of select="$ext-attr-trigger" />
			<add dev-element="trigger" />
		</xsl:variable>

		<xsl:variable name="attr-slide">
			<add class="transition-slide" />
			<!-- OPTION: is-open -->
			<xsl:choose>
				<xsl:when test="$is-open">
					<add class="is-auto-slide-click" />
				</xsl:when>
				<xsl:otherwise>
					<add class="display-none" />
				</xsl:otherwise>
			</xsl:choose>
			<!-- SLIDE (click): slide -->
			<add class="js-auto-slide-click-slide" />
			<xsl:copy-of select="$ext-attr-slide" />
			<add dev-element="slide" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Trigger ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-trigger-ctn" />
					<xsl:with-param name="content">
						<!-- Fake trigger -->
						<xsl:if test="$has-fake-trigger">
							<xsl:copy-of select="$content-fake-trigger" />
						</xsl:if>
						<!-- Trigger -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-trigger" />
							<xsl:with-param name="content">
								<xsl:copy-of select="$content-trigger" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
				<!-- Slide -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-slide" />
					<xsl:with-param name="content">
						<xsl:copy-of select="$content-slide" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
