<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	exclude-result-prefixes="str">

<!-- 
	Everyone
		Url: Absolute url to the content being shared

	LinkedIn
		Title: Title of the page being shared
		Summary: Short description of the page
	
	Tweeter
		Text: Prepopulated message of the tweet
		Hashtags: Prepopulated, comma-separated hashtags of the tweet

	Email
		Subject: Title of the email
		Body: Content of the email
-->

<!-- COMPONENT: util-share-links-node -->
	<xsl:template name="util-share-links-node">
		<xsl:param name="url" select="$current-url" />
		<xsl:param name="title" />
		<xsl:param name="summary" />
		<xsl:param name="text" />
		<xsl:param name="hashtags" />
		<xsl:param name="subject" />
		<xsl:param name="body" />

		<xsl:variable name="encoded-url" select="str:encode-uri($url, true())" />
		<xsl:variable name="encoded-text" select="str:encode-uri($text, true())" />
		<xsl:variable name="encoded-hashtags" select="str:encode-uri($hashtags, true())" />
		<xsl:variable name="encoded-title" select="str:encode-uri($title, true())" />
		<xsl:variable name="encoded-summary" select="str:encode-uri($summary, true())" />
		<xsl:variable name="encoded-subject" select="str:encode-uri($subject, true())" />
		<xsl:variable name="encoded-body" select="str:encode-uri($body, true())" />

		<xsl:variable name="has-text" select="string-length($text) != 0" />
		<xsl:variable name="has-hashtags" select="string-length($hashtags) != 0" />
		<xsl:variable name="has-title" select="string-length($title) != 0" />
		<xsl:variable name="has-summary" select="string-length($summary) != 0" />
		<xsl:variable name="has-subject" select="string-length($subject) != 0" />
		<xsl:variable name="has-body" select="string-length($body) != 0" />

		<links>
			<!-- Facebook -->
			<item target="facebook">
				<url>
					<xsl:text>https://www.facebook.com/sharer/sharer.php?u=</xsl:text>
					<xsl:value-of select="$encoded-url" />
				</url>
			</item>
			<!-- Twitter -->
			<item target="twitter">
				<url>
					<xsl:text>https://twitter.com/intent/tweet?url=</xsl:text>
					<xsl:value-of select="$encoded-url" />
					<xsl:if test="$has-text">
						<xsl:text>&amp;text=</xsl:text>
						<xsl:value-of select="$encoded-text" />
					</xsl:if>
					<xsl:if test="$has-hashtags">
						<xsl:text>&amp;hashtags=</xsl:text>
						<xsl:value-of select="$encoded-hashtags" />
					</xsl:if>
				</url>
			</item>
			<!-- LinkedIn -->
			<item target="linkedin">
				<url>
					<xsl:text>https://www.linkedin.com/shareArticle?mini=true&amp;url=</xsl:text>
					<xsl:value-of select="$encoded-url" />
					<xsl:if test="$has-title">
						<xsl:text>&amp;title=</xsl:text>
						<xsl:value-of select="$encoded-title" />
					</xsl:if>
					<xsl:if test="$has-summary">
						<xsl:text>&amp;summary=</xsl:text>
						<xsl:value-of select="$encoded-summary" />
					</xsl:if>
				</url>
			</item>
			<!-- Email -->
			<item target="email">
				<url>
					<xsl:text>mailto:?body=</xsl:text>
					<xsl:choose>
						<xsl:when test="$has-body">
							<xsl:value-of select="$encoded-body" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$encoded-url" />
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="$has-subject">
						<xsl:text>&amp;subject</xsl:text>
						<xsl:value-of select="$encoded-subject" />
					</xsl:if>
				</url>
			</item>
		</links>


	</xsl:template>
</xsl:stylesheet>
