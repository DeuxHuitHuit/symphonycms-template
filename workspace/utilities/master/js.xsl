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
	<!--  jQuery Sizing -->
	<script src="{$jsPath}lib/jquery.sizing.min.js?v={$version}"></script>
	<!-- BBQ -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.ba-bbq/1.2.1/jquery.ba-bbq.min.js"></script>
	<!-- Underscore -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.1/underscore-min.js"></script>
	
	<xsl:choose>
		<xsl:when test="$debug = true()">
			<!-- FX -->
			<script src="{$jsPath}core/framework.js?v={$version}"></script>
			<script>
				<xsl:text>(function(){</xsl:text>
					<xsl:text>App.debug(true);</xsl:text>
				<xsl:text>})();</xsl:text>
			</script>
			
			<!-- Modules -->
			<!-- Input Modules -->
			<script src="{$jsPath}modules/links.js?v={$version}"></script>
			<script src="{$jsPath}modules/url-changer.js?v={$version}"></script>
			
			<!-- Output Modules-->
			<script src="{$jsPath}modules/title-updater.js?v={$version}"></script>
			<script src="{$jsPath}modules/share-this.js?v={$version}"></script>
			<script src="{$jsPath}modules/format-twitter.js?v={$version}"></script>
			<script src="{$jsPath}modules/blank-target-link.js?v={$version}"></script>
			<script src="{$jsPath}modules/oEmbed.js?v={$version}"></script>
			<script src="{$jsPath}modules/transition-animation.js?v={$version}"></script>
			
			<!-- Transitions -->
			<script src="{$jsPath}transitions/default-transition"></script>
			
			<!-- Pages -->
			<script src="{$jsPath}pages/default-page.js"></script>
		</xsl:when>
		<xsl:otherwise>
			<script src="{$jsPath}{$site-ref}.min.js?v={$version}"></script>
		</xsl:otherwise>
	</xsl:choose>
	
	<xsl:copy-of name="$extra-js" />
	
	<!-- Run the app! -->
	<script>
		<xsl:text>(function(){</xsl:text>
			<xsl:text>App.run('#site-pages');</xsl:text>
		<xsl:text>})();</xsl:text>
	</script>
	
</xsl:template>

</xsl:stylesheet>