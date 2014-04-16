<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="variables.xsl" />
<xsl:import href="../site-variables.xsl" />

<xsl:output method="xml"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no" />

<xsl:template match="/">
<ajax>
	<xsl:apply-templates select="data" />
</ajax>
</xsl:template>

</xsl:stylesheet>