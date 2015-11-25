<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="ga">
	<xsl:param name="ua" />
	<xsl:param name="domain" select="'auto'" />
	<xsl:param name="send-pageview" select="false()" />
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
ga('create', '<xsl:value-of select="$ua" />', '<xsl:value-of select="$domain" />');
ga('set', 'forceSSL', true);
ga('require', 'displayfeatures');
<xsl:if test="$send-pageview = true()">
	<xsl:text>ga('send', 'pageview');</xsl:text>
</xsl:if>
</script>
</xsl:template>

<xsl:template name="gtm">
	<xsl:param name="ua" />
<script>
var dataLayer = dataLayer || [];
dataLayer.push({'page':{'language':'<xsl:value-of select="$url-language" />'}});
</script>
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id={$ua}" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&amp;l='+l:'';j.async=true;j.src='https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','<xsl:value-of select="$ua" />');</script>
</xsl:template>

</xsl:stylesheet>
