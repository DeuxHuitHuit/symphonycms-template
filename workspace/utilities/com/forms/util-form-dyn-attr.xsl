<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: util-form-dyn-attr -->
	<xsl:template name="util-form-dyn-attr" match="entry | item" mode="util-form-dyn-attr">
		<xsl:param name="id" select="@id" />
		<xsl:param name="identifier" select="identifier" />
		<xsl:param name="hint-required-field" select="$form-config/hint-required-field" />
		<xsl:param name="hint-email-invalid" select="$form-config/hint-invalid-email" />
		<xsl:param name="hint-doc-invalid" select="$form-config/hint-invalid-document" />
		<xsl:param name="hint-img-invalid" select="$form-config/hint-invalid-image" />
		<xsl:param name="hint-phone-invalid" select="$form-config/hint-invalid-phone" />


		<!-- Method -->
		<add method="POST" />
		<!-- Action -->
		<add action="{$page-ajax-form-url}{$id}/" />
		<!-- GA -->
		<set data-ga-form-cat="Forms" />
		<set data-ga-form-label="{$identifier}" />
		<!-- Hints -->
		<xsl:if test="string-length(hint-required-field) != 0">
			<set data-hint-required="~'{$hint-required-field}'" />
		</xsl:if>
		<xsl:if test="string-length(hint-email-invalid) != 0">
			<set data-hint-email-invalid="~'{$hint-email-invalid}'" />
		</xsl:if>
		<xsl:if test="string-length(hint-doc-invalid) != 0">
			<set data-hint-doc-invalid="~'{$hint-doc-invalid}'" />
		</xsl:if>
		<xsl:if test="string-length(hint-img-invalid) != 0">
			<set data-hint-img-invalid="~'{$hint-img-invalid}'" />
		</xsl:if>
		<xsl:if test="string-length(hint-phone-invalid) != 0">
			<set data-hint-phone-invalid="~'{$hint-phone-invalid}'" />
		</xsl:if>
		
	</xsl:template>
</xsl:stylesheet>
