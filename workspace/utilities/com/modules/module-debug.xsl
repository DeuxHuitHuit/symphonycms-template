<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Debug Module -->
	<xsl:template name="module-debug" match="item" mode="module" priority="0">
		<xsl:param name="msg" select="'NOT FOUND'" />
		<xsl:param name="debug" select="@section" />
		<xsl:if test="/data/events/login-info/@user-type = 'developer'">
			<pre style="background-color:#f44336;color:white;padding:5px;border-radius:3px;text-align:center;margin:10px;">
				<xsl:value-of select="$msg" /><br/>
				<xsl:value-of select="$debug" />
			</pre>
		</xsl:if>
	</xsl:template>

	<!-- Debug Grid Item -->
	<xsl:template match="item" mode="grid-item" priority="0">
		<xsl:param name="debug" select="@section" />
		<xsl:if test="/data/events/login-info/@user-type = 'developer'">
			<pre style="background-color:#f44336;color:white;padding:5px;border-radius:3px;text-align:center;margin:10px;">
				<xsl:text>not found</xsl:text><br/>
				<xsl:value-of select="$debug" />
			</pre>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
