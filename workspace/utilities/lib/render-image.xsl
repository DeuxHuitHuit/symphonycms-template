<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:exslt="http://exslt.org/common"
 exclude-result-prefixes="exslt"
>

<xsl:template name="render-image">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'3'" />
	<xsl:param name="format" select="''" />
	<xsl:param name="container" select="''" />

	<!--img 
		src="/image/1/{$width}/{$height}{$image/@path}/{$image/filename}" 
		alt="{$alt}" -->
		
	<img alt="{$alt}">
		<xsl:attribute name="src">
			<xsl:choose>
				<xsl:when test="exslt:object-type($image) = 'string'">
					<xsl:value-of select="$image" />
				</xsl:when>
				<xsl:when test="exslt:object-type($image) = 'node-set'">
					<xsl:variable name="width" select="round($image/meta/@width div $factor)" />
					<xsl:variable name="height" select="round($image/meta/@height div $factor)" />
					
					<xsl:text>/image/1/</xsl:text>
					<xsl:value-of select="$width" />
					<xsl:text>/</xsl:text>
					<xsl:value-of select="$height" />
					<xsl:value-of select="$image/@path" />
					<xsl:text>/</xsl:text>
					<xsl:value-of select="$image/filename" />
				</xsl:when>
			</xsl:choose>
		</xsl:attribute>
		
		<xsl:if test="string-length($format) != 0 and exslt:object-type($image) = 'node-set'">
			<xsl:attribute name="data-src-format">
				<xsl:value-of select="$format" />
				<xsl:value-of select="$image/@path" />
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$image/filename" />
			</xsl:attribute>
		</xsl:if>
		
		<xsl:if test="string-length($container) != 0">
			<xsl:attribute name="data-container">
				<xsl:value-of select="$container" />
			</xsl:attribute>
		</xsl:if>
		<xsl:if test="string-length($class) != 0">
			<xsl:attribute name="class">
				<xsl:value-of select="$class" />
			</xsl:attribute>
		</xsl:if>
	</img>
</xsl:template>

<xsl:template name="render-image-crop">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'3'" />
	<xsl:param name="container" select="''" />
	<xsl:param name="width" select="'$w'" />
	<xsl:param name="height" select="'$h'" />
	<xsl:param name="position" select="'5'" />

	<xsl:call-template name="render-image">
		<xsl:with-param name="image" select="$image" />
		<xsl:with-param name="alt" select="$alt" />
		<xsl:with-param name="class" select="$class" />
		<xsl:with-param name="factor" select="$factor" />
		<xsl:with-param name="container" select="$container" />
		<xsl:with-param name="format">
			<xsl:text>/image/2/</xsl:text>
			<xsl:value-of select="concat($width, '/')" />
			<xsl:value-of select="concat($height, '/')" />
			<xsl:value-of select="$position" />
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="render-image-resize">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'3'" />
	<xsl:param name="container" select="''" />
	<xsl:param name="width" select="'$w'" />
	<xsl:param name="height" select="'0'" />

	<xsl:call-template name="render-image">
		<xsl:with-param name="image" select="$image" />
		<xsl:with-param name="alt" select="$alt" />
		<xsl:with-param name="class" select="$class" />
		<xsl:with-param name="factor" select="$factor" />
		<xsl:with-param name="container" select="$container" />
		<xsl:with-param name="format">
			<xsl:text>/image/1/</xsl:text>
			<xsl:value-of select="concat($width, '/')" />
			<xsl:value-of select="$height" />
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="render-image-fit">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'3'" />
	<xsl:param name="container" select="''" />
	<xsl:param name="width" select="'$w'" />
	<xsl:param name="height" select="'$h'" />

	<xsl:call-template name="render-image">
		<xsl:with-param name="image" select="$image" />
		<xsl:with-param name="alt" select="$alt" />
		<xsl:with-param name="class" select="$class" />
		<xsl:with-param name="factor" select="$factor" />
		<xsl:with-param name="container" select="$container" />
		<xsl:with-param name="format">
			<xsl:text>/image/4/</xsl:text>
			<xsl:value-of select="concat($width, '/')" />
			<xsl:value-of select="$height" />
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
