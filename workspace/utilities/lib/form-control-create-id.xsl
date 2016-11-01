<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:math="http://exslt.org/math"
	exclude-result-prefixes="math exsl">

<!-- TOOLS : form-control-create-field-id ======================================================-->
	<xsl:template name="form-control-create-field-id">
		<xsl:param name="name"/>

		<xsl:value-of select="concat('idm', translate(number(math:random() * 10000000), '.', ''), $name)"/>
	</xsl:template>
</xsl:stylesheet>
