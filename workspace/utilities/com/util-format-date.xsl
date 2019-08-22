<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:func="http://exslt.org/functions"
	xmlns:util="https://github.com/DeuxHuitHuit/288-utils"
	extension-element-prefixes="func util">

<!-- 

	Available format
	Y: Year in 4 digits, e. g. 1981, 1992, 2008
	y: Year in 2 digits, e. g. 81, 92, 08
	M: Month as a full word, e. g. January, March, September
	m: Month in 3 letters, e. g. Jan, Mar, Sep
	N: Month in digits without leading zero
	n: Month in digits with leading zero
	D: Day with suffix and no leading zero, e. g. 1st, 23rd
	d: Day in digits with leading zero, e. g. 01, 09, 12, 25
	x: Day in digits with no leading zero, e. g. 1, 9, 12, 25
	T: Time in 24-hours, e. g. 18:30
	h: Time in 24-hours with no leading zero, e. g. 4:25
	t: Time in 12-hours, e. g. 6:30pm
	W: Weekday as a full word, e. g. Monday, Tuesday
	w: Weekday in 3 letters, e. g. Mon, Tue, Wed

 -->

	<!-- FUNCTION: util:format-date -->
	<func:function name="util:format-date">
		<xsl:param name="date" select="date/date/start"/>
		<xsl:param name="format" select="Y-n-d" />

		<xsl:if test="string-length($date) != 0">
			<xsl:variable name="result">
				<xsl:call-template name="datetime">
					<xsl:with-param name="date" select="$date" />
					<xsl:with-param name="format" select="$format" />
					<xsl:with-param name="lang" select="$url-language" />
					<xsl:with-param name="data" select="$data" />
				</xsl:call-template>
			</xsl:variable>
		</xsl:if>

		<func:result>
			<xsl:value-of select="$result" />
		</func:result>

	</func:function>

</xsl:stylesheet>
