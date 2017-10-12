<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="algolia-search-result">
	<xsl:param name="template-no-results" select="''" />
	<xsl:param name="template-result-item" select="''" />
	<xsl:param name="attr" select="''" />
	<xsl:param name="attr-result-ctn" />
	<xsl:param name="facets" select="''" />
	<xsl:param name="facets-filter" select="''" />
	
	<xsl:call-template name="element">
		<xsl:with-param name="attr">
			<add class="js-algolia-results-ctn" />
			<xsl:copy-of select="$attr" />
			
			<add data-algolia-facet-filters="{$facets-filter}" />
			<add data-algolia-facet="{$facets}" />
		</xsl:with-param>
		<xsl:with-param name="content">
			<script class="js-algolia-no-results-template" type="text/template">
				<xsl:call-template name="content">
					<xsl:with-param name="content" select="$template-no-results" />
				</xsl:call-template>
			</script>
			<script class="js-algolia-results-item-template" type="text/template">
				<xsl:call-template name="content">
					<xsl:with-param name="content" select="$template-result-item" />
				</xsl:call-template>
			</script>
			
			
			<!-- results content -->
			<xsl:call-template name="element">
				<xsl:with-param name="attr">
					<add class="js-algolia-results-content" />
					<xsl:copy-of select="$attr-result-ctn" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>