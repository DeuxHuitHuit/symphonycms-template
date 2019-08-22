<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-list -->
	<xsl:template match="item[@section = 'form-field-option-list']" mode="form-field">
		<xsl:param name="label" select="label" />
		<xsl:param name="id">
			<xsl:call-template name="util-form-id" />
		</xsl:param>
		<xsl:param name="name" select="concat('form[', name/@handle, ']')" />
		<xsl:param name="options" select="options/item" />
		<xsl:param name="content-required" select="'*'" />
		<xsl:param name="rules">
			<xsl:call-template name="util-form-rules" />
		</xsl:param>
		<xsl:param name="is-multiselect" select="multiselect = 'Yes'" />
		<xsl:param name="is-required" select="contains($rules, 'required')" />
		<xsl:param name="is-half-width" select="half-width = 'Yes'" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-label" />
		<xsl:param name="ext-attr-input" />
		<xsl:param name="ext-attr-required" />
		<xsl:param name="ext-attr-hint" />
		<xsl:param name="ext-attr-items-ctn" />
		<xsl:param name="ext-attr-item" />

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
			<add class="transition-form-field transition-form-field-list" />
			<add class="js-form-field js-form-field-list" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-list" />
		</xsl:variable>

		<xsl:variable name="attr-label">
			<xsl:apply-templates select="." mode="util-form-field-label-attr" />
			<add for="{$id}" />
			<add class="transition-label" />
			<xsl:copy-of select="$ext-attr-label" />
			<add dev-element="label" />
		</xsl:variable>

		<xsl:variable name="attr-required">
			<add class="transition-required" />
			<xsl:copy-of select="$ext-attr-required" />
			<add dev-element="required" />
		</xsl:variable>

		<xsl:variable name="attr-items-ctn">
			<add class="transition-items-ctn" />
			<add class="js-form-field-input" />
			<xsl:choose>
				<xsl:when test="$is-multiselect">
					<add class="js-form-field-checkbox-list" />
				</xsl:when>
				<xsl:otherwise>
					<add class="js-form-field-radio-list" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:copy-of select="$ext-attr-items-ctn" />
			<add dev-element="items-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-item">
			<add class="transition-item" />
			<add class="js-form-field-list-item" />
			<xsl:copy-of select="$ext-attr-item" />
			<add dev-element="item" />
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
			<xsl:with-param name="element" select="'fieldset'" />
			<xsl:with-param name="content">

				<!-- Label -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-label" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>

				<!-- Required -->
				<xsl:if test="$has-required and $is-required">
					<xsl:call-template name="element">
						<xsl:with-param name="attr" select="$attr-required" />
						<xsl:with-param name="content" select="$content-required" />
					</xsl:call-template>
				</xsl:if>

				<!-- Items ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-items-ctn" />
					<xsl:with-param name="content">

						<!-- APPLY: options -->
						<xsl:apply-templates select="options" mode="form-field-list-item">
							<xsl:with-param name="name" select="$name" />
						</xsl:apply-templates>

					</xsl:with-param>
				</xsl:call-template>

				<!-- Hint -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-hint" />
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
