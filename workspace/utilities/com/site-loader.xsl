<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="site-loader">

		<xsl:variable name="attr">
			<add class="fixed fill z-index-max border-box" />
			<add class="bg-color-white" />
			<add class="js-site-loader js-site-loader-close-ended-anim-ref target" />
			<add class="transition-opacity transition-duration-fast" />
			<add data-close-state-add-class="transparent" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<add class="absolute fill" />
			<add class="flexbox flex-center" />
			<add dev-element="ctn" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr"/>
			<xsl:with-param name="content">
				<!-- Ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-ctn" />
					<xsl:with-param name="content">
						<!-- Loader -->
						<!-- <xsl:call-template name="com-loader" /> -->
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
