<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="pages-erreurs/entry">
	<h1>
		<xsl:value-of select="titre" />
	</h1>
 	<xsl:copy-of select="texte/*" />
</xsl:template>

</xsl:stylesheet>