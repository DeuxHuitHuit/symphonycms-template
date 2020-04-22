<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
								xmlns:exsl="http://exslt.org/common" 
								extension-element-prefixes="exsl">

	<xsl:variable name="default-image-sizes">
		<sizes>
			<size height="0" width="430" />
			<size height="0" width="620" />
			<size height="0" width="800" />
			<size height="0" width="960" />
			<size height="0" width="1100" />
			<size height="0" width="1260" />
			<size height="0" width="1400" />
			<size height="0" width="2000" />
		</sizes>
	</xsl:variable>

	<xsl:template name="image">
		<xsl:param name="image" select="image" />
		<xsl:param name="alt" select="alt" />
		<xsl:param name="sizes" select="exsl:node-set($default-image-sizes)/sizes" />
		<xsl:param name="use-sizes" select="$image/@type != 'image/gif' and $image/@type != 'image/svg+xml' and $image/@type != 'image/svg' and $image/@type != 'image/tiff' and $image/@type != 'text/plain'"/>
		<xsl:param name="ext-attr" />

		<xsl:variable name="srcset">
			<xsl:apply-templates select="$sizes/size" mode="image-source">
				<xsl:with-param name="image" select="$image" />
			</xsl:apply-templates>
		</xsl:variable>

		<xsl:variable name="attr">
			<add class="block width-full" />
			<set src="/workspace{$image/@path}/{$image/filename}" />
			<set alt="{$alt}" />
			<xsl:if test="string-length($srcset) != 0">
				<set srcset="{$srcset}" />
			</xsl:if>
			<set loading="lazy" />
			<xsl:copy-of select="$ext-attr" />
			<add dev-component="image" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr-img" />
			<xsl:with-param name="element" select="'img'" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="size" mode="image-source">
		<xsl:param name="size" select="." />
		<xsl:param name="image" />
		<xsl:param name="src">
			<xsl:call-template name="image-src">
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="image" select="$image" />
			</xsl:call-template>
		</xsl:param>

		<xsl:value-of select="$src" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="$size/@width" />
		<xsl:text>w</xsl:text>
		<xsl:if test="postion() != last()">, </xsl:if>
	</xsl:template> <!-- image-source -->

	<xsl:template name="image-src">
		<xsl:param name="image" />
		<xsl:param name="size" />
		<xsl:text>/image/1/</xsl:text>
		<xsl:value-of select="$size/@width" />
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$size/@height" />
		<xsl:value-of select="$image/@path" />
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$image/filename" />
	</xsl:template> <!-- image-src -->

</xsl:stylesheet>
