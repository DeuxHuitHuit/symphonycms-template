<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="menu-admin">
	<xsl:if test="/data/events/login-info/@logged-in = 'true'">
		<a id="top-admin" href="/symphony/">ADMIN</a>
		<xsl:if test="/data/events/login-info/@user-type = 'developer'">
			<a id="top-debug" href="?debug">debug</a>
		</xsl:if>
		<a id="top-logout" href="/symphony/logout/">déconnection</a>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>