<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- PLATE -->
<xsl:variable name="plate-button-white-on-dark-grey-short" type="button">
	<!-- Minimal -->
	<add dev-plate="button-colored-white-on-dark-grey-short" />
	<add class="inline-block" />

</xsl:variable>

<xsl:variable name="s-rounded-button" type="button">
	<add class="cursor-pointer" />
	<add class="inline-block" />
	<add class="bg-color-white  bg-color-yellow-on-hover color-dark-grey-on-hover" />
	<add class="color-grey" />
	<add class="text-short" />
	<add class="line-height-perfect" />
	<add class="padding-thinner padding-horizontal-broad" />
	<add class="border-radius-duller" />
	<add class="transition-duration-medium transition-ease-out-expo transition-bg-color-color" />
</xsl:variable>


<xsl:variable name="s-toolbar-square">
	<xsl:text>flexbox
		border-slimmest border-color-lighter-grey border-left-solid
		flex-basis-broad-plus-broader width-broad-plus-broader height-broad-plus-broader  flex-shrink-0</xsl:text>
</xsl:variable>

<xsl:variable name="s-nav-link">
	<add class="text-current color-dark-grey line-height-perfect font-weight-light text-nowrap" />
	<add class="animated-box-underlined border-color-light-grey" />
	<add class="transition-border-color transition-duration-faster" />
	<add data-selected-class-add="box-underlined border-color-grey" /> <!-- Attributes to sync js behavior with class -->
	<add data-selected-class-remove="animated-box-underlined border-color-light-grey" />
</xsl:variable>

<xsl:variable name="s-nav-link-selected">
	<add class="box-underlined border-color-grey" />
</xsl:variable>

</xsl:stylesheet>