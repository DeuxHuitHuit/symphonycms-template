<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	exclude-result-prefixes="exslt str">

<!-- render-image -->
	<xsl:template name="render-image">
		<xsl:param name="image" select="image" />
		<xsl:param name="factor" select="'3'" />
		<xsl:param name="ratio" select="''" />
		<xsl:param name="format" select="''" />
		<xsl:param name="use-src" select="true()" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="attr" />

		<xsl:variable name="computed-attr">
			<xsl:choose>
				<!-- Svg File -->
				<xsl:when test="exslt:object-type($image) = 'node-set' and (contains($image/@type, 'svg') or contains($image/@type, 'gif') or contains($image/@type, 'tiff'))">
					<set src="/workspace{$image/@path}/{$image/filename}" />
				</xsl:when>

				<!-- Img File -->
				<xsl:otherwise>
					<xsl:if test="$use-src">
						<set>
							<xsl:attribute name="src">
								<xsl:call-template name="render-image-src">
									<xsl:with-param name="image" select="$image" />
									<xsl:with-param name="factor" select="$factor" />
									<xsl:with-param name="ratio" select="$ratio" />
									<xsl:with-param name="use-format" select="string-length($format) != 0" />
								</xsl:call-template>
							</xsl:attribute>
						</set>
					</xsl:if>

					<xsl:if test="string-length($format) != 0 and exslt:object-type($image) = 'node-set' and count($image/filename) = 1">
						<!-- Format -->
						<set data-src-format="{$format}{$image/@path}/{$image/filename}" />

						<!-- Path original source -->
						<set>
							<xsl:attribute name="data-src-original" >
								<xsl:call-template name="render-image-src">
									<xsl:with-param name="image" select="$image" />
									<xsl:with-param name="use-format" select="false()" />
								</xsl:call-template>
							</xsl:attribute>
						</set>
					</xsl:if>
					
					<!-- Amp minimal parameter -->
					<xsl:if test="/data/params/amp = 'Yes'">
						<set width="{$image/meta/@width}" />
						<set height="{$image/meta/@height}" />
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>

			<!-- Process Alt -->
			<xsl:choose>
				<xsl:when test="string-length($alt) != 0">
					<set alt="~'{$alt}'" />
				</xsl:when>
				<xsl:when test="$use-alt-fallback = true()">
					<xsl:variable name="auto-alt">
						<xsl:call-template name="default-image-alt-selector" />
					</xsl:variable>
					<set alt="~'{$auto-alt}'" />
				</xsl:when>
				<xsl:otherwise>
					<!-- Set Empty alt -->
					<set alt="" />
				</xsl:otherwise>
			</xsl:choose>

			<xsl:copy-of select="$attr" />
		</xsl:variable>

		<!-- Reel image element -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="'img'"/>
			<xsl:with-param name="attr" select="$computed-attr" />
		</xsl:call-template>
	</xsl:template>

<!-- render-image-crop -->
	<xsl:template name="render-image-crop">
		<xsl:param name="image" select="image" />
		<xsl:param name="factor" select="'3'" />
		<xsl:param name="width" select="'$w'" />
		<xsl:param name="height" select="'$h'" />
		<xsl:param name="position" select="'5'" />
		<xsl:param name="use-src" select="true()" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="attr" />

		<xsl:variable name="computed-format" >
			<xsl:text>/image/2/</xsl:text>
			<xsl:value-of select="concat($width, '/')" />
			<xsl:value-of select="concat($height, '/')" />
			<xsl:value-of select="$position" />
		</xsl:variable>

		<xsl:call-template name="render-image">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="factor" select="$factor" />
			<xsl:with-param name="format" select="$computed-format" />
			<xsl:with-param name="use-src" select="$use-src" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="use-alt-fallback" select="$use-alt-fallback" />
			<xsl:with-param name="attr" select="$attr" />
		</xsl:call-template>
	</xsl:template>

<!-- render-image-crop-ratio -->
	<xsl:template name="render-image-crop-ratio">
		<xsl:param name="image" select="image" />
		<xsl:param name="factor" select="'8'" />
		<xsl:param name="ratio" select="''" />
		<xsl:param name="position" select="'5'" />
		<xsl:param name="use-src" select="true()" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="attr" />
		
		<xsl:variable name="computed-format">
			<xsl:text>/image/2/$w/$</xsl:text>
			<xsl:value-of select="$ratio" />
			<xsl:text>/</xsl:text>
			<xsl:value-of select="$position" />
		</xsl:variable>

		<xsl:call-template name="render-image">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="factor" select="$factor" />
			<xsl:with-param name="ratio" select="$ratio" />
			<xsl:with-param name="format" select="$computed-format" />
			<xsl:with-param name="use-src" select="$use-src" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="use-alt-fallback" select="$use-alt-fallback" />
			<xsl:with-param name="attr" select="$attr" />
		</xsl:call-template>
	</xsl:template>

<!-- render-image-crop-3_4 -->
	<xsl:template name="render-image-crop-3_4">
		<xsl:param name="image" select="image" />
		<xsl:param name="factor" select="'8'" />
		<xsl:param name="position" select="'5'" />
		<xsl:param name="use-src" select="true()" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="attr" />

		<xsl:call-template name="render-image-crop-ratio">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="factor" select="$factor" />
			<xsl:with-param name="ratio" select="'3/4'" />
			<xsl:with-param name="position" select="$position" />
			<xsl:with-param name="use-src" select="$use-src" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="use-alt-fallback" select="$use-alt-fallback" />
			<xsl:with-param name="attr" select="$attr" />
		</xsl:call-template>
	</xsl:template>

<!-- render-image-crop-9_16 -->
	<xsl:template name="render-image-crop-9_16">
		<xsl:param name="image" select="image" />
		<xsl:param name="factor" select="'8'" />
		<xsl:param name="position" select="'5'" />
		<xsl:param name="use-src" select="true()" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="attr" />

		<xsl:call-template name="render-image-crop-ratio">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="factor" select="$factor" />
			<xsl:with-param name="ratio" select="'9/16'" />
			<xsl:with-param name="position" select="$position" />
			<xsl:with-param name="use-src" select="$use-src" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="use-alt-fallback" select="$use-alt-fallback" />
			<xsl:with-param name="attr" select="$attr" />
		</xsl:call-template>
	</xsl:template>
	
<!-- render-image-resize -->
	<xsl:template name="render-image-resize">
		<xsl:param name="image" select="image" />
		<xsl:param name="width" select="'$w'" />
		<xsl:param name="height" select="'0'" />
		<xsl:param name="factor" select="'3'" />
		<xsl:param name="use-src" select="true()" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="attr" />

		<xsl:variable name="computed-format">
			<xsl:text>/image/1/</xsl:text>
			<xsl:value-of select="concat($width, '/')" />
			<xsl:value-of select="$height" />
		</xsl:variable>

		<xsl:variable name="computed-attr">
			<!-- Add basic class -->
			<xsl:choose>
				<xsl:when test="$width = '$w' and $height != '$h'">
					<add class="block width-full" />
				</xsl:when>
				<xsl:when test="$height = '$h' and $width != '$w'">
					<add class="block height-full" />
				</xsl:when>
			</xsl:choose>

			<xsl:copy-of select="$attr" />
		</xsl:variable>

		<xsl:call-template name="render-image">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="factor" select="$factor" />
			<xsl:with-param name="format" select="$computed-format" />
			<xsl:with-param name="use-src" select="$use-src" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="use-alt-fallback" select="$use-alt-fallback" />
			<xsl:with-param name="attr" select="$computed-attr" />
		</xsl:call-template>
	</xsl:template>

<!-- render-image-fit -->
	<xsl:template name="render-image-fit">
		<xsl:param name="image" select="image" />
		<xsl:param name="factor" select="'3'" />
		<xsl:param name="width" select="'$w'" />
		<xsl:param name="height" select="'$h'" />
		<xsl:param name="use-src" select="true()" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="attr" />

		<xsl:variable name="computed-format">
			<xsl:text>/image/4/</xsl:text>
			<xsl:value-of select="concat($width, '/')" />
			<xsl:value-of select="$height" />
		</xsl:variable>

		<xsl:call-template name="render-image">
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="factor" select="$factor" />
			<xsl:with-param name="format" select="$computed-format" />
			<xsl:with-param name="use-src" select="$use-src" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="use-alt-fallback" select="$use-alt-fallback" />
			<xsl:with-param name="attr" select="$attr"/>
		</xsl:call-template>
	</xsl:template>

<!-- render-image-bg -->
	<xsl:template name="render-image-bg">
		<xsl:param name="position" />
		<xsl:param name="size" />
		<xsl:param name="width" select="'$w'" />
		<xsl:param name="height" select="'0'" />
		<xsl:param name="image" select="image" />
		<xsl:param name="image-attr" />
		<xsl:param name="factor" select="'1'" />
		<xsl:param name="element" select="'figure'" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="with-initial-image" select="true()" />
		<xsl:param name="attr" />
		<xsl:param name="format" >
			<xsl:text>/image/1/</xsl:text>
			<xsl:value-of select="concat($width, '/')" />
			<xsl:value-of select="$height" />
		</xsl:param>
		
	<!-- Computed value -->
		<xsl:variable name="img-path">
			<xsl:choose>
				<xsl:when test="exslt:object-type($image) = 'node-set' and (contains($image/@type, 'svg') or contains($image/@type, 'gif') or contains($image/@type, 'tiff'))">
					<xsl:value-of select="concat('/workspace', $image/@path, '/', $image/filename)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>/image/1/</xsl:text>
					<xsl:value-of select="round($image/meta/@width div $factor)" />
					<xsl:text>/</xsl:text>
					<xsl:value-of select="round($image/meta/@height div $factor)" />
					<xsl:value-of select="$image/@path" />
					<xsl:text>/</xsl:text>
					<xsl:value-of select="$image/filename" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

	<!-- Computed attributes -->
		<!-- Component -->
		<xsl:variable name="computed-attr">
			<!-- Add default no-repeat bg class -->
			<add class="bg-no-repeat" />

			<!-- Add background-image -->
			<xsl:if test="$with-initial-image">
				<add style="~'background-image:url('{$img-path}');'" />
			</xsl:if>

			<!-- Style: background-position if specified -->
			<xsl:if test="string-length($position) != 0">
				<add style="~'background-position:{$position};'" />
			</xsl:if>

			<!-- Style: background-size if specified -->
			<xsl:if test="string-length($size) != 0">
				<add style="~'background-size:{$size};'" />
			</xsl:if>

			<!-- Js class for auto-jit-image -->
			<add class="jit-image-bg" />

			<!-- External attr -->
			<xsl:copy-of select="$attr"/>

			<!-- Component name -->
			<add dev-core="render-image-bg" />
		</xsl:variable>

		<!-- image -->
		<xsl:variable name="computed-image-attr">
			<!-- Core JS Class for jit image -->
			<add class="jit-image-bg-src display-none" />
			<xsl:copy-of select="$image-attr" />
			<add dev-core-element="image" />
		</xsl:variable>

	<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$element"/>
			<xsl:with-param name="attr" select="$computed-attr"/>
			<xsl:with-param name="content">
				
				<xsl:call-template name="render-image">
					<xsl:with-param name="attr" select="$computed-image-attr" />
					<xsl:with-param name="image" select="$image" />
					<xsl:with-param name="factor" select="$factor" />
					<xsl:with-param name="format" select="$format" />
					<xsl:with-param name="use-src" select="false()" />
					<xsl:with-param name="alt" select="$alt" />
					<xsl:with-param name="use-alt-fallback" select="$use-alt-fallback" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!-- render-image-bg-cover -->
	<xsl:template name="render-image-bg-cover">
		<xsl:param name="position" select="'50% 50%'" />
		<xsl:param name="width" select="'$w'" />
		<xsl:param name="height" select="'0'" />
		<xsl:param name="image" select="image" />
		<xsl:param name="image-attr" />
		<xsl:param name="factor" select="'3'" />
		<xsl:param name="element" select="'figure'" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="with-initial-image" select="true()" />
		<xsl:param name="attr" />
		<xsl:param name="format" >
			<xsl:text>/image/1/</xsl:text>
			<xsl:value-of select="concat($width, '/')" />
			<xsl:value-of select="$height" />
		</xsl:param>

		<xsl:call-template name="render-image-bg">
			<xsl:with-param name="position" select="$position" />
			<xsl:with-param name="size" select="'cover'" />
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="image-attr" select="$image-attr" />
			<xsl:with-param name="element" select="$element" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="factor" select="$factor" />
			<xsl:with-param name="width" select="$width" />
			<xsl:with-param name="height" select="$height" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="use-alt-fallback" select="$use-alt-fallback" />
			<xsl:with-param name="format" select="$format" />
			<xsl:with-param name="with-initial-image" select="$with-initial-image" />
		</xsl:call-template>
	</xsl:template>
	
<!-- render-image-bg-contain -->
	<xsl:template name="render-image-bg-contain">
		<xsl:param name="position" select="'50% 50%'" />
		<xsl:param name="width" select="'$w'" />
		<xsl:param name="height" select="'0'" />
		<xsl:param name="image" select="image" />
		<xsl:param name="image-attr" />
		<xsl:param name="factor" select="'3'" />
		<xsl:param name="element" select="'figure'" />
		<xsl:param name="alt" select="''" />
		<xsl:param name="use-alt-fallback" select="true()" />
		<xsl:param name="with-initial-image" select="true()" />
		<xsl:param name="attr" />

		<xsl:call-template name="render-image-bg">
			<xsl:with-param name="position" select="$position" />
			<xsl:with-param name="size" select="'contain'" />
			<xsl:with-param name="image" select="$image" />
			<xsl:with-param name="image-attr" select="$image-attr" />
			<xsl:with-param name="element" select="$element" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="factor" select="$factor" />
			<xsl:with-param name="width" select="$width" />
			<xsl:with-param name="height" select="$height" />
			<xsl:with-param name="alt" select="$alt" />
			<xsl:with-param name="use-alt-fallback" select="$use-alt-fallback" />
			<xsl:with-param name="with-initial-image" select="$with-initial-image" />
		</xsl:call-template>
	</xsl:template>

<!-- render-image-src -->
	<xsl:template name="render-image-src">
		<xsl:param name="image" select="image" />
		<xsl:param name="factor" select="'3'" />
		<xsl:param name="ratio" select="''" />
		<xsl:param name="use-format" select="true()" />
		
		<xsl:variable name="parsed-ratio">
			<xsl:choose>
				<!-- No ratio -->
				<xsl:when test="string-length($ratio) = 0"></xsl:when>
				<!-- Numeric ratio -->
				<xsl:when test="number($ratio) = $ratio">
					<xsl:value-of select="$ratio" />
				</xsl:when>
				<!-- Fractionnal ratio -->
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
				
				<!-- Create URL -->
				<xsl:text>/image/</xsl:text>
				<xsl:choose>
					<xsl:when test="number($parsed-ratio) = $parsed-ratio">2</xsl:when>
					<xsl:otherwise>1</xsl:otherwise>
				</xsl:choose>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$width" />
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$height" />

				<xsl:if test="number($parsed-ratio) = $parsed-ratio">
					<xsl:text >/5</xsl:text>
				</xsl:if>

				<xsl:value-of select="$image/@path" />
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$image/filename" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$image" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- default-image-alt-selector -->
	<xsl:template name="default-image-alt-selector">
		<xsl:call-template name="default-value">
			<xsl:with-param name="a" select="image-alt" />
			<xsl:with-param name="b" select="image-credit" />
			<xsl:with-param name="c" select="alt" />
			<xsl:with-param name="d" select="titre" />
			<xsl:with-param name="e" select="title" />
			<xsl:with-param name="f" select="nom" />
			<xsl:with-param name="g" select="name" />
			<xsl:with-param name="h" select="legende" />
			<xsl:with-param name="i" select="legend" />
			<xsl:with-param name="j" select="caption" />
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
