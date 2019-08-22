<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="widget-logout">
		<div class="widget widget-logout">
			<a href="/symphony/logout/">
				<div style="display:flex">
					<div class="widget-icon">
						<svg xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMin slice"
							viewBox="0 0 25 25">
							<path fill="none" d="M0 0h24v24H0V0z"/><path fill="currentColor" d="M18 14.49V9c0-1-1.01-2.01-2-2V3h-2v4h-4V3H8v2.48l9.51 9.5.49-.49zm-1.76 1.77L7.2 7.2l-.01.01L3.98 4 2.71 5.25l3.36 3.36C6.04 8.74 6 8.87 6 9v5.48L9.5 18v3h5v-3l.48-.48L19.45 22l1.26-1.28-4.47-4.46z"/>
						</svg>
					</div>
					<div class="label"><xsl:text>Logout</xsl:text></div>
				</div>
			</a>
		</div>
	</xsl:template>

</xsl:stylesheet>
