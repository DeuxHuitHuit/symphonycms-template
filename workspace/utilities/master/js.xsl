<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="js-templates.xsl" />

	<xsl:template name="master-js">
		<xsl:param name="extra-js" />
		
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
				<script src="{$js-path}{$site-ref}.min.{$version}.js" integrity="{/data/sri/file[@filename=concat($site-ref, '.min.js')]/@integrity}"></script>
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
</xsl:stylesheet>
