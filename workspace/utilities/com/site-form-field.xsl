<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:math="http://exslt.org/math"
	exclude-result-prefixes="math exsl">


<!-- DEFAULT FORM FIELD STYLE ===================================================================-->
	<!-- Field -->
		<xsl:variable name="form-field-default-style">
			<add class="width-full" />
		</xsl:variable>
		<!-- Valid state -->
		<xsl:variable name="form-field-valid-default-style">
			
		</xsl:variable>
		<!-- Error state -->
		<xsl:variable name="form-field-error-default-style">
			
		</xsl:variable>

	<!-- ctn -->
		<xsl:variable name="form-field-ctn-default-style">
			<add class="flexbox" />
			<add class="width-full" />
		</xsl:variable>

	<!-- Inner ctn -->
		<xsl:variable name="form-field-inner-ctn-default-style">
			<add class="relative" />
			<add class="width-full" />
			<add class="flexbox" />
		</xsl:variable>

	<!-- Label-->
		<xsl:variable name="form-field-label-default-style">
			<add class="pointer-events-none" />
			<add class="transition-opacity transition-duration-faster" />
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
		</xsl:variable>

<!-- DEFAULT FORM FIELD INPUT STYLE =======================================================-->
	<!-- Field -->
		<xsl:variable name="form-field-input-default-style">
			<xsl:copy-of select="$form-field-input-basic-style" />
		</xsl:variable>

	<!-- Label -->
		<xsl:variable name="form-field-input-label-default-style" >
			<xsl:copy-of select="$form-field-input-label-basic-style" />
		</xsl:variable>

	<!-- Error message -->
		<xsl:variable name="form-field-input-error-message-default-style">
		</xsl:variable>

<!-- site-form-field-input ================================================================-->
	<xsl:template name="site-form-field-input">
		<xsl:param name="name"/>
		<xsl:param name="attr"/>
		<xsl:param name="value"/>
		<xsl:param name="label"/>
		<xsl:param name="placeholder"/>
		<xsl:param name="rules" />
		
		<xsl:variable name="label-class-empty">
			<xsl:text></xsl:text>
		</xsl:variable>

		<xsl:variable name="label-class-not-empty">
			<xsl:text></xsl:text>
		</xsl:variable>

		<xsl:call-template name="form-field-input">
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="value" select="$value" />
			<xsl:with-param name="placeholder" select="$placeholder" />
			<xsl:with-param name="label" select="$label" />
			<xsl:with-param name="label-class-empty" select="$label-class-empty" />
			<xsl:with-param name="label-class-not-empty" select="$label-class-not-empty" />
			<xsl:with-param name="rules" select="$rules" />
			<!-- <xsl:with-param name="valid-flag" select="''"/> -->
			<!-- <xsl:with-param name="required-flag" select="''"/> -->
		</xsl:call-template>
	</xsl:template>

<!-- site-form-field-password ================================================================-->
	<xsl:template name="site-form-field-password">
		<xsl:param name="name"/>
		<xsl:param name="label"/>
		<xsl:param name="placeholder"/>
		<xsl:param name="rules" />

		<xsl:param name="attr"/>
		<xsl:param name="ctn-attr" />
		<xsl:param name="ctn-class-valid" />
		<xsl:param name="inner-ctn-attr" />
		<xsl:param name="label-attr" />
		<xsl:param name="flag-attr" />
		<xsl:param name="error-message-attr"/>

		<xsl:variable name="computed-attr-flag">
			<add class="display-none" />
			<xsl:copy-of select="$flag-attr" />
		</xsl:variable>

		<xsl:variable name="computed-attr-ctn">
			<xsl:copy-of select="$ctn-attr" />
		</xsl:variable>

		<xsl:variable name="computed-attr-inner-ctn">
			<xsl:copy-of select="$inner-ctn-attr" />
		</xsl:variable>

		<xsl:variable name="computed-attr-label">
			<xsl:copy-of select="$label-attr" />
		</xsl:variable>

		<xsl:variable name="computed-ctn-class-valid">
			<xsl:text>is-valid </xsl:text>
			<xsl:copy-of select="$ctn-class-valid" />
		</xsl:variable>

		<xsl:variable name="computed-error-message-attr">
			<!-- <add class="absolute top-full right" /> -->
			<add class="display-none-important" />
			<xsl:copy-of select="$error-message-attr" />
		</xsl:variable>

		<xsl:call-template name="form-field-input">
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="type" select="'password'" />
			<xsl:with-param name="placeholder" select="$placeholder" />
			<xsl:with-param name="label" select="$label" />
			<xsl:with-param name="rules" select="$rules" />
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="ctn-attr" select="$computed-attr-ctn" />
			<xsl:with-param name="ctn-class-valid" select="$computed-ctn-class-valid" />
			<xsl:with-param name="inner-ctn-attr" select="$computed-attr-inner-ctn" />
			<xsl:with-param name="label-attr" select="$computed-attr-label" />
			<xsl:with-param name="flag-attr" select="$computed-attr-flag" />
			<xsl:with-param name="error-message-attr" select="$computed-error-message-attr" />
		</xsl:call-template>
	</xsl:template>

<!-- site-form-field-input-date ===========================================================-->
	<xsl:template name="site-form-field-input-date">
		<xsl:param name="name"/>
		<xsl:param name="attr"/>
		<xsl:param name="label"/>
		<xsl:param name="placeholder"/>
		<xsl:param name="rules" />

		<xsl:variable name="label-class-empty">
			<xsl:text></xsl:text>
		</xsl:variable>

		<xsl:variable name="label-class-not-empty">
			<xsl:text></xsl:text>
		</xsl:variable>

		<xsl:call-template name="form-field-input">
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="placeholder" select="$placeholder" />
			<xsl:with-param name="label" select="$label" />
			<xsl:with-param name="label-class-not-empty" select="$label-class-not-empty" />
			<xsl:with-param name="label-class-empty" select="$label-class-empty" />
			<xsl:with-param name="rules" select="$rules" />

		</xsl:call-template>
	</xsl:template>

<!-- site-form-field-dropdown =============================================================-->
	<xsl:template name="site-form-field-dropdown">
		<xsl:param name="name"/>
		<xsl:param name="attr"/>
		<xsl:param name="label"/>
		<xsl:param name="placeholder"/>
		<xsl:param name="rules" />
		<xsl:param name="options" />
		
		<xsl:variable name="label-attr">
			<add class="absolute pointer-events-none color-mid-blue " />
		</xsl:variable>
		<xsl:variable name="label-class-empty">
			<xsl:text></xsl:text>
		</xsl:variable>
		
		<xsl:variable name="label-class-error">
			<xsl:text></xsl:text>
		</xsl:variable>

		<xsl:variable name="label-class-not-empty">
			<xsl:text></xsl:text>
		</xsl:variable>

		<xsl:variable name="computed-attr">
			<add class="text-indent-thinnest" />
			<xsl:copy-of select="$attr"/>
		</xsl:variable>

		<xsl:call-template name="form-field-list">
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="placeholder" select="$placeholder" />
			<xsl:with-param name="label" select="$label" />
			<xsl:with-param name="label-attr" select="$label-attr" />
			<xsl:with-param name="label-class-error" select="$label-class-error" />
			<xsl:with-param name="label-class-not-empty" select="$label-class-not-empty" />
			<xsl:with-param name="label-class-empty" select="$label-class-empty" />
			<xsl:with-param name="rules" select="$rules" />
			<xsl:with-param name="content" select="$options" />
			<xsl:with-param name="valid-flag" select="''"/>
			<xsl:with-param name="required-flag" select="''"/>
		</xsl:call-template>
	</xsl:template>

<!-- site-form-field-textarea =============================================================-->
	<xsl:template name="site-form-field-textarea">
		<xsl:param name="name"/>
		<xsl:param name="attr"/>
		<xsl:param name="label"/>
		<xsl:param name="placeholder"/>
		<xsl:param name="rules" />


		<xsl:variable name="label-class-empty">
			<xsl:text></xsl:text>
		</xsl:variable>

		<xsl:variable name="label-class-not-empty">
			<xsl:text></xsl:text>
		</xsl:variable>

		<xsl:variable name="computed-attr">
			<add class="min-height-tinier" />
			<xsl:copy-of select="$attr"/>
		</xsl:variable>
		
		<xsl:call-template name="form-field-textarea">
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="placeholder" select="$placeholder" />
			<xsl:with-param name="label" select="$label" />
			<xsl:with-param name="label-class-not-empty" select="$label-class-not-empty" />
			<xsl:with-param name="label-class-empty" select="$label-class-empty" />
			<xsl:with-param name="rules" select="$rules" />
		</xsl:call-template>
	</xsl:template>

<!-- site-form-field-checkbox =============================================================-->
	<xsl:template name="site-form-field-checkbox">
		<xsl:param name="name"/>
		<xsl:param name="attr"/>
		<xsl:param name="label"/>
		<xsl:param name="placeholder"/>
		<xsl:param name="rules" />

		<xsl:variable name="computed-attr-inner-ctn">
			<add class="align-items-center" />
			<rem class="flexbox width-full" />
			<add class="flexbox-inline" />
			<add dev-extended-by="site-form-field" />
		</xsl:variable>

		<xsl:variable name="computed-attr-label">
			<add class="text-shorter margin-left-thinnest" />
			<rem class="pointer-events-none" />
		</xsl:variable>

		<xsl:variable name="computed-attr-ctn">
			<rem class="flexbox width-full" />
			<add class="flexbox-inline" />
			<add dev-extended-by="site-form-field" />
		</xsl:variable>

		<xsl:variable name="computed-attr-error-message">
			<rem class="bottom-nano" />
			<add class="margin-top-thinnest top-full" />
			<add dev-extended-by="site-form-field" />
		</xsl:variable>

		<xsl:call-template name="form-field-checkbox">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="ctn-attr" select="$computed-attr-ctn"/>
			<xsl:with-param name="inner-ctn-attr" select="$computed-attr-inner-ctn"/>
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="label" select="$label" />
			<xsl:with-param name="error-message-attr" select="$computed-attr-error-message"/>
			<xsl:with-param name="label-attr" select="$computed-attr-label"/>
			<xsl:with-param name="rules" select="$rules" />
		</xsl:call-template>
	</xsl:template>

<!-- site-form-field-file =================================================================-->
	<xsl:template name="site-form-field-file">
		<xsl:param name="name"/>
		<xsl:param name="attr"/>
		<xsl:param name="label"/>
		<xsl:param name="placeholder"/>
		<xsl:param name="rules" />
		
		<xsl:variable name="label-class-empty">
		 <xsl:text></xsl:text>
		</xsl:variable>

		<xsl:variable name="label-class-not-empty">
			<xsl:text></xsl:text>
		</xsl:variable>
		
		<xsl:variable name="preview-attr">
			<add class="max-width-broader flexbox z-index-1 absolute right-thinnest top-thinnest bottom-thinnest flex-column justify-content-center" />
			<add class="broder-radius-sharper overflow-hidden" />
			<add data-preview-class="width-full" />
		</xsl:variable>

		<xsl:call-template name="form-field-file">
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="placeholder" select="$placeholder" />
			<xsl:with-param name="label" select="$label" />
			<xsl:with-param name="label-class-empty" select="$label-class-empty" />
			<xsl:with-param name="label-class-not-empty" select="$label-class-not-empty" />
			<xsl:with-param name="rules" select="$rules" />
			<!-- <xsl:with-param name="valid-flag" select="''"/> -->
			<!-- <xsl:with-param name="required-flag" select="''"/> -->
			<xsl:with-param name="preview-attr" select="$preview-attr" />
		</xsl:call-template>
	</xsl:template>

<!-- Site form field button =====================================================-->
	<xsl:template name="site-form-field-button">
		<xsl:param name="content" />

		<xsl:param name="attr" />
		<xsl:param name="attr-ctn" />

		<!-- ATTRIBUTES -->
		<xsl:variable name="computed-attr">
			<xsl:copy-of select="$attr" />

			<!-- Is active -->
			<add class="js-form-btn-submit" />
			<add data-active-state-add-class="bg-color-white color-black color-white-on-hover bg-color-accent-light-on-hover cursor-pointer" />
			<add data-active-state-rem-class="bg-color-accent-dark color-white" />
		</xsl:variable>

		<!-- CLASSES -->
		<xsl:call-template name="form-field-button">
			<xsl:with-param name="content" select="$content" />
			<xsl:with-param name="attr" select="$computed-attr" />
			<xsl:with-param name="ctn-attr" select="$attr-ctn" />
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
