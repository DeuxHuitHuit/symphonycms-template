<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="menu-admin">
	<xsl:if test="/data/events/login-info/@logged-in = 'true'">
		<div id="menu-admin">
			<span><xsl:value-of select="/data/events/login-info/name" /></span>
			
			<span><xsl:text> - </xsl:text></span>
			
			<a data-action="full" href="/symphony/">Symphony</a>
			
			<xsl:if test="/data/events/login-info/@user-type = 'developer'">
				<a data-action="full" href="?debug">DEBUG</a>
			</xsl:if>
			
			<a data-action="full" href="/symphony/logout/">Déconnexion</a>
			
			<span><xsl:text> Cache: </xsl:text></span>
			
			<a data-action="full" href="?flush">Flush page</a>
			
			<a data-action="full" href="?flush=site">Flush site</a>
		</div>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
