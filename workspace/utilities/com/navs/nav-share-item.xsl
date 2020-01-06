<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ITEM: facebook -->
	<xsl:template match="item[@target = 'facebook']" mode="nav-share-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-share-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: share -->
				<xsl:call-template name="button-share">
					<xsl:with-param name="content" select="'Facebook'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- ITEM: twitter -->
	<xsl:template match="item[@target = 'twitter']" mode="nav-share-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-share-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: share -->
				<xsl:call-template name="button-share">
					<xsl:with-param name="content" select="'Twitter'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- ITEM: linkedin -->
	<xsl:template match="item[@target = 'linkedin']" mode="nav-share-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-share-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: share -->
				<xsl:call-template name="button-share">
					<xsl:with-param name="content" select="'LinkedIn'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- ITEM: email -->
	<xsl:template match="item[@target = 'email']" mode="nav-share-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-share-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: share -->
				<xsl:call-template name="button-share">
					<xsl:with-param name="content" select="'Email'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
