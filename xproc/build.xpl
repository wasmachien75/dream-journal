<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:xspec="http://www.jenitennison.com/xslt/xspec" xmlns:p="http://www.w3.org/ns/xproc" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:cx="http://xmlcalabash.com/ns/extensions" version="3.0" name="validate-transform">
  <p:import href="file:/C:/Users/willem.van.lishout/Documents/Repositories/xspec/src/harnesses/harness-lib.xpl"/>
  <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl"/>
  <p:input port="source">
    <p:document href="../xml/dreams.xml"/>
  </p:input>
  <p:output port="result">
    <p:inline>
      <null/>
    </p:inline>
  </p:output>
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
  <xspec:compile-xslt name="compile">
    <p:input port="source">
      <p:document href="../test/test.xspec"/>
    </p:input>
    <p:input port="parameters">
      <p:inline>
        <c:param-set>
          <c:param name="xspec-home" value="file:/C:/Users/willem.van.lishout/Documents/Repositories/xspec/"/>
        </c:param-set>
      </p:inline>
    </p:input>
  </xspec:compile-xslt>
  <p:xslt name="run" template-name="xspec:main">
    <p:input port="source">
      <p:empty/>
    </p:input>
    <p:input port="stylesheet">
      <p:pipe step="compile" port="result"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>
  <p:choose name="test-check">
    <p:when test="//xspec:test[@successful eq 'false']">
      <p:variable name="numberOfTests" select="count(//xspec:test[@successful eq 'false'])"/>
      <p:store href="../test/test-results.xml" indent="true" name="store"/>
      <p:error name="test-error" code="TESTFAILURE">
        <p:input port="source">
          <p:inline>
            <msg>Failed tests - will not build</msg>
          </p:inline>
        </p:input>
      </p:error>
      <p:sink/>
    </p:when>
    <p:otherwise>
      <p:xslt name="transformation">
        <p:input port="stylesheet">
          <p:document href="../xslt/main.xsl"/>
        </p:input>
        <p:input port="source">
          <p:empty/>
        </p:input>
        <p:with-param name="doc-collection" select="resolve-uri($source)"/>
        <p:with-option name="template-name" select="'xsl:initial-template'"/>
      </p:xslt>
      <p:store href="../index.html" method="html" encoding="utf-8" indent="true" version="5" name="store"/>
    </p:otherwise>
  </p:choose>
  <!--<p:exec name="git-push" command="git" args="push">
    <p:with-option name="result-is-xml" select="false()"/>
    <p:with-option name="errors-is-xml" select="false()"/>
  </p:exec>-->
</p:declare-step>
