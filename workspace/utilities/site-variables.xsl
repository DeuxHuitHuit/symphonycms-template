<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="site-name" select="$config/site-name" />
<xsl:variable name="site-description" select="$config/description" />
<xsl:variable name="site-share-image" select="$config/site-share-image" />

<xsl:variable name="default-share-page-title" >
	<xsl:call-template name="default-master-title" />
</xsl:variable>


<!-- Google Analytics -->
<xsl:variable name="ga-ua" select="''" />
<xsl:variable name="ga-domain" select="''" />

<!-- Twitter Card -->
<xsl:variable name="twitter-card-site" select="''" />
<xsl:variable name="twitter-card-creator" select="'@'" />
<xsl:variable name="twitter-card-domain" select="''" />


<!-- Default langue if fl-languages not found -->
<xsl:variable name="default-langue" select="'fr'" />

<!-- Default Path -->
<xsl:variable name="css-path" select="'/workspace/assets/css/'" />
<xsl:variable name="js-path" select="'/workspace/assets/js/'" />


</xsl:stylesheet>