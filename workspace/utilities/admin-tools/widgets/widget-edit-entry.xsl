<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="widget-edit-entry">
		<xsl:param name="section" select="../section/@handle" />
		<xsl:param name="entry-id" select="@id" />
		<xsl:param name="url-prefix" select="$root" />
		<xsl:param name="url">
			<xsl:choose>
				<xsl:when test="string-length($section) != 0 and string-length($entry-id) != 0">
					<xsl:value-of select="$url-prefix" />
					<xsl:text>/symphony/publish/</xsl:text>
					<xsl:value-of select="$section"/>
					<xsl:text>/edit/</xsl:text>
					<xsl:value-of select="$entry-id" />
					<xsl:text>/</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$url-prefix" />
					<xsl:text>/symphony/</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>

		<div class="widget widget-edit-entry">
			<a href="{$url}">
				<div style="display:flex">
					<div class="widget-icon">
						<svg xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMin slice"
							viewBox="0 0 25 25">
							<path fill="currentColor" d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/><path d="M0 0h24v24H0z" fill="none"/>
						</svg>
					</div>
					<div class="label"><xsl:text>Edit</xsl:text></div>
				</div>
			</a>
		</div>
	</xsl:template>

</xsl:stylesheet>
