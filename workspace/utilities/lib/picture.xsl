<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
								xmlns:exsl="http://exslt.org/common" 
								extension-element-prefixes="exsl">

	<xsl:variable name="default-image-sizes">
		<sizes>
			<size request-height="0" request-width="430" media="(max-width: 430px)" />
			<size request-height="0" request-width="620" media="(max-width: 620px)" />
			<size request-height="0" request-width="800" media="(max-width: 800px)" />
			<size request-height="0" request-width="960" media="(max-width: 960px)" />
			<size request-height="0" request-width="1100" media="(max-width: 1100px)" />
			<size request-height="0" request-width="1260" media="(max-width: 1260px)" />
			<size request-height="0" request-width="1400" media="(max-width: 1400px)" />
			<size request-height="0" request-width="2000" media="(max-width: 2000px)" />
		</sizes>
	</xsl:variable>

	<xsl:template name="picture">
		<xsl:param name="image" select="image" />
		<xsl:param name="alt" select="alt" />
		<xsl:param name="sizes" select="exsl:node-set($default-image-sizes)/sizes" />
		<xsl:param name="use-sizes" select="$image/@type != 'image/gif' and $image/@type != 'image/svg+xml'"/>
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-image" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-component="picture" />
		</xsl:variable>

		<xsl:variable name="attr-img">
			<add class="block width-full" />
			<set src="/workspace{$image/@path}/{$image/filename}" />
			<set alt="{$alt}" />
			<set loading="lazy" />
			<xsl:copy-of select="$ext-attr-image" />
			<add dev-element="img" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="element" select="'picture'" />
			<xsl:with-param name="content">

				<xsl:if test="$use-sizes">
					<xsl:apply-templates select="$sizes/size" mode="picture-source">
						<xsl:with-param name="image" select="$image" />
					</xsl:apply-templates>
				</xsl:if>

				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-img" />
					<xsl:with-param name="element" select="'img'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="size" mode="picture-source">
		<xsl:param name="size" select="." />
		<xsl:param name="image" />
		<xsl:param name="srcset">
			<xsl:call-template name="picture-src">
				<xsl:with-param name="size" select="$size" />
				<xsl:with-param name="image" select="$image" />
			</xsl:call-template>
		</xsl:param>

		<xsl:variable name="attr">
			<set srcset="{$srcset}" />
			<!-- <set type="{$image/@type}" /> seems to be laggy with svg uploads application/octetstream stuff -->
			<set media="{$size/@media}" />
			<add dev-element="picture-source" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="element" select="'source'" />
		</xsl:call-template>
	</xsl:template> <!-- picture-source -->

	<xsl:template name="picture-src">
		<xsl:param name="image" />
		<xsl:param name="size" />
		<xsl:text>/image/1/</xsl:text>
		<xsl:value-of select="$size/@request-height" />
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$size/@request-width" />
		<xsl:value-of select="$image/@path" />
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$image/filename" />
	</xsl:template> <!-- picture-src -->

</xsl:stylesheet>
