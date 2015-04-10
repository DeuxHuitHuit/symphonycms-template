<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../lib/nav-link.xsl" />

<xsl:template name="site-nav">
	<nav id="site-nav" role="menu">
		<xsl:apply-templates select="/data/menu/entry" />
	</nav>
</xsl:template>

<xsl:template match="menu/entry">
	<div class="nav-link-ctn">
		<xsl:call-template name="nav-link">
			<xsl:with-param name="class" select="'nav-link'" />
			<xsl:with-param name="extra-param-key" select="." />
		</xsl:call-template>
	</div>
</xsl:template>

<xsl:template match="menu/entry" mode="nav-link-extra-param">
	<xsl:if test="string-length(access-key) != 0">
		<xsl:attribute name="accesskey">
			<xsl:value-of select="access-key" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>