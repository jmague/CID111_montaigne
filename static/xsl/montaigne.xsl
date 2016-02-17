<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">
	<xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="/">
		<section>
		<xsl:apply-templates/>
	</section>
	</xsl:template>
	
  <xsl:template match="teiHeader"/>
  
	<xsl:template match="TEI">  
		    <xsl:apply-templates/>
	</xsl:template>

  <xsl:template match="p">
    <p>
		    <xsl:apply-templates/>
    </p>
	</xsl:template>

	
<xsl:template match="rdg">
  <span>
    <xsl:attribute name="class">wit_<xsl:value-of select="substring(@wit,2)"/>
    </xsl:attribute>  
    <xsl:apply-templates />
 </span>
</xsl:template>

<xsl:template match="head">
  <h3>
    <xsl:apply-templates />
 </h3>
</xsl:template>

<xsl:template match="title">
  <span class="title">
    <xsl:apply-templates />
 </span>
</xsl:template>

<xsl:template match="list">
  <ul>
    <xsl:apply-templates />
 </ul>
</xsl:template>

<xsl:template match="item">
  <li>
    <xsl:apply-templates />
 </li>
</xsl:template>

<xsl:template match="ref">
  <a>
    <xsl:attribute name="href"><xsl:value-of select="@target"/>
    </xsl:attribute>  
    <xsl:apply-templates />
 </a>
</xsl:template>

<xsl:template match="quote">
  <p class="citation">
    <xsl:apply-templates />
 </p>
</xsl:template>

<xsl:template match="q">
  <span class="citation">
    <xsl:apply-templates />
 </span>
 
</xsl:template><xsl:template match="lb">
  <br/>
</xsl:template>

</xsl:stylesheet>
