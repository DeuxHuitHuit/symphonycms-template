<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:template match="erreurs/entry">
	<xsl:param name="code" />

	<section class="section-erreurs">
		<xsl:copy-of select="*[name() = concat('p', $code)]/*" />
	</section>
</xsl:template>

</xsl:stylesheet>