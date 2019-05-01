<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt">

<!-- CORE-FUNCTION: content =====================================================================-->
	<xsl:template name="content">
		<xsl:param name="content" />
		<xsl:param name="lg" select="$url-language"/>
		
		<xsl:choose>
			<xsl:when test="exslt:object-type($content) = 'string' or exslt:object-type($content) = 'number'">
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
		<xsl:param name="g" select="''" />
		<xsl:param name="h" select="''" />
		<xsl:param name="i" select="''" />
		<xsl:param name="j" select="''" />
		<xsl:param name="k" select="''" />
		<xsl:param name="l" select="''" />
		<xsl:param name="m" select="''" />
		<xsl:param name="n" select="''" />
		<xsl:param name="o" select="''" />
		<xsl:param name="p" select="''" />
		<xsl:param name="q" select="''" />
		<xsl:param name="r" select="''" />
		<xsl:param name="s" select="''" />
		<xsl:param name="t" select="''" />
		<xsl:param name="u" select="''" />
		
		<xsl:variable name="temp-a">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$a" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-b">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$b" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-c">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$c" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-d">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$d" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-e">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$e" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-f">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$f" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-g">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$g" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-h">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$h" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-i">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$i" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-j">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$j" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-k">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$k" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-l">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$l" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-m">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$m" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-n">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$n" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-o">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$o" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-p">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$p" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-q">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$q" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-r">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$r" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-s">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$s" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-t">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$t" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="temp-u">
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$u" />
				<xsl:with-param name="lg" select="$lg" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="string-length($temp-a) != 0">
				<xsl:copy-of select="$temp-a" />
			</xsl:when>
			<xsl:when test="string-length($temp-b) != 0">
				<xsl:copy-of select="$temp-b" />
			</xsl:when>
			<xsl:when test="string-length($temp-c) != 0">
				<xsl:copy-of select="$temp-c" />
			</xsl:when>
			<xsl:when test="string-length($temp-d) != 0">
				<xsl:copy-of select="$temp-d" />
			</xsl:when>
			<xsl:when test="string-length($temp-e) != 0">
				<xsl:copy-of select="$temp-e" />
			</xsl:when>
			<xsl:when test="string-length($temp-f) != 0">
				<xsl:copy-of select="$temp-f" />
			</xsl:when>
			<xsl:when test="string-length($temp-g) != 0">
				<xsl:copy-of select="$temp-g" />
			</xsl:when>
			<xsl:when test="string-length($temp-h) != 0">
				<xsl:copy-of select="$temp-h" />
			</xsl:when>
			<xsl:when test="string-length($temp-i) != 0">
				<xsl:copy-of select="$temp-i" />
			</xsl:when>
			<xsl:when test="string-length($temp-j) != 0">
				<xsl:copy-of select="$temp-j" />
			</xsl:when>
			<xsl:when test="string-length($temp-k) != 0">
				<xsl:copy-of select="$temp-k" />
			</xsl:when>
			<xsl:when test="string-length($temp-l) != 0">
				<xsl:copy-of select="$temp-l" />
			</xsl:when>
			<xsl:when test="string-length($temp-m) != 0">
				<xsl:copy-of select="$temp-m" />
			</xsl:when>
			<xsl:when test="string-length($temp-n) != 0">
				<xsl:copy-of select="$temp-n" />
			</xsl:when>
			<xsl:when test="string-length($temp-o) != 0">
				<xsl:copy-of select="$temp-o" />
			</xsl:when>
			<xsl:when test="string-length($temp-p) != 0">
				<xsl:copy-of select="$temp-p" />
			</xsl:when>
			<xsl:when test="string-length($temp-q) != 0">
				<xsl:copy-of select="$temp-q" />
			</xsl:when>
			<xsl:when test="string-length($temp-r) != 0">
				<xsl:copy-of select="$temp-r" />
			</xsl:when>
			<xsl:when test="string-length($temp-s) != 0">
				<xsl:copy-of select="$temp-s" />
			</xsl:when>
			<xsl:when test="string-length($temp-t) != 0">
				<xsl:copy-of select="$temp-t" />
			</xsl:when>
			<xsl:when test="string-length($temp-u) != 0">
				<xsl:copy-of select="$temp-u" />
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
