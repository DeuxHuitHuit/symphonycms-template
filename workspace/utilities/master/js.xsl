<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="js-path" select="'/workspace/assets/js/'" />

<xsl:template name="master-js">
	<xsl:param name="extra-js" />
	
	<!-- jQuery -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<!-- jQuery Migrate-->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-migrate/1.2.1/jquery-migrate.min.js"></script>
	<!-- jQuery Easing -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
	<!-- jQuery Sizing -->
	<script src="{$js-path}lib/jquery.sizing.min.js?v={$version}"></script>
	
	<!-- BBQ -->
	<xsl:call-template name="ie-cc">
		<xsl:with-param name="content">
			<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.ba-bbq/1.2.1/jquery.ba-bbq.min.js"></script>
		</xsl:with-param>
	</xsl:call-template>
	
	<!-- Underscore -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/underscore.string/2.3.3/underscore.string.min.js"></script>
	
	<!-- Vimeo -->
	<!-- script src="//a.vimeocdn.com/js/froogaloop2.min.js"></script -->
	
	<!-- Youtube -->
	<!-- script src="//www.youtube.com/player_api"></script -->
	
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

</xsl:stylesheet>