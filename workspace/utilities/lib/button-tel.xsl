<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="default-button-tel-failover-element">a</xsl:variable>

<!-- CORE-ELEMENT: button-tel ===================================================================-->
	<xsl:template name="button-tel">
		<xsl:param name="tel" 				/>
		<xsl:param name="tel-type" 			select="'tel'"/>
		<xsl:param name="add-pays-code" 	select="true()" />
		<xsl:param name="pays-code" 		select="'+1'" />
		<!-- button params -->
		<xsl:param name="failover-element" 	select="$default-button-tel-failover-element" /> 	<!-- override default -->
		<!-- element params -->
		<xsl:param name="is-optional" 		select="false()" />
		<!-- attr params -->
		<xsl:param name="attr" 				/>
		<xsl:param name="attr-mode" 		select="$default-attr-mode" />
		<!-- content params -->
		<xsl:param name="lg" 				select="$url-language" />
		<xsl:param name="content" 			select="$tel"/>

	<!-- COMPUTED VALUES 													 -->
		<xsl:variable name="phone-number">
			<xsl:if test="string-length($tel) != 0">
				<xsl:if test="starts-with($tel, '+') = false() and $add-pays-code = true()">
					<xsl:value-of select="$pays-code" />
				</xsl:if>
				<xsl:value-of select="translate($tel, ' -().', '')" />
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="computed-url">
			<xsl:value-of select="concat($tel-type,':', $phone-number)" />
		</xsl:variable>
	<!--																	/-->

	<!-- STRUCTURE															 -->
		<xsl:call-template name="button">
			<xsl:with-param name="url" 				select="$computed-url" />
			<xsl:with-param name="failover-element"	select="$failover-element" />
			<xsl:with-param name="is-optional" 		select="$is-optional" />
			<xsl:with-param name="attr" 			select="$attr" />
			<xsl:with-param name="attr-mode" 		select="$attr-mode" />
			<xsl:with-param name="lg" 				select="$lg" />
			<xsl:with-param name="content" 			select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>

<!-- CORE-ELEMENT: optional-button-tel ==========================================================-->
	<xsl:template name="optional-button-tel">
		<xsl:param name="tel" 				/>
		<xsl:param name="tel-type" 			select="'tel'"/>
		<xsl:param name="add-pays-code" 	select="true()" />
		<xsl:param name="pays-code" 		select="'+1'" />
		<!-- button params -->
		<xsl:param name="failover-element" 	select="$default-button-tel-failover-element" /> <!-- override default -->
		<!-- attr params -->
		<xsl:param name="attr" 				/>
		<xsl:param name="attr-mode" 		select="$default-attr-mode" />
		<!-- content params -->
		<xsl:param name="lg" 				select="$url-language" />
		<xsl:param name="content" 			select="$tel"/>

	<!-- STRUCTURE															 -->
		<xsl:call-template name="button-tel" >
			<xsl:with-param name="tel" 				select="$tel" />
			<xsl:with-param name="tel-type" 		select="$tel-type" />
			<xsl:with-param name="add-pays-code" 	select="$add-pays-code" />
			<xsl:with-param name="pays-code" 		select="$pays-code" />
			<xsl:with-param name="failover-element"	select="$failover-element" />
			<xsl:with-param name="is-optional" 		select="true()" />
			<xsl:with-param name="attr" 			select="$attr" />
			<xsl:with-param name="attr-mode" 		select="$attr-mode" />
			<xsl:with-param name="lg" 				select="$lg" />
			<xsl:with-param name="content" 			select="$content" />
		</xsl:call-template>
	<!--																	/-->
	</xsl:template>
</xsl:stylesheet>