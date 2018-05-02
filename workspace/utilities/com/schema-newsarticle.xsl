<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: schema-newsarticle -->
	<xsl:template name="schema-newsarticle">

		<xsl:param name="img-article" select="concat($workspace, image/@path, '/', image/filename)" />
		<xsl:param name="img-organisation" select="concat($workspace, $config/image-partage/@path, '/', $config/image-partage/filename)" />
		<xsl:param name="description">
			<xsl:choose>
				<xsl:when test="string-length(meta-description) != 0">
					<xsl:value-of select="meta-description" />
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="substring(content, 0, 300)" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

		<script type="application/ld+json">
		  {
			"@context": "http://schema.org",
			"@type": "NewsArticle",
			"mainEntityOfPage": {
			  "@type": "WebPage",
			  "@id": "<xsl:value-of select="$current-url" />"
			},
			"headline": "<xsl:value-of select="translate(title/item[1], ',&quot;', '')" />",
			"image": [
			  "<xsl:value-of select="$img-article" />"
			 ],
			"datePublished": "<xsl:value-of select="publish-date/date/start" />",
			"dateModified": "<xsl:value-of select="publish-date/date/start" />",
			"author": {
			  "@type": "Person",
			  "name": "<xsl:value-of select="translate(author/item, ',&quot;', '')" />"
			},
			 "publisher": {
			  "@type": "Organization",
			  "name": "<xsl:value-of select="translate($data/site-config/entry[1]/schema-name, ',&quot;', '')" />",
			  "logo": {
				"@type": "ImageObject",
				"url": "<xsl:value-of select="$img-organisation" />"
			  }
			},
			"description": "<xsl:value-of select="translate($description, ',&quot;', '')" />"
		  }
		  </script>

	</xsl:template>
</xsl:stylesheet>
