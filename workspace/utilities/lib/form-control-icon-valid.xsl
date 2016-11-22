<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- DEFAULT STYLE 																				 -->
	<xsl:variable name="form-control-icon-valid-default-style">
		<add class="valign-middle bold" />
		<add style="color: green;" />
	</xsl:variable>
<!-- END DEFAULT STYLE 																			/-->

<!-- CORE ELEMENT : form-control-icon-valid =====================================================-->
	<xsl:template name="form-control-icon-valid">
		<xsl:param name="element" select="'span'" />
		<xsl:param name="attr" />

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$form-control-icon-valid-default-style" />
			<xsl:copy-of select="$attr" />

			<add dev-core-element="icon-valid"/>
		</xsl:variable>
	<!-- 																	/-->

	<!-- STRUCTURE 															 -->
		<!-- <xsl:call-template name="form-control-icon-checked" >
			<xsl:with-param name="attr" select="$computed-attr" />
		</xsl:call-template> -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$element"/>
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="content" select="'•'" />
		</xsl:call-template>
	<!-- 																	/-->
	</xsl:template>

<!-- CORE SVG : form-control-icon-checked =======================================================-->
	<xsl:template name="form-control-icon-checked">
		<xsl:param name="attr" />

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$attr" />

			<add dev-file="form-control-icon-valid" />
			<!-- <add dev-core-svg="icon-checked" /> -->
		</xsl:variable>
	<!-- 																	/-->

	<!-- STRUCTURE 															 -->
		<svg 
			width="18px" 
			height="15px" 
			viewBox="0 0 21 18" 
			preserveAspectRatio="xMinYMin meet">
			<xsl:call-template name="attr">
				<xsl:with-param name="attr" select="$computed-attr"/>
			</xsl:call-template>

			<polyline fill="none" stroke-width="2" stroke-miterlimit="10" points="0.707,11.967 4.927,16.187 20.407,0.707"/>
		</svg>

	<!-- 																	/-->
	</xsl:template>
</xsl:stylesheet>
