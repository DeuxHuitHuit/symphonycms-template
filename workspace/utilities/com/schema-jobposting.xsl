<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="schema-jobposting">
		<xsl:param name="title" select="''" />
		<xsl:param name="description" select="''" />
		<xsl:param name="publishdate" select="''" />
		<xsl:param name="enddate" select="''" />
		<xsl:param name="name" select="''" />
		<xsl:param name="img-article" select="''" />
		<xsl:param name="img-organisation" select="''" />
		<xsl:param name="address" select="''" />
		<xsl:param name="region" select="''" />
		<xsl:param name="country" select="''" />
		<xsl:param name="postal-code" select="''" />
		<xsl:param name="phone" select="''" />
		<xsl:param name="email" select="''" />


		<script type="application/ld+json"> {
		  "@context" : "http://schema.org/",
		  "@type" : "JobPosting",
		  "title" : "<xsl:value-of select="translate($title, ',&quot;', '')" />",
		  "description" : "<xsl:value-of select="translate($description, ',&quot;', '')" />",
		  "datePosted" : "<xsl:value-of select="$publishdate" />",
		  "validThrough" : "<xsl:value-of select="$enddate" />",
		  "employmentType" : "",
		  "hiringOrganization" : {
		    "@type" : "Organization",
		    "name" : "<xsl:value-of select="$name" />",
		    "logo" : "<xsl:value-of select="$img-organisation" />"
		  },
		  "jobLocation" : {
		    "@type" : "Place",
		    "address" : {
		      "@type" : "PostalAddress",
		      "streetAddress" : "<xsl:value-of select="translate($address, ',&quot;', '')"/>",
		      "addressLocality" : "<xsl:value-of select="translate($country, ',&quot;', '')" />",
		      "addressRegion" : "<xsl:value-of select="translate($region, ',&quot;', '')" />",
		      "postalCode" : "<xsl:value-of select="translate($postal-code, ',&quot;', '')" />",
		      "addressCountry": "<xsl:value-of select="translate($country, ',&quot;', '')" />"
		    }
		  }
		}
		</script>

	</xsl:template>
</xsl:stylesheet>
