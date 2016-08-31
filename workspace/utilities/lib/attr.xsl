<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

<!-- PUBLIC VARIABLES 														 -->
	<xsl:variable name="attr-string-start-delimiter">
		<xsl:text>~'</xsl:text>
	</xsl:variable>

	<xsl:variable name="attr-string-end-delimiter">
		<xsl:text>'</xsl:text>
	</xsl:variable>
<!-- 																		/-->

<!-- CORE-FUNCTION: attr ========================================================================-->
	<xsl:template name="attr">
		<xsl:param name="attr" />
		<xsl:param name="mode" select="''" />

	<!-- INTERNAL VARIABLES 												 -->
		<xsl:variable name="initialNodeResult" ><root></root></xsl:variable>

		<xsl:variable name="compiledAttrXml">
			<!-- Compute compiled attributes -->
			<xsl:apply-templates select="exsl:node-set($attr)//*[1]" mode="node-attributes-rec" >
				<xsl:with-param name="attrResult" select="$initialNodeResult"/>
			</xsl:apply-templates>
		</xsl:variable>
	<!-- 																	/-->

	<!-- STRUCTURE 															 -->
		<!-- Loop throught each compiled attributes to output them -->
		<xsl:for-each select="exsl:node-set($compiledAttrXml)/root/*">
			<xsl:variable name="attr-name" select="name()" />

			<!-- Exclude all dev- begining attributes -->
			<xsl:if test="starts-with($attr-name, 'dev-') = false() or $debug = true()">

				<!-- Output attribute -->
				<xsl:attribute name="{$attr-name}">
					<!-- Loop throught each values-->
					<xsl:for-each select="*">
						<!-- Add space before new attribute (except first) -->
						<xsl:if test="position() &gt; 1">
							<xsl:text> </xsl:text>
						</xsl:if>
						<!-- Output value -->
						<xsl:value-of select="." />
					</xsl:for-each>
				</xsl:attribute>
			</xsl:if>
		</xsl:for-each>

		<!-- Debug info if enabled -->
		<xsl:if test="$mode = 'debug' and $debug = true()">
			<script type="text/debug">
				<src>
					<xsl:copy-of select="$attr" />
				</src>
				<compiled>
					<xsl:copy-of select="$compiledAttrXml" />
				</compiled>
			</script>
		</xsl:if>
	<!-- 																	/-->
	</xsl:template>

<!-- HELPER-TEMPLATES: COMPUTE ADD | SET | REM ==================================================-->
	<xsl:template match="add | set" mode="node-attributes-rec">
		<xsl:param name="attrResult" />

		<xsl:variable name="curNodeName" select="name()" />

		<!-- Merge new value to existing attribute or create new attribute -->
		<xsl:variable name="temp">

			<xsl:for-each select="@*">
				<xsl:variable name="attr-name" select="name()" />
				
				<xsl:element name="{$attr-name}">

					<!-- Check attribute existence -->
					<xsl:choose>
						<xsl:when test="count(exsl:node-set($attrResult)//*[name() = $attr-name]) != 0">
							
							<xsl:if test="$curNodeName = 'add'">
								<!-- Copy existing value for this attribute -->
								<xsl:copy-of select="exsl:node-set($attrResult)//*[name() = $attr-name]/*" />
							</xsl:if>
							
							<!-- Detect single value -->
							<xsl:choose>
								<xsl:when test="starts-with(., $attr-string-start-delimiter) and 
									substring(., string-length(.)) = $attr-string-end-delimiter">
									<xsl:variable name="tempCurValue" select="."/>

									<xsl:variable name="curValue">
										<xsl:call-template name="attr-string-transform">
											<xsl:with-param name="value" select="."/>
										</xsl:call-template>
									</xsl:variable>

									<xsl:choose>
										<xsl:when test="$curNodeName = 'set' or 
											count(exsl:node-set($attrResult)//*[name() = $attr-name]/value[text() = $curValue]) = 0">
											<!-- its set or the value is Not Present : Creating new value -->
											<value><xsl:value-of select="$curValue" /></value>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>

									<!-- Loop throught add or set node values to create new value -->
									<xsl:for-each select="str:tokenize(., ' ')" >
										<!-- Check if already there -->
										<xsl:variable name="curValue" select="." />

										<xsl:choose>
											<xsl:when test="$curNodeName = 'set' or 
												count(exsl:node-set($attrResult)//*[name() = $attr-name]/value[text() = $curValue]) = 0">
												<!-- its set or the value is Not Present : Creating new value -->
												<value><xsl:value-of select="$curValue" /></value>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>

							<!-- Create new attribute -->
							<xsl:choose>
								<xsl:when test="starts-with(., $attr-string-start-delimiter) and 
									substring(., string-length(.)) = $attr-string-end-delimiter">
									<xsl:variable name="tempCurValue" select="."/>

									<xsl:variable name="curValue">
										<xsl:call-template name="attr-string-transform">
											<xsl:with-param name="value" select="."/>
										</xsl:call-template>
									</xsl:variable>

									<value><xsl:value-of select="$curValue" /></value>
								</xsl:when>
								<xsl:otherwise>

									<xsl:for-each select="str:tokenize(., ' ')" >
										<value><xsl:value-of select="." /></value>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
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

							<xsl:variable name="curAttr" select="$curNode/@*[name() = $attr-name]"/>

							<!-- Detect single value -->
							<xsl:choose>
								<xsl:when test="starts-with($curAttr, $attr-string-start-delimiter) and 
									substring($curAttr, string-length($curAttr)) = $attr-string-end-delimiter">

									<xsl:variable name="stringRemove" >
										<xsl:call-template name="attr-string-transform">
											<xsl:with-param name="value" select="$curAttr"/>
										</xsl:call-template>
									</xsl:variable>

									<!-- Create New Element -->
									<xsl:element name="{$attr-name}">

										<!-- Pass Existing value and output if not present in the token of the remove node -->
										<xsl:for-each select="value" >
											<xsl:variable name="curValue" select="."/>

											<xsl:if test="$stringRemove != $curValue">
												<value><xsl:value-of select="$curValue" /></value>
											</xsl:if>
										</xsl:for-each>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable name="tokenRemove" select="str:tokenize($curAttr, ' ')"/>

									<!-- Create New Element -->
									<xsl:element name="{$attr-name}">

										<!-- Pass Existing value and output if not present in the token of the remove node -->
										<xsl:for-each select="value" >
											<xsl:variable name="curValue" select="./text()"/>
											<xsl:if test="count($tokenRemove[text() = $curValue]) = 0">
												<value><xsl:value-of select="$curValue" /></value>
											</xsl:if>
										</xsl:for-each>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
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

<!-- HELPER-TEMPLATES: attr-string-transform ====================================================-->
	<xsl:template name="attr-string-transform">
		<xsl:param name="value" />

		<xsl:for-each select="str:tokenize($value, '')" >
			<xsl:if test="position() &gt; 2 and position() &lt; string-length($value)" >
				<xsl:value-of select="." />
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
