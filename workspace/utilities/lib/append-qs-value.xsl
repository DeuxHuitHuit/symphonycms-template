<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

<!-- CORE-FUNCTION: append-qs-value =============================================================-->
	<xsl:template name="append-qs-value">
		<xsl:param name="url" />
		<xsl:param name="value" />

	<!-- STRUCTURE															 -->
		<xsl:value-of select="$url" />

		<xsl:if test="string-length($value) != 0">

			<xsl:if test="contains($value, '=') = false()">
				<xsl:message>
					<xsl:text>Error when calling append-qs-value: A Query string value must contain an = sign. Value received : </xsl:text>
					<xsl:value-of select="$value" />
				</xsl:message>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="contains($url, '?')">
					<xsl:text>&amp;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>?</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="$value" />
		</xsl:if>
	<!--																	/-->
	</xsl:template>

<!-- CORE-FUNCTION: append-qs-values ============================================================-->
	<xsl:template name="append-qs-values">
		<xsl:param name="url" />
		<xsl:param name="values" />

		<xsl:variable name="valuesNode" select="exsl:node-set($values)" />

		<xsl:choose>
			<xsl:when test="count($valuesNode/*[name() = 'value']) != 0">

				<!-- Start recursion with the first one -->
				<xsl:call-template name="append-qs-values-rec">
					<xsl:with-param name="url" select="$url"/>
					<xsl:with-param name="value" select="$valuesNode/*[name() = 'value'][1]" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>

				<!-- Output directly the url -->
				<xsl:value-of select="$url" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- CORE-TOOLS-FUNCTION: append-qs-values-rec ==================================================-->
	<xsl:template name="append-qs-values-rec">
		<xsl:param name="url" />
		<xsl:param name="value" />
		
		<!-- Check if we have a sibling value -->
		<xsl:variable name="has-sibling" select="count($value/following-sibling::value) != 0" />

		<xsl:choose>
			<xsl:when test="$has-sibling">
				<!-- Continu recursion -->
				<xsl:variable name="next-value" select="$value/following-sibling::value[1]" />

				<!-- call recursif with next-value -->
				<xsl:call-template name="append-qs-values-rec">
					<xsl:with-param name="url">

						<!-- Append current value to the url -->
						<xsl:call-template name="append-qs-value">
							<xsl:with-param name="url" select="$url"/>
							<xsl:with-param name="value" select="$value/@content" />
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="value" select="$next-value" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				
				<!-- Last Run. Render final url -->
				<xsl:call-template name="append-qs-value">
					<xsl:with-param name="url" select="$url"/>
					<xsl:with-param name="value" select="$value/@content" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
