<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
	Creates a modal, either for a page or a simple element.

	Content
		modal: The actual content of the modal
		close: The element that will trigger a closing action

	Options
		id: Unique identifier used to easily target a specific modal
		is-visible: Determines if the modal starts visible or not
		is-page: Changes the behavior of the modal to make it work as a page

	Dependencies
		modules/change-state.js
		modules/auto-change-state-click.js
-->


<!-- COMPONENT: struct-modal -->
	<xsl:template name="struct-modal">
		<xsl:param name="content-modal" />
		<xsl:param name="content-close" />
		<xsl:param name="id" />
		<xsl:param name="is-visible" select="false()" />
		<xsl:param name="is-page" select="false()" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-background" />
		<xsl:param name="ext-attr-ctn" />
		<xsl:param name="ext-attr-close-ctn" />

		<xsl:variable name="has-id" select="string-length($id) != 0" />

		<!-- For background and close button -->
		<xsl:variable name="util-close-attr">
			<xsl:choose>
				<xsl:when test="$is-page">
					<set href="{/data/params/current-path}/" />
					<set data-action="toggle" />
				</xsl:when>
				<xsl:otherwise>
					<!-- STATE (click): visible ~> OFF -->
					<xsl:if test="$has-id">
						<add class="js-change-state-click" />
						<set data-change-state-click-target=".js-struct-modal[data-id='{$id}']" />
						<set data-change-state-click="visible" />
						<set data-change-state-action="off" />
						<set data-change-state-click-target-common-ancestor="#site" />
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Element type of background -->
		<xsl:variable name="element-background">
			<xsl:choose>
				<xsl:when test="$is-page">a</xsl:when>
				<xsl:otherwise>button</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="fixed fill z-index-10000" />
			<add class="flexbox" />
			<!-- OPTION: is-visible -->
			<xsl:if test="$is-visible">
				<add class="is-visible" />
			</xsl:if>
			<!-- OPTION: is-page -->
			<xsl:if test="$is-page">
				<add class="js-modal-page" />
			</xsl:if>
			<add class="transition-struct-modal" />
			<add class="js-struct-modal" />
			<xsl:if test="$has-id">
				<set data-id="{$id}" />
			</xsl:if>
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="struct-modal" />
		</xsl:variable>

		<xsl:variable name="attr-background">
			<add class="absolute fill cursor-pointer" />
			<xsl:if test="$is-page">
				<add class="transparent" />
			</xsl:if>
			<xsl:copy-of select="$util-close-attr" />
			<add class="transition-background" />
			<xsl:copy-of select="$ext-attr-background" />
			<add dev-element="background" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<add class="z-index-1" />
			<add class="transition-ctn" />
			<xsl:copy-of select="$ext-attr-ctn" />
			<add dev-element="ctn" />
		</xsl:variable>

		<xsl:variable name="attr-close-ctn">
			<xsl:copy-of select="$util-close-attr" />
			<xsl:copy-of select="$ext-attr-close-ctn" />
			<add dev-element="close-ctn" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Background -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-background" />
					<xsl:with-param name="element" select="$element-background" />
				</xsl:call-template>
				<!-- Ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-ctn" />
					<xsl:with-param name="content">
						<!-- Close ctn -->
						<xsl:if test="$content-close != false()">
							<xsl:call-template name="element">
								<xsl:with-param name="attr" select="$attr-close-ctn" />
								<xsl:with-param name="content">
									<xsl:copy-of select="$content-close" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<!-- Content modal -->
						<xsl:if test="$content-modal != false()">
							<xsl:copy-of select="$content-modal" />
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
