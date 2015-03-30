<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:import href="../utilities/master/master-toolkit.xsl" />

<xsl:template match="data">
	<section class="ui-toolkit-ctn">
		<div class="ui-group">
			<h1 class="ui-group-title">Palette</h1>
			
			<div class="ui-palette-ctn">
				<xsl:call-template name="palette-couleur">
					<xsl:with-param name="titre" select="'@black or @dark'" />
					<xsl:with-param name="class" select="'black'"/>
					<xsl:with-param name="couleur" select="'000000'" />
				</xsl:call-template>
				
				<xsl:call-template name="palette-couleur">
					<xsl:with-param name="titre" select="'@white or @light'" />
					<xsl:with-param name="class" select="'white'"/>
					<xsl:with-param name="couleur" select="'ffffff'" />
				</xsl:call-template>
			</div>
		</div>
		
		<div class="ui-group">
			<h1 class="ui-group-title">Typographie</h1>
				
			<xsl:call-template name="typo-template">
				<xsl:with-param name="titre" select="'Typo'"/>
				<xsl:with-param name="class" select="'heading'" />
			</xsl:call-template>
			
			<xsl:call-template name="heading-template">
				<xsl:with-param name="element-type" select="'h1'" />
			</xsl:call-template>
			
			<xsl:call-template name="heading-template">
				<xsl:with-param name="element-type" select="'h2'" />
			</xsl:call-template>
			
			<xsl:call-template name="heading-template">
				<xsl:with-param name="element-type" select="'h3'" />
			</xsl:call-template>
			
			<xsl:call-template name="heading-template">
				<xsl:with-param name="element-type" select="'h4'" />
			</xsl:call-template>
			
			<xsl:call-template name="heading-template">
				<xsl:with-param name="element-type" select="'h5'" />
			</xsl:call-template>
			
			<xsl:call-template name="heading-template">
				<xsl:with-param name="element-type" select="'h6'" />
			</xsl:call-template>
			
			<xsl:call-template name="strong-template">
				<xsl:with-param name="titre" select="'Strong and italics'" />
			</xsl:call-template>
			
			<xsl:call-template name="markdown-template">
				<xsl:with-param name="titre" select="'Markdown'" />
			</xsl:call-template>
			
			<xsl:call-template name="ol-template">
				<xsl:with-param name="titre" select="'Ordered list'" />
			</xsl:call-template>
			
			<xsl:call-template name="ul-template">
				<xsl:with-param name="titre" select="'Unordered list'" />
			</xsl:call-template>
			
			<xsl:call-template name="blockquote-template">
				<xsl:with-param name="titre" select="'Blockquote'" />
			</xsl:call-template>
			
			<xsl:call-template name="table-template">
				<xsl:with-param name="titre" select="'Table'" />
			</xsl:call-template>
		</div>
		
		<div class="ui-group">
			<h1 class="ui-group-title">Liens et boutons</h1>
			
			<xsl:call-template name="ui-item">
				<xsl:with-param name="titre" select="'Lien normal'" />
				<xsl:with-param name="content">
					<xsl:call-template name="button">
						<xsl:with-param name="content" select="'Nous joindre'" />
						<xsl:with-param name="url" select="'http://www.google.com'"/>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="ui-item">
				<xsl:with-param name="titre" select="'Lien normal'" />
				<xsl:with-param name="content">
					<xsl:call-template name="button">
						<xsl:with-param name="content" select="'Nous joindre'" />
						<xsl:with-param name="url" select="'http://www.google.com'"/>
						<xsl:with-param name="class" select="'nav-item-link'" />
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</div>
	</section>
</xsl:template>

<xsl:template name="table-template">
	<xsl:param name="titre" select="''" />
	<xsl:param name="class" select="''" />
	
	<xsl:call-template name="ui-item">
		<xsl:with-param name="titre" select="$titre" />
		<xsl:with-param name="content">
			<table>
				<tr>
					<th>Cépages</th>
					<td>60% grenache, 30% syrah, 10% mourvèdre et cinsault</td>
				</tr>
				<tr>
					<th>Élevage</th>
					<td>1 an en foudre de 50 hl</td>
				</tr>
				<tr>
					<th>Vinification</th>
					<td>Égrappage, fermentation avec levures indigènes, après un unique sulfitage, vin mis en bouteille sans collage, ni filtration.</td>
				</tr>
			</table>
		</xsl:with-param>
		<xsl:with-param name="class" select="$class" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="blockquote-template">
	<xsl:param name="titre" select="''" />
	<xsl:param name="class" select="''" />
	
	<xsl:call-template name="ui-item">
		<xsl:with-param name="titre" select="$titre" />
		<xsl:with-param name="content">
			<blockquote>« Citation ou texte en exergu Lato Light italic align : centered. »</blockquote>
		</xsl:with-param>
		<xsl:with-param name="class" select="$class" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="ol-template">
	<xsl:param name="titre" select="''" />
	<xsl:param name="class" select="''" />
	
	<xsl:call-template name="ui-item">
		<xsl:with-param name="titre" select="$titre" />
		<xsl:with-param name="content">
			<ol>
				<li>Free text</li>
				<li><p>Text in p</p></li>
				<li><a href="https://www.youtube.com/watch?v=lPELNn_OeOU" target="_blank">Linked text</a></li>
			</ol>
		</xsl:with-param>
		<xsl:with-param name="class" select="$class" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="ul-template">
	<xsl:param name="titre" select="''" />
	<xsl:param name="class" select="''" />
	
	<xsl:call-template name="ui-item">
		<xsl:with-param name="titre" select="$titre" />
		<xsl:with-param name="content">
			<ul>
				<li>Free text</li>
				<li><p>Text in p</p></li>
				<li><a href="https://www.youtube.com/watch?v=lPELNn_OeOU" target="_blank">Linked text</a></li>
			</ul>
		</xsl:with-param>
		<xsl:with-param name="class" select="$class" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="strong-template">
	<xsl:param name="titre" select="''" />
	<xsl:param name="class" select="''" />
	
	<xsl:call-template name="ui-item">
		<xsl:with-param name="titre" select="$titre" />
		<xsl:with-param name="content">
			<p>We have a text here <strong>Such strong</strong> and <em>mush italic</em>. But we dont have to forget a <em><strong>strong intalic</strong></em> and all the <strong><em>italic strong</em></strong>.</p>
		</xsl:with-param>
		<xsl:with-param name="class">
			<xsl:text>strong </xsl:text>
			<xsl:value-of select="$class" />
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="markdown-template">
	<xsl:param name="titre" select="''" />
	<xsl:param name="class" select="''" />
	
	<xsl:call-template name="ui-item">
		<xsl:with-param name="titre" select="$titre" />
		<xsl:with-param name="content">
			<p>We have a text here <strong>Such strong</strong> and <em>mush italic</em>. But we dont have to forget a <em><strong>strong intalic</strong></em> and all the <strong><em>italic strong</em></strong>.</p>
			<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt <a href="http://www.google.no">Google lvl => 100</a> ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
			<p>We have a text here <strong>Such strong</strong> and <em>mush italic</em>. But we dont have to forget a <em><strong>strong intalic</strong></em> and all the <strong><em>italic strong</em></strong>.</p>
		</xsl:with-param>
		<xsl:with-param name="class">
			<xsl:text>markdown </xsl:text>
			<xsl:value-of select="$class" />
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="heading-template">
	<xsl:param name="element-type" select="'h1'" />
	
	<xsl:call-template name="ui-item">
		<xsl:with-param name="titre" select="$element-type" />
		<xsl:with-param name="content">
			<xsl:element name="{$element-type}">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque quis <strong>Such strong</strong>, turpis <em>mush italic</em>, in commodo ligula nisi at diam.</xsl:element>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="typo-template">
	<xsl:param name="titre" select="''" />
	<xsl:param name="class" select="''" />
	
	<xsl:call-template name="ui-item">
		<xsl:with-param name="titre" select="'Font'" />
		<xsl:with-param name="class">
			<xsl:text>ui-font </xsl:text>
			<xsl:value-of select="$class" />
		</xsl:with-param>
		<xsl:with-param name="content">
			ABCDEFGHIJKLMNOPQRSTUVWXYZ<br />
			abcdefghijklmnopqrstuvwxyz<br />
			1234567890
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="palette-couleur">
	<xsl:param name="titre" />
	<xsl:param name="class" />
	<xsl:param name="couleur" />
	
	<div class="ui-palette-couleurs">
		<div class="ui-color-ctn">
			<div class="ui-color {$class}"></div>
			<div class="ui-color {$class} ui-darker"></div>
		</div>
		<div class="ui-color-title">
			<xsl:value-of select="$titre" />
		</div>
		<div class="ui-color-title">
			<xsl:text>#</xsl:text>
			<xsl:value-of select="$couleur" />
		</div>
	</div>
</xsl:template>

<xsl:template name="ui-item">
	<xsl:param name="titre" select="''" />
	<xsl:param name="class" select="''" />
	<xsl:param name="content" select="''" />
	
	<div class="ui-item">
		<h2 class="ui-item-title">
			<xsl:value-of select="$titre" />
		</h2>
		<div>
			<xsl:attribute name="class">
				<xsl:text>ui-item-ctn</xsl:text>
				
				<xsl:if test="string-length($class) != 0">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$class" />
				</xsl:if>
			</xsl:attribute>
			
			<xsl:call-template name="content">
				<xsl:with-param name="content" select="$content" />
			</xsl:call-template>
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>