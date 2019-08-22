<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:math="http://exslt.org/math"
	exclude-result-prefixes="math exsl">

<!-- COMPONENT : util-form-id -->
	<xsl:template name="util-form-id">
		<xsl:param name="prefix" select="'form-field'" />
		<xsl:param name="random-number" select="translate(number(math:random() * 10000000), '.', '')" />
		<xsl:param name="name" select="name/@handle" />

		<xsl:value-of select="concat($prefix, '-', $random-number, '-', $name)"/>
	</xsl:template>
</xsl:stylesheet>
