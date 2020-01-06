<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-file -->
	<xsl:template match="item[@section = 'form-field-file']" mode="form-field">
		<xsl:param name="label" select="label" />
		<xsl:param name="name" select="concat('form[', name/@handle, ']')" />
		<xsl:param name="content-required" select="$form-config/hint-required" />
		<xsl:param name="label-button">
			<xsl:choose>
				<xsl:when test="string-length(button-label) != 0">
					<xsl:value-of select="button-label" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$form-config/upload" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="label-no-file" select="$form-config/label-no-file" />
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
		<xsl:param name="ext-attr-button" />
		<xsl:param name="ext-attr-filename" />
		<xsl:param name="ext-attr-input" />
		<xsl:param name="ext-attr-hidden-input" />
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
			<add class="transition-form-field transition-form-field-file" />
			<add class="js-form-field js-form-field-file" />
			<set data-default-filename="{$label-no-file}" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-file" />
		</xsl:variable>

		<xsl:variable name="attr-label">
			<xsl:apply-templates select="." mode="util-form-field-label-attr" />
			<xsl:copy-of select="$ext-attr-label" />
			<add dev-element="label" />
		</xsl:variable>

		<xsl:variable name="attr-input">
			<xsl:apply-templates select="." mode="util-form-field-input-attr" />
			<xsl:copy-of select="$recipe-font-text" />
			<add class="block" />
			<add for="{$id}" />
			<add class="transition-input" />
			<xsl:copy-of select="$ext-attr-input"/>
			<add dev-element="label" />
		</xsl:variable>

		<xsl:variable name="attr-input-grid">
			<add class="flexbox align-items-center" />
			<xsl:copy-of select="$recipe-gutter-h-button" />
			<add dev-element="input-grid" />
		</xsl:variable>

		<xsl:variable name="attr-grid-item">
			<xsl:copy-of select="$recipe-gutter-h-button-item" />
			<add dev-element="grid-item" />
		</xsl:variable>

		<xsl:variable name="attr-required">
			<add class="transition-required" />
			<xsl:copy-of select="$ext-attr-required"/>
			<add dev-element="required" />
		</xsl:variable>

		<xsl:variable name="attr-hidden-input">
			<!-- Visually hide input -->
			<add class="transparent overflow-hidden" />
			<add class="absolute z-index-minus-1" />
			<add style="~'width:0.1px;'" />
			<add style="~'height:0.1px;'" />
			<add name="{$name}" />
			<add type="file" />
			<add id="{$id}" />
			<add class="js-form-field-input" />
			<xsl:if test="string-length($accept) != 0">
				<set accept="{$accept}" />
			</xsl:if>
			<xsl:copy-of select="$ext-attr-hidden-input"/>
			<add dev-element="input" />
		</xsl:variable>

		<xsl:variable name="attr-hint">
			<add class="transition-hint" />
			<add class="js-form-field-hint" />
			<xsl:copy-of select="$ext-attr-hint"/>
			<add dev-element="hint" />
		</xsl:variable>

		<xsl:variable name="attr-button">
			<add class="bg-color-main-fill padding-horizontal-thinner" />
			<add class="cursor-pointer flex-shrink-0" />
			<add class="transition-button" />
			<xsl:copy-of select="$ext-attr-button" />
			<add dev-element="button" />
		</xsl:variable>

		<xsl:variable name="attr-preview">
			<add class="flexbox flex-center" />
			<add class="overflow-hidden flex-shrink-0" />
			<add data-preview-class="square-broad object-fit-cover" />
			<add class="js-form-field-preview" />
			<add dev-element="preview" />
		</xsl:variable>

		<xsl:variable name="attr-filename">
			<xsl:copy-of select="$recipe-font-caption" />
			<add class="text-ellipsis overflow-hidden" />
			<add class="transition-filename" />
			<add class="js-form-field-filename" />
			<add data-text="{$label-no-file}" />
			<xsl:copy-of select="$ext-attr-filename" />
			<add dev-element="filename" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Label -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-label" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>

				<!-- Input -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-input" />
					<xsl:with-param name="element" select="'label'" />
					<xsl:with-param name="content">
						<!-- Required -->
						<xsl:if test="$has-required and $is-required">
							<xsl:call-template name="element">
								<xsl:with-param name="attr" select="$attr-required" />
								<xsl:with-param name="content" select="$content-required" />
							</xsl:call-template>
						</xsl:if>
						<!-- Input grid -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-input-grid" />
							<xsl:with-param name="content">
								<!-- Grid item -->
								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$attr-grid-item" />
									<xsl:with-param name="content">
										<!-- Button -->
										<xsl:call-template name="element">
											<xsl:with-param name="attr" select="$attr-button" />
											<xsl:with-param name="content" select="$label-button" />
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
								<!-- Grid item -->
								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$attr-grid-item" />
									<xsl:with-param name="content">
										<!-- Preview -->
										<xsl:call-template name="element">
											<xsl:with-param name="attr" select="$attr-preview" />
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
								<!-- Grid item -->
								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$attr-grid-item" />
									<xsl:with-param name="content">
										<!-- Filename -->
										<xsl:call-template name="element">
											<xsl:with-param name="attr" select="$attr-filename" />
											<xsl:with-param name="content" select="$label-no-file" />
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- Hidden input -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-hidden-input" />
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
