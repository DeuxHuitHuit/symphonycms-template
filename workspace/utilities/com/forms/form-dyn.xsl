<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="form-field-checkbox.xsl" />
<xsl:import href="form-field-file.xsl" />
<xsl:import href="form-field-list.xsl" />
<xsl:import href="form-field-list-item.xsl" />
<xsl:import href="form-field-number.xsl" />
<xsl:import href="form-field-option.xsl" />
<xsl:import href="form-field-radio.xsl" />
<xsl:import href="form-field-select.xsl" />
<xsl:import href="form-field-text.xsl" />
<xsl:import href="form-field-textarea.xsl" />
<xsl:import href="form-messages.xsl" />
<xsl:import href="form-recaptcha.xsl" />
<xsl:import href="button-submit.xsl" />
<xsl:import href="util-form-field-interval-attr.xsl" />
<xsl:import href="util-form-field-label-attr.xsl" />
<xsl:import href="util-form-field-input-attr.xsl" />
<xsl:import href="util-form-field-required-attr.xsl" />
<xsl:import href="util-form-dyn-attr.xsl" />
<xsl:import href="util-form-id.xsl" />
<xsl:import href="util-form-rules.xsl" />


<!-- 
	Displays a dynamic form

	Dependencies
		com/form.js
		com/form-field.js
		modules/form-dyn.js
		modules/form-dyn-loading.js
		modules/form-dyn-messages.js
		modules/form-dyn-reset.js
		modules/auto-invisible-recaptcha.js
 -->

<!-- COMPONENT: form-dyn -->
	<xsl:template name="form-dyn" match="entry | item" mode="form-dyn">
		<xsl:param name="fields" select="fields/item" />
		<xsl:param name="message-success" select="message-success" />
		<xsl:param name="message-error" select="message-error" />
		<xsl:param name="ext-attr" />
		<xsl:param name="ext-attr-field" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<add class="transition-form-dyn" />
			<add class="js-form-dyn" />
			<add data-completed-state-follower=".js-form-field, .js-form-footer" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-dyn" />
		</xsl:variable>

		<xsl:variable name="attr-form">
			<add class="flexbox flex-wrap" />
			<xsl:copy-of select="$recipe-gutter-h-card" />
			<!-- Form attributes -->
			<xsl:call-template name="util-form-dyn-attr" />
			<add class="js-form" />
			<add dev-element="form" />
		</xsl:variable>

		<xsl:variable name="attr-field">
			<xsl:copy-of select="$recipe-gutter-h-card-item" />
			<!-- Reset -->
			<add class="margin-horizontal-0" />
			<add dev-element="field" />
		</xsl:variable>

		<xsl:variable name="attr-form-footer">
			<xsl:copy-of select="$recipe-gutter-h-card-item" />
			<add class="js-form-footer" />
			<add data-completed-state-add-class="display-none" />
			<add dev-element="form-footer" />
		</xsl:variable>

		<xsl:variable name="attr-submit">
			<xsl:copy-of select="$recipe-interval-form-field" />
			<add class="text-center" />
			<add dev-element="submit" />
		</xsl:variable>

		<xsl:variable name="attr-messages">
			<add class="width-full margin-bottom-broad" />
			<xsl:copy-of select="$recipe-gutter-h-card-item" />
			<add dev-element="messages" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">

				<!-- Form -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-form" />
					<xsl:with-param name="element" select="'form'" />
					<xsl:with-param name="content">

						<!-- Messages -->
						<xsl:call-template name="form-messages">
							<xsl:with-param name="success" select="$message-success" />
							<xsl:with-param name="error" select="$message-error" />
							<xsl:with-param name="ext-attr" select="$attr-messages" />
						</xsl:call-template>

						<!-- Fields -->
						<xsl:apply-templates select="$fields" mode="form-field">
							<xsl:with-param name="ext-attr" select="$attr-field" />
						</xsl:apply-templates>

						<!-- Form footer -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-form-footer" />
							<xsl:with-param name="content">

								<!-- BUTTON: submit -->
								<xsl:call-template name="button-submit">
									<xsl:with-param name="ext-attr" select="$attr-submit" />
								</xsl:call-template>

								<!-- Recaptcha -->
								<xsl:call-template name="form-recaptcha" />

								<!-- HIDDEN: Action -->
								<input type="hidden" name="action[form-dyn]" />

								<!-- HIDDEN: Lang -->
								<input type="hidden" name="form[lang]" value="{$url-language}" />

							</xsl:with-param>
						</xsl:call-template>

					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

	</xsl:template>
</xsl:stylesheet>
