<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--***************************************************************************>
	Auto computed value :

	JS :
		- modules/site-nav-link-selector.js
			> Js Class identificator
				js-site-nav-link
			> State class identificator
				is-selected
			> Data Attributes availables : 
				<add data-selected-class-add="" />
				<add data-selected-class-remove="" />
****************************************************************************/-->

<!-- CORE : nav-link ========================================================-->
<xsl:template name="nav-link">
	<xsl:param name="content" select="titre" />
	<xsl:param name="page" select="page/page" />
	<xsl:param name="page-extra-url" select="''" />
	<xsl:param name="selected-on-sub-page" select="true()" />
	<xsl:param name="failover-element" select="'button'" />
	<xsl:param name="url" select="url" />
	<xsl:param name="attr" />
	<xsl:param name="selected-attr" />

	<!-- COMPUTED VALUE 													 -->
		<xsl:variable name="has-page" select="string-length($page) != 0" />
		<xsl:variable name="has-url" select="string-length($url) != 0" />
		
		<xsl:variable name="computed-url">
			<xsl:choose>
				<xsl:when test="$has-url = true()">
					<xsl:value-of select="$url" />
				</xsl:when>
				<xsl:when test="$has-page = true()">
					<xsl:call-template name="create-page-url-by-id">
						<xsl:with-param name="id" select="$page/@id" />
					</xsl:call-template>
					<xsl:value-of select="$page-extra-url" />
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- Generate btn page handle class if we have a page-->
		<xsl:variable name="generated-page-handle-class">
			<xsl:if test="$has-page">
				<xsl:text>btn-page-</xsl:text>
				<xsl:call-template name="create-page-handle-by-id">
					<xsl:with-param name="id" select="$page/@id" />
				</xsl:call-template>
			</xsl:if>
		</xsl:variable>
		
		<!-- Generate btn sub page handle class if we have a page and we are selected on sub page -->
		<xsl:variable name="generated-sub-pages-handle-class">
			<xsl:if test="$has-page and $selected-on-sub-page = true()" >

				<xsl:for-each select="/data/pages//page [@id = $page/@id]//page">
					<xsl:text> btn-page-</xsl:text>
					<xsl:call-template name="create-page-handle-by-id">
						<xsl:with-param name="id" select="@id" />
					</xsl:call-template>
				</xsl:for-each>

			</xsl:if>
		</xsl:variable>

		<!-- Generate btn is-selected class if we have a page -->
		<xsl:variable name="generated-selected-class"> 

			<xsl:if test="$has-page" >

				<!-- Add is-selected if we are a child page and selected on sub page = 'yes' -->
				<xsl:if test="$selected-on-sub-page = true()">
					<xsl:if test="count(/data/pages//page [@id = $page/@id]//page[@id = $current-page-id]) != 0">
						<xsl:text> is-selected</xsl:text>
					</xsl:if>
				</xsl:if>

				<!-- Process current page -->
				<xsl:if test="$current-page-id = $page/@id">
					<xsl:text> is-selected</xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="computed-class">
			<xsl:copy-of select="$generated-page-handle-class" />
			<xsl:copy-of select="$generated-sub-pages-handle-class" />
			<xsl:copy-of select="$generated-selected-class" />
		</xsl:variable>
	<!--																	/-->

	<!-- MINIMAL ATTRIBUTES 												 -->
		<xsl:variable name="minimal-attr">
			<!-- Js class -->
			<add class="js-site-nav-link" />

			<!-- Google analytics attributes -->
			<add data-ga-cat="menu" />
			<add data-ga-label="{concat($url-language, '/', $content)}" />

			<!-- Html 5 semantic role -->
			<add role="menuitem" />

			<!-- Target self -->
			<add target="_self" />
		</xsl:variable>
	<!--																	/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<!-- Computed class attribute -->
			<xsl:if test="string-length($computed-class)" >
				<add class="{$computed-class}" />
			</xsl:if>

			<!-- Merge attributes -->
			<xsl:copy-of select="$minimal-attr" />
			<xsl:copy-of select="$attr" />

			<!-- Output selected attribute only if we are selected -->
			<xsl:if test="string-length($generated-selected-class) != 0">
				<xsl:copy-of select="$selected-attr" />
			</xsl:if>

			<add dev-base-component="nav-link" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:if test="string-length($content) != 0">
			<xsl:call-template name="button">
				<xsl:with-param name="url" select="$computed-url" />
				<xsl:with-param name="attr" select="$computed-attr" />
				<xsl:with-param name="failover-element" select="$failover-element" />
				<xsl:with-param name="content" select="$content" />
			</xsl:call-template>
		</xsl:if>
	<!--																	/-->
</xsl:template>
	
</xsl:stylesheet>