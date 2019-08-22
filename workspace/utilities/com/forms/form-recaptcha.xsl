<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-recaptcha -->
	<xsl:template name="form-recaptcha">
		<xsl:param name="ext-attr" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$recipe-interval-form-field" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-recaptcha" />
		</xsl:variable>

		<xsl:variable name="attr-input">
			<add type="hidden" />
			<add name="fields[google_recaptcha]" />
			<add class="js-recaptcha-response" />
			<add dev-element="input" />
		</xsl:variable>

		<xsl:variable name="attr-badge">
			<add class="display-none" />
			<add class="js-recaptcha" />
			<set data-sitekey="{/data/params/recaptcha-sitekey}" />
			<set data-size="invisible" />
			<add data-badge="inline" />
			<add dev-element="badge" />
		</xsl:variable>

		<xsl:variable name="attr-text">
			<add dev-element="text" />
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
				<!-- Badge -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-badge" />
				</xsl:call-template>
				<!-- Text -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-text" />
					<xsl:with-param name="content">
						<xsl:choose>
							<xsl:when test="$url-language = 'fr'">
								<p>Ce site est protégé par reCATPCHA et la <a href="https://policies.google.com/privacy">politique de confidentialité</a> et les <a href="https://policies.google.com/terms">termes et conditions</a> de Google s'appliquent.</p>
							</xsl:when>
							<xsl:otherwise>
								<p>This site is protected by reCAPTCHA and the Google <a href="https://policies.google.com/privacy">Privacy Policy</a> and <a href="https://policies.google.com/terms">Terms of Service</a> apply.</p>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
