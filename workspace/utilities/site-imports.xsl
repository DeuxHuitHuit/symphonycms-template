<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- RECIPES -->
	<xsl:import href="recipes/recipes.xsl" />

	<!-- SITE -->
	<xsl:import href="com/site-loader.xsl" />
	<xsl:import href="com/site-header.xsl" />
	<xsl:import href="com/site-logo.xsl" />
	<xsl:import href="com/site-nav.xsl" />
	<xsl:import href="com/site-nav-item.xsl" />
	<xsl:import href="com/site-languages-links.xsl" />
	<xsl:import href="com/site-footer.xsl" />
	
	<xsl:import href="com/site-svg.xsl" />
	<xsl:import href="com/site-social-svg.xsl" />

	<!-- LAYOUTS -->
	<xsl:import href="com/layouts/layout.xsl" />
	<xsl:import href="com/layouts/layout-base.xsl" />

	<!-- MODULES -->
	<xsl:import href="com/modules/module.xsl" />
	<xsl:import href="com/modules/module-debug.xsl" />
	<xsl:import href="com/modules/module-buttons.xsl" />
	<xsl:import href="com/modules/module-text.xsl" />
	<xsl:import href="com/modules/module-image.xsl" />
	<xsl:import href="com/modules/module-image-text.xsl" />
	<xsl:import href="com/modules/module-embed.xsl" />
	<xsl:import href="com/modules/module-video.xsl" />
	<xsl:import href="com/modules/module-form.xsl" />

	<!-- NAVS -->
	<xsl:import href="com/navs/nav-share.xsl" />
	<xsl:import href="com/navs/nav-share-item.xsl" />
	<xsl:import href="com/navs/nav-social.xsl" />
	<xsl:import href="com/navs/nav-social-item.xsl" />

	<!-- FORMS -->
	<xsl:import href="com/forms/form-dyn.xsl" />

	<!-- BUTTONS -->
	<xsl:import href="com/buttons/button-main.xsl" />
	<xsl:import href="com/buttons/button-link.xsl" />
	<xsl:import href="com/buttons/button-share.xsl" />
	<xsl:import href="com/buttons/button-copy.xsl" />

	<!-- ADMIN-TOOLS -->
	<xsl:import href="admin-tools/admin-tools.xsl" />

	<!-- UTILS -->
	<xsl:import href="lib/util-nav-link-attr.xsl" />
	<xsl:import href="lib/util-share-links-node.xsl" />
	<xsl:import href="lib/util-image-path.xsl" />
	<xsl:import href="lib/util-auto-handle.xsl" />
	<xsl:import href="lib/util-rewrite-markdown.xsl" />
	<xsl:import href="lib/util-transition-scroll-attr.xsl" />
	<xsl:import href="lib/util-ficelle.xsl" />
	<xsl:import href="lib/util-count.xsl" />
	<xsl:import href="com/util-auto-url.xsl" />
	<xsl:import href="com/util-module-interval-attr.xsl" />
	<xsl:import href="com/util-module-width-attr.xsl" />

	<!-- ELEMENTS -->
	<xsl:import href="com/com-video.xsl" />

	<!-- Schemas -->
	<!-- <xsl:import href="schemas/schema-breadcrumblist.xsl" /> -->
	<!-- <xsl:import href="schemas/schema-jobposting.xsl" /> -->
	<!-- <xsl:import href="com/schemas/schema-newsarticle.xsl" /> -->
	<xsl:import href="com/schemas/schema-organization.xsl" />
	<!-- <xsl:import href="com/schemas/schema-searchaction.xsl" /> -->
	
</xsl:stylesheet>
