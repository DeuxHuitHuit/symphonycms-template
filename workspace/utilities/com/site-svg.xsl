<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- ICON: close -->
	<xsl:template name="icon-close">
		<xsl:param name="class" select="'width-full overflow-visible block'" />
		<svg xmlns="http://www.w3.org/2000/svg"
			class="{$class}"
			style="padding-bottom: 100%; height: 1px;"
			preserveAspectRatio="xMidYMin slice"
			viewBox="0 0 25 25">
			<path fill="currentColor" d="M3.307 4.015l.708-.707 17.677 17.677-.707.707z"/><path fill="currentColor" d="M3.307 20.985L20.986 3.308l.707.707L4.015 21.692z"/>
		</svg>
	</xsl:template>

</xsl:stylesheet>
