<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt">

<!-- CORE-FUNCTION: content =====================================================================-->
	<xsl:template name="content">
		<xsl:param name="content" />
		<xsl:param name="lg" select="$url-language"/>
		
		<xsl:choose>
			<xsl:when test="exslt:object-type($content) = 'string'">
				<xsl:value-of select="$content" />
			</xsl:when>
			<xsl:when test="exslt:object-type($content) = 'RTF'">
				<xsl:copy-of select="$content"/>
			</xsl:when>
			<xsl:when test="exslt:object-type($content) = 'node-set'">
				<xsl:choose>
					<xsl:when test="count($content/item) != 0 and string-length($content/item[@lang=$lg]) != 0">
						<xsl:value-of select="$content/item[@lang=$lg]" />
					</xsl:when>
					<xsl:when test="count($content/item) != 0">
						<xsl:value-of select="$content/item[1]" />
					</xsl:when>
					<xsl:when test="count($content/*) != 0">
						<xsl:copy-of select="$content/*" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$content" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$content/*" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- CORE-FUNCTION: default-value ===============================================================-->
	<!-- TODO: Refactor to be used like this
		<xsl:call-template name="default-value">
			<xsl:with-param name="values">
				<value><xsl:value-of select="nothing" /></value>
				<value>Default value</value>
			</xsl:with-param>
		</xsl:call-template>
	-->
	<xsl:template name="default-value">
		<xsl:param name="lg" select="$url-language"/>
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
					<xsl:with-param name="lg" select="$lg" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="string-length($b) != 0">
				<xsl:call-template name="content">
					<xsl:with-param name="content" select="$b" />
					<xsl:with-param name="lg" select="$lg" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="string-length($c) != 0">
				<xsl:call-template name="content">
					<xsl:with-param name="content" select="$c" />
					<xsl:with-param name="lg" select="$lg" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="string-length($d) != 0">
				<xsl:call-template name="content">
					<xsl:with-param name="content" select="$d" />
					<xsl:with-param name="lg" select="$lg" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="string-length($e) != 0">
				<xsl:call-template name="content">
					<xsl:with-param name="content" select="$e" />
					<xsl:with-param name="lg" select="$lg" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="string-length($f) != 0">
				<xsl:call-template name="content">
					<xsl:with-param name="content" select="$f" />
					<xsl:with-param name="lg" select="$lg" />
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
