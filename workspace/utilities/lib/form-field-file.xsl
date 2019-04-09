<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-file -->
	<xsl:template name="form-field-file">
		<xsl:param name="label" select="label" />
		<xsl:param name="name" select="name" />
		<xsl:param name="content-required" select="$form-config/required-flag" />
		<xsl:param name="label-button" select="$form-config/label-choose-a-file" />
		<xsl:param name="label-no-file" select="$form-config/label-no-file" />
		<xsl:param name="id">
			<xsl:call-template name="util-form-id" />
		</xsl:param>
		<xsl:param name="rules">
			<xsl:call-template name="util-form-rules" />
		</xsl:param>
		<xsl:param name="is-required" select="contains($rules, 'required')" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-label-text" />
		<xsl:param name="ext-attr-label" />
		<xsl:param name="ext-attr-button" />
		<xsl:param name="ext-attr-filename" />
		<xsl:param name="ext-attr-input" />
		<xsl:param name="ext-attr-required" />
		<xsl:param name="ext-attr-hint" />
		
		
		<xsl:variable name="has-required" select="string-length($content-required) != 0" />
		<xsl:variable name="is-doc" select="contains($rules, 'document')" />
		<xsl:variable name="is-img" select="contains($rules, 'image')" />
		<xsl:variable name="accept">
			<xsl:if test="$is-doc">
				<xsl:text>.pdf,.doc,.docx</xsl:text>
				<xsl:if test="$is-img">
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:if>
			<xsl:if test="$is-img">
				<xsl:text>.png,.jpg,.jpeg</xsl:text>
			</xsl:if>
		</xsl:variable>

		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<!-- OPTION: is required -->
			<xsl:if test="$is-required">
				<add class="is-required" />
			</xsl:if>
			<!-- Rules -->
			<add data-rules="{$rules}" />
			<add class="transition-form-field transition-form-field-file" />
			<add class="js-form-field js-form-field-file" />
			<set data-default-filename="{$label-no-file}" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-file" />
		</xsl:variable>

		<xsl:variable name="attr-label">
			<add for="{$id}" />
			<add class="transition-label" />
			<xsl:copy-of select="$ext-attr-label"/>
			<add dev-element="label" />
		</xsl:variable>
		
		<xsl:variable name="attr-label-text">
			<add for="{$id}" />
			<xsl:copy-of select="$ext-attr-label-text" />
			<add dev-element="label-text" />
		</xsl:variable>

		<xsl:variable name="attr-required">
			<add class="transition-required" />
			<xsl:copy-of select="$ext-attr-required"/>
			<add dev-element="required" />
		</xsl:variable>

		<xsl:variable name="attr-input">
			<add name="{$name}" />
			<add type="file" />
			<add id="{$id}" />
			<add class="display-none" />
			<add class="js-form-field-input" />
			<xsl:if test="string-length($accept) != 0">
				<set accept="{$accept}" />
			</xsl:if>
			<xsl:copy-of select="$ext-attr-input"/>
			<add dev-element="input" />
		</xsl:variable>

		<xsl:variable name="attr-hint">
			<add class="transition-hint" />
			<add class="js-form-field-hint" />
			<xsl:copy-of select="$ext-attr-hint"/>
			<add dev-element="hint" />
		</xsl:variable>
		
		<xsl:variable name="attr-button">
			<add class="transition-button" />
			<xsl:copy-of select="$ext-attr-button" />
			<add dev-element="button" />
		</xsl:variable>
		
		<xsl:variable name="attr-filename">
			<add class="transition-filename" />
			<add class="js-form-field-file-label" />
			<xsl:copy-of select="$ext-attr-filename" />
			<add dev-element="filename" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- LABEL TEXT -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-label-text" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>
				
				<!-- Label -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-label" />
					<xsl:with-param name="element" select="'label'" />
					<xsl:with-param name="content">
						<!-- Required -->
						<xsl:if test="$has-required and $is-required">
							<xsl:call-template name="element">
								<xsl:with-param name="attr" select="$attr-required" />
								<xsl:with-param name="content" select="$content-required" />
							</xsl:call-template>
						</xsl:if>
						
						<!-- UPLOAD button -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-button" />
							<xsl:with-param name="content" select="$label-button" />
						</xsl:call-template>
						
						<!-- UPLOAD filename -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-filename" />
							<xsl:with-param name="content" select="$label-no-file" />
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
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
