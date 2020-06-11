<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all" xmlns:dr="dream" version="3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:wvl="wvl">
  <xsl:output method="html" encoding="UTF-8"/>
  <xsl:param name="doc-collection" as="xs:anyURI"/>
  <xsl:template name="xsl:initial-template">
    <xsl:comment expand-text="true">Generated on {adjust-dateTime-to-timezone(current-dateTime(), xs:dayTimeDuration('PT0H'))} </xsl:comment>
    <html>
      <head>
        <title>DREAM JOURNAL</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500&amp;display=swap" rel="stylesheet"/>
        <style>
          <xsl:value-of select="unparsed-text('../css/style.css')"/>
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
    <h1>Dream journal</h1>
  </xsl:template>

  <xsl:template match="dr:dream">
    <div class="{if(position() ne last()) then 'dashed' else ''} dream" xsl:expand-text="true">
      <p class="date">{dr:date => wvl:format-date()}</p>
      <p class="description">{dr:description => normalize-space()}</p>
    </div>
  </xsl:template>

  <xsl:function name="wvl:format-date" as="xs:string">
    <xsl:param name="date" as="xs:string"/>
    <xsl:sequence select="$date => xs:date() => format-date('[MNn] [D1o], [Y]')"/>
  </xsl:function>

</xsl:stylesheet>
