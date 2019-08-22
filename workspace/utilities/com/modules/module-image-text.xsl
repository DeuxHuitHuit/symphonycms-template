<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: module-image-text -->
	<xsl:template name="module-image-text" match="item[@section = 'module-image-text']" mode="module">
		<xsl:param name="image" select="image" />
		<xsl:param name="alt" select="alt" />
		<xsl:param name="text" select="text" />
		<xsl:param name="computed-text">
			<xsl:call-template name="util-rewrite-markdown">
				<xsl:with-param name="text" select="$text"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="is-inverted" select="inverted = 'Yes'" />
		<xsl:param name="ext-attr" />

		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="module-image-text" />
		</xsl:variable>

		<xsl:variable name="attr-ctn">
			<add dev-extended-by="module-image" />
		</xsl:variable>

		<xsl:variable name="attr-grid">
			<add class="flexbox" />
			<xsl:copy-of select="$recipe-gutter-h-card" />
			<xsl:copy-of select="$recipe-gutter-v-card" />
			<!-- OPTION: is-inverted -->
			<xsl:if test="$is-inverted">
				<add class="flex-row-reverse" />
			</xsl:if>
			<add dev-element="grid" />
		</xsl:variable>

		<xsl:variable name="attr-image-ctn">
			<add class="width-1_2" />
			<xsl:copy-of select="$recipe-gutter-h-card-item" />
			<xsl:copy-of select="$recipe-gutter-v-card-item" />
			<add dev-element="image-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-text-ctn">
			<add class="width-1_2" />
			<xsl:copy-of select="$recipe-gutter-h-card-item" />
			<xsl:copy-of select="$recipe-gutter-v-card-item" />
			<add dev-element="text-ctn" />
		</xsl:variable>

		<xsl:variable name="attr-text">
			<xsl:copy-of select="$recipe-markdown-normal" />
			<add dev-element="text" />
		</xsl:variable>

		<!-- STRUCTURE -->
		<xsl:call-template name="module">
			<xsl:with-param name="ext-attr" select="$attr" />
			<xsl:with-param name="ext-attr-ctn" select="$attr-ctn" />
			<xsl:with-param name="transition-name" select="'transition-module-image-text'" />
			<xsl:with-param name="content">
				<!-- Grid -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-grid" />
					<xsl:with-param name="content">
						<!-- Image ctn -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-image-ctn" />
							<xsl:with-param name="content">
								<!-- Picture -->
								<xsl:call-template name="picture">
									<xsl:with-param name="image" select="$image" />
									<xsl:with-param name="alt" select="$alt" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- Text ctn -->
						<xsl:call-template name="element">
							<xsl:with-param name="attr" select="$attr-text-ctn" />
							<xsl:with-param name="content">
								<!-- Text -->
								<xsl:call-template name="element">
									<xsl:with-param name="attr" select="$attr-text" />
									<xsl:with-param name="content" select="$computed-text" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
