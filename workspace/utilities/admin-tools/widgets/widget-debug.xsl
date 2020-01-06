<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="widget-debug">
		<div class="widget widget-debug">
			<a href="{$params/current-url}/?debug">
				<div style="display:flex">
					<div class="widget-icon">
						<svg xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMin slice"
							viewBox="0 0 25 25">
							<path fill="none" d="M0 0h24v24H0V0z"/><path fill="currentColor" d="M9.4 16.6L4.8 12l4.6-4.6L8 6l-6 6 6 6 1.4-1.4zm5.2 0l4.6-4.6-4.6-4.6L16 6l6 6-6 6-1.4-1.4z"/>
						</svg>
					</div>
					<div class="label"><xsl:text>Debug</xsl:text></div>
				</div>
			</a>
		</div>
	</xsl:template>

</xsl:stylesheet>
