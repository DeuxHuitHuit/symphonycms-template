<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt">

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

		<xsl:variable name="sameas">
			<xsl:if test="string-length($config/facebook-url) != 0">
				<item url="$config/facebook-url" />
			</xsl:if>
			<xsl:if test="string-length($config/youtube-url) != 0">
				<item url="$config/youtube-url" />
			</xsl:if>
			<xsl:if test="string-length($config/linkedin-url) != 0">
				<item url="$config/linkedin-url" />
			</xsl:if>
			<xsl:if test="string-length($config/twitter-url) != 0">
				<item url="$config/twitter-url" />
			</xsl:if>
			<xsl:if test="string-length($config/instagram-url) != 0">
				<item url="$config/instagram-url" />
			</xsl:if>
			<xsl:if test="string-length($config/vimeo-url) != 0">
				<item url="$config/vimeo-url" />
			</xsl:if>
		</xsl:variable>		

		<script type="application/ld+json">
		{
			"@context": "http://schema.org",
			"@type": "Organization",
			"logo": "<xsl:value-of select="$logo-path" />",
			"url": "<xsl:value-of select="$root" />",
			"email": "<xsl:value-of select="translate($email, ',&quot;', '')" />",
			"name": "<xsl:value-of select="translate($name, ',&quot;', '')" />",
			"telephone": "<xsl:value-of select="translate($phone, ',&quot;', '')" />",

			<xsl:if test="string-length($sameas)">
				"sameAs": [
					<xsl:apply-templates select="exsl:node-set($sameas)" mode="sameas-item" />
					]
			</xsl:if>
		}
		</script>

	</xsl:template>

	<xsl:template match="item" mode="sameas-item">
		<xsl:value-of select="@url" />
		<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
	</xsl:template>

</xsl:stylesheet>
