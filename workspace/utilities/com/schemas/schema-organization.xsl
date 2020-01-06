<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="schema-organization">
		<xsl:param name="url" select="$root" />
		<xsl:param name="logo">
			<xsl:call-template name="util-image-path">
				<xsl:with-param name="image" select="$organization/logo" />
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="name" select="$organization/name" />
		<xsl:param name="phone" select="$organization/phone" />
		<xsl:param name="email" select="$organization/email" />
		<xsl:param name="contacttype" select="$organization/contact-type/item[1]" />

		<script type="application/ld+json">
		{
			"@context": "http://schema.org",
			"@type": "Organization",
			"url": "<xsl:value-of select="$url" />",
			"logo": {
			  "@type": "ImageObject",
			  "url": "<xsl:value-of select="$logo" />"
			},
			"name": "<xsl:value-of select="$name" />",
			"contactPoint": [{
			  "@type": "ContactPoint",
			  "telephone": "<xsl:value-of select="$phone" />",
			  "email": "<xsl:value-of select="$email" />",
			  "url": "<xsl:value-of select="$url" />",
			  "contactType": "<xsl:value-of select="$contacttype" />"
			}]
		}
		</script>

	</xsl:template>
</xsl:stylesheet>