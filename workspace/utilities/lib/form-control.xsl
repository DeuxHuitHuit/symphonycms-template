<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:math="http://exslt.org/math"
	exclude-result-prefixes="math exsl">

<xsl:import href="form-control-create-id.xsl" />
<xsl:import href="form-field-label.xsl" />
<xsl:import href="form-control-icon-valid.xsl" />
<xsl:import href="form-control-icon-error.xsl" />
<xsl:import href="form-control-icon-required.xsl" />

<!-- DEFAULT STYLE ==============================================================================-->
	<!-- Field -->
		<xsl:variable name="form-field-default-style">
			
		</xsl:variable>
		<!-- Valid state -->
		<xsl:variable name="form-field-valid-default-style">
			
		</xsl:variable>
		<!-- Error state -->
		<xsl:variable name="form-field-error-default-style">
			
		</xsl:variable>

	<!-- ctn -->
		<xsl:variable name="form-field-ctn-default-style">
			
		</xsl:variable>

	<!-- Inner ctn -->
		<xsl:variable name="form-field-inner-ctn-default-style">
			<add class="relative" />
		</xsl:variable>

	<!-- Error message -->
		<xsl:variable name="form-field-error-message-default-style">
			<add class="pointer-events-none" />
		</xsl:variable>

	<!-- All flag -->
		<xsl:variable name="form-field-flag-default-style">
			<add class="pointer-events-none" />
		</xsl:variable>

	<!-- Valid flag -->
		<xsl:variable name="form-field-valid-flag-default-style">
			
		</xsl:variable>

	<!-- Error flag -->
		<xsl:variable name="form-field-error-flag-default-style">
			
		</xsl:variable>

	<!-- Required flag -->
		<xsl:variable name="form-field-required-flag-default-style">
			<add class="pointer-events-none " />
		</xsl:variable>

<!-- CORE COMPONENT : form-field ================================================================-->
	<xsl:template name="form-control">
		<!-- Field -->
		<xsl:param name="name"/>
		<xsl:param name="element" select="'input'" />
		<!-- Optional -->
		<xsl:param name="attr"/>
		<xsl:param name="value"/>
		<!-- States -->
		<xsl:param name="class-error"/>
		<xsl:param name="class-valid"/>
		<xsl:param name="class-empty"/>
		<xsl:param name="class-not-empty"/>
		<!-- Options -->
		<xsl:param name="disabled" select="false()" />
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
		<xsl:param name="inner-ctn-attr" />

		<!-- Label -->
		<xsl:param name="label"/>
		<xsl:param name="label-attr"/>
		<!-- States -->
		<xsl:param name="label-class-error"/>
		<xsl:param name="label-class-valid"/>
		<xsl:param name="label-class-empty"/>
		<xsl:param name="label-class-not-empty"/>
		<!-- Options -->
		<xsl:param name="label-after-input" select="false()"/>
		<xsl:param name="label-is-optional" select="true()" />

		<!-- Error message -->
		<xsl:param name="error-message-attr" />
		<xsl:param name="error-message-class-when-on"/>
		<xsl:param name="error-message-is-optional" select="false()" />

		<!-- All Flag (valid, error, required) -->
		<xsl:param name="flag-attr" />

		<!-- Valid flag -->
		<xsl:param name="valid-flag" />
		<xsl:param name="valid-flag-attr" />
		<xsl:param name="valid-flag-class-when-on"/>
		<xsl:param name="valid-flag-is-optional" select="true()" />

		<!-- Error flag -->
		<xsl:param name="error-flag" />
		<xsl:param name="error-flag-attr"/>
		<xsl:param name="error-flag-class-when-on"/>
		<xsl:param name="error-flag-is-optional" select="true()" />

		<!-- Required flag -->
		<xsl:param name="required-flag" />
		<xsl:param name="required-flag-attr"/>
		<xsl:param name="required-flag-class-when-on"/>
		<xsl:param name="required-flag-is-optional" select="true()" />

		<xsl:param name="clear-class"/>
		<xsl:param name="progress-class"/>
		<xsl:param name="preview-attr"/>
		<xsl:param name="preview-is-optional" select="true()" />
		
		<!-- id (auto-generated from name)-->
		<xsl:param name="id">
			<xsl:call-template name="form-control-create-field-id">
				<xsl:with-param name="name" select="$name"/>
			</xsl:call-template>
		</xsl:param>
		
		<xsl:param name="content"/>
	<!-- 																	/-->

	<!-- COMPUTED FLAG 														 -->
		<xsl:variable name="is-empty" select="string-length($value) = 0"/>
	<!-- 																	/-->

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">

			<!-- Required class -->
			<xsl:if test="$required = true()">
				<add class="required" />
				<add aria-required="true" />
			</xsl:if>

			<!-- Disabled class -->
			<xsl:if test="$disabled = 'Yes' or $disabled = 'disabled' or $disabled = true()">
				<add class="disabled" />
			</xsl:if>

			<!-- Name attr -->
			<add name="{$name}" />

			<!-- id attr -->
			<xsl:if test="string-length($id) != 0">
				<add id="{$id}" />
			</xsl:if>
			
			<!-- State class -->
			<xsl:if test="string-length($class-error) != 0">
				<add data-error-class="{$class-error}" />
			</xsl:if>

			<xsl:if test="string-length($class-valid) != 0">
				<add data-valid-class="{$class-valid}" />
			</xsl:if>

			<xsl:if test="string-length($class-empty) != 0">
				<add data-empty-class="{$class-empty}" />
			</xsl:if>

			<xsl:if test="string-length($class-not-empty) != 0">
				<add data-not-empty-class="{$class-not-empty}" />
			</xsl:if>
			
			<!-- value -->
			<xsl:if test="string-length($value) != 0">
				<add value="{$value}" />
			</xsl:if>

			<!-- Js Class -->
			<add class="js-form-input" />

			<!-- Merge -->
			<xsl:copy-of select="$form-field-default-style" />
			<xsl:copy-of select="$attr" />

			<!-- Name -->
			<add dev-core="form-field" />
		</xsl:variable>

		<!-- ctn -->
		<xsl:variable name="computed-ctn-attr">

			<!-- Initial empty or not empty class -->
			<xsl:choose>
				<xsl:when test="string-length($value) != 0">
					<add class="{$ctn-class-not-empty}" />
				</xsl:when>
				<xsl:otherwise>
					<add class="{$ctn-class-empty}" />
				</xsl:otherwise>
			</xsl:choose>

			<!-- Empty class attribute -->
			<xsl:if test="string-length($ctn-class-empty) != 0">
				<add data-empty-class="{$ctn-class-empty}" />
			</xsl:if>

			<!-- Not empty class attribute -->
			<xsl:if test="string-length($ctn-class-not-empty) != 0">
				<add data-not-empty-class="{$ctn-class-not-empty}" />
			</xsl:if>

			<!-- Rules attributes -->
			<xsl:if test="string-length($rules) != 0">
				<add data-rules="{$rules}" />
			</xsl:if>

			<!-- Error class attribute -->
			<xsl:if test="string-length($ctn-class-error) != 0">
				<add data-error-class="{$ctn-class-error}" />
			</xsl:if>

			<!-- Valid class attribute -->
			<xsl:if test="string-length($ctn-class-valid) != 0">
				<add data-valid-class="{$ctn-class-valid}" />
			</xsl:if>

			<!-- Merge -->
			<xsl:copy-of select="$form-field-ctn-default-style" />
			<xsl:copy-of select="$ctn-attr" />
			
			<add dev-extended-by="form-field" />
		</xsl:variable>

		<!-- inner-ctn -->
		<xsl:variable name="computed-inner-ctn-attr">
			<xsl:copy-of select="$form-field-inner-ctn-default-style" />
			<xsl:copy-of select="$inner-ctn-attr" />

			<add dev-core-element="inner-ctn" />
		</xsl:variable>

		<!-- label -->
		<xsl:variable name="computed-label-attr">

			<xsl:choose>
				<!-- empty class -->
				<xsl:when test="$is-empty = true()">
					<add class="{$label-class-empty}" />
				</xsl:when>
				<!-- not empty class -->
				<xsl:otherwise>
					<add class="{$label-class-not-empty}" />
				</xsl:otherwise>
			</xsl:choose>

			<!-- For js state behavior -->
			<!-- empty data class -->
			<xsl:if test="string-length($label-class-empty) != 0">
				<add data-empty-class="{$label-class-empty}" />
			</xsl:if>

			<!-- not empty data class -->
			<xsl:if test="string-length($label-class-not-empty) != 0">
				<add data-not-empty-class="{$label-class-not-empty}" />
			</xsl:if>

			<!-- Disabled class -->
			<xsl:if test="$disabled = 'Yes' or $disabled = 'disabled' or $disabled = true()">
				<add class="is-disabled" />
			</xsl:if>
			
			<add data-error-class="{$label-class-error}" />
			<add data-valid-class="{$label-class-valid}" />

			<!-- For -->
			<add for="{$id}" />

			<!-- js-class -->
			<add class="js-form-label" />
			
			<xsl:copy-of select="$label-attr" />
			<add dev-extended-by="form-field" />
		</xsl:variable>

		<!-- error-message -->
		<xsl:variable name="computed-error-message-attr">
			<!-- For js state behavior -->
			<xsl:if test="string-length($error-message-class-when-on) != 0">
				<add data-state-class="{$error-message-class-when-on}" />
			</xsl:if>

			<add class="js-form-error" />

			<xsl:copy-of select="$form-field-error-message-default-style" />
			<xsl:copy-of select="$error-message-attr" />
			<add dev-core-element="error-message" />
		</xsl:variable>

		<!-- valid-flag -->
		<xsl:variable name="computed-valid-flag-attr">

			<!-- For js valid-state behavior -->
			<add data-state="valid" />
			
			<xsl:if test="string-length($valid-flag-class-when-on) != 0">
				<add data-state-class="{$valid-flag-class-when-on}" />
			</xsl:if>

			<add class="js-form-state" />

			<xsl:copy-of select="$form-field-flag-default-style" />
			<xsl:copy-of select="$form-field-valid-flag-default-style" />
			<xsl:copy-of select="$flag-attr" />
			<xsl:copy-of select="$valid-flag-attr" />
			
			<add dev-core-element="valid-flag" />
		</xsl:variable>

		<!-- Error flag -->
		<xsl:variable name="computed-error-flag-attr">
			
			<!-- For js valid-state behavior -->
			<add data-state="error" />
			<xsl:if test="string-length($error-flag-class-when-on) != 0">
				<add data-state-class="{$error-flag-class-when-on}" />
			</xsl:if>
			<add class="js-form-state" />

			<xsl:copy-of select="$form-field-flag-default-style" />
			<xsl:copy-of select="$form-field-error-flag-default-style" />
			<xsl:copy-of select="$flag-attr" />
			<xsl:copy-of select="$error-flag-attr" />

			<!-- Name -->
			<add dev-core-element="error-flag" />
		</xsl:variable>

		<!-- Required flag -->
		<xsl:variable name="computed-required-flag-attr">

			<xsl:copy-of select="$form-field-flag-default-style" />
			<xsl:copy-of select="$form-field-required-flag-default-style" />
			<xsl:copy-of select="$flag-attr" />
			<xsl:copy-of select="$required-flag-attr" />

			<add dev-core-element="required-flag" />
		</xsl:variable>

		<!-- Progress -->
		<xsl:variable name="computed-progress-attr">
			<add class="{$progress-class}" />
			<add class="js-form-progress" />
		</xsl:variable>

		<!-- Clear -->
		<xsl:variable name="computed-clear-attr">
			<add class="{$clear-class}" />
			<add class="js-form-clear" />
		</xsl:variable>

		<!-- Preview -->
		<xsl:variable name="computed-preview-attr">
			<xsl:copy-of select="$preview-attr" />
			<add class="js-form-preview" />
		</xsl:variable>
	<!-- 																	/-->

	<!-- COMPUTED VALUE 													 -->
		<!-- cached label output -->
		<xsl:variable name="computed-label">
			<xsl:call-template name="form-field-label">
				<xsl:with-param name="attr" select="$computed-label-attr" />
				<xsl:with-param name="is-optional" select="$label-is-optional" />
				<xsl:with-param name="content" select="$label" />
			</xsl:call-template>
		</xsl:variable>
	<!-- 																	/-->

	<!-- STRUCTURE 															 -->

	<!-- Ctn -->
		<xsl:call-template name="form-field-container">
			<xsl:with-param name="attr" select="$computed-ctn-attr"/>
			<xsl:with-param name="content">
				
				<!-- Inner ctn -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$computed-inner-ctn-attr"/>
					<xsl:with-param name="content">

						<!-- Label -->
						<xsl:if test="$label-after-input = false()">
							<xsl:copy-of select="$computed-label" />
						</xsl:if>

						<!-- Error Message -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$computed-error-message-attr"/>
							<xsl:with-param name="is-optional" select="$error-message-is-optional" />
						</xsl:call-template>

						<!-- Valid flag -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$computed-valid-flag-attr"/>
							<xsl:with-param name="content" select="$valid-flag" />
							<xsl:with-param name="is-optional" select="$valid-flag-is-optional" />
						</xsl:call-template>

						<!-- Error flag -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$computed-error-flag-attr"/>
							<xsl:with-param name="content" select="$error-flag" />
							<xsl:with-param name="is-optional" select="$error-flag-is-optional" />
						</xsl:call-template>
						
						<!-- Required flag -->
						<xsl:if test="$required = true()">
							<xsl:call-template name="element">
								<xsl:with-param name="attr" select="$computed-required-flag-attr"/>
								<xsl:with-param name="content" select="$required-flag" />
								<xsl:with-param name="is-optional" select="$required-flag-is-optional" />
							</xsl:call-template>
						</xsl:if>

						<!-- field -->
						<xsl:call-template name="element">
							<xsl:with-param name="element" select="$element"/>
							<xsl:with-param name="attr" select="$computed-attr" />
							<xsl:with-param name="content" select="$content" />
						</xsl:call-template>

						<!-- Progress -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$computed-progress-attr"/>
							<xsl:with-param name="is-optional" select="true()" />
							<xsl:with-param name="content" select="''" />
						</xsl:call-template>

						<!-- Label -->
						<xsl:if test="$label-after-input = true()">
							<xsl:copy-of select="$computed-label" />
						</xsl:if>

						<!-- Clear -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$computed-clear-attr"/>
							<xsl:with-param name="is-optional" select="true()" />
							<xsl:with-param name="content">
								<!-- not needed in our case -->
								<!-- xsl:call-template name="form-control-icon-x" /-->
							</xsl:with-param>
						</xsl:call-template>
						
						<!-- Preview -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$computed-preview-attr"/>
							<xsl:with-param name="is-optional" select="$preview-is-optional" />
							<xsl:with-param name="content" select="''" />
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	<!-- 																	/-->
	</xsl:template>

<!-- CORE ELEMENT : form-field-container ========================================================-->
	<xsl:template name="form-field-container">
		<xsl:param name="attr"/>
		<xsl:param name="content"/>

	<!-- COMPUTED ATTRIBUTES 												 -->
		<xsl:variable name="computed-attr">
			<!-- js class -->
			<add class="js-form-field" />
			<!-- Merge -->
			<xsl:copy-of select="$attr" />
			<!-- Name -->
			<add dev-core-element="ctn" />
		</xsl:variable>
	<!-- 																	/-->

	<!-- STRUCTURE 															 -->
		<xsl:call-template name="optional-element">
			<xsl:with-param name="attr" select="$computed-attr"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	<!-- 																	/-->
	</xsl:template>
</xsl:stylesheet>
