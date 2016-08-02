<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

<xsl:template name="attr">
	<xsl:param name="attr" />
	<xsl:param name="trace" select="false()" />

	<xsl:variable name="initialNodeResult" ><root></root></xsl:variable>

	<xsl:variable name="compiledAttrXml">
		<xsl:apply-templates select="exsl:node-set($attr)//*[1]" mode="node-attributes-rec" >
			<xsl:with-param name="attrResult" select="$initialNodeResult"/>
		</xsl:apply-templates>
	</xsl:variable>

	<xsl:for-each select="exsl:node-set($compiledAttrXml)/root/*">
		<xsl:variable name="attr-name" select="name()" />

		<xsl:if test="starts-with($attr-name, 'dev-') = false() or $debug = true()">
			<xsl:attribute name="{$attr-name}">
				<xsl:for-each select="*">
					<xsl:if test="position() &gt; 1">
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:value-of select="." />
				</xsl:for-each>
			</xsl:attribute>
		</xsl:if>
	</xsl:for-each>

	<xsl:if test="$trace = true() and $debug = true()">
		<script type="text/debug">
			<src>
				<xsl:copy-of select="$attr" />
			</src>
			<compiled>
				<xsl:copy-of select="$compiledAttrXml" />
			</compiled>
		</script>
	</xsl:if>

</xsl:template>

<xsl:template match="add | set" mode="node-attributes-rec">
	<xsl:param name="attrResult" />

	<xsl:variable name="curNodeName" select="name()" />

	<!-- Merge new value to existing attribute or create new attribute -->
	<xsl:variable name="temp">

		<xsl:for-each select="@*">
			<xsl:variable name="attr-name" select="name()" />

			<!-- Check attribute existence -->
			<xsl:choose>
				<xsl:when test="count(exsl:node-set($attrResult)//*[name() = $attr-name]) != 0">
					<xsl:element name="{$attr-name}">

						<xsl:if test="$curNodeName = 'add'">
							<!-- Copy existing value for this attribute -->
							<xsl:copy-of select="exsl:node-set($attrResult)//*[name() = $attr-name]/*" />
						</xsl:if>

						<!-- Loop throught add or set node value to create new value -->
						<xsl:for-each select="str:tokenize(., ' ')" >
							<!-- Check if already there -->
							<xsl:variable name="curValue" select="." />

							<xsl:choose>
								<xsl:when test="$curNodeName = 'set' or count(exsl:node-set($attrResult)//*[name() = $attr-name]/value[text() = $curValue]) = 0">
									<!-- its set or the value is Not Present : Creating new value -->
									<value><xsl:value-of select="." /></value>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<!-- Create new attribute -->
					<xsl:element name="{$attr-name}">
						<xsl:for-each select="str:tokenize(., ' ')" >
							<value><xsl:value-of select="." /></value>
						</xsl:for-each>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:variable>

	<!-- Import untouched attribute back -->
	<xsl:variable name="temp2">
		<xsl:copy-of select="$temp" />

		<xsl:for-each select="exsl:node-set($attrResult)/root/*" >
			<xsl:variable name="attr-name" select="name()" />

			<!-- Check if not present -->
			<xsl:if test="count(exsl:node-set($temp)//*[name() = $attr-name]) = 0">
				<xsl:copy-of select="." />
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>

	<xsl:variable name="newAttrResult">
		<root>
			<xsl:copy-of select="$temp2" />
		</root>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="count(./following-sibling::*) &gt; 0">
			<!-- Recursive call -->
			<xsl:apply-templates select="./following-sibling::*[1]" mode="node-attributes-rec">
				<xsl:with-param name="attrResult" select="$newAttrResult" />
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<!-- Final render -->
			<xsl:copy-of select="$newAttrResult" />
		</xsl:otherwise>
	</xsl:choose>
	
</xsl:template>


<xsl:template match="rem" mode="node-attributes-rec">
	<xsl:param name="attrResult" />

	<xsl:variable name="curNode" select="." />

	<xsl:variable name="newAttrResult">
		<root>
			<xsl:for-each select="exsl:node-set($attrResult)/root/*" >
				<xsl:variable name="attr-name" select="name()" />

				<!-- Check if this attribute exist in the rem node -->
				<xsl:choose>
					<xsl:when test="count($curNode/@*[name() = $attr-name]) != 0">
						<xsl:variable name="tokenRemove" select="str:tokenize($curNode/@*[name() = $attr-name], ' ')"/>
						
						<!-- Create New Element -->
						<xsl:element name="{$attr-name}">
							<!-- Pass Existing value and output if not present in the token of the remove node -->
							<xsl:for-each select="value" >
								<xsl:variable name="curValue" select="."/>
								<xsl:if test="count($tokenRemove/*[. = $curValue]) = 0">
									<value><xsl:value-of select="." /></value>
								</xsl:if>
							</xsl:for-each>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="." />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</root>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="count(./following-sibling::*) &gt; 0">
			<!-- Recursive call -->
			<xsl:apply-templates select="./following-sibling::*[1]" mode="node-attributes-rec">
				<xsl:with-param name="attrResult" select="$newAttrResult" />
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<!-- Final render -->
			<xsl:copy-of select="$newAttrResult" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--xsl:template name="component">
	<xsl:param name="attributes" />
	<xsl:param name="content" />

	<div>
		<xsl:call-template name="attributes">
			<xsl:with-param name="attributes" select="$attributes" />
		</xsl:call-template>

		<xsl:call-template name="content">
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	</div>
</xsl:template-->

</xsl:stylesheet>