<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="exslt">

	<xsl:template name="schema-organization">
		<xsl:param name="url" select="$root" />
		<xsl:param name="logo">
			<xsl:call-template name="util-image-path">
				<xsl:with-param name="image" select="$config/logo" />
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="name" select="$config/name" />
		<xsl:param name="phone" select="$config/phone" />
		<xsl:param name="email" select="$config/email" />
		<xsl:param name="contact-type" select="'Customer service'" />

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
				"url": "<xsl:value-of select="$url" />",
				"logo": "<xsl:value-of select="$logo" />",
				"name": "<xsl:value-of select="$name" />",
				<xsl:if test="string-length($sameas) != 0">
				"sameAs": [
					<xsl:apply-templates select="exsl:node-set($sameas)" mode="sameas-item" />
				]
				</xsl:if>

				"contactPoint": [{
				  "@type": "ContactPoint",
				  "telephone": "<xsl:value-of select="$phone" />",
				  "email": "<xsl:value-of select="$email" />",
				  "url": "<xsl:value-of select="$url" />",
				  "contactType": "<xsl:value-of select="$contact-type" />"
				}]
			}
		</script>

	</xsl:template>

	<xsl:template match="item" mode="sameas-item">
		<xsl:value-of select="@url" />
		<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
	</xsl:template>

</xsl:stylesheet>
