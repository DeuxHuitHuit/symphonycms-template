<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-checkbox -->
	<xsl:template name="form-field-checkbox" match="item[@section = 'form-field-checkbox']" mode="form-field">
		<xsl:param name="label" select="label" />
		<xsl:param name="name" select="concat('form[', name/@handle, ']')" />
		<xsl:param name="value" select="name/@handle" />
		<xsl:param name="content-required" select="'*'" />
		<xsl:param name="id">
			<xsl:call-template name="util-form-id" />
		</xsl:param>
		<xsl:param name="rules">
			<xsl:call-template name="util-form-rules" />
		</xsl:param>
		<xsl:param name="is-required" select="contains($rules, 'required')" />
		<xsl:param name="is-checked" select="false()" />
		<xsl:param name="is-half-width" select="half-width = 'Yes'" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-label" />
		<xsl:param name="ext-attr-input" />
		<xsl:param name="ext-attr-required" />

		<xsl:variable name="has-required" select="string-length($content-required) != 0" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<!-- Interval -->
			<xsl:apply-templates select="." mode="util-form-field-interval-attr" />
			<!-- Width -->
			<add class="width-full" />
			<xsl:if test="$is-half-width">
				<add class="width-1_2-from-sm" />
			</xsl:if>
			<!-- Required -->
			<xsl:if test="$is-required">
				<add class="is-required" />
			</xsl:if>
			<!-- Rules -->
			<add data-rules="{$rules}" />
			<add class="transition-form-field transition-form-field-checkbox" />
			<add class="js-form-field js-form-field-checkbox" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-checkbox" />
		</xsl:variable>

		<xsl:variable name="attr-label">
			<xsl:apply-templates select="." mode="util-form-field-label-attr" />
			<set for="{$id}" />
			<add class="transition-label" />
			<xsl:copy-of select="$ext-attr-label" />
			<add dev-element="label" />
		</xsl:variable>

		<xsl:variable name="attr-required">
			<xsl:copy-of select="$ext-attr-required" />
			<add class="transition-required" />
			<add dev-element="required" />
		</xsl:variable>

		<xsl:variable name="attr-input">
			<xsl:apply-templates select="." mode="util-form-field-input-attr" />
			<set name="{$name}" />
			<set value="{$value}" />
			<set type="checkbox" />
			<set id="{$id}" />
			<!-- OPTION: checked -->
			<xsl:if test="$is-checked">
				<set checked="checked" />
			</xsl:if>
			<add class="transition-input" />
			<add class="js-form-field-input" />
			<xsl:copy-of select="$ext-attr-input" />
			<add dev-element="input" />
		</xsl:variable>

		<xsl:variable name="attr-hint">
			<add class="js-form-field-hint" />
			<add class="transition-hint" />
			<add dev-element="hint" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">

				<!-- Input -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-input" />
					<xsl:with-param name="element" select="'input'" />
				</xsl:call-template>

				<!-- Label -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-label" />
					<xsl:with-param name="element" select="'label'" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>

				<!-- Hint -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-hint" />
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
