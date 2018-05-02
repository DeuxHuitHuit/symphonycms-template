<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- 
	This shema will require you to work a bit.
	You need to provide a list of node like this one...

	<item>
		<name></name>
		<url></url>
	</item>

	... using exslt:node-set($whatever)/item
	as the $items param.

 -->
	<xsl:template name="schema-breadcrumblist">
		<xsl:param name="items" />

		<xsl:if test="$items">
			<script type="application/ld+json">
			{
			  "@context": "http://schema.org",
			  "@type": "BreadcrumbList",
			  "itemListElement": [
			  <xsl:apply-templates select="$items" mode="schema-breadcrumblist-item" />
			  ]
			}
			</script>
		</xsl:if>
	</xsl:template>

	<xsl:template name="schema-breadcrumblist-item" match="*" mode="schema-breadcrumblist-item">
		<xsl:param name="name" select="name" />
		<xsl:param name="url" select="url" />
		{
		  "@type": "ListItem",
		  "position": <xsl:value-of select="position()" />,
		  "item": {
		    "@id": "<xsl:value-of select="$url" />",
		    "name": "<xsl:value-of select="translate($name, ',&quot;', '')" />"
		  }
		}<xsl:if test="position() != last()">,</xsl:if>
	</xsl:template>

</xsl:stylesheet>
