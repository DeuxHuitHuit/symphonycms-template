<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="site-header-mobile-toggler">
		<xsl:param name="trait-height" select="'2'" />
		<xsl:param name="ext-attr" />

		<!-- STYLES /////////////////////////////////////////////////////////////// -->

		<xsl:variable name="attr-site-header-mobile-toggler">
			<add class="block" />
			<add class="square-broad" />
			<add class="cursor-pointer" />

			<add class="js-change-state-click" />
			<add data-change-state-click="mobile-opened" />
			<add data-change-state-action="toggle" />

			<add data-mobile-opened-state-follower=".js-site-header-mobile-toggler-icon-part, .js-site-header" />
			<add data-mobile-opened-state-follower-common-ancestor="#site" />

			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="site-header-mobile-toggler" />
		</xsl:variable>

		<xsl:variable name="attr-inner-ctn">
			<add class="flexbox flex-row align-items-center" />
		</xsl:variable>

		<xsl:variable name="attr-icon">
			<add class="block" />
			<add class="relative" />
			<add class="width-broad height-thinner" />
		</xsl:variable>

		<xsl:variable name="attr-icon-part">
			<add class="block" />
			<add class="absolute left" />
			<add class="bg-color-current-color" />
			<add class="width-full" />
			<add style="height: {$trait-height}px;" />
			<add class="transition-transform-opacity transition-duration-faster" />

			<add class="js-site-header-mobile-toggler-icon-part" />
		</xsl:variable>

		<xsl:variable name="attr-icon-part-1">
			<xsl:copy-of select="$attr-icon-part" />

			<add class="top" />

			<add data-mobile-opened-state-add-class="transparent" />
		</xsl:variable>

		<xsl:variable name="attr-icon-part-2">
			<xsl:copy-of select="$attr-icon-part" />

			<add class="top-1_2" />
			<add class="margin-top-minus-1px" />

			<add data-mobile-opened-state-add-class="rotate-45deg" />
		</xsl:variable>

		<xsl:variable name="attr-icon-part-3">
			<xsl:copy-of select="$attr-icon-part" />

			<add class="top-1_2" />
			<add class="margin-top-minus-1px" />

			<add data-mobile-opened-state-add-class="rotate-minus-45deg" />
		</xsl:variable>

		<xsl:variable name="attr-icon-part-4">
			<xsl:copy-of select="$attr-icon-part" />

			<add class="bottom" />
			<add data-mobile-opened-state-add-class="transparent" />
		</xsl:variable>

		<!-- STRUCTURE ////////////////////////////////////////////////////////// -->

		<xsl:call-template name="button">
			<xsl:with-param name="attr" select="$attr-site-header-mobile-toggler" />
			<xsl:with-param name="content">

				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-inner-ctn" />
					<xsl:with-param name="element" select="'span'" />
					<xsl:with-param name="content">

						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-icon" />
							<xsl:with-param name="element" select="'span'" />
							<xsl:with-param name="content">

								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$attr-icon-part-1" />
									<xsl:with-param name="element" select="'span'" />
								</xsl:call-template>

								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$attr-icon-part-2" />
									<xsl:with-param name="element" select="'span'" />
								</xsl:call-template>

								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$attr-icon-part-3" />
									<xsl:with-param name="element" select="'span'" />
								</xsl:call-template>

								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$attr-icon-part-4" />
									<xsl:with-param name="element" select="'span'" />
								</xsl:call-template>

							</xsl:with-param>
						</xsl:call-template>

					</xsl:with-param>
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
