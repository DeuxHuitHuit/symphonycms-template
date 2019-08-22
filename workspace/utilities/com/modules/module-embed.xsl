<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
	Allows embedding of multiple sources throught oembed standard.

	Content
		url: Source of content to be embeded

	Dependencies
		com/module-embed.xsl
		modules/auto-oembed.js
		com/oembed.js
		modules/oembed-vm.js
		modules/oembed-yt.js
		(optional) modules/oembed-dm.js
		(optional) modules/oembed-fb.js
		(optional) modules/oembed-ig.js
		(optional) modules/oembed-sc.js
		(optional) modules/oembed-tw.js
 -->

 <xsl:import href="../../lib/util-oembed-attr.xsl" />
 <xsl:import href="../com-embed-video.xsl" />
 <xsl:import href="module-embed-item.xsl" />

<!-- COMPONENT: module-embed -->
	<xsl:template name="module-embed" match="item[@section = 'module-embed']" mode="module">
		<xsl:param name="url" select="url" />
		<xsl:param name="custom-thumbnail" select="custom-thumbnail" />
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="module-embed" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<add dev-extended-by="module-embed" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="module">
			<xsl:with-param name="ext-attr" select="$attr" />
			<xsl:with-param name="ext-attr-ctn" select="$attr-ctn" />
			<xsl:with-param name="transition-name" select="'transition-module-embed'" />
			<xsl:with-param name="content">
				<!-- APPLY: url -->
				<xsl:apply-templates select="$url" mode="module-embed-item">
					<xsl:with-param name="custom-thumbnail" select="$custom-thumbnail" />
				</xsl:apply-templates>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
