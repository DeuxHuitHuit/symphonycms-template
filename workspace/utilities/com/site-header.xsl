<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="site-header">
	<header>
		<a href="/">
		<h2>
			<!-- Logo -->
			<img src="/workspace/assets/img/logo.png" />
			<!-- Nom du site -->
			<span><xsl:value-of select="$metas/site-titre" /></span>
		</h2>
		</a>
	</header>
</xsl:template>

</xsl:stylesheet>