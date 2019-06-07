<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- IMPORTS -->
	<xsl:import href="widgets/widget-flush-cache.xsl" />
	<xsl:import href="widgets/widget-logout.xsl" />
	<xsl:import href="widgets/widget-edit-entry.xsl" />
	<xsl:import href="widgets/widget-debug.xsl" />
	<xsl:import href="widgets/widget-build.xsl" />

	<xsl:template name="admin-tools">
		<xsl:param name="visible" select="visible = 'Yes' or string-length(visible) = 0" />
		<xsl:param name="domain" select="''" />
		
		<xsl:param name="notifier-color">
			<xsl:choose>
				<xsl:when test="$visible">
					<xsl:text>#2f77eb</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>#D32F2F</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

		<xsl:param name="notifier-label">
			<xsl:choose>
				<xsl:when test="$visible">
					<xsl:text>Published</xsl:text> 
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Unpublished</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

		<xsl:variable name="is-user" select="/data/events/login-info/@logged-in = 'true'" />
		<xsl:variable name="is-user-author" select="/data/events/login-info/@user-type = 'author'" />
		<xsl:variable name="is-user-admin" select="/data/events/login-info/@user-type = 'admin'" />
		<xsl:variable name="is-user-dev" select="/data/events/login-info/@user-type = 'developer'" />

		<xsl:if test="$is-user">
			<div class="admin-tools">
				<div class="notifier" style="background-color:{$notifier-color};"></div>
				<div class="widgets">
					<div class="widget" style="margin-left: 20px;margin-top: 5px;font-size: 10px;">
						<xsl:value-of select="$notifier-label" />
					</div>
					<xsl:call-template name="widget-edit-entry" >
						<xsl:with-param name="domain" select="$domain" />
					</xsl:call-template>
					<xsl:call-template name="widget-flush-cache" />
					<xsl:call-template name="widget-logout" />
					<xsl:if test="$is-user-dev">
						<xsl:call-template name="widget-debug" />
					</xsl:if>
					<xsl:call-template name="widget-build" />
				</div>
			</div>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
