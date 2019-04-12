<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- DEFAULT STYLE 																				 -->
	<xsl:variable name="form-control-icon-error-default-style">
		<add class="valign-middle bold" />
		<add style="color:red;" />
	</xsl:variable>
<!-- END DEFAULT STYLE 																			/-->

<!-- CORE ELEMENT : form-control-icon-error ====================================================-->
	<xsl:template name="form-control-icon-error">
		<xsl:param name="element" select="'span'" />
		<xsl:param name="attr" />

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$form-control-icon-error-default-style" />
			<xsl:copy-of select="$attr" />
			<add dev-core-element="icon-error" />
		</xsl:variable>
	<!-- 																	/-->

	<!-- STRUCTURE 															 -->
<!-- 		<xsl:call-template name="form-control-icon-x">
			<xsl:with-param name="attr" select="$computed-attr" />
		</xsl:call-template> -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$element"/>
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content" select="'•'" />
		</xsl:call-template>
	<!-- 																	/-->
	</xsl:template>

<!-- CORE SVG : form-control-icon-x =============================================================-->
	<xsl:template name="form-control-icon-x">
		<xsl:param name="attr" />
		<xsl:param name="element" select="'span'" />

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$attr" />
			<add dev-file="form-control-icon-error" />
			<!-- <add dev-core-svg="icon-x" /> -->
		</xsl:variable>
	<!-- 																	/-->

	<!-- STRUCTURE 															 -->
		<svg 
			width="10" 
			height="10" 
			viewBox="0 0 12.408 12.583" 
			preserveAspectRatio="xMinYMin meet">
			<xsl:call-template name="attr">
				<xsl:with-param name="attr" select="$computed-attr"/>
			</xsl:call-template>

			<polyline fill="none" stroke-width="2" stroke-miterlimit="10" points="11.665,0.958 6.185,6.417 0.664,0.979 "/>
			<polyline fill="none" stroke-width="2" stroke-miterlimit="10" points="0.706,11.875 6.185,6.417 11.706,11.854"/>
		</svg>

	<!-- 																	/-->
	</xsl:template>
</xsl:stylesheet>
