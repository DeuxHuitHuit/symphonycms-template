<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- WIDTH: tiniest -->
	<xsl:template name="util-module-width-tiniest" match="item[@section = 'module-text'] | item[@section = 'module-form']" mode="util-module-width-attr">
		<add class="max-width-tiniest" />
		<add dev-width="tiniest" />
	</xsl:template>

<!-- DEFAULT -->
	<xsl:template match="*" mode="util-module-width-attr" priority="0">
		<add class="max-width-perimeter" />
		<add dev-width="default" />
	</xsl:template>

</xsl:stylesheet>
