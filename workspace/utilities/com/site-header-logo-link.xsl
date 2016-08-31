<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="site-header-logo-link">
	<xsl:param name="url" select="$page-index-url"/>
	<xsl:param name="attr" />
	<xsl:param name="heading-attr" />
	<xsl:param name="span-attr" >
		<add class="hidden" />
	</xsl:param>
	<xsl:param name="content" />
	
	<xsl:variable name="computed-attr" >
		<add role="menuitem" />
		<xsl:copy-of select="$attr" />
	</xsl:variable>

	<xsl:call-template name="button">
		<xsl:with-param name="attr" select="$computed-attr" />
		<xsl:with-param name="url" select="$url" />
		<xsl:with-param name="content">

			<h1>
				<xsl:call-template name="attr" >
					<xsl:with-param name="attr" select="$heading-attr"/>
				</xsl:call-template>

				<!-- Logo -->
				<xsl:call-template name="content" >
					<xsl:with-param name="content" select="$content"/>
				</xsl:call-template>

				<!-- Nom du site -->
				<span>
					<xsl:call-template name="attr" >
						<xsl:with-param name="attr" select="$span-attr" />
					</xsl:call-template>

					<xsl:call-template name="content" >
						<xsl:with-param name="content"  select="$config/site-titre"/>
					</xsl:call-template>
				</span>
			</h1>

		</xsl:with-param>
	</xsl:call-template>

</xsl:template>

</xsl:stylesheet>
