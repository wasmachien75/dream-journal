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
          <img id="cloud" src="{wvl:get-image-with-name('cloud')}"/>
          <xsl:sequence select="wvl:header()"/>
        </div>
      </h1>
      <div id="moon">
        <img alt="Moon" src="{wvl:get-image-with-name('moon')}"/>
      </div>
    </div>
  </xsl:template>

  <xsl:function name="wvl:get-image-with-name" as="xs:string">
    <xsl:param name="name" as="xs:string"/>
    <xsl:value-of select="'data:image/png;base64, ' || $images//img[@name=$name]"/>
  </xsl:function>

  <xsl:function name="wvl:header" as="element(span)*">
    <span style="opacity: 0.891176470588235294; font-size: 120.849394638258%;">D</span>
    <span style="opacity: 0.832352941176470588; font-size: 60%;">r</span>
    <span style="opacity: 0.773529411764705882; font-size: 62.924519640000376%;">e</span>
    <span style="opacity: 0.714705882352941176; font-size: 91.17141244543386%;">a</span>
    <span style="opacity: 0.655882352941176471; font-size: 60%;">m</span>
    <span style="opacity: 0.597058823529411765; font-size: 91.27236636832423%;"> </span>
    <span style="opacity: 0.538235294117647059; font-size: 103.92258382347666%;">t</span>
    <span style="opacity: 0.479411764705882353; font-size: 124.70269110820757%;">a</span>
    <span style="opacity: 0.420588235294117647; font-size: 105.12581165178848%;">p</span>
    <span style="opacity: 0.361764705882352941; font-size: 119.23879477390823%;">e</span>
    <span style="opacity: 0.302941176470588235; font-size: 60.660290629283594%;">s</span>
    <span style="opacity: 0.244117647058823529; font-size: 110.20433970294917%;"></span>
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
