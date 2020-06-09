<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step exclude-inline-prefixes="c" xmlns:p="http://www.w3.org/ns/xproc" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:cx="http://xmlcalabash.com/ns/extensions"
  version="3.0" name="validate-transform">
  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>
  <p:input port="source">
    <p:document href="../xml/dreams.xml"/>
  </p:input>
  <p:output port="result">
    <p:pipe port="result" step="store"/>
  </p:output>
  <p:serialization port="result" method="html" encoding="utf-8" indent="true" include-content-type="false" media-type="html"/>
  <p:variable name="source" select="resolve-uri('../xml')"/>
  <p:for-each name="validate-all">
    <p:iteration-source select="collection($source)"/>
    <p:validate-with-relax-ng name="validate">
      <p:input port="schema">
        <p:data href="../schema/dreams.rnc"/>
      </p:input>
    </p:validate-with-relax-ng>
  </p:for-each>
  <p:sink/>
  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="../xslt/main.xsl"/>
    </p:input>
    <p:input port="source">
      <p:empty/>
    </p:input>
    <p:with-param name="doc-collection" select="resolve-uri($source)"/>
    <p:with-option name="template-name" select="'xsl:initial-template'"/>
  </p:xslt>
  <p:store href="../dist/index.html" method="html" encoding="utf-8" indent="true" version="5" name="store"/>
  <!--<p:exec name="git-push" command="git" args="push">
    <p:with-option name="result-is-xml" select="false()"/>
    <p:with-option name="errors-is-xml" select="false()"/>
  </p:exec>-->
</p:declare-step>
