<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-textarea -->
	<xsl:template name="form-field-textarea">
		<xsl:param name="id">
			<xsl:call-template name="util-form-id" />
		</xsl:param>
		<xsl:param name="rules">
			<xsl:call-template name="util-form-rules" />
		</xsl:param>
		<xsl:param name="is-required" select="contains($rules, 'required')" />
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<!-- OPTION: is required -->
			<xsl:if test="$is-required">
				<add class="is-required" />
			</xsl:if>
			<!-- Rules -->
			<add data-rules="{$rules}" />
			<add class="transition-form-field transition-form-field-textarea" />
			<add class="js-form-field js-form-field-textarea" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-textarea" />
		</xsl:variable>

		<xsl:variable name="attr-label">
			<add for="{$id}" />
			<add class="transition-label" />
			<add dev-element="label" />
		</xsl:variable>

		<xsl:variable name="attr-required">
			<add class="transition-required" />
			<add dev-element="required" />
		</xsl:variable>

		<xsl:variable name="attr-textarea">
			<add name="{$name}" />
			<add placeholder="{$placeholder}" />
			<add id="{$id}" />
			<add class="transition-textarea" />
			<add class="js-form-field-textarea" />
			<add dev-element="textarea" />
		</xsl:variable>

		<xsl:variable name="attr-hint">
			<add class="transition-hint" />
			<add class="js-form-field-hint" />
			<add dev-element="hint" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Label -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-label" />
					<xsl:with-param name="element" select="'label'" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>
				<!-- Required -->
				<xsl:if test="$has-required">
					<xsl:call-template name="element">
						<xsl:with-param name="attr" select="$attr-required" />
						<xsl:with-param name="content" select="$content-required" />
					</xsl:call-template>
				</xsl:if>
				<!-- Textarea -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-textarea" />
					<xsl:with-param name="element" select="'textarea'" />
					<xsl:with-param name="content" select="$value" />
				</xsl:call-template>
				<!-- Hint -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-hint" />
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
