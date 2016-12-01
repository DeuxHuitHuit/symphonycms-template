<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="entry" mode="edit-btn">
	<xsl:call-template name="edit-btn" />
</xsl:template>

<xsl:template name="edit-btn">
	<xsl:param name="section" select="../section/@handle" />
	<xsl:param name="entry-id" select="@id" />
	<xsl:param name="text" select="'EDIT'" />
	<xsl:param name="wrap" select="'div'" />
	
	<xsl:if test="/data/events/login-info/@logged-in = 'true'">
		<xsl:element name="{$wrap}">
			<xsl:attribute name="class">edit-btn</xsl:attribute>
			
			<a href="/symphony/publish/{$section}/edit/{$entry-id}/" data-action="full">
				<xsl:value-of select="$text" />
			</a>
		</xsl:element>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
