<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="form-control.xsl" />

<!-- CORE COMPONENT : form-field-radio =======================================================-->
	<xsl:template name="form-field-radio">
		<!-- Field -->
		<xsl:param name="name"/>
		<!-- Optional -->
		<xsl:param name="attr"/>
		<xsl:param name="value"/>
		<xsl:param name="checked"/>
		<!-- States -->
		<xsl:param name="class-error"/>
		<xsl:param name="class-valid"/>
		<xsl:param name="class-empty"/>
		<xsl:param name="class-not-empty"/>
		<!-- Options -->
		<xsl:param name="disabled" select="false()"/>
		<!-- Validations -->
		<xsl:param name="rules"/>
		<xsl:param name="required" select="contains($rules, 'required')"/>

		<!-- Ctn -->
		<xsl:param name="ctn-attr"/>
		<!-- States -->
		<xsl:param name="ctn-class-error"/>
		<xsl:param name="ctn-class-valid"/>
		<xsl:param name="ctn-class-empty"/>
		<xsl:param name="ctn-class-not-empty"/>

		<!-- Inner ctn -->
		<xsl:param name="inner-ctn-attr"/>

		<!-- Label -->
		<xsl:param name="label"/>
		<xsl:param name="label-attr"/>
		<!-- States -->
		<xsl:param name="label-class-error"/>
		<xsl:param name="label-class-valid"/>
		<xsl:param name="label-class-empty"/>
		<xsl:param name="label-class-not-empty"/>
		<!-- Options -->
		<xsl:param name="label-after-input" select="true()"/>
		<xsl:param name="label-is-optional" select="true()"/>

		<!-- Error message -->
		<xsl:param name="error-message-attr"/>
		<xsl:param name="error-message-class-when-on"/>
		<xsl:param name="error-message-is-optional" select="false()"/>

		<!-- All Flag (valid, error, required) -->
		<xsl:param name="flag-attr"/>
		
		<!-- Valid flag -->
		<xsl:param name="valid-flag"/>
		<xsl:param name="valid-flag-attr"/>
		<xsl:param name="valid-flag-class-when-on"/>
		<xsl:param name="valid-flag-is-optional" select="true()" />

		<!-- Error flag -->
		<xsl:param name="error-flag"/>
		<xsl:param name="error-flag-attr"/>
		<xsl:param name="error-flag-class-when-on"/>
		<xsl:param name="error-flag-is-optional" select="true()" />

		<!-- Required flag -->
		<xsl:param name="required-flag"/>
		<xsl:param name="required-flag-attr"/>
		<xsl:param name="required-flag-class-when-on"/>
		<xsl:param name="required-flag-is-optional" select="true()" />

		<xsl:param name="clear-class"/>
		<xsl:param name="progress-class"/>
		
		<xsl:param name="id">
			<xsl:call-template name="form-control-create-field-id">
				<xsl:with-param name="name" select="$name"/>
			</xsl:call-template>
		</xsl:param>

		<xsl:variable name="computed-attr">
			<add type="radio"/>
			<xsl:copy-of select="$attr" />
			<add dev-core="form-field-checkbox"/>
		</xsl:variable>
		
		<xsl:call-template name="form-control">
			<!-- Field -->
			<xsl:with-param name="name" select="$name" />
			<xsl:with-param name="element" select="'input'" />
			<!-- Optional -->
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="value" select="$value" />
			<xsl:with-param name="checked" select="$checked" />
			<!-- States -->
			<xsl:with-param name="class-error" select="$class-error" />
			<xsl:with-param name="class-valid" select="$class-valid" />
			<xsl:with-param name="class-empty" select="$class-empty" />
			<xsl:with-param name="class-not-empty" select="$class-not-empty" />
			<!-- Options -->
			<xsl:with-param name="disabled" select="$disabled" />
			<!-- Validations -->
			<xsl:with-param name="rules" select="$rules" />
			<xsl:with-param name="required" select="$required" />
			
			<!-- Ctn -->
			<xsl:with-param name="ctn-attr" select="$ctn-attr" />
			<!-- States -->
			<xsl:with-param name="ctn-class-error" select="$ctn-class-error" />
			<xsl:with-param name="ctn-class-valid" select="$ctn-class-valid" />
			<xsl:with-param name="ctn-class-empty" select="$ctn-class-empty" />
			<xsl:with-param name="ctn-class-not-empty" select="$ctn-class-not-empty" />
			
			<!-- Inner ctn -->
			<xsl:with-param name="inner-ctn-attr" select="$inner-ctn-attr" />

			<!-- Label -->
			<xsl:with-param name="label" select="$label" />
			<xsl:with-param name="label-attr" select="$label-attr" />
			<!-- States -->
			<xsl:with-param name="label-class-error" select="$label-class-error" />
			<xsl:with-param name="label-class-valid" select="$label-class-valid" />
			<xsl:with-param name="label-class-empty" select="$label-class-empty" />
			<xsl:with-param name="label-class-not-empty" select="$label-class-not-empty" />
			<!-- Options -->
			<xsl:with-param name="label-after-input" select="$label-after-input" />
			<xsl:with-param name="label-is-optional" select="$label-is-optional" />
			
			<!-- Error message -->
			<xsl:with-param name="error-message-attr" select="$error-message-attr" />
			<xsl:with-param name="error-message-class-when-on" select="$error-message-class-when-on"/>
			<xsl:with-param name="error-message-is-optional" select="$error-message-is-optional" />
			
			<!-- All Flag (valid, error, required) -->
			<xsl:with-param name="flag-attr" select="$flag-attr" />

			<!-- Valid flag -->
			<xsl:with-param name="valid-flag" select="$valid-flag"/>
			<xsl:with-param name="valid-flag-attr" select="$valid-flag-attr"/>
			<xsl:with-param name="valid-flag-class-when-on" select="$valid-flag-class-when-on"/>
			<xsl:with-param name="valid-flag-is-optional" select="$valid-flag-is-optional" />

			<!-- Error flag -->
			<xsl:with-param name="error-flag" select="$error-flag"/>
			<xsl:with-param name="error-flag-attr" select="$error-flag-attr"/>
			<xsl:with-param name="error-flag-class-when-on" select="$error-flag-class-when-on"/>
			<xsl:with-param name="error-flag-is-optional" select="$error-flag-is-optional" />

			<!-- Required flag -->
			<xsl:with-param name="required-flag" select="$required-flag"/>
			<xsl:with-param name="required-flag-attr" select="$required-flag-attr"/>
			<xsl:with-param name="required-flag-class-when-on" select="$required-flag-class-when-on"/>
			<xsl:with-param name="required-flag-is-optional" select="$required-flag-is-optional" />

			<xsl:with-param name="clear-class" select="$clear-class" />
			<xsl:with-param name="progress-class" select="$progress-class" />
			
			<xsl:with-param name="id" select="$id" />
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
