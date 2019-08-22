<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- IMPORTS -->
	<xsl:import href="widgets/widget-flush-cache.xsl" />
	<xsl:import href="widgets/widget-user.xsl" />
	<xsl:import href="widgets/widget-logout.xsl" />
	<xsl:import href="widgets/widget-edit-entry.xsl" />
	<xsl:import href="widgets/widget-debug.xsl" />
	<xsl:import href="widgets/widget-build.xsl" />

	<xsl:template name="admin-tools">
		<xsl:param name="url-prefix" select="$root" />

		<xsl:variable name="is-user" select="/data/events/login-info/@logged-in = 'true'" />
		<xsl:variable name="is-user-author" select="/data/events/login-info/@user-type = 'author'" />
		<xsl:variable name="is-user-admin" select="/data/events/login-info/@user-type = 'admin'" />
		<xsl:variable name="is-user-dev" select="/data/events/login-info/@user-type = 'developer'" />

		<xsl:if test="$is-user">
			<div class="admin-tools">
				<div class="notifier"></div>
				<div class="widgets">
					<xsl:call-template name="widget-edit-entry" >
						<xsl:with-param name="url-prefix" select="$url-prefix" />
					</xsl:call-template>
					<xsl:if test="$is-user-dev">
						<xsl:call-template name="widget-debug" />
					</xsl:if>
					<xsl:call-template name="widget-flush-cache" />
					<xsl:call-template name="widget-user" />
					<xsl:call-template name="widget-logout" />
					<xsl:call-template name="widget-build" />
				</div>
			</div>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
