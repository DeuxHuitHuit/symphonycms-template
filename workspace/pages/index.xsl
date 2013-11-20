<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master/master.xsl" />

<xsl:template match="data">
	<h1><xsl:value-of select="$page-title"/></h1>
</xsl:template>

</xsl:stylesheet>