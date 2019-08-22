<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="widget-flush-cache">
		<div class="widget widget-flush-cache">
			<a href="?flush=site" target="_blank">
				<div style="display:flex">
					<div class="widget-icon">
						<svg xmlns="http://www.w3.org/2000/svg"
							preserveAspectRatio="xMidYMin slice"
							viewBox="0 0 25 25">
							<path fill="currentColor" d="M12 4V1L8 5l4 4V6c3.31 0 6 2.69 6 6 0 1.01-.25 1.97-.7 2.8l1.46 1.46C19.54 15.03 20 13.57 20 12c0-4.42-3.58-8-8-8zm0 14c-3.31 0-6-2.69-6-6 0-1.01.25-1.97.7-2.8L5.24 7.74C4.46 8.97 4 10.43 4 12c0 4.42 3.58 8 8 8v3l4-4-4-4v3z"/><path fill="none" d="M0 0h24v24H0z"/>
						</svg>
					</div>
					<div class="label"><xsl:text>Cache</xsl:text></div>
				</div>
			</a>
		</div>
	</xsl:template>
	
</xsl:stylesheet>
