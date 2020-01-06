<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master/ajax.xsl" />

<xsl:template match="data">
	<xsl:copy-of select="/data/events/form-dyn" />
</xsl:template>

</xsl:stylesheet>
