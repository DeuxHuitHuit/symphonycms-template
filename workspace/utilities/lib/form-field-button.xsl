<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="form-control.xsl" />

<!-- CORE COMPONENT : form-field-button =========================================================-->
	<xsl:template name="form-field-button">
		<!-- Optional -->
		<xsl:param name="attr"/>
		<xsl:param name="name"/>
		
		<!-- State -->
		<xsl:param name="class-error"/>
		<xsl:param name="class-valid"/>
		
		<!-- Options -->
		<xsl:param name="disabled" select="false()"/>

		<!-- Ctn -->
		<xsl:param name="ctn-attr"/>
		<!-- States -->
		<xsl:param name="ctn-class-error"/>
		<xsl:param name="ctn-class-valid"/>

		<!-- Inner ctn -->
		<xsl:param name="inner-ctn-attr" />

		<!-- Label -->
		<xsl:param name="label"/>
		<xsl:param name="label-attr"/>
		<!-- States -->
		<xsl:param name="label-class-error"/>
		<xsl:param name="label-class-valid"/>
		
		<!-- Options -->
		<xsl:param name="label-after-input" select="false()"/>
		<xsl:param name="label-is-optional" select="true()" />

		<!-- Error message -->
		<xsl:param name="error-message-attr" />
		<xsl:param name="error-message-class-when-on"/>
		<xsl:param name="error-message-is-optional" select="true()" />

		<!-- All Flag (valid, error, ...) -->
		<xsl:param name="flag-attr" />

		<!-- Valid flag -->
		<xsl:param name="valid-flag" />
		<xsl:param name="valid-flag-attr" />
		<xsl:param name="valid-flag-class-when-on" select="$default-flag-class-when-on"/>
		<xsl:param name="valid-flag-is-optional" select="true()" />

		<!-- Error flag -->
		<xsl:param name="error-flag" />
		<xsl:param name="error-flag-attr"/>
		<xsl:param name="error-flag-class-when-on" select="$default-flag-class-when-on"/>
		<xsl:param name="error-flag-is-optional" select="true()" />
		<xsl:param name="id" />

		<xsl:param name="progress-class"/>
		
		<xsl:param name="content" select="$label"/>

		<xsl:variable name="computed-attr">
			<!-- Merge attr -->
			<rem class="js-form-input" />
			<xsl:copy-of select="$attr" />
			<add dev-extended-by="form-field-button" />
		</xsl:variable>

		<xsl:variable name="computed-ctn-attr">
			<rem class="js-form-field" />
			<xsl:copy-of select="$ctn-attr" />
			<add dev-extended-by="form-field-button" />
		</xsl:variable>
		
		<xsl:call-template name="form-control">
			<xsl:with-param name="element" select="'button'"/>
			<xsl:with-param name="content" select="$content" />
			<xsl:with-param name="name" select="$name" />
			<xsl:with-param name="id" select="$id" />

			<xsl:with-param name="attr" select="$computed-attr" />

			<xsl:with-param name="class-error" select="$class-error"/>
			<xsl:with-param name="class-valid" select="$class-valid"/>
			
			<xsl:with-param name="disabled" select="$disabled"/>

			<xsl:with-param name="ctn-attr" select="$computed-ctn-attr" />

			<xsl:with-param name="ctn-class-error" select="$ctn-class-error"/>
			<xsl:with-param name="ctn-class-valid" select="$ctn-class-valid"/>
			
			<xsl:with-param name="inner-ctn-attr" select="$inner-ctn-attr" />

			<xsl:with-param name="label" select="$label"/>
			<xsl:with-param name="label-attr" select="$label-attr" />
			<xsl:with-param name="label-class-error" select="$label-class-error"/>
			<xsl:with-param name="label-class-valid" select="$label-class-valid"/>
			<xsl:with-param name="label-after-input" select="$label-after-input" />
			<xsl:with-param name="label-is-optional" select="$label-is-optional" />

			<xsl:with-param name="error-message-attr" select="$error-message-attr"/>
			<xsl:with-param name="error-message-class-when-on" select="$error-message-class-when-on"/>
			<xsl:with-param name="error-message-is-optional" select="$error-message-is-optional" />

			<xsl:with-param name="flag-attr" select="$flag-attr" />

			<xsl:with-param name="valid-flag" select="$valid-flag" />
			<xsl:with-param name="valid-flag-attr" select="$valid-flag-attr" />
			<xsl:with-param name="valid-flag-class-when-on" select="$valid-flag-class-when-on" />
			<xsl:with-param name="valid-flag-is-optional" select="$valid-flag-is-optional" />

			<xsl:with-param name="error-flag" select="$error-flag" />
			<xsl:with-param name="error-flag-attr" select="$error-flag-attr" />
			<xsl:with-param name="error-flag-class-when-on" select="$error-flag-class-when-on" />
			<xsl:with-param name="error-flag-is-optional" select="$error-flag-is-optional" />

			<xsl:with-param name="progress-class" select="$progress-class"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
