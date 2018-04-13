<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="menu-admin">
	<xsl:param name="attr" />

	<xsl:variable name="is-logged-in" select="/data/events/login-info/@logged-in = 'true'" />
	<xsl:variable name="is-developper" select="/data/events/login-info/@user-type = 'developer'" />

	<xsl:variable name="computed-attr">
		<add class="admin-tool admin-tool-menu" />
		<add class="fixed z-index-10000 text-uppercase" />
		<xsl:copy-of select="$attr" />
	</xsl:variable>

	<xsl:variable name="computed-attr-title">
		<add class="menu-title" />
		<add class="relative z-index-1 cursor-pointer" />
		<add class="white-space-nowrap" />
		<add dev-element="title" />
	</xsl:variable>

	<xsl:variable name="computed-attr-items-ctn">
		<add class="menu-items-ctn" />
		<add class="absolute top-full overflow-hidden" />
		<add class="pointer-events-none" />
		<add dev-element="items-ctn" />
	</xsl:variable>

	<xsl:variable name="computed-attr-items-wrapper">
		<add class="menu-items-wrapper" />
		<add class="pointer-events-all" />
		<add class="transparent" />
		<add dev-element="items-wrapper" />
	</xsl:variable>

	<xsl:variable name="computed-attr-item">
		<add class="menu-item" />
		<add dev-element="item" />
	</xsl:variable>


	<xsl:if test="$is-logged-in">
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$computed-attr"/>
			<xsl:with-param name="content">
				<div class="menu-ctn">
					<!-- TITLE -->
					<xsl:call-template name="element">
						<xsl:with-param name="attr" select="$computed-attr-title" />
						<xsl:with-param name="content">
							<span>Admin — <xsl:value-of select="substring-before(/data/events/login-info/name, ' ')" /></span>
						</xsl:with-param>
					</xsl:call-template>
					<!-- ITEMS CTN -->
					<xsl:call-template name="element">
						<xsl:with-param name="attr" select="$computed-attr-items-ctn" />
						<xsl:with-param name="content">
							<!-- ITEMS WRAPPER -->
							<xsl:call-template name="element">
								<xsl:with-param name="attr" select="$computed-attr-items-wrapper" />
								<xsl:with-param name="content">
									<!-- ITEM: Symphony -->
									<xsl:call-template name="element">
										<xsl:with-param name="attr" select="$computed-attr-item" />
										<xsl:with-param name="content">
											<a data-action="full" href="/symphony/" tabindex="-1">Symphony</a>
										</xsl:with-param>
									</xsl:call-template>

									<!-- ITEM: Debug -->
									<xsl:if test="$is-developper">
										<xsl:call-template name="element">
											<xsl:with-param name="attr" select="$computed-attr-item" />
											<xsl:with-param name="content">
												<a data-action="full" tabindex="-1">
													<xsl:attribute name="href">
														<xsl:text>?debug</xsl:text>
														<xsl:if test="string-length(/data/params/current-query-string) != 0">
															<xsl:text>&amp;</xsl:text>
															<xsl:value-of select="/data/params/current-query-string" />
														</xsl:if>
													</xsl:attribute>
													<xsl:text>Debug</xsl:text>
												</a>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>

									<xsl:if test="count(/data/params/use-dev) != 0 and $dev = true()">
										<xsl:choose>
											<xsl:when test="$debug = true()">
												<xsl:if test="$is-developper">
													<!-- ITEM: Use Build -->
													<xsl:call-template name="element">
														<xsl:with-param name="attr" select="$computed-attr-item" />
														<xsl:with-param name="content">
															<a data-action="full" tabindex="-1" href="?use-dev=no">
																<p><xsl:text>Use Build</xsl:text></p>
															</a>
														</xsl:with-param>
													</xsl:call-template>
												</xsl:if>
											</xsl:when>
											<xsl:otherwise>
												<!-- ITEM: Build Infos -->
												<xsl:call-template name="element">
													<xsl:with-param name="attr" select="$computed-attr-item" />
													<xsl:with-param name="content">
														<span>
															<xsl:choose>
																<xsl:when test="string-length(/data/build/last) != 0">
																	<xsl:text>Build </xsl:text>
																	<xsl:value-of select="/data/build/last" />
																</xsl:when>
																<xsl:when test="$dev = true()">
																	<xsl:text>No build infos found.</xsl:text>
																</xsl:when>
															</xsl:choose>
														</span>
													</xsl:with-param>
												</xsl:call-template>

												<!-- ITEM: Use Dev -->
												<xsl:if test="$is-developper">
													<xsl:call-template name="element">
														<xsl:with-param name="attr" select="$computed-attr-item" />
														<xsl:with-param name="content">
															<a data-action="full" tabindex="-1" href="?use-dev">
																<xsl:text>Use Dev</xsl:text>
															</a>
														</xsl:with-param>
													</xsl:call-template>
												</xsl:if>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:if>

									<!-- ITEM: Logout -->
									<xsl:call-template name="element">
										<xsl:with-param name="attr" select="$computed-attr-item" />
										<xsl:with-param name="content">
											<a data-action="full" tabindex="-1" href="/symphony/logout/">Logout</a>
										</xsl:with-param>
									</xsl:call-template>

									<!-- ITEM: Flush Cache -->
									<xsl:if test="$is-developper">
										<xsl:call-template name="element">
											<xsl:with-param name="attr" select="$computed-attr-item" />
											<xsl:with-param name="content">
												<a data-action="full" tabindex="-1" href="?flush=site">Flush Cache</a>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
							
						</xsl:with-param>
					</xsl:call-template>
				</div>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
