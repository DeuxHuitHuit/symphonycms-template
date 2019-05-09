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
		(optional) modules/oembed-dm.js
		(optional) modules/oembed-fb.js
		(optional) modules/oembed-ig.js
		(optional) modules/oembed-sc.js
		(optional) modules/oembed-tw.js
		(optional) modules/oembed-vm.js
		(optional) modules/oembed-yt.js
 -->

 <xsl:import href="../lib/util-oembed-attr.xsl" />
 <xsl:import href="module-embed-item.xsl" />
 <xsl:import href="com-embed-video.xsl" />

<!-- COMPONENT: module-embed -->
	<xsl:template name="module-embed" match="item[@section = 'module-embed']" mode="module">
		<xsl:param name="url" select="url" />
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="js-auto-oembed-ctn" />
			<add data-playing-state-follower=".js-auto-oembed-play" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="module-embed" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'section'" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- APPLY: url -->
				<xsl:apply-templates select="$url" mode="module-embed-item" />
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
