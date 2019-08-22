<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="widget-build">
		<xsl:param name="build" select="/data/build/last" />

		<div class="widget widget-build">
			<a>
				<div style="display:flex">
					<div class="widget-icon">
						<svg xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMin slice"
							viewBox="0 0 25 25">
							<path xmlns="http://www.w3.org/2000/svg" fill="currentColor" d="M22.7 19l-9.1-9.1c.9-2.3.4-5-1.5-6.9-2-2-5-2.4-7.4-1.3L9 6 6 9 1.6 4.7C.4 7.1.9 10.1 2.9 12.1c1.9 1.9 4.6 2.4 6.9 1.5l9.1 9.1c.4.4 1 .4 1.4 0l2.3-2.3c.5-.4.5-1.1.1-1.4z"/>
						</svg>
					</div>
					<div class="label">
						<xsl:choose>
							<xsl:when test="string-length($build) != 0">
								<xsl:value-of select="$build" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>NA</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</div>
				</div>
			</a>
		</div>
	</xsl:template>

</xsl:stylesheet>
