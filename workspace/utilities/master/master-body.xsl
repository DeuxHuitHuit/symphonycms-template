<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="js.xsl" />
<xsl:import href="../lib/menu-admin.xsl" />
<xsl:import href="../lib/button.xsl" />
<xsl:import href="../com/site-footer.xsl" />
<xsl:import href="../com/site-header.xsl" />
<xsl:import href="../com/site-nav.xsl" />
<xsl:import href="../com/language-link.xsl" />

<!-- Extensions -->
<xsl:import href="../../../extensions/block_user_agent/utilities/block_user_agent.xsl" />
<xsl:import href="../../../extensions/datetime/utilities/datetime.xsl" />

<xsl:template name="master-body">

	<!-- Body -->
	<body 
		class="{$url-language} page-{$full-page-handle}" 
		data-version="{$version}" >
		
		<!-- Site -->
		<div id="site">
			
			<!-- Site header -->
			<xsl:call-template name="site-header" />
			
			<!-- Site Pages -->
			<div id="site-pages">
				
				<!-- Page -->
				<div id="page-{$full-page-handle}" class="page">
					<xsl:apply-templates select="data" />
				</div>
				
			</div>
			
			<!-- Site footer -->
			<xsl:call-template name="site-footer" />
			
		</div>
		
		<!-- load progress -->
		<div id="load-progress"></div>
		
		<!-- Block user agent -->
		<xsl:call-template name="block-user-agent-light">
			<xsl:with-param name="text" select="$config/navigateurs-non-supportes-titre" />
			<xsl:with-param name="client-side-detection" select="true()" />
		</xsl:call-template>
		
		<!-- JS -->
		<xsl:call-template name="master-js">
			<xsl:with-param name="extra-js">
				<!-- Register URL for the site-->
				<xsl:call-template name="framework-288-url-creator" /> 
			</xsl:with-param>
		</xsl:call-template>
	</body>
</xsl:template>


</xsl:stylesheet>
