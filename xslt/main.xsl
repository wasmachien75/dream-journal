<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all" version="3.0" xmlns:dr="dream" xmlns:file="http://expath.org/ns/file"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:wvl="wvl">
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:param name="doc-collection" as="xs:anyURI" select="resolve-uri('../xml/')"/>
  <xsl:variable name="images" select="doc('./images.xml')"/>
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
        <main>
          <div id="dreams">
            <xsl:apply-templates select="collection($doc-collection)//dr:dream">
              <xsl:sort select=".//dr:date" order="descending" data-type="text"/>
            </xsl:apply-templates>
          </div>
        </main>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="header" as="element(header)">
    <header>
      <div id="header-inner">
        <img alt="Cloud" id="cloud" src="{wvl:get-image-with-name('cloud')}"/>
        <xsl:sequence select="wvl:header()"/>
      </div>
      <div id="moon">
        <img alt="Moon" src="{wvl:get-image-with-name('moon')}"/>
      </div>
    </header>
  </xsl:template>

  <xsl:function name="wvl:get-image-with-name" as="xs:string">
    <xsl:param name="name" as="xs:string"/>
    <xsl:value-of select="'data:image/png;base64, ' || $images//img[@name=$name]"/>
  </xsl:function>

  <xsl:function name="wvl:header" as="element(div)*">
    <div id="title">
      <h1>
        <span id="header-1">Dream</span>
        <span id="header-2">tapes</span>
      </h1>
    </div>
  </xsl:function>

  <xsl:template match="dr:dream" as="element(div)">
    <div class="{if(position() ne last()) then 'dashed ' else ''}dream" xsl:expand-text="true">
      <h4 class="date">{dr:date => wvl:format-date()}</h4>
      <p class="description">{dr:description => normalize-space()}</p>
    </div>
  </xsl:template>

  <xsl:function name="wvl:format-date" as="xs:string">
    <xsl:param name="date" as="xs:string"/>
    <xsl:sequence select="$date => xs:date() => format-date('[MNn] [D1o], [Y]')"/>
  </xsl:function>

</xsl:stylesheet>
