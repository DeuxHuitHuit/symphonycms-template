<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:import href="../utilities/master/master-toolkit.xsl" />

<xsl:template match="data">
	<section class="ui-toolkit-ctn">
		<div class="ui-group">
			<h1 class="ui-group-title">Palette</h1>
			
			<div class="ui-palette-ctn">
				<div class="ui-palette-couleurs">
					<div class="ui-color-ctn">
						<div class="ui-color gray"></div>
						<div class="ui-color gray ui-darker"></div>
					</div>
					<div class="ui-color-title">#000000</div>
					<div class="ui-color-title">@black</div>
				</div>
				
				<div class="ui-palette-couleurs">
					<div class="ui-color-ctn">
						<div class="ui-color white"></div>
						<div class="ui-color white ui-darker"></div>
					</div>
					<div class="ui-color-title">#ffffff</div>
					<div class="ui-color-title">@white</div>
				</div>
			</div>
		</div>
		
		<div class="ui-group">
			<h1 class="ui-group-title">Typographie</h1>
				
			<div class="ui-item">
				<h2 class="ui-item-title">Oenonew</h2>
				<div class="ui-font-oenonew ui-item-ctn">
					ABCDEFGHIJKLMNOPQRSTUVWXYZ<br />
					abcdefghijklmnopqrstuvwxyz<br />
					1234567890
				</div>
			</div>
			
				
			<div class="ui-item">
				<h2 class="ui-item-title">Oenotalian</h2>
				<div class="ui-font-oenotalian ui-item-ctn">
					ABCDEFGHIJKLMNOPQRSTUVWXYZ<br />
					abcdefghijklmnopqrstuvwxyz<br />
					1234567890
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Lato Bold (Google Font)</h2>
				<div class="ui-font-lato-bold ui-item-ctn">
					ABCDEFGHIJKLMNOPQRSTUVWXYZ<br />
					abcdefghijklmnopqrstuvwxyz<br />
					1234567890
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Lato Light (Google Font)</h2>
				<div class="ui-font-lato-light ui-item-ctn">
					ABCDEFGHIJKLMNOPQRSTUVWXYZ<br />
					abcdefghijklmnopqrstuvwxyz<br />
					1234567890
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">H1</h2>
				<div class="ui-item-ctn">
					<h1>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque quis <strong>Such strong</strong>, turpis <em>mush italic</em>, in commodo ligula nisi at diam.</h1>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">H2</h2>
				<div class="ui-item-ctn">
					<h2>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque quis <strong>Such strong</strong>, turpis <em>mush italic</em>, in commodo ligula nisi at diam.</h2>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">H3</h2>
				<div class="ui-item-ctn">
					<h3>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque quis <strong>Such strong</strong>, turpis <em>mush italic</em>, in commodo ligula nisi at diam.</h3>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">H4</h2>
				<div class="ui-item-ctn">
					<h4>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque quis <strong>Such strong</strong>, turpis <em>mush italic</em>, in commodo ligula nisi at diam.</h4>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">H5</h2>
				<div class="ui-item-ctn">
					<h5>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque quis <strong>Such strong</strong>, turpis <em>mush italic</em>, in commodo ligula nisi at diam.</h5>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">H6</h2>
				<div class="ui-item-ctn">
					<h6>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, neque quis <strong>Such strong</strong>, turpis <em>mush italic</em>, in commodo ligula nisi at diam.</h6>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Lead Text</h2>
				<div class="lead-text ui-item-ctn">
					<p>We have a text here <strong>Such strong</strong> and <em>mush italic</em>. But we dont have to forget a <em><strong>strong intalic</strong></em> and all the <strong><em>italic strong</em></strong>.</p>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Strong and italic</h2>
				<div class="ui-item-ctn">
					<p>We have a text here <strong>Such strong</strong> and <em>mush italic</em>. But we dont have to forget a <em><strong>strong intalic</strong></em> and all the <strong><em>italic strong</em></strong>. Blah blah Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Link</h2>
				<div class="ui-item-ctn">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt <a href="http://www.google.no">Google lvl => 100</a> ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Ordered list</h2>
				<div class="ui-item-ctn">
					<ol>
						<li>Free text</li>
						<li><p>Text in p</p></li>
						<li><a href="https://www.youtube.com/watch?v=lPELNn_OeOU" target="_blank">Linked text</a></li>
					</ol>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Unordered list</h2>
				<div class="ui-item-ctn">
					<ul>
						<li>Free text</li>
						<li><p>Text in p</p></li>
						<li><a href="https://www.youtube.com/watch?v=lPELNn_OeOU" target="_blank">Linked text</a></li>
					</ul>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">blockquote</h2>
				<div class="ui-item-ctn">
					<blockquote>« Citation ou texte en exergu Lato Light italic align : centered. »</blockquote>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Table</h2>
				<div class="ui-item-ctn">
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
				</div>
			</div>
		</div>
		
		<div class="ui-group">
			<h1 class="ui-group-title">Liens</h1>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Lien normal</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="button">
						<xsl:with-param name="text" select="'Nous joindre'" />
						<xsl:with-param name="url" select="'http://www.google.com'"/>
					</xsl:call-template>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">Lien menu</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="button">
						<xsl:with-param name="text" select="'Nous joindre'" />
						<xsl:with-param name="url" select="'http://www.google.com'"/>
						<xsl:with-param name="class" select="'nav-item-link'" />
					</xsl:call-template>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">link-pin</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="link-pin">
						<xsl:with-param name="url" select="'http://www.google.com'" />
						<xsl:with-param name="titre" select="'localisation'" />
					</xsl:call-template>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">link-image</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="link-image">
						<xsl:with-param name="url" select="'http://www.google.com'" />
						<xsl:with-param name="image" select="'http://www.placehold.it/110x110.jpg'" />
						<xsl:with-param name="titre" select="'John Doe'" />
					</xsl:call-template>
				</div>
			</div>
		</div>
		
		<div class="ui-group">
			<h1 class="ui-group-title">Boutons</h1>
			
			<div class="ui-item">
				<h2 class="ui-item-title">social-nav</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="social-nav" />
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">btn-close</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="btn-close" />
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">btn-print</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="btn-print">
						<xsl:with-param name="url" select="'http://www.google.com'" />
					</xsl:call-template>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">btn-select-box</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="btn-select-box">
						<xsl:with-param name="title" select="'Filtres'" />
					</xsl:call-template>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">btn-prix</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="btn-prix">
						<xsl:with-param name="url" select="'http://www.google.com'" />
						<xsl:with-param name="prix" select="'24.34'" />
						<xsl:with-param name="fournisseur" select="'SAQ'" />
						<xsl:with-param name="id" select="'1023547'" />
					</xsl:call-template>
				</div>
			</div>
			
			<div class="ui-item">
				<h2 class="ui-item-title">btn-prix small</h2>
				<div class="ui-item-ctn">
					<xsl:call-template name="btn-prix">
						<xsl:with-param name="url" select="'http://www.google.com'" />
						<xsl:with-param name="prix" select="'24.34'" />
						<xsl:with-param name="fournisseur" select="'SAQ'" />
						<xsl:with-param name="id" select="'1023547'" />
						<xsl:with-param name="isSmall" select="'Yes'" />
					</xsl:call-template>
				</div>
			</div>
		</div>
	</section>
</xsl:template>

</xsl:stylesheet>