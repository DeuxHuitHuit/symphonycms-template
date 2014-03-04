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
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.ba-bbq/1.2.1/jquery.ba-bbq.min.js"></script>
	
	<!-- Underscore -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js"></script>
	<script src="/cdnjs.cloudflare.com/ajax/libs/underscore.string/2.3.3/underscore.string.min.js"></script>
	
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
			
			<!-- Modules -->
			<!-- Input Modules -->
			<script src="{$js-path}modules/links.js?v={$version}"></script>
			<script src="{$js-path}modules/url-changer.js?v={$version}"></script>
			
			<!-- Output Modules-->
			<script src="{$js-path}modules/title-updater.js?v={$version}"></script>
			<script src="{$js-path}modules/alt-language-link-updater.js?v={$version}"></script>
			<script src="{$js-path}modules/share-this.js?v={$version}"></script>
			<script src="{$js-path}modules/format-twitter.js?v={$version}"></script>
			<script src="{$js-path}modules/blank-target-link.js?v={$version}"></script>
			<script src="{$js-path}modules/oEmbed.js?v={$version}"></script>
			<script src="{$js-path}modules/transition-animation.js?v={$version}"></script>
			
			<!-- Transitions -->
			<script src="{$js-path}transitions/default-transition.js?v={$version}"></script>
			
			<!-- Pages -->
			<script src="{$js-path}pages/default-page.js"></script>
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

</xsl:stylesheet>