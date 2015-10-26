<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="master-js">
	<xsl:param name="extra-js" />
	
	<!-- IE JS -->
	<xsl:call-template name="ie-cc">
		<xsl:with-param name="content">
			<!-- BBQ -->
			<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.ba-bbq/1.2.1/jquery.ba-bbq.min.js"></script>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:choose>
		<xsl:when test="$debug = true()">
			<!-- Remote Libs -->
			<xsl:apply-templates select="/data/javascript/cdn-before/file" mode="cdn" />
			<!-- Local libs -->
			<xsl:apply-templates select="/data/javascript/libs/file" mode="local" />
			<!-- FX -->
			<script src="{$js-path}core/framework.{$version}.js"></script>
			<script>
				<xsl:text>(function(){</xsl:text>
					<xsl:text>App.debug(true);</xsl:text>
				<xsl:text>})();</xsl:text>
			</script>
			
			<!-- Local sources -->
			<xsl:apply-templates select="/data/javascript/sources/file" mode="local" />
			<xsl:apply-templates select="/data/javascript/dev/file" mode="local" />
		</xsl:when>
		<xsl:otherwise>
			<script src="{$js-path}{$site-ref}.min.{$version}.js"></script>
		</xsl:otherwise>
	</xsl:choose>
	
	<xsl:copy-of select="$extra-js" />
	
	<!-- Run the app! -->
	<script>
		<xsl:text>(function(){</xsl:text>
			<xsl:text>App.run('#site-pages');</xsl:text>
		<xsl:text>})();</xsl:text>
	</script>
	
	<!-- Libs -->
	<xsl:apply-templates select="/data/javascript/cdn-after/file" mode="cdn-async" />
	
</xsl:template>

<xsl:template match="javascript/*/file" mode="local">
	<script src="{$js-path}{.}"></script>
</xsl:template>

<xsl:template match="javascript/*/file" mode="cdn">
	<script src="{.}"></script>
</xsl:template>

<xsl:template match="javascript/*/file" mode="cdn-async">
	<script src="{.}" async="" defer=""></script>
</xsl:template>

</xsl:stylesheet>