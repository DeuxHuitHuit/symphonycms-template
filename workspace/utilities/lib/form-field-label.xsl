<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:math="http://exslt.org/math"
	exclude-result-prefixes="math exsl">

<!-- JS STATE ATTR -->
<!-- 
	<add data-error-class="{$class-error}" />
	<add data-valid-class="{$class-valid}" />
	<add class="is-disabled" />
	<add class="js-form-label" />
-->

<!-- Label Default Style-->
	<xsl:variable name="form-field-label-default-style">
		<add class="pointer-events-none " />
	</xsl:variable>

<!-- CORE COMPONENT : form-field-label ==========================================================-->
	<xsl:template name="form-field-label">
	<!-- PARAMS 															 -->
		<xsl:param name="attr"/>
		<xsl:param name="element" select="'label'" />
		<xsl:param name="js" select="true()"/>
		<xsl:param name="is-optional" select="true()" />
		<xsl:param name="content"/>
	<!-- 																	/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">

			<!-- Js class -->
			<xsl:if test="$js != false()">
				<add class="js-form-label" />
			</xsl:if>

			<!-- Merge attr -->
			<xsl:copy-of select="$form-field-label-default-style" />
			<xsl:copy-of select="$attr" />

			<!-- Name -->
			<add dev-core="form-field-label" />
		</xsl:variable>
	<!-- 																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:call-template name="element">
			<xsl:with-param name="element" select="$element" />
			<xsl:with-param name="attr" select="$computed-attr"/>
			<xsl:with-param name="content" select="$content"/>
			<xsl:with-param name="is-optional" select="$is-optional" />
		</xsl:call-template>
	<!-- 																	/-->
	</xsl:template>

</xsl:stylesheet>
