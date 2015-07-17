<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:media="http://search.yahoo.com/mrss/"
	xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">

<!-- MASTER -->
<xsl:import href="variables.xsl" />
<xsl:import href="../site-variables.xsl" />
<xsl:import href="../lib/page-title.xsl" />
<xsl:import href="../lib/master-title.xsl" />
<!-- LIB -->
<xsl:import href="../lib/create-page-url.xsl" />
<xsl:import href="../lib/fx-url-creator.xsl" />
<!-- Extensions -->
<xsl:import href="../../../extensions/datetime/utilities/datetime.xsl" />

<xsl:output method="xml" encoding="UTF-8" indent="yes" />

<xsl:variable name="rss-image" select="concat($root, '/image/1/1400/1400', $config/image-partage/@path, '/', $config/image-partage/filename)" />

<xsl:template match="/"><rss version="2.0" 
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:media="http://search.yahoo.com/mrss/"
	xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
	>
	<channel>
		<title>
			<xsl:call-template name="channel-title" />
		</title>
		<link>
			<xsl:call-template name="channel-url" />
		</link>
		<description>
			<xsl:call-template name="channel-description" />
		</description>
		<language><xsl:value-of select="$url-language" />-ca</language>
		<generator>Symphony <xsl:value-of select="$symphony-version"/></generator>
		<atom:link href="{$root}{$current-path}/" rel="self" type="application/rss+xml" />
		
		<image>
			<url><xsl:value-of select="$rss-image" /></url>
			<title>
				<xsl:call-template name="channel-title" />
			</title>
			<link>
				<xsl:call-template name="channel-url" />
			</link>
			<width>1400<!-- xsl:value-of select="$config/image-partage/meta/@width" /--></width>
			<height>1400<!-- xsl:value-of select="$config/image-partage/meta/@height" /--></height>
			<description>
				<xsl:call-template name="channel-copyrights" />
			</description>
		</image>
		
		<!--xsl:call-template name="podcast-channel" /-->
		
		<xsl:apply-templates match="data" />
	</channel>
</rss>
</xsl:template>

<xsl:template name="rss-entry">
	<xsl:param name="title" />
	<xsl:param name="link" />
	<xsl:param name="date" />
	<xsl:param name="description" />
	<xsl:param name="image" />
	<xsl:param name="medias" />
	
	<xsl:call-template name="rss-item">
		<xsl:with-param name="title" select="$title" />
		<xsl:with-param name="link" select="$link" />
		<xsl:with-param name="date">
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="$date"/>
				<xsl:with-param name="format" select="'w, d m Y T'"/>
				<xsl:with-param name="lg" select="'en'" /> <!-- force date in EN -->
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:value-of select="translate($timezone,':','')"/>
		</xsl:with-param>
		<xsl:with-param name="description" select="$description" />
		<xsl:with-param name="medias">
			<xsl:if test="string-length($image) != 0">
				<media:content 
					url="{$root}/workspace{$image/@path}/{$image/filename}" 
					fileSize="{number(substring-before($image/@size, ' ')) * 1024}" 
					type="{$image/@type}" 
					isDefault="true" 
					height="{$image/meta/@height}"
					width="{$image/meta/@width}" />
			</xsl:if>
			
			<xsl:copy-of select="$medias" />
			
			<xsl:if test="string-length($medias) != 0">
				<xsl:call-template name="podcast">
					<xsl:with-param name="title" select="$title" />
					<xsl:with-param name="image" select="concat($root, '/workspace', $image/@path, '/', $image/filename)" />
					<xsl:with-param name="description" select="$description" />
				</xsl:call-template>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="rss-item">
	<xsl:param name="title" />
	<xsl:param name="link" />
	<xsl:param name="date" />
	<xsl:param name="description" />
	<xsl:param name="medias" />
	
	<item>
		<title>
			<xsl:value-of select="$title" />
		</title>
		<link><xsl:value-of select="$link" /></link>
		<pubDate><xsl:value-of select="$date" /></pubDate>
		<guid><xsl:value-of select="$link"/></guid>
		<description>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
			<xsl:value-of select="$description" disable-output-escaping="yes"/>
			<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
		</description>
		
		<xsl:copy-of select="$medias" />
	</item>
</xsl:template>

<xsl:template name="podcast-channel">
	<itunes:subtitle>
		<xsl:call-template name="channel-title" />
	</itunes:subtitle>
	<itunes:summary>
		<xsl:call-template name="channel-description" />
	</itunes:summary>
	<itunes:owner>
		<itunes:name><xsl:value-of select="$config/itunes-auteur" /></itunes:name>
		<itunes:email><xsl:value-of select="$config/itunes-email" /></itunes:email>
	</itunes:owner>
	<itunes:author><xsl:value-of select="$config/itunes-auteur" /></itunes:author>
	<itunes:category text="News &amp; Politics" />
	<itunes:explicit>no</itunes:explicit>
	<itunes:image href="{$rss-image}"></itunes:image>
	<itunes:keywords></itunes:keywords>
</xsl:template>

<xsl:template name="podcast">
	<xsl:param name="title" />
	<xsl:param name="image" />
	<xsl:param name="description" />
	<xsl:param name="keywords" />
	
	<itunes:summary>
		<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
		<xsl:value-of select="$description" disable-output-escaping="yes"/>
		<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
	</itunes:summary>
	<itunes:subtitle>
		<xsl:value-of select="substring($title, 0, 255)" />
	</itunes:subtitle>
	<itunes:author><xsl:value-of select="$config/itunes-auteur" /></itunes:author>
	<!-- itunes:duration></itunes:duration -->
	<itunes:explicit>no</itunes:explicit>
	<!-- itunes:image></itunes:image -->
	<itunes:keywords>
		<xsl:value-of select="$keywords" />
	</itunes:keywords>
</xsl:template>

<xsl:template name="enclosure">
	<xsl:param name="file" />
	<xsl:param name="type" />
	
	<xsl:variable name="content-type">
		<xsl:choose>
			<xsl:when test="contains($type, '/')">
				<xsl:value-of select="$type" />
			</xsl:when>
			<xsl:when test="$type = 'mp3' or $type = 'mpeg'">
				<xsl:value-of select="concat('audio/', $type)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('video/', $type)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="filesize">
		<xsl:call-template name="filesize">
			<xsl:with-param name="size" select="$file/@size" />
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:if test="string-length($file) != 0">
		<enclosure url="{$root}/workspace{$file/@path}/{$file/filename}" length="{round($filesize)}" type="{$content-type}"/>
	</xsl:if>
</xsl:template>

<xsl:template name="filesize">
	<xsl:param name="size" select="'0'" />
	
	<xsl:choose>
		<xsl:when test="contains($size, 'KB')">
			<xsl:value-of select="number(substring-before($size, ' ')) * 1024" />
		</xsl:when>
		<xsl:when test="contains($size, 'MB')">
			<xsl:value-of select="number(substring-before($size, ' ')) * 1024 * 1024" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$size" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>