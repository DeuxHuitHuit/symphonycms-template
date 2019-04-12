<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

	<xsl:import href="generate-mock-data.xsl" />

<xsl:variable name="sym-data" select="/data" />
<xsl:variable name="mock-model" select="document('../../model.xml')" />
<xsl:variable name="mock-data-templates" select="document('../../fake/entities.xml')/root/fake-content"/>


<xsl:variable name="mock-data-text">
	<xsl:call-template name="generate-mock-data">
		<xsl:with-param name="model" select="$mock-model"/>
		<xsl:with-param name="entities" select="document('../../fake/entities.xml')/root/entities" />
		<xsl:with-param name="data-templates" select="$mock-data-templates" />
	</xsl:call-template>
</xsl:variable>

<xsl:variable name="data" select="exsl:node-set($mock-data-text)/data" />

</xsl:stylesheet>