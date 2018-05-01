<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="schema-contact">
		<xsl:param name="name" select="''" />
		<xsl:param name="phone" select="''" />
		<xsl:param name="email" select="''" />
		<xsl:param name="contact-type" select="''" />
		<xsl:param name="service-type" select="''" />

		<script type="application/ld+json">
		{
		  "@context": "http://schema.org",
		  "@type": "Organization",
		  "contactPoint": [
			{ "@type": "ContactPoint",
			  "name": "<xsl:value-of select="translate($name, ',&quot;', '')" />",
			  "telephone": "<xsl:value-of select="translate($phone, ',&quot;', '')" />",
			  "email": "<xsl:value-of select="translate($email, ',&quot;', '')" />",
			  "contactType": "<xsl:value-of select="translate($conteacttype, ',&quot;', '')" />",
			  "serviceType": "<xsl:value-of select="translate($service-type, ',&quot;', '')" />"
			}
		  ]
		}
		</script>
	</xsl:template>
</xsl:stylesheet>
