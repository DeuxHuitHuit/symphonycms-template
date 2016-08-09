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
	
	<xsl:variable name="computed-attr" >
		<add class="{$url-language}" />
		<add class="page-{$full-page-handle}" />
		<add data-version="{$version}" />
		<xsl:call-template name="body-attr" />
	</xsl:variable>

	<!-- Body -->
	<body>
		<xsl:call-template name="attr" >
			<xsl:with-param name="attr" select="$computed-attr" />
		</xsl:call-template>

		<!-- Site -->
		<div id="site">
			
			<!-- Site header -->
			<xsl:call-template name="site-header" />
			
			<!-- Site Pages -->
			<div id="site-pages">
				
				<!-- Page -->
				<div>
					<xsl:call-template name="attr">
						<xsl:with-param name="attr" >
							<add id="page-{$full-page-handle}" />
							<add class="page" />
							<xsl:call-template name="page-attr" />
						</xsl:with-param>
					</xsl:call-template>

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

<xsl:template name="body-attr" ></xsl:template>
<xsl:template name="page-attr" ></xsl:template>


</xsl:stylesheet>
