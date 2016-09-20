<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl">

<xsl:variable name="allowArgsName" select="'f288-allowArgs'" />

<xsl:template name="framework-288-url-creator">
	<xsl:apply-templates select="/data/pages" mode="framework-288-url-creator" />
</xsl:template>

<xsl:template match="data/pages" mode="framework-288-url-creator">
	<script>
		<!-- All pages except index -->
		<xsl:for-each select="page">
			<xsl:if test="count(./types/type [. = 'index']) = 0">
				<xsl:apply-templates select="." mode="framework-288-url-creator"/>
			</xsl:if>
		</xsl:for-each>
		
		<!-- Special case if current page is 403 or 404 -->
		<xsl:choose>
			<xsl:when test="count(/data/params/page-types/item[@handle='404']) != 0">
				<xsl:call-template name="framework-288-render-page">
					<xsl:with-param name="handle" select="'404'" />
					<xsl:with-param name="model">
						<xsl:call-template name="framework-288-page-model">
							<xsl:with-param name="types" select="/data/params/page-types/item" />
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="count(/data/params/page-types/item[@handle='403']) != 0">
				<xsl:call-template name="framework-288-render-page">
					<xsl:with-param name="handle" select="'403'" />
					<xsl:with-param name="model">
						<xsl:call-template name="framework-288-page-model">
							<xsl:with-param name="types" select="/data/params/page-types/item" />
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		
		<!-- Index page -->
		<xsl:apply-templates select="page[./types/type = 'index']" mode="framework-288-url-creator" />
	</script>
</xsl:template>

<xsl:template match="page" mode="framework-288-url-creator">
	<xsl:if test="count(page) &gt; 0">
		<xsl:apply-templates select="page" mode="framework-288-url-creator" />
	</xsl:if>
	
	<xsl:variable name="item" select="." />
	
	<xsl:variable name="handle">
		<xsl:apply-templates select="." mode="full-page-handle-creator" />
	</xsl:variable>
	
	<xsl:variable name="routes">
		<xsl:text>[</xsl:text>
			<xsl:choose>
				<xsl:when test="$multi-langues = 'yes'">
					<!-- main language -->
					<xsl:for-each select="/data/fl-languages/supported-languages/item [@main = 'yes']">
						<xsl:call-template name="framework-288-url-creator-page-route">
							<xsl:with-param name="item" select="$item" />
						</xsl:call-template>
					</xsl:for-each>
					
					<!-- other language -->
					<xsl:for-each select="/data/fl-languages/supported-languages/item [string-length(./@main) = 0]">
						<xsl:text>,</xsl:text>
						
						<xsl:call-template name="framework-288-url-creator-page-route">
							<xsl:with-param name="item" select="$item" />
						</xsl:call-template>
					</xsl:for-each>
					
					<!-- Index page -->
					<xsl:if test="@id = '1'">
						<xsl:text>,'/'</xsl:text>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="framework-288-url-creator-page-route">
						<xsl:with-param name="item" select="$item" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		<xsl:text>]</xsl:text>
	</xsl:variable>
	
	<xsl:variable name="model">
		<xsl:call-template name="framework-288-page-model">
			<xsl:with-param name="types" select="types/type" />
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:if test="count(types/type[. = 'hidden']) = 0 and (count(types/type[. = 'admin']) = 0 or $is-loggued-in = true())">
		<xsl:call-template name="framework-288-render-page">
			<xsl:with-param name="handle" select="$handle" />
			<xsl:with-param name="routes" select="$routes" />
			<xsl:with-param name="model" select="$model" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="framework-288-url-creator-page-route">
	<xsl:param name="item" />
	
	<xsl:variable name="allowArgs">
		<xsl:choose>
			<xsl:when test="count($item/types/type [. = $allowArgsName]) &gt; 0">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="isIndex">
		<xsl:choose>
			<xsl:when test="count($item/types/type [. = 'index']) &gt; 0">
				<xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>no</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!-- Langue -->
	<xsl:variable name="lg" select="@handle" />
	<xsl:text>'/</xsl:text>
	<xsl:if test="$multi-langues = 'yes'">
		<xsl:value-of select="$lg" />
		<xsl:text>/</xsl:text>
	</xsl:if>
	
	<!-- parents -->
	<xsl:for-each select="$item/ancestor::page">
		<xsl:choose>
			<xsl:when test="$multi-langues = 'yes'">
				<xsl:value-of select="item [@lang=$lg]/@handle" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@handle" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>/</xsl:text>
	</xsl:for-each>
	
	<!-- Current (if not index)-->
	<xsl:if test="$isIndex != 'yes'">
		<xsl:choose>
			<xsl:when test="$multi-langues = 'yes'">
				<xsl:value-of select="$item/item [@lang=$lg]/@handle" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@handle" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>/</xsl:text>
	</xsl:if>
	
	<!-- stars-->
	<xsl:if test="$allowArgs = 'yes'">
		<xsl:text>*</xsl:text>
	</xsl:if>
	<xsl:text>'</xsl:text>
</xsl:template>

<xsl:template name="framework-288-page-model">
	<xsl:param name="types" />
	<xsl:choose>
		<xsl:when test="count(exsl:node-set($types)[substring-before(.,'-model-') = 'f288']) &gt; 0">
			<xsl:value-of select="substring-after(exsl:node-set($types)[string-length(substring-after(.,'f288-model-')) &gt; 0],'f288-model-')" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>defaultPage</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="framework-288-render-page">
	<xsl:param name="handle" />
	<xsl:param name="routes" select="concat('[&quot;', $current-path, '/&quot;]')" />
	<xsl:param name="model" select="'defaultPage'" />
	
	<xsl:text>App.pages.create({key: '#page-</xsl:text>
	<xsl:value-of select="$handle" />
	<xsl:text>',routes: </xsl:text>
	<xsl:value-of select="$routes" />
	<xsl:text>},'</xsl:text>
	<xsl:value-of select="$model" />
	<xsl:text>');</xsl:text>
</xsl:template>

</xsl:stylesheet>