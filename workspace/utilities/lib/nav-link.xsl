<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="nav-link">
	<xsl:param name="title" select="titre" />
	<xsl:param name="page" select="page/page" />
	<xsl:param name="class" select="''" />
	<xsl:param name="action" select="''" />
	<xsl:param name="extra-param-key" select="''" />
	<xsl:param name="selected-on-sub-page" select="'yes'" />
	
	<xsl:variable name="has-page">
		<xsl:if test="string-length(page) != 0">
			<xsl:text>yes</xsl:text>
		</xsl:if>
	</xsl:variable>
	
	<xsl:variable name="page-handle">
		<xsl:text>btn-page-</xsl:text>
		<xsl:call-template name="create-page-handle-by-id">
			<xsl:with-param name="id" select="$page/@id" />
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="sub-pages-handle">
		<xsl:for-each select="/data/pages//page [@id = $page/@id]//page">
			<xsl:text> btn-page-</xsl:text>
			<xsl:call-template name="create-page-handle-by-id">
				<xsl:with-param name="id" select="@id" />
			</xsl:call-template>
		</xsl:for-each>
	</xsl:variable>
	
	<xsl:variable name="selected"> 
		<xsl:if test="$selected-on-sub-page = 'yes'">
			<xsl:if test="count(/data/pages//page [@id = $page/@id]//page[@id = $current-page-id]) != 0">
				<xsl:text>selected</xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$current-page-id = $page/@id">
			<xsl:text>selected</xsl:text>
		</xsl:if>
		
	</xsl:variable>
	
	<xsl:variable name="reel-class">
		<xsl:if test="$has-page = 'yes'">
			<xsl:value-of select="$page-handle" />
			<xsl:value-of select="$sub-pages-handle" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="$selected" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="$class" />
	</xsl:variable>
	
	<xsl:variable name="has-url">
		<xsl:if test="string-length(url) != 0">
			<xsl:text>yes</xsl:text>
		</xsl:if>
	</xsl:variable>
	
	
	<xsl:if test="$has-url = 'yes' or $has-page = 'yes'">
		<a target="_self" role="menuitem" data-ga-cat="menu" data-ga-value="{$url-language}/{$title}">
			<xsl:if test="string-length($reel-class) != 0">
				<xsl:attribute name="class">
					<xsl:value-of select="$reel-class" />
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string-length($action) != 0">
				<xsl:attribute name="data-action" >
					<xsl:value-of select="$action" />
				</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href">
				<xsl:choose>
					<xsl:when test="$has-page = 'yes'">
						<xsl:call-template name="create-page-url">
							<xsl:with-param name="page" select="page" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$has-url = 'yes'">
						<xsl:value-of select="url" />
					</xsl:when>
				</xsl:choose>
			</xsl:attribute>
			<xsl:if test="string-length($extra-param-key) != 0">
				<xsl:apply-templates select="." mode="nav-link-extra-param" >
					<xsl:with-param name="key" select="$extra-param-key" />
				</xsl:apply-templates>
			</xsl:if>
			<span>
				<xsl:value-of select="$title" />
			</span>
		</a>
	</xsl:if>
		
</xsl:template>
	
</xsl:stylesheet>