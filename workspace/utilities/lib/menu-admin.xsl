<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="menu-admin">
	<xsl:param name="attr" />

	<xsl:if test="/data/events/login-info/@logged-in = 'true'">

		<xsl:variable name="computed-attr">
			<add id="menu-admin" />
			<add class="fixed" />
			<add class="z-index-max" />
			<add class="top left" />
			<add class="color-true-black" />
			<xsl:copy-of select="$attr" />
		</xsl:variable>
		
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$computed-attr"/>
			<xsl:with-param name="content">
				<span><xsl:value-of select="/data/events/login-info/name" /></span>

				<span><xsl:text> - </xsl:text></span>

				<a data-action="full" href="/symphony/">Symphony</a>

				<xsl:if test="/data/events/login-info/@user-type = 'developer'">
					<a data-action="full">
						<xsl:attribute name="href">
							<xsl:text>?debug</xsl:text>
							<xsl:if test="string-length(/data/params/current-query-string) != 0">
								<xsl:text>&amp;</xsl:text>
								<xsl:value-of select="/data/params/current-query-string" />
							</xsl:if>
						</xsl:attribute>
						<xsl:text>DEBUG</xsl:text>
					</a>
				</xsl:if>

				<xsl:if test="count(/data/params/use-dev) != 0">
					<xsl:choose>
						<xsl:when test="$debug = true()">
							<xsl:if test="/data/events/login-info/@user-type = 'developer'">
								<span class="debug">
									<a data-action="full" href="?use-dev=no">
										<xsl:text>Use BUILD</xsl:text>
									</a>
								</span>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<span class="build">
								<strong>
									<xsl:choose>
										<xsl:when test="string-length(/data/build/last) != 0">
											<xsl:text>Build </xsl:text>
											<xsl:value-of select="/data/build/last" />
										</xsl:when>
										<xsl:when test="$dev = true()">
											<xsl:text>No build infos found.</xsl:text>
										</xsl:when>
									</xsl:choose>
								</strong>
							</span>

							<xsl:if test="/data/events/login-info/@user-type = 'developer'">
								<span class="debug">
									<a data-action="full" href="?use-dev">
										<xsl:text>Use DEV</xsl:text>
									</a>
								</span>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>

				<a data-action="full" href="/symphony/logout/">Déconnexion</a>

				<span class="cache"><xsl:text> Cache: </xsl:text></span>

				<a data-action="full" href="?flush">Flush page</a>

				<a data-action="full" href="?flush=site">Flush site</a>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
