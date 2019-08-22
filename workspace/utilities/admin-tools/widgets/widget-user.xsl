<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="widget-user">
		<xsl:param name="user" select="/data/events/login-info" />
		<xsl:param name="avatar" select="concat('https://www.gravatar.com/avatar/', $user/gravatar)" />

		<div class="widget widget-user">
			<a href="/symphony/system/authors/edit/{$user/@id}" target="_blank">
				<div style="display:flex">
					<div class="widget-icon">
						<img class="widget-avatar" src="{$avatar}"></img>
						<!-- <svg xmlns="http://www.w3.org/2000/svg"	preserveAspectRatio="xMidYMin slice" viewBox="0 0 25 25">
						<path fill="currentColor" d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 3c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14.2c-2.5 0-4.71-1.28-6-3.22.03-1.99 4-3.08 6-3.08 1.99 0 5.97 1.09 6 3.08-1.29 1.94-3.5 3.22-6 3.22z"/>
						<path d="M0 0h24v24H0z" fill="none"/></svg> -->
					</div>
					<div class="label"><xsl:value-of select="$user/name" /></div>
				</div>
			</a>
		</div>
	</xsl:template>
	
</xsl:stylesheet>
