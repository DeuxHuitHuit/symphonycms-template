<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-text -->
	<xsl:template name="form-field-text" match="item[@section = 'form-field-text']" mode="form-field">
		<xsl:param name="label" select="label" />
		<xsl:param name="name" select="concat('form[', name/@handle, ']')" />
		<xsl:param name="placeholder" select="placeholder" />
		<xsl:param name="value" select="value" />
		<xsl:param name="content-required" select="'*'" />
		<xsl:param name="id">
			<xsl:call-template name="util-form-id" />
		</xsl:param>
		<xsl:param name="rules">
			<xsl:call-template name="util-form-rules" />
		</xsl:param>
		<xsl:param name="is-required" select="contains($rules, 'required')" />
		<xsl:param name="is-half-width" select="half-width = 'Yes'" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-label" />
		<xsl:param name="ext-attr-input" />
		<xsl:param name="ext-attr-required" />
		<xsl:param name="ext-attr-hint" />

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
			<add class="transition-form-field transition-form-field-text" />
			<add class="js-form-field js-form-field-text" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-text" />
		</xsl:variable>

		<xsl:variable name="attr-label">
			<xsl:apply-templates select="." mode="util-form-field-label-attr" />
			<add for="{$id}" />
			<add class="transition-label" />
			<xsl:copy-of select="$ext-attr-label" />
			<add dev-element="label" />
		</xsl:variable>

		<xsl:variable name="attr-required">
			<xsl:apply-templates select="." mode="util-form-field-required-attr" />
			<add class="transition-required" />
			<xsl:copy-of select="$ext-attr-required" />
			<add dev-element="required" />
		</xsl:variable>

		<xsl:variable name="attr-input">
			<xsl:apply-templates select="." mode="util-form-field-input-attr" />
			<set id="{$id}" />
			<set type="text" />
			<set name="{$name}" />
			<set placeholder="{$placeholder}" />
			<set value="{$value}" />
			<add class="transition-input" />
			<add class="js-form-field-input" />
			<xsl:copy-of select="$ext-attr-input" />
			<add dev-element="form-field-text-input" />
		</xsl:variable>

		<xsl:variable name="attr-hint">
			<add class="transition-hint" />
			<add class="js-form-field-hint" />
			<xsl:copy-of select="$ext-attr-hint" />
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
				<xsl:if test="$has-required and $is-required">
					<xsl:call-template name="element">
						<xsl:with-param name="attr" select="$attr-required" />
						<xsl:with-param name="content" select="$content-required" />
					</xsl:call-template>
				</xsl:if>
				<!-- Input -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-input" />
					<xsl:with-param name="element" select="'input'" />
				</xsl:call-template>
				<!-- Hint -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-hint" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
