<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method='html' version='1.0' encoding='UTF-8' indent='yes'/>

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="wml">
    <html>
        <head>
            <xsl:apply-templates select="head"/>
            <xsl:apply-templates select="card/@ontimer"/>
            <title><xsl:value-of select="card/@title" /></title>
        </head>
        <body>
             <xsl:apply-templates select="card/p"/>
             <script  src="http://res.3g.cn/js/wml.js?v=222" type="text/javascript"></script>
        </body>
    </html>
</xsl:template>

<xsl:template match="head">
        <xsl:copy-of select="meta"/>
</xsl:template>

<xsl:template match="card/@ontimer">
       <meta http-equiv="refresh" >
        <xsl:attribute name="content">
            <xsl:value-of select="concat( round(number(//timer/@value) div 10)  ,';  ',  //card/@ontimer)" />
       </xsl:attribute>
       </meta>
</xsl:template>

<xsl:template match="card/p">
         <xsl:apply-templates/>
</xsl:template>

<xsl:template match="a|br|img|b|strong|em|i|u|big|small|select|table">
        <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="input/@id">
        <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="input[not(self/@id)]">
        <xsl:copy>
        <xsl:attribute name="id">
            <xsl:value-of select="@name" />
       </xsl:attribute>
       <xsl:apply-templates select="@*"/>
       </xsl:copy>
</xsl:template>


<xsl:template match="@*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
    </xsl:copy>
  </xsl:template>


<xsl:template match="anchor">
     <xsl:variable name="anchoridx" select="position() "/>
    <form  style="display:inline">
        <xsl:attribute name="method"><xsl:value-of select="go/@method"/></xsl:attribute>
        <xsl:attribute name="action"><xsl:value-of select="go/@href"/></xsl:attribute>
        <xsl:attribute name="origaction"><xsl:value-of select="go/@href"/></xsl:attribute>
        <xsl:attribute name="onsubmit">return nsWMLcheckForm(this);</xsl:attribute>
        <xsl:for-each select="go/postfield">
            <xsl:variable name="fieldidx" select="concat('field', $anchoridx, position() )"/>
            <input type="hidden" name="{@name}"  id="{$fieldidx}" value="{@value}" origvalue="{@value}" />
        </xsl:for-each>
        <xsl:apply-templates select="text()" />
    </form>
</xsl:template>

<xsl:template match="anchor/text()">
    <xsl:if test="normalize-space(.) != ''" >
         <input type="submit"  value="{normalize-space(.)}"  />
    </xsl:if>
</xsl:template>


</xsl:stylesheet>
