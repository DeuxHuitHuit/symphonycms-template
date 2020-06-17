<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:util="https://github.com/DeuxHuitHuit/288-utils"
	extension-element-prefixes="exsl util">

	<xsl:variable name="default-image-sizes">
		<sizes>
			<size height="0" width="430" media="(max-width: 430px)" />
 			<size height="0" width="620" media="(max-width: 620px)" />
 			<size height="0" width="760" media="(max-width: 760px)" />
 			<size height="0" width="890" media="(max-width: 890px)" />
 			<size height="0" width="1120" media="(max-width: 1120px)" />
 			<size height="0" width="1260" media="(max-width: 1260px)" />
 			<size height="0" width="1560" media="(max-width: 1560px)" />
 			<size height="0" width="1920" media="(max-width: 1920px)" />
			<size height="0" width="2500" media="(max-width: 2500px)" />
		</sizes>
	</xsl:variable>

	<xsl:template name="image">
		<xsl:param name="image" select="image" />
		<xsl:param name="alt" select="alt" />
		<xsl:param name="custom-sizes" />
		<xsl:param name="sizes-node">
			<xsl:choose>
				<xsl:when test="util:count($custom-sizes) &gt; 0">
					<sizes>
						<xsl:copy-of select="$custom-sizes" />
					</sizes>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="$default-image-sizes" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="sizes" select="exsl:node-set($sizes-node)/sizes" />
		<xsl:param name="use-sizes" select="$image/@type != 'image/gif' and $image/@type != 'image/svg+xml' and $image/@type != 'image/svg' and $image/@type != 'image/tiff' and $image/@type != 'text/plain'"/>
		<xsl:param name="valid-sizes" select="$sizes/size[@width &lt; $image/meta/@width]" />
		<xsl:param name="srcset">
			<xsl:if test="$use-sizes">
				<xsl:apply-templates select="$valid-sizes" mode="image-source">
					<xsl:with-param name="image" select="$image" />
				</xsl:apply-templates>
			</xsl:if>
		</xsl:param>
		<xsl:param name="media-queries">
			<xsl:if test="$use-sizes">
				<xsl:apply-templates select="$valid-sizes" mode="image-media-query">
					<xsl:with-param name="image" select="$image" />
				</xsl:apply-templates>
			</xsl:if>
		</xsl:param>

		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<add class="block width-full" />
			<set src="/workspace{$image/@path}/{$image/filename}" />
			<set alt="{$alt}" />
			<xsl:if test="string-length($srcset) != 0">
				<set srcset="{$srcset}" />
			</xsl:if>
			<xsl:if test="string-length($media-queries) != 0">
				<set sizes="{$media-queries}" />
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

	<xsl:template name="image-width">
		<xsl:param name="image" />
		<xsl:param name="size" />

		<xsl:choose>
			<xsl:when test="number($size/@width) &gt; 0">
				<xsl:value-of select="$size/@width" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="round((number($image/meta/@width) div number($image/meta/@height)) * number($size/@height))" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template> <!-- image-width -->

	<xsl:template match="size" mode="image-media-query">
		<xsl:param name="size" select="." />
		<xsl:param name="image" />
		<xsl:param name="width">
			<xsl:call-template name="image-width">
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="image" select="$image"/>
			</xsl:call-template>
		</xsl:param>

		<xsl:value-of select="$size/@media" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="$width" />
		<xsl:text>px</xsl:text>
		<xsl:if test="position() != last()">, </xsl:if>
		<xsl:if test="position() = last()">
			<xsl:text>, 100vw</xsl:text>
		</xsl:if>
	</xsl:template> <!-- image-media-query -->

	<xsl:template match="size" mode="image-source">
		<xsl:param name="size" select="." />
		<xsl:param name="image" />
		<xsl:param name="src">
			<xsl:call-template name="image-src">
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="image" select="$image" />
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="width">
			<xsl:call-template name="image-width">
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="image" select="$image"/>
			</xsl:call-template>
		</xsl:param>

		<xsl:value-of select="$src" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="$width" />
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
