<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt"
>

<xsl:template name="content">
	<xsl:param name="content" />
	
	<xsl:choose>
		<xsl:when test="exslt:object-type($content) = 'string'">
			<xsl:value-of select="$content" />
		</xsl:when>
		<xsl:when test="exslt:object-type($content) = 'RTF'">
			<xsl:copy-of select="$content"/>
		</xsl:when>
		<xsl:when test="exslt:object-type($content) = 'node-set' and count($content/*) = 0">
			<xsl:value-of select="$content" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy-of select="$content/*" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="default-value">
	<xsl:param name="a" select="''" />
	<xsl:param name="b" select="''" />
	<xsl:param name="c" select="''" />
	<xsl:param name="d" select="''" />
	<xsl:param name="e" select="''" />
	<xsl:param name="f" select="''" />
	
	<xsl:choose>
		<xsl:when test="string-length($a) != 0">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$a" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="string-length($b) != 0">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$b" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="string-length($c) != 0">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$c" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="string-length($d) != 0">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$d" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="string-length($e) != 0">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$e" />
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="string-length($f) != 0">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$f" />
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>