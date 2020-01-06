<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ITEM: checkbox -->
	<xsl:template match="item[multiselect='Yes']/options/item" mode="form-field-list-item">
		<xsl:param name="name" />
		<xsl:param name="value" select="value/@handle" />
		<xsl:param name="id">
			<xsl:call-template name="util-form-id">
				<xsl:with-param name="name" select="$value"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="ext-attr" />

		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-list-item" />
		</xsl:variable>

		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<xsl:call-template name="form-field-checkbox">
					<xsl:with-param name="name" select="$name" />
					<xsl:with-param name="id" select="$id" />
					<xsl:with-param name="value" select="$value" />
					<xsl:with-param name="ext-attr-input">
						<rem class="js-form-field-input" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>

<!-- ITEM: radio -->
	<xsl:template match="item[multiselect!='Yes']/options/item" mode="form-field-list-item">
		<xsl:param name="name" />
		<xsl:param name="value" select="value/@handle" />
		<xsl:param name="id">
			<xsl:call-template name="util-form-id">
				<xsl:with-param name="name" select="$value"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="ext-attr" />

		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-list-item" />
		</xsl:variable>

		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<xsl:call-template name="form-field-radio">
					<xsl:with-param name="name" select="$name" />
					<xsl:with-param name="id" select="$id" />
					<xsl:with-param name="value" select="$value" />
					<xsl:with-param name="ext-attr-input">
						<rem class="js-form-field-input" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
