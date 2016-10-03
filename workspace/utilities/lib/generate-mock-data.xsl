<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

<!-- MOCKING GENERATOR -->
<xsl:template name="generate-mock-data" >
	<xsl:param name="model" />
	<xsl:param name="params" select="/data/params"/>
	<xsl:param name="entities" select="$model/model/entities"/>
	<xsl:param name="data-templates" select="$entities/../fake-content" /> 

	<data>
		<xsl:copy-of select="$params" />

		<xsl:apply-templates select="$model/model/ds/*" mode="generate-mock-ds-data">
			<xsl:with-param name="entities" select="$entities" />
			<xsl:with-param name="model" select="$model/model" />
			<xsl:with-param name="data-templates" select="$data-templates" />
		</xsl:apply-templates>
	</data>
</xsl:template>


<xsl:template match="*" mode="generate-mock-ds-data">
	<xsl:param name="entities" />
	<xsl:param name="model" />
	<xsl:param name="data-templates" />

	<xsl:element name="{name()}">
		<xsl:variable name="ds" select="." />
		<xsl:variable name="section-name" select="./@section" />

		<xsl:if test="count($model/group-sections/*[name() = $section-name])">
			<xsl:variable name="section" select="$model/group-sections/*[name() = $section-name]" />
			<xsl:variable name="section-entities" select="$entities/*[name() = $section-name]" />

			<xsl:apply-templates select="$section-entities/*" mode="generate-mock-ds-entry-entity">
				<xsl:with-param name="model" select="$model" />
				<xsl:with-param name="section-name" select="$section-name" />
				<xsl:with-param name="entities" select="$entities" />
				<xsl:with-param name="data-templates" select="$data-templates"/>
				<xsl:with-param name="definition" select="$section"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:element>
</xsl:template>

<xsl:template match="*" mode="generate-mock-ds-entry-entity">
	<xsl:param name="model" />
	<xsl:param name="section-name" />
	<xsl:param name="entities" />
	<xsl:param name="data-templates" />
	<xsl:param name="definition" />
	<xsl:param name="is-sub-item" select="false()" />

	<xsl:variable name="entity-type" >
		<xsl:if test="$is-sub-item = true()">
			<xsl:text>item</xsl:text>
		</xsl:if>
		<xsl:if test="$is-sub-item = false()">
			<xsl:text>entry</xsl:text>
		</xsl:if>
	</xsl:variable>

	<xsl:variable name="entity-name" select="name()" />

	<xsl:element name="{$entity-type}" >
		<xsl:if test="$is-sub-item = true()">
			<xsl:variable name="parent" select=".."/>

			<!-- Add section attribute -->
			<xsl:attribute name="section">
				<xsl:value-of select="$section-name"/>
			</xsl:attribute>
		</xsl:if>

		<xsl:apply-templates select="@*" mode="generate-mock-entity-value" >
			<xsl:with-param name="model" select="$model" />
			<xsl:with-param name="entities" select="$entities" />
			<xsl:with-param name="entity" select="." />
			<xsl:with-param name="entity-name" select="$entity-name" />
			<xsl:with-param name="data-templates" select="$data-templates" />
			<xsl:with-param name="definition" select="$definition"/>
		</xsl:apply-templates>
	</xsl:element>
</xsl:template>

<xsl:template match="@*" mode="generate-mock-entity-value">
	<xsl:param name="model" />
	<xsl:param name="entities" />
	<xsl:param name="entity" />
	<xsl:param name="entity-name" />
	<xsl:param name="data-templates" />
	<xsl:param name="definition" />

	<xsl:variable name="field-name" select="name()" />
	<xsl:variable name="field-definition" select="$definition/*[name() = $field-name]"/>

	<!-- Check -->
	<xsl:if test="count($field-definition) = 0">
		<xsl:message>
			<xsl:text>Field definition not found for : </xsl:text>
			<xsl:value-of select="$field-name" />
		</xsl:message>
	</xsl:if>

	<xsl:if test="$field-name = 'image' or $field-name = 'img'">
		<xsl:message>
			<xsl:text>You can not use 'image' or 'img field-name'. Prefer explicit name like picture or photo.</xsl:text>
			<xsl:text>
</xsl:text>
			<xsl:text>entity name : </xsl:text>
			<xsl:value-of select="$entity-name" />
		</xsl:message>
	</xsl:if>
	<!-- Process -->
	<xsl:if test="count($field-definition) != 0">
		<xsl:choose>
			<!-- No Type : So Single line text or small text without markdown -->
			<xsl:when test="count($field-definition/@type) = 0">
				<!-- Single text element -->
				<xsl:element name="{$field-name}">
					<!-- Check for handle options -->
					<xsl:if test="string-length($field-definition/@options) != 0" >
						<xsl:variable name="options-tokens" select="str:tokenize($field-definition/@options, ' ')" />
						<xsl:if test="count($options-tokens[text() = 'handle']) != 0">
							<!-- Output handle -->
							<xsl:attribute name="handle">
								<xsl:value-of select="$entity-name" />
							</xsl:attribute>
						</xsl:if>
					</xsl:if>
					<!-- Ouput value -->
					<xsl:value-of select="." />
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<!-- Choose from type -->
				<xsl:variable name="value-type" select="$field-definition/@type" />
				<xsl:choose>
					<!-- Process image type -->
					<xsl:when test="$value-type = 'image'">
						<!-- Get Image Def -->
						<xsl:variable name="img-filename" select="." />
						
						<xsl:variable name="img-data" select="$data-templates/image[@name = $img-filename]" />

						<xsl:element name="{$field-name}">
							<xsl:attribute name="path">
								<xsl:text>/mock/assets/</xsl:text>
							</xsl:attribute>
							<xsl:attribute name="type">
								<xsl:text>image/jpeg</xsl:text>
							</xsl:attribute>

							<filename>
								<xsl:value-of select="$img-filename" />
							</filename>

							<meta>
								<xsl:attribute name="width" >
									<xsl:value-of select="$img-data/@width" />
								</xsl:attribute>
								<xsl:attribute name="height" >
									<xsl:value-of select="$img-data/@height" />
								</xsl:attribute>
							</meta>
						</xsl:element>
					</xsl:when>
					<!-- Process relation type -->
					<xsl:when test="$value-type = 'relation'">
						<xsl:element name="{$field-name}">
							<!-- Find section in definition -->
							<xsl:variable name="section-tokens" select="str:tokenize($field-definition/@sections, ',')" />

							<xsl:for-each select="str:tokenize($entity/@*[name() = $field-name], ',')" >
								<xsl:variable name="temp" select="text()" />

								<xsl:for-each select="$section-tokens">
									<xsl:variable name="section-child-name" select="text()" />
									<xsl:variable name="section" select="$model/group-sections/*[name() = $section-child-name]"/>
									<xsl:variable name="section-entities" select="$entities/*[name() = $section-child-name]" />

									<xsl:apply-templates select="$section-entities/*[name() = $temp]" mode="generate-mock-ds-entry-entity">
										<xsl:with-param name="model" select="$model" />
										<xsl:with-param name="section-name" select="$section-child-name" />
										<xsl:with-param name="entities" select="$entities" />
										<xsl:with-param name="definition" select="$section"/>
										<xsl:with-param name="is-sub-item" select="true()" />
										<xsl:with-param name="data-templates" select="$data-templates" />
									</xsl:apply-templates>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:element>
					</xsl:when>
					<!-- Process markdown type -->
					<xsl:when test="$value-type = 'markdown'">
						<xsl:variable name="markdown-name" select="." />

						<xsl:variable name="markdown-data" select="$data-templates/markdown[@name = $markdown-name]" />

						<xsl:element name="{$field-name}">
							<xsl:copy-of select="$markdown-data/*" />
						</xsl:element>
					</xsl:when>
					<!-- Process checkbox type -->
					<xsl:when test="$value-type = 'checkbox'">
						<xsl:element name="{$field-name}">
							<xsl:choose>
								<xsl:when test=". = 'Yes' or . = 'true' or . = 'yes' or . = 'true()'">
									<xsl:text>Yes</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>No</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:when>
					<!-- Process date type -->
					<xsl:when test="$value-type = 'date'">

					</xsl:when>

					<!-- Process color type -->
					<xsl:when test="$value-type = 'color'">
						<xsl:element name="{$field-name}">
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:when>
					<!-- Process page type -->
					<xsl:when test="$value-type = 'page'">
						<xsl:element name="{$field-name}">
							<xsl:element name="page">
								<xsl:attribute name="id">
									<xsl:value-of select="."/>
								</xsl:attribute>
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<!-- Throw error : Type not found -->
						<xsl:message>
							<xsl:text>Unknow </xsl:text>;
							<xsl:value-of select="$value-type" />
							<xsl:text> type</xsl:text>
						</xsl:message>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>