<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../lib/site-title.xsl" />
	<xsl:import href="../lib/page-title.xsl" />
	<xsl:import href="../lib/full-title.xsl" />
	<xsl:import href="../lib/meta-title.xsl" />
	<xsl:import href="../lib/site-description.xsl" />
	<xsl:import href="../lib/page-description.xsl" />
	<xsl:import href="../lib/meta-description.xsl" />
	<xsl:import href="../lib/meta-theme.xsl" />
	<xsl:import href="../lib/meta-alt-link.xsl" />
	<xsl:import href="../lib/canonical.xsl" />
	<xsl:import href="../lib/meta-author.xsl" />
	<xsl:import href="../lib/twitter-card.xsl" />
	<xsl:import href="../lib/open-graph.xsl" />
	<xsl:import href="../lib/meta-share.xsl" />

	<xsl:import href="favicon.xsl" />
	<xsl:import href="css.xsl" />

	<xsl:template name="master-head">
		<head>
			<meta charset="utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1" />

		<!-- 			
			Pages generated from entries can add custom metas by overwriting the following templates.
			Examples are given in respective templates.
				-page-title
				-page-description 
				-meta-share (for image)
		-->

			<xsl:call-template name="meta-title" />
			<xsl:call-template name="meta-share" />
			<xsl:call-template name="meta-canonical" />
			<xsl:call-template name="meta-alt-link" />
			<xsl:call-template name="favicon" />
			<xsl:call-template name="meta-author" />
			<xsl:call-template name="meta-theme" />
			<xsl:call-template name="schema-organization" />
			<xsl:call-template name="page-metas-alt-rss" />
			
			<!-- GA -->
			<xsl:if test="$debug != true() and string-length($ga-ua) != 0">
				<xsl:call-template name="ga">
					<xsl:with-param name="ua" select="$ga-ua" />
				</xsl:call-template>
			</xsl:if>
			
			<!-- GTM -->
			<xsl:if test="$debug != true() and string-length($gtm-ctn) != 0">
				<xsl:call-template name="gtm-head">
					<xsl:with-param name="ctn" select="$gtm-ctn" />
				</xsl:call-template>
			</xsl:if>
			
			<!-- Master css -->
			<xsl:call-template name="master-css" />

			<!-- Admin-tools css -->
			<xsl:if test="/data/events/login-info/@logged-in = 'true'">
				<link rel="stylesheet" type="text/css" href="/workspace/utilities/admin-tools/admin-tools.css" />
			</xsl:if>

			<xsl:call-template name="master-head-extra" />
			
		</head>
	</xsl:template>

	<xsl:template name="master-head-extra"></xsl:template>
	
</xsl:stylesheet>
