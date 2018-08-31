<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-list -->
	<xsl:template name="form-field-list" match="item" mode="form-field-list">
		<xsl:param name="label" select="label" />
		<xsl:param name="name" select="name" />
		<xsl:param name="items" select="items/item" />
		<xsl:param name="content-required" select="'*'" />
		<xsl:param name="rules">
			<xsl:call-template name="util-form-rules" />
		</xsl:param>
		<xsl:param name="is-multiselect" select="false()" />
		<xsl:param name="is-required" select="contains($rules, 'required')" />
		<xsl:param name="ext-attr" />

		<xsl:variable name="mode">
			<xsl:choose>
				<xsl:when test="$is-multiselect">
					<xsl:text>form-field-checkbox</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>form-field-radio</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<!-- OPTION: is required -->
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
			<add for="{$id}" />
			<add class="transition-label" />
			<add dev-element="label" />
		</xsl:variable>

		<xsl:variable name="attr-required">
			<add class="transition-required" />
			<add dev-element="required" />
		</xsl:variable>

		<xsl:variable name="attr-items-ctn">
			<add class="transition-items-ctn" />
			<add dev-element="items-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-item">
			<add class="transition-item" />
			<add class="js-form-field-list-item" />
			<add dev-element="item" />
		</xsl:variable>

		<xsl:variable name="attr-hint">
			<add class="transition-hint" />
			<add class="js-form-field-hint" />
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
					<xsl:with-param name="element" select="'legend'" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>
				<!-- Required -->
				<xsl:if test="$has-required">
					<xsl:call-template name="element">
						<xsl:with-param name="attr" select="$attr-required" />
						<xsl:with-param name="content" select="$content-required" />
					</xsl:call-template>
				</xsl:if>
				<!-- Items ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-items-ctn" />
					<xsl:with-param name="content">
						<!-- REPEAT: items -->
						<xsl:apply-templates select="$items" mode="$mode">
							<xsl:with-param name="name" select="$name" />
							<xsl:with-param name="ext-attr" select="$attr-item" />
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
