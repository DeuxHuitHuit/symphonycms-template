<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="menu-admin">
		<xsl:if test="/data/events/login-info/@logged-in = 'true'">
			<div id="menu-admin">
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

				<xsl:if test="count(/data/params/use-build) != 0">
					<xsl:choose>
						<xsl:when test="$debug = true()">
							<span class="debug">
								<xsl:text>DEV CODE</xsl:text>
								<a data-action="full" href="?use-build">
									I want to test builds
								</a>
							</span>
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
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				
				<a data-action="full" href="/symphony/logout/">Déconnexion</a>
				
				<span class="cache"><xsl:text> Cache: </xsl:text></span>
				
				<a data-action="full" href="?flush">Flush page</a>
				
				<a data-action="full" href="?flush=site">Flush site</a>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
