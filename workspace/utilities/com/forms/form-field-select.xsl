<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-select -->
	<xsl:template match="item[@section = 'form-field-select']" mode="form-field">
		<xsl:param name="id">
			<xsl:call-template name="util-form-id" />
		</xsl:param>
		<xsl:param name="label" select="label" />
		<xsl:param name="name" select="concat('form[', name/@handle, ']')" />
		<xsl:param name="placeholder" select="placeholder" />
		<xsl:param name="options" select="options/item" />
		<xsl:param name="content-required" select="'*'" />
		<xsl:param name="content-icon" />
		<xsl:param name="rules">
			<xsl:call-template name="util-form-rules" />
		</xsl:param>
		<xsl:param name="is-multiselect" select="false()" />
		<xsl:param name="is-required" select="contains($rules, 'required')" />
		<xsl:param name="is-half-width" select="half-width = 'Yes'" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-label" />
		<xsl:param name="ext-attr-input-wrapper" />
		<xsl:param name="ext-attr-input" />
		<xsl:param name="ext-attr-icon" />
		<xsl:param name="ext-attr-required" />
		<xsl:param name="ext-attr-hint" />

		<xsl:variable name="has-required" select="string-length($content-required) != 0" />
		<xsl:variable name="has-placeholder" select="string-length($placeholder) != 0" />


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
			<add class="transition-form-field transition-form-field-select" />
			<add class="js-form-field js-form-field-select" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-select" />
		</xsl:variable>

		<xsl:variable name="attr-label">
			<xsl:apply-templates select="." mode="util-form-field-label-attr" />
			<set for="{$id}" />
			<add class="transition-label" />
			<xsl:copy-of select="$ext-attr-label" />
			<add dev-element="label" />
		</xsl:variable>

		<xsl:variable name="attr-required">
			<add class="transition-required" />
			<xsl:copy-of select="$ext-attr-required" />
			<add dev-element="required" />
		</xsl:variable>

		<xsl:variable name="attr-select-wrapper">
			<add class="relative" />
			<xsl:copy-of select="$ext-attr-input-wrapper" />
			<add dev-element="input-wrapper" />
		</xsl:variable>

		<xsl:variable name="attr-select">
			<xsl:apply-templates select="." mode="util-form-field-input-attr" />
			<add class="block appearance-none bg-color-transparent" />
			<set id="{$id}" />
			<set name="{$name}" />
			<add class="transition-select" />
			<add class="js-form-field-input" />
			<xsl:copy-of select="$ext-attr-input" />
			<add dev-element="select" />
		</xsl:variable>

		<xsl:variable name="attr-icon">
			<add class="transition-icon" />
			<xsl:copy-of select="$ext-attr-icon" />
			<add dev-element="icon" />
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
				<!-- Select wrapper -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-select-wrapper" />
					<xsl:with-param name="content">
						<!-- Select -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-select" />
							<xsl:with-param name="element" select="'select'" />
							<xsl:with-param name="content">
								<!-- Default option -->
								<xsl:if test="$has-placeholder">
									<xsl:call-template name="form-field-option">
										<xsl:with-param name="label" select="$placeholder" />
										<xsl:with-param name="value" select="''" />
										<xsl:with-param name="is-selected" select="true()" />
										<xsl:with-param name="is-disabled" select="true()" />
									</xsl:call-template>
								</xsl:if>
								<!-- REPEAT: options -->
								<xsl:apply-templates select="$options" mode="form-field" />
							</xsl:with-param>
						</xsl:call-template>
						<!-- Icon -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-icon" />
							<xsl:with-param name="content">
								<!-- <xsl:call-template name="icon-chevron" /> -->
							</xsl:with-param>
						</xsl:call-template>
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
