<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ITEM: facebook -->
	<xsl:template match="item[type/item/@handle = 'facebook']" mode="nav-social-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-social-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: link -->
				<xsl:call-template name="button-link">
					<xsl:with-param name="label" select="'Facebook'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- ITEM: twitter -->
	<xsl:template match="item[type/item/@handle = 'twitter']" mode="nav-social-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-social-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: link -->
				<xsl:call-template name="button-link">
					<xsl:with-param name="label" select="'Twitter'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- ITEM: instagram -->
	<xsl:template match="item[type/item/@handle = 'instagram']" mode="nav-social-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-social-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: link -->
				<xsl:call-template name="button-link">
					<xsl:with-param name="label" select="'Instagram'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- ITEM: youtube -->
	<xsl:template match="item[type/item/@handle = 'youtube']" mode="nav-social-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-social-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: link -->
				<xsl:call-template name="button-link">
					<xsl:with-param name="label" select="'Youtube'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- ITEM: linkedin -->
	<xsl:template match="item[type/item/@handle = 'linkedin']" mode="nav-social-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-social-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: link -->
				<xsl:call-template name="button-link">
					<xsl:with-param name="label" select="'LinkedIn'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- ITEM: pinterest -->
	<xsl:template match="item[type/item/@handle = 'pinterest']" mode="nav-social-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-social-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: link -->
				<xsl:call-template name="button-link">
					<xsl:with-param name="label" select="'Pinterest'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<!-- ITEM: vimeo -->
	<xsl:template match="item[type/item/@handle = 'vimeo']" mode="nav-social-item">
		<xsl:param name="ext-attr" />

		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr" />
			<add dev-element="nav-social-item" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- BUTTON: link -->
				<xsl:call-template name="button-link">
					<xsl:with-param name="label" select="'Vimeo'" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
