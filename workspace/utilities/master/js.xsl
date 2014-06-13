<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="master-js">
	<xsl:param name="extra-js" />
	
	<!-- Libs -->
	<xsl:apply-templates select="/data/javascript-libs/file" />
	
	
	<!-- IE JS -->
	<xsl:call-template name="ie-cc">
		<xsl:with-param name="content">
			<!-- BBQ -->
			<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.ba-bbq/1.2.1/jquery.ba-bbq.min.js"></script>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:choose>
		<xsl:when test="$debug = true()">
			<!-- FX -->
			<script src="{$js-path}core/framework.js?v={$version}"></script>
			<script>
				<xsl:text>(function(){</xsl:text>
					<xsl:text>App.debug(true);</xsl:text>
				<xsl:text>})();</xsl:text>
			</script>
			
			<xsl:apply-templates select="/data/javascript/file" />
		</xsl:when>
		<xsl:otherwise>
			<script src="{$js-path}core/framework.min.js?v={$version}"></script>
			<script src="{$js-path}{$site-ref}.min.js?v={$version}"></script>
		</xsl:otherwise>
	</xsl:choose>
	
	<xsl:copy-of select="$extra-js" />
	
	<!-- Run the app! -->
	<script>
		<xsl:text>(function(){</xsl:text>
			<xsl:text>App.run('#site-pages');</xsl:text>
		<xsl:text>})();</xsl:text>
	</script>
	
</xsl:template>

<xsl:template match="javascript/file">
	<script src="{$js-path}{.}?v={$version}"></script>
</xsl:template>

<xsl:template match="javascript-libs/file">
	<script src="{.}"></script>
</xsl:template>

</xsl:stylesheet>