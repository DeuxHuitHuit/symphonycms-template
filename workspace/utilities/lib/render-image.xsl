<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	exclude-result-prefixes="exslt str"
	>

<xsl:template name="render-image">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'3'" />
	<xsl:param name="ratio" select="''" />
	<xsl:param name="format" select="''" />
	<xsl:param name="container" select="''" />
	<xsl:param name="use-format" select="true()" />
	<xsl:param name="itemprop" select="''" />

	<!--img 
		src="/image/1/{$width}/{$height}{$image/@path}/{$image/filename}" 
		alt="{$alt}" -->
	
	<xsl:choose>
		<xsl:when test="exslt:object-type($image) = 'node-set' and contains($image/@type, 'svg')">
			<img src="/workspace{$image/@path}/{$image/filename}" alt="{$alt}" class="{$class}" />
		</xsl:when>
		<xsl:otherwise>
			<img alt="{$alt}">
				<xsl:attribute name="src">
					<xsl:call-template name="render-image-src">
						<xsl:with-param name="image" select="$image" />
						<xsl:with-param name="factor" select="$factor" />
						<xsl:with-param name="ratio" select="$ratio" />
						<xsl:with-param name="use-format" select="$use-format" />
					</xsl:call-template>
				</xsl:attribute>
				
				<xsl:if test="$use-format = true() and string-length($format) != 0 and exslt:object-type($image) = 'node-set'">
					<xsl:attribute name="data-src-format">
						<xsl:value-of select="$format" />
						<xsl:value-of select="$image/@path" />
						<xsl:text>/</xsl:text>
						<xsl:value-of select="$image/filename" />
					</xsl:attribute>
					
					<xsl:attribute name="data-original-src">
						<xsl:call-template name="render-image-src">
							<xsl:with-param name="image" select="$image" />
							<xsl:with-param name="use-format" select="false()" />
						</xsl:call-template>
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
				<xsl:if test="string-length($itemprop) != 0">
					<xsl:attribute name="itemprop">
						<xsl:value-of select="$itemprop" />
					</xsl:attribute>
				</xsl:if>
			</img>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="render-image-src">
	<xsl:param name="image" select="image" />
	<xsl:param name="factor" select="'3'" />
	<xsl:param name="ratio" select="''" />
	<xsl:param name="use-format" select="true()" />
	
	<xsl:variable name="parsed-ratio">
		<xsl:choose>
			<xsl:when test="string-length($ratio) = 0"></xsl:when>
			<xsl:when test="number($ratio) = $ratio">
				<xsl:value-of select="$ratio" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="ratio-tokens" select="str:tokenize($ratio, '/')" />
				<xsl:choose>
					<xsl:when test="count($ratio-tokens) = 2">
						<xsl:value-of select="number($ratio-tokens[1]) div number($ratio-tokens[2])" />
					</xsl:when>
					<xsl:otherwise>1</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:choose>
		<xsl:when test="exslt:object-type($image) = 'string' or (exslt:object-type($image) = 'node-set' and count($image/*) = 0)">
			<xsl:value-of select="$image" />
		</xsl:when>
		<xsl:when test="exslt:object-type($image) = 'node-set' and $use-format = false()">
			<xsl:text>/workspace</xsl:text>
			<xsl:value-of select="$image/@path" />
			<xsl:text>/</xsl:text>
			<xsl:value-of select="$image/filename" />
		</xsl:when>
		<xsl:when test="exslt:object-type($image) = 'node-set'">
			<xsl:variable name="width" select="round($image/meta/@width div $factor)" />
			<xsl:variable name="height">
				<xsl:choose>
					<xsl:when test="number($parsed-ratio) = $parsed-ratio">
						<xsl:value-of select="round(($image/meta/@width * number($parsed-ratio)) div $factor)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="round($image/meta/@height div $factor)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:text>/image/</xsl:text>
			<xsl:choose>
				<xsl:when test="number($parsed-ratio) = $parsed-ratio">2</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
			<xsl:text>/</xsl:text>
			<xsl:value-of select="$width" />
			<xsl:text>/</xsl:text>
			<xsl:value-of select="$height" />
			<xsl:if test="number($parsed-ratio) = $parsed-ratio">/5</xsl:if>
			<xsl:value-of select="$image/@path" />
			<xsl:text>/</xsl:text>
			<xsl:value-of select="$image/filename" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$image" />
		</xsl:otherwise>
	</xsl:choose>
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

<xsl:template name="render-image-crop-ratio">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'8'" />
	<xsl:param name="ratio" select="''" />
	<xsl:param name="container" select="''" />
	<xsl:param name="position" select="'5'" />

	<xsl:call-template name="render-image">
		<xsl:with-param name="image" select="$image" />
		<xsl:with-param name="alt" select="$alt" />
		<xsl:with-param name="class" select="$class" />
		<xsl:with-param name="factor" select="$factor" />
		<xsl:with-param name="ratio" select="$ratio" />
		<xsl:with-param name="container" select="$container" />
		<xsl:with-param name="format">
			<xsl:text>/image/2/$w/$</xsl:text>
			<xsl:value-of select="$ratio" />
			<xsl:text>/</xsl:text>
			<xsl:value-of select="$position" />
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="render-image-crop-34">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'8'" />
	<xsl:param name="container" select="''" />
	<xsl:param name="position" select="'5'" />

	<xsl:call-template name="render-image-crop-ratio">
		<xsl:with-param name="image" select="$image" />
		<xsl:with-param name="alt" select="$alt" />
		<xsl:with-param name="class" select="$class" />
		<xsl:with-param name="factor" select="$factor" />
		<xsl:with-param name="ratio" select="'3/4'" />
		<xsl:with-param name="container" select="$container" />
		<xsl:with-param name="position" select="$position" />
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

<!-- background-image -->
<xsl:template name="render-image-bg">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'3'" />
	<xsl:param name="container" select="''" />
	<xsl:param name="width" select="'$w'" />
	<xsl:param name="height" select="'0'" />
	<xsl:param name="style" select="''" />
	<xsl:param name="position" select="'50% 50%'" />
	<xsl:param name="size" select="''" />
	
	<xsl:variable name="c">
		<xsl:text>jit-image-bg</xsl:text>
		<xsl:if test="string-length($class) != 0">
			<xsl:value-of select="concat(' ', $class)" />
		</xsl:if>
	</xsl:variable>

	<xsl:variable name="img-path">
		<xsl:text>/image/1/</xsl:text>
		<xsl:value-of select="round($image/meta/@width div $factor)" />
		<xsl:text>/</xsl:text>
		<xsl:value-of select="round($image/meta/@height div $factor)" />
		<xsl:value-of select="$image/@path" />
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$image/filename" />
	</xsl:variable>

	<xsl:variable name="pos">
		<xsl:choose>
			<xsl:when test="string-length($position) != 0">
				<xsl:value-of select="$position" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>50% 50%</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<div class="">
		<xsl:attribute name="style">
			<xsl:text>background-image: url('</xsl:text>
			<xsl:value-of select="$img-path" />
			<xsl:text>');</xsl:text>
			<xsl:text>background-repeat: no-repeat;</xsl:text>
			<xsl:value-of select="concat('background-position: ', $pos, ';')" />
			<xsl:if test="string-length($size) != 0">

				<xsl:value-of select="concat('background-size: ', $size, ';')" />
			</xsl:if>
			<xsl:if test="string-length($style) != 0">
				<xsl:value-of select="concat(' ', $style)" />
			</xsl:if>
		</xsl:attribute>
		<xsl:attribute name="class">
			<xsl:value-of select="$c" />
		</xsl:attribute>

		<xsl:variable name="img-c">
			<xsl:text>jit-image-bg-src</xsl:text>
		</xsl:variable>
		<xsl:call-template name="render-image">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="class" select="$img-c" />
			<xsl:with-param name="factor" select="$factor" />
			<xsl:with-param name="container" select="$container" />
			<xsl:with-param name="format">
				<xsl:text>/image/1/</xsl:text>
				<xsl:value-of select="concat($width, '/')" />
				<xsl:value-of select="$height" />
			</xsl:with-param>
		</xsl:call-template>
	</div>
</xsl:template>

<xsl:template name="render-image-bg-cover">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'3'" />
	<xsl:param name="container" select="''" />
	<xsl:param name="width" select="'$w'" />
	<xsl:param name="height" select="'0'" />
	<xsl:param name="style" select="''" />
	<xsl:param name="position" select="'50% 50%'" />
	
	<xsl:call-template name="render-image-bg">
		<xsl:with-param name="image" select="$image" />
		<xsl:with-param name="alt" select="$alt" />
		<xsl:with-param name="class" select="$class" />
		<xsl:with-param name="factor" select="$factor" />
		<xsl:with-param name="container" select="$container" />
		<xsl:with-param name="width" select="$width" />
		<xsl:with-param name="height" select="$height" />
		<xsl:with-param name="style" select="$style" />
		<xsl:with-param name="position" select="$position" />
		<xsl:with-param name="size" select="'cover'" />
	</xsl:call-template>
</xsl:template>
	
<xsl:template name="render-image-bg-contain">
	<xsl:param name="image" select="image" />
	<xsl:param name="alt" select="titre" />
	<xsl:param name="class" select="''" />
	<xsl:param name="factor" select="'3'" />
	<xsl:param name="container" select="''" />
	<xsl:param name="width" select="'$w'" />
	<xsl:param name="height" select="'0'" />
	<xsl:param name="style" select="''" />
	<xsl:param name="position" select="'50% 50%'" />
	
	<xsl:call-template name="render-image-bg">
		<xsl:with-param name="image" select="$image" />
		<xsl:with-param name="alt" select="$alt" />
		<xsl:with-param name="class" select="$class" />
		<xsl:with-param name="factor" select="$factor" />
		<xsl:with-param name="container" select="$container" />
		<xsl:with-param name="width" select="$width" />
		<xsl:with-param name="height" select="$height" />
		<xsl:with-param name="style" select="$style" />
		<xsl:with-param name="position" select="$position" />
		<xsl:with-param name="size" select="'contain'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
