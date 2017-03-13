<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

	<xsl:import href="toolkit-variables-colors.xsl" />
	<xsl:import href="toolkit-variables-typographie.xsl" />

	<xsl:template name="toolkit-variables-graphique">
		<xsl:call-template name="main-section">
			<xsl:with-param name="name" select="'variables-graphique'" />
			<xsl:with-param name="attr" >
				<add class="flexbox min-width-full" />
			</xsl:with-param>
			<xsl:with-param name="content">
				<script type="text/data">
					<xsl:call-template name="toolkit-master-color-data" />
				</script>

				<xsl:call-template name="toolkit-variables-aside" />

				<div class="toolkit-right-panel" style="padding-bottom: 40px;">
					
					<!-- Couleurs -->
					<xsl:call-template name="toolkit-article">
						<xsl:with-param name="name" select="'couleurs'"/>
						<xsl:with-param name="title" select="'Couleurs'" />
						<xsl:with-param name="content">

							<xsl:call-template name="toolkit-variables-color-editor" />
						</xsl:with-param>
					</xsl:call-template>

					<!-- Typographie -->
					<xsl:call-template name="toolkit-article">
						<xsl:with-param name="name" select="'typographie'"/>
						<xsl:with-param name="title" select="'Typographie'" />
						<xsl:with-param name="content">

							<xsl:call-template name="toolkit-typographie-editor" />
						</xsl:with-param>
					</xsl:call-template>

					<!-- Espacements/dimensions -->
					<xsl:call-template name="toolkit-article">
						<xsl:with-param name="name" select="'espacement-dimensions'"/>
						<xsl:with-param name="title" select="'Espacements/Dimensions'" />
						<xsl:with-param name="content">
							<h2 class="toolkit-h2-style">Espacements</h2>
							<xsl:apply-templates select="$theme-node/spacing/*" mode="toolkit-spacing-item" />

							<h2 style="margin-top: 3rem;" class="toolkit-h2-style">Dimensions</h2>
							<xsl:apply-templates select="$theme-node/dimensions/*" mode="toolkit-dimension-item" />
						</xsl:with-param>
					</xsl:call-template>

					<!-- Opacity -->
					<xsl:call-template name="toolkit-article">
						<xsl:with-param name="name" select="'opacity'"/>
						<xsl:with-param name="title" select="'Opacité'" />
						<xsl:with-param name="content">
							<div style="margin-left: 500px;">
								<label>Bg</label>
								<input id="lg-opacity-preview-bg-color" type="text" style="width: 40px;" value="#ffffff" onkeyup="document.documentElement.style.setProperty('--' + this.getAttribute('id'), this.value);"/>
								<label>Fg</label>
								<input id="lg-opacity-preview-fg-color" type="text" style="width: 40px;" value="#000000" onkeyup="document.documentElement.style.setProperty('--' + this.getAttribute('id'), this.value);"/>
							</div>
							<xsl:apply-templates select="$theme-node/opacity/*" mode="toolkit-opacity-item" />
						</xsl:with-param>
					</xsl:call-template>

					<!-- Bordure -->
					<xsl:call-template name="toolkit-article">
						<xsl:with-param name="name" select="'bordure'"/>
						<xsl:with-param name="title" select="'Bordure'" />
						<xsl:with-param name="content">

							<h2 class="toolkit-h2-style inline-block" style="width: 500px;">Size</h2>
							<xsl:apply-templates select="$theme-node/border/size/*" mode="toolkit-border-size-item" />

							<h2 class="toolkit-h2-style inline-block" style="width: 500px; margin-top: 3rem;">Radius</h2>
							<xsl:apply-templates select="$theme-node/border/radius/*" mode="toolkit-border-radius-item" />
						</xsl:with-param>
					</xsl:call-template>

					<!-- Transition -->
					<xsl:call-template name="toolkit-article">
						<xsl:with-param name="name" select="'transitions'"/>
						<xsl:with-param name="title" select="'Transitions'" />
						<xsl:with-param name="content">

							<h2 class="toolkit-h2-style inline-block" style="width: 500px;">Durée</h2>
							<xsl:apply-templates select="$theme-node/transition/duration/*" mode="toolkit-transition-duration-item" />

							<h2 class="toolkit-h2-style inline-block" style="width: 500px; margin-top: 3rem;">Ease</h2>
							<xsl:apply-templates select="$theme-node/transition/ease/*" mode="toolkit-transition-ease-item" />
						</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>

		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.0/jquery.min.js" ></script>
		<script src="/workspace/dev/toolkit/assets/js/toolkit-variables-editor.js" ></script>
		<script src="/workspace/dev/toolkit/assets/js/clipboard.js" ></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.3/FileSaver.min.js" ></script>
	</xsl:template>

	<xsl:template name="toolkit-variables-aside">
		<aside class="toolkit-aside">
			<h1>
				<xsl:text>Variables graphique</xsl:text>
			</h1>

			<nav>
				<a href="#couleurs" >Couleurs</a>
				<a href="#typographie">Typographies</a>
				<a href="#espacement-dimensions" >Espacements/Dimensions</a>
				<a href="#opacity">Opacités</a>
				<a href="#bordure">Bordures</a>
				<a href="#transitions">Transitions</a>
			</nav>
		</aside>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-spacing-item">
		<div class="toolkit-spacing-item">
			<div class="inline-block" style="width: 500px;">
				<span style="width: 70px;" class="inline-block js-btn-copy cursor-pointer" data-clipboard-text="{name()}">
					<xsl:value-of select="name()" />
				</span>
				<span style="width: 60px; text-align: right;" class="inline-block js-btn-copy cursor-pointer"
					data-clipboard-text="{@value}">
					<xsl:value-of select="@value" />
				</span>
			</div>

			<span style="width: {@value}; border-bottom: 1px solid black; margin-left: 2rem;" class="inline-block">
			</span>
			<div>

			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-dimension-item">
		<xsl:variable name="deref-value">
			<xsl:call-template name="deref-value">
				<xsl:with-param name="value" select="@value"/>
			</xsl:call-template>
		</xsl:variable>

		<div class="toolkit-spacing-item">
			<div class="inline-block" style="width: 500px;">
				<span style="width: 70px;" class="inline-block js-btn-copy cursor-pointer"
					data-clipboard-text="{name()}">
					<xsl:value-of select="name()" />
				</span>
				<span style="width: 180px;" class="inline-block">
					<xsl:if test="contains(@value, '@')">
						<xsl:value-of select="@value" />
					</xsl:if>
				</span>
				<span style="width: 140px; text-align: right;" class="inline-block">
					<xsl:for-each select="exsl:node-set($deref-value)/val">
						<xsl:value-of select="."/>
						<xsl:text> </xsl:text>
					</xsl:for-each>
				</span>
			</div>
			<span style="width: calc({$deref-value}); border-bottom: 1px solid black; margin-left: 2rem;" class="inline-block">
			</span>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-opacity-item">
		<div>
			<div class="inline-block toolkit-spacing-item vertical-align-middle;" style="width: 500px;">
				<span style="width: 80px;" class="inline-block js-btn-copy cursor-pointer"
					data-clipboard-text="{name()}">
					<xsl:value-of select="name()" />
				</span>
				<span style="width: 180px;" class="inline-block text-align-right js-btn-copy cursor-pointer"
					data-clipboard-text="{@value}">
					<xsl:value-of select="@value" />
				</span>
			</div>

			<div class="inline-block site-theme vertical-align-middle" 
				style="height: 50px; width: 50px; background-color: var(--lg-opacity-preview-bg-color); color: var(--lg-opacity-preview-fg-color); border-left: 1px solid; border-right: 1px solid;">
				<div style="margin-right: 10px; margin-left: 10px; background-color: var(--lg-opacity-preview-fg-color);" 
					class="height-full {name()}"></div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-border-size-item">
		<div>
			<div class="inline-block toolkit-spacing-item vertical-align-middle;" style="width: 500px;">
				<span style="width: 80px;" class="inline-block js-btn-copy cursor-pointer" data-clipboard-text="border-{name()}">
					<xsl:value-of select="name()" />
				</span>
				<span style="width: 180px;" class="inline-block text-align-right js-btn-copy cursor-pointer"
					data-clipboard-text="{@value}">
					<xsl:value-of select="@value" />
				</span>
			</div>
			<div class="inline-block site-theme">
				<div style="width: 100px;" class="inline-block">
					<div class="inline-block border-top-{name()} border-top-solid" style="width: 100px" />
				</div>
				<div class="inline-block border-{name()} border-solid" style="margin-left: 10px; width: 20px; height: 20px;">
					
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-border-radius-item">
		<div style="margin-top: 1rem;">
			<div class="inline-block toolkit-spacing-item vertical-align-middle;" style="width: 500px;">
				<span style="width: 80px;" class="inline-block"
					data-clipboard-text="border-radius-{name()}">
					<xsl:value-of select="name()" />
				</span>

				<span style="width: 180px;" class="inline-block text-align-right">
					<xsl:value-of select="@value" />
				</span>
			</div>
			<div class="inline-block site-theme">
				<div class="inline-block flexbox-inline flex-center border-1px border-radius-{name()} border-solid" style="width: 100px; height: 100px;">
					<span>
						<xsl:text>100x100</xsl:text>
					</span>
				</div>
				<div class="inline-block flexbox-inline flex-center border-1px border-radius-{name()} border-solid" style="width: 100px; height: 50px; margin-left: 10px;">
					<span>
						<xsl:text>100x50</xsl:text>
					</span>
				</div>
				<div class="inline-block flexbox-inline flex-center border-1px border-radius-{name()} border-solid" style="width: 100px; height: 30px; margin-left: 10px;">
					<span>
						<xsl:text>100x30</xsl:text>
					</span>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-transition-duration-item">
		<div style="margin-top: 1rem;">
			<div class="inline-block toolkit-spacing-item vertical-align-middle;" style="width: 500px;">
				<span style="width: 80px;" 
					class="inline-block js-btn-copy cursor-pointer" 
					data-clipboard-text="transition-duration-{name()}">
					<xsl:value-of select="name()" />
				</span>

				<span style="width: 180px;" class="inline-block text-align-right">
					<xsl:value-of select="@value" />
				</span>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-transition-ease-item">
		<div style="margin-top: 1rem;">
			<div class="inline-block toolkit-spacing-item vertical-align-middle;" style="width: 500px;">
				<span style="width: 150px;" class="inline-block js-btn-copy cursor-pointer" data-clipboard-text="ease-{name()}">
					<xsl:value-of select="name()" />
				</span>

				<span style="width: 250px;" class="inline-block ">
					<xsl:value-of select="@value" />
				</span>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
