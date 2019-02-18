<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="schema-organization">
		<xsl:param name="phone" select="$config/organization-phone" />
		<xsl:param name="email" select="$config/organization-email" />
		<xsl:param name="name" select="$config/organization-name" />
		<xsl:param name="logo" select="$config/organization-logo" />
		<xsl:param name="logo-path">
			<xsl:if test="string-length($logo) != 0">
				<xsl:if test="string-length($logo/@path) != 0 and string-length($logo/filename) != 0">
					<xsl:value-of select="$root" />
					<xsl:text>/workspace</xsl:text>
					<xsl:value-of select="$logo/@path" />
					<xsl:text>/</xsl:text>
					<xsl:value-of select="$logo/filename" />
				</xsl:if>
			</xsl:if>
		</xsl:param>

		<script type="application/ld+json">
		{
			"@context": "http://schema.org",
			"@type": "Organization",
			"logo": "<xsl:value-of select="$logo-path" />",
			"url": "<xsl:value-of select="$root" />",
			"email": "<xsl:value-of select="translate($email, ',&quot;', '')" />",
			"name": "<xsl:value-of select="translate($name, ',&quot;', '')" />",
			"telephone": "<xsl:value-of select="translate($phone, ',&quot;', '')" />",
			"sameAs": [
			          "<xsl:value-of select="$config/facebook-url" />",
			          "<xsl:value-of select="$config/youtube-url" />",
			          "<xsl:value-of select="$config/linkedin-url" />",
			          "<xsl:value-of select="$config/twitter-url" />",
			          "<xsl:value-of select="$config/instagram-url" />",
			          "<xsl:value-of select="$config/vimeo-url" />"
			]
		}
		</script>

	</xsl:template>
</xsl:stylesheet>
