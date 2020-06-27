<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all" version="3.0" xmlns:dr="dream" xmlns:file="http://expath.org/ns/file"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:wvl="wvl">
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:param name="doc-collection" as="xs:anyURI" select="resolve-uri('../xml/')"/>
  <xsl:template name="xsl:initial-template">
    <html lang="en">
      <xsl:comment expand-text="true">Generated on {adjust-dateTime-to-timezone(current-dateTime(), xs:dayTimeDuration('PT0H'))} </xsl:comment>
      <head>
        <title>DREAM TAPES</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500&amp;display=swap" rel="stylesheet"/>
        <style>
          <xsl:value-of select="unparsed-text('../css/style.css') => normalize-space()"/>
        </style>
      </head>
      <body>
        <xsl:call-template name="header"/>
        <div id="dreams">
          <xsl:apply-templates select="collection($doc-collection)//dr:dream">
            <xsl:sort select=".//dr:date" order="descending" data-type="text"/>
          </xsl:apply-templates>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="header">
    <div id="header">
      <h1>
        <div id="header-inner">
          <img id="cloud" src="{'data:image/png;base64, ' || file:read-binary(resolve-uri('./img/cloud.png')) }"/>
          <xsl:variable name="title" select="'Dream tapes'"/>
          <xsl:sequence select="wvl:header(random-number-generator(), 1, $title)"/>
        </div>
        </h1>
      <div id="moon">
        <xsl:variable name="imgSource"
          select="           if (function-available('file:read-binary')) then'data:image/png;base64, ' || file:read-binary(resolve-uri('./img/moon.png'))           else 'https://phasesmoon.com/moonpng/moon-phase-9.png'"/>
        <img alt="Moon" src="{$imgSource}"/>
      </div>
    </div>
  </xsl:template>

  <xsl:function name="wvl:header" as="element(span)*">
    <xsl:param name="rng"/>
    <xsl:param name="position"/>
    <xsl:param name="title"/>
    <span style="opacity: {0.95 - $position div 17}; font-size: {max((60, $rng?number*100 + 25))}%;">
      <xsl:value-of select="substring($title, $position, 1)"/>
    </span>
    <xsl:if test="$position le string-length($title)">
      <xsl:sequence select="wvl:header($rng?next(), $position + 1, $title)"/>
    </xsl:if>
  </xsl:function>

  <xsl:template match="dr:dream">
    <div class="{if(position() ne last()) then 'dashed ' else ''}dream" xsl:expand-text="true">
      <p class="date">{dr:date => wvl:format-date()}</p>
      <p class="description">{dr:description => normalize-space()}</p>
    </div>
  </xsl:template>

  <xsl:function name="wvl:format-date" as="xs:string">
    <xsl:param name="date" as="xs:string"/>
    <xsl:sequence select="$date => xs:date() => format-date('[MNn] [D1o], [Y]')"/>
  </xsl:function>

</xsl:stylesheet>
