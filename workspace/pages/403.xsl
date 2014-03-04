<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master/master.xsl" />
<xsl:import href="../utilities/lib/erreurs.xsl" />

<xsl:template match="data">
	<xsl:apply-templates select="erreurs/entry[1]" />
</xsl:template>

</xsl:stylesheet>