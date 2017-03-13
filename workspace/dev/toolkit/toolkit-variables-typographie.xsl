<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:exsl="http://exslt.org/common"
	xmlns:str="http://exslt.org/strings"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="exsl str">

	<xsl:template name="toolkit-typographie-editor">
		<div class="toolkit-typographie-font-editor">
			<h2 class="toolkit-h2-style inline-block" style="width: 500px;">Fonts</h2>
			<div class="inline-block ">
				<label>Font size:</label>
				<input id="lg-fonts-preview-size" type="text" value="10px" style="width: 40px;" onkeyup="document.documentElement.style.setProperty('--' + this.getAttribute('id'), this.value);"/>
				<label>Font weight:</label>
				<input id="lg-fonts-preview-weight" type="text" value="400" style="width: 40px;" onkeyup="document.documentElement.style.setProperty('--' + this.getAttribute('id'), this.value);"/>
			</div>
			<div style="font-size: var(--lg-fonts-preview-size);">
				<xsl:apply-templates select="$theme-node/typographie/fonts/*" mode="toolkit-typographie-fonts-item" />
			</div>
		</div>

		<div style="margin-top: 3rem;">
			<h2 class="toolkit-h2-style inline-block" style="width: 500px;">Fonts size</h2>
			<div class="inline-block">
				<label>Fonts:</label>
				<select>
					<option value="all" selected="">tous</option>
					<xsl:for-each select="$theme-node/typographie/fonts/*">
						<option>
							<xsl:value-of select="name()" />
						</option>
					</xsl:for-each>
				</select>
				<label>Font weight:</label>
				<input id="lg-fonts-size-preview-weight" type="text" value="400" style="width: 40px;" onkeyup="document.documentElement.style.setProperty('--' + this.getAttribute('id'), this.value);"/>
			</div>

			<xsl:apply-templates select="$theme-node/typographie/fonts-size/*" mode="toolkit-typographie-fonts-size-item" />
		</div>
		
		<div style="margin-top: 3rem;">
			<h2 class="toolkit-h2-style inline-block" style="width: 500px;">Line height</h2>
			<div class="inline-block">
				<label>Fonts:</label>
				<select>
					<option value="all" selected="">tous</option>
					<xsl:for-each select="$theme-node/typographie/fonts/*">
						<option>
							<xsl:value-of select="name()" />
						</option>
					</xsl:for-each>
				</select>
				<label>Font weight:</label>
				<input id="lg-fonts-line-height-preview-weight" type="text" value="400" style="width: 40px;" onkeyup="document.documentElement.style.setProperty('--' + this.getAttribute('id'), this.value);"/>
			</div>
			<div class="inline-block">
				<label>Font size:</label>
				<input id="lg-line-height-preview-size" type="text" value="10px" style="width: 40px;" onkeyup="document.documentElement.style.setProperty('--' + this.getAttribute('id'), this.value);"/>
			</div>
			<div style="font-size: var(--lg-line-height-preview-size);">
				<xsl:apply-templates select="$theme-node/typographie/line-height/*" mode="toolkit-typographie-line-height-item" />
			</div>
		</div>

		<div style="margin-top: 3rem;">
			<h2 class="toolkit-h2-style inline-block" style="width: 500px;">Letter spacing</h2>
			<div class="inline-block ">
				<label>Font size:</label>
				<input id="lg-letter-spacing-preview-size" type="text" value="10px" style="width: 40px;" onkeyup="document.documentElement.style.setProperty('--' + this.getAttribute('id'), this.value);"/>
			</div>

			<div style="font-size: var(--lg-letter-spacing-preview-size);">
				<xsl:apply-templates select="$theme-node/typographie/letter-spacing/*" mode="toolkit-typographie-letter-spacing-item" />
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-typographie-fonts-item">
		<xsl:variable name="deref-value">
			<xsl:call-template name="deref-value">
				<xsl:with-param name="value" select="@value"/>
			</xsl:call-template>
		</xsl:variable>

		<div class="flexbox">
			<div class="inline-block toolkit-spacing-item flex-shrink-0" style="width: 500px;">
				<span style="width: 70px;" class="inline-block js-btn-copy cursor-pointer"
					data-clipboard-text="font-{name()}">
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

			<div class="inline-block site-theme overflow-x-auto">
				<span class="font-{name()}" style="font-weight: var(--lg-fonts-preview-weight);">
					<xsl:value-of select="$alphabet" />
				</span>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-typographie-fonts-size-item">
		<xsl:variable name="deref-value">
			<xsl:call-template name="deref-value">
				<xsl:with-param name="value" select="@value"/>
			</xsl:call-template>
		</xsl:variable>

		<div style="padding-top: 1rem;"  class="flexbox">
			<div class="inline-block toolkit-spacing-item flex-shrink-0" style="width: 500px;">
				<span style="width: 70px;" class="inline-block js-btn-copy cursor-pointer"
					data-clipboard-text="text-{name()}">

					<xsl:value-of select="name()" />
				</span>
				<span style="width: 180px;" class="inline-block">
					<xsl:if test="contains(@value, '@')">
						<xsl:value-of select="@value" />
					</xsl:if>
				</span>
				<span style="width: 140px; text-align: right;" 
					class="inline-block js-btn-copy cursor-pointer">
					<xsl:attribute name="data-clipboard-text">
						<xsl:for-each select="exsl:node-set($deref-value)/val">
							<xsl:value-of select="."/>
							<xsl:if test="position() != last()">
								<xsl:text> </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</xsl:attribute>
					<xsl:for-each select="exsl:node-set($deref-value)/val">
						<xsl:value-of select="."/>
						<xsl:if test="position() != last()">
							<xsl:text> </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</span>
			</div>
			<div class="inline-block site-theme overflow-x-auto" style="font-weight: var(--lg-fonts-size-preview-weight);">
				<xsl:variable name="font-size-name" select="name()" />
				<xsl:for-each select="$theme-node/typographie/fonts/*">
					<span class="text-{$font-size-name} font-{name()}">
						<xsl:value-of select="concat('(', name(), ') ')" />
						<xsl:value-of select="$alphabet" />
					</span>
					<br />
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-typographie-line-height-item">
		<xsl:variable name="deref-value">
			<xsl:call-template name="deref-value">
				<xsl:with-param name="value" select="@value"/>
			</xsl:call-template>
		</xsl:variable>

		<div style="padding-top: 2rem; border-bottom: 1px solid #d3dce2;" class="flexbox">
			<div class="inline-block toolkit-spacing-item vertical-align-bottom flex-shrink-0" style="width: 500px;">
				<span style="width: 70px;" class="inline-block js-btn-copy cursor-pointer"
					data-clipboard-text="line-height-{name()}">
					<xsl:value-of select="name()" />
				</span>
				<span style="width: 180px;" class="inline-block">
					<xsl:if test="contains(@value, '@')">
						<xsl:value-of select="@value" />
					</xsl:if>
				</span>
				<span style="width: 140px; text-align: right;" class="inline-block js-btn-copy cursor-pointer">
					<xsl:attribute name="data-clipboard-text">
						<xsl:for-each select="exsl:node-set($deref-value)/val">
							<xsl:value-of select="."/>
							<xsl:if test="position() != last()">
								<xsl:text> </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</xsl:attribute>

					<xsl:for-each select="exsl:node-set($deref-value)/val">
						<xsl:value-of select="."/>
						<xsl:if test="position() != last()">
							<xsl:text> </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</span>
			</div>
			<div class="inline-block site-theme vertical-align-bottom overflow-x-auto">
				<xsl:variable name="line-height-name" select="name()" />
				<xsl:for-each select="$theme-node/typographie/fonts/*">
					<span class="line-height-{$line-height-name} inline-block font-{name()}" style="background-color: #d3dce2; font-weight: var(--lg-fonts-line-height-preview-weight)">
						<xsl:value-of select="concat('(', name(), ') ')" />
						<xsl:value-of select="$alphabet" /><br />
						<xsl:value-of select="concat('(', name(), ') ')" />
						<xsl:value-of select="$alphabet" />
					</span>
					<br />
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template match="*" mode="toolkit-typographie-letter-spacing-item">
		<xsl:variable name="deref-value">
			<xsl:call-template name="deref-value">
				<xsl:with-param name="value" select="@value"/>
			</xsl:call-template>
		</xsl:variable>

		<div style="margin-top: 2rem;" class="flexbox">
			<div class="inline-block toolkit-spacing-item flex-shrink-0" style="width: 500px;">
				<span style="width: 70px;" class="inline-block js-btn-copy cursor-pointer"
					data-clipboard-text="letter-spacing-{name()}">
					<xsl:value-of select="name()" />
				</span>
				<span style="width: 180px;" class="inline-block">
					<xsl:if test="contains(@value, '@')">
						<xsl:value-of select="@value" />
					</xsl:if>
				</span>
				<span style="width: 140px; text-align: right;" class="inline-block js-btn-copy cursor-pointer">
					<xsl:attribute name="data-clipboard-text">
						<xsl:for-each select="exsl:node-set($deref-value)/val">
							<xsl:value-of select="."/>
							<xsl:if test="position() != last()">
								<xsl:text> </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</xsl:attribute>

					<xsl:for-each select="exsl:node-set($deref-value)/val">
						<xsl:value-of select="."/>
						<xsl:if test="position() != last()">
							<xsl:text> </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</span>
			</div>
			<div class="inline-block site-theme overflow-x-auto">
				<xsl:variable name="letter-spacing-name" select="name()" />
				<xsl:for-each select="$theme-node/typographie/fonts/*">
					<span class="letter-spacing-{$letter-spacing-name} font-{name()}">
						<xsl:value-of select="concat('(', name(), ') ')" />
						<xsl:value-of select="$alphabet" />
					</span>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:variable name="alphabet" select="'aàbcçdeéëêfghijklmnopqrstuvwxyz AÀBCÇDEÉËÊFGHIJKLMNOPQRSTUVWXYZ'" />
</xsl:stylesheet>