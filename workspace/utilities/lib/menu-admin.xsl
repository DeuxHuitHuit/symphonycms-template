<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="menu-admin">
	<xsl:param name="attr" />

	<xsl:if test="/data/events/login-info/@logged-in = 'true'">

		<xsl:variable name="computed-attr">
			<add class="admin-tool admin-tool-menu" />
			<xsl:copy-of select="$attr" />
		</xsl:variable>

		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$computed-attr"/>
			<xsl:with-param name="content">
				<div class="menu-ctn">
					<div class="menu-title">
						<b>Admin</b>
					</div>
					<div class="menu-items-ctn">
						<div class="menu-items-wrapper">
							<div class="menu-item menu-item-symphony">
								<a data-action="full" href="/symphony/">Symphony</a>
							</div>

							<xsl:if test="/data/events/login-info/@user-type = 'developer'">
								<div class="menu-item menu-item-debug">
									<a data-action="full">
										<xsl:attribute name="href">
											<xsl:text>?debug</xsl:text>
											<xsl:if test="string-length(/data/params/current-query-string) != 0">
												<xsl:text>&amp;</xsl:text>
												<xsl:value-of select="/data/params/current-query-string" />
											</xsl:if>
										</xsl:attribute>
										<xsl:text>Debug</xsl:text>
									</a>
								</div>
							</xsl:if>

							<xsl:if test="count(/data/params/use-dev) != 0 and $dev = true()">
								<xsl:choose>
									<xsl:when test="$debug = true()">
										<xsl:if test="/data/events/login-info/@user-type = 'developer'">
											<div class="menu-item menu-item-use-build">
												<a data-action="full" href="?use-dev=no">
													<p><xsl:text>Use Build</xsl:text></p>
												</a>
											</div>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<div class="menu-item menu-item-build-info">
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
										</div>

										<xsl:if test="/data/events/login-info/@user-type = 'developer'">
											<div class="menu-item menu-item-use-dev">
												<a data-action="full" href="?use-dev">
													<xsl:text>Use Dev</xsl:text>
												</a>
											</div>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>

							<div class="menu-item menu-item-logout">
								<a data-action="full" href="/symphony/logout/">Logout</a>
							</div>

							<xsl:if test="/data/events/login-info/@user-type = 'developer'">
								<div class="menu-item menu-item-flush">
									<a data-action="full" href="?flush=site">Flush Cache</a>
								</div>
							</xsl:if>
						</div>
					</div>
				</div>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
