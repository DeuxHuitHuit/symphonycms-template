<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="schema-organization">
		<xsl:param name="address" select="''" />
		<xsl:param name="region" select="''" />
		<xsl:param name="country" select="''" />
		<xsl:param name="postal-code" select="''" />
		<xsl:param name="phone" select="''" />
		<xsl:param name="email" select="''" />
		<xsl:param name="name" select="''" />

		<script type="application/ld+json">
		{
			"@context": "http://schema.org",
			"@type": "Organization",
			"address": {
			"@type": "PostalAddress",
			"addressLocality": "<xsl:value-of select="translate(concat($region, ' ',$country), ',&quot;', '')" />",
			"postalCode": "<xsl:value-of select="translate($postal-code, ',&quot;', '')" />",
			"streetAddress": "<xsl:value-of select="translate($address, ',&quot;', '')" />"
			},
			"email": "<xsl:value-of select="translate($email, ',&quot;', '')" />",
			"name": "<xsl:value-of select="translate($name, ',&quot;', '')" />",
			"telephone": "<xsl:value-of select="translate($phone, ',&quot;', '')" />"
		}
		</script>

	</xsl:template>
</xsl:stylesheet>
