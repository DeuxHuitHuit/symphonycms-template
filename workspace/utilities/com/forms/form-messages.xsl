<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="form-messages">
		<xsl:param name="success" />
		<xsl:param name="error" />
		<xsl:param name="success-default" select="$form-config/message-success" />
		<xsl:param name="error-default" select="$form-config/message-error" />
		<xsl:param name="computed-success">
			<xsl:choose>
				<xsl:when test="string-length($success) != 0">
					<xsl:call-template name="util-rewrite-markdown">
						<xsl:with-param name="text" select="$success" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="util-rewrite-markdown">
						<xsl:with-param name="text" select="$success-error" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="computed-error">
			<xsl:choose>
				<xsl:when test="string-length($error) != 0">
					<xsl:call-template name="util-rewrite-markdown">
						<xsl:with-param name="text" select="$error" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="util-rewrite-markdown">
						<xsl:with-param name="text" select="$error-default" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="ext-attr" />


		<xsl:variable name="computed-attr-ctn">
			<add class="js-form-dyn-messages-ctn" />
			<xsl:copy-of select="$ext-attr" />
			<add dev-component="form-dyn-messages" />
		</xsl:variable>

		<xsl:variable name="computed-attr-message">
			<add class="padding-thinner" />
			<add class="display-none" />
			<add class="transition-form-message" />
			<add class="js-form-dyn-message" />
			<add data-visible-state-rem-class="display-none" />
			<add data-visible-state-follower=".js-form-inner-ctn" />
			<add data-visible-state-follower-common-ancestor=".js-form-dyn" />
			<add dev-element="message" />
		</xsl:variable>

		<xsl:variable name="computed-attr-template-success">
			<add type="text/template" />
			<add data-fx="success" />
			<add class="js-form-dyn-message-template" />
			<add dev-element="template-success" />
		</xsl:variable>

		<xsl:variable name="computed-attr-template-error">
			<add type="text/template" />
			<add data-fx="error" />
			<add class="js-form-dyn-message-template" />
			<add dev-element="template-error" />
		</xsl:variable>

		<xsl:variable name="attr-content">
			<add dev-element="content" />
		</xsl:variable>

		<!-- ELEMENT: ctn -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$computed-attr-ctn" />
			<xsl:with-param name="content">

				<!-- ELEMENT: message -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$computed-attr-message" />
				</xsl:call-template>

				<!-- ELEMENT: template-error -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$computed-attr-template-error" />
					<xsl:with-param name="element" select="'script'" />
					<xsl:with-param name="content">

						<!-- Content -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-content" />
							<xsl:with-param name="content" select="$error" />
						</xsl:call-template>

					</xsl:with-param>
				</xsl:call-template>

				<!-- ELEMENT: template-success -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$computed-attr-template-success" />
					<xsl:with-param name="element" select="'script'" />
					<xsl:with-param name="content">

						<!-- Content -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-content" />
							<xsl:with-param name="content" select="$success" />
						</xsl:call-template>

					</xsl:with-param>
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>

	</xsl:template> <!-- form-dyn-messages -->
</xsl:stylesheet>
