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
    <div>
		    <xsl:apply-templates/>
    </div>
	</xsl:template>

	
<xsl:template match="rdg">
	<xsl:if test=".//quote">
		<div>
	    <xsl:attribute name="class">wit_<xsl:value-of select="substring(@wit,2)"/>
	    </xsl:attribute>  
	    <xsl:apply-templates />
	 </div>
	</xsl:if>
<xsl:if test="not(.//quote)">
  <span>
    <xsl:attribute name="class">wit_<xsl:value-of select="substring(@wit,2)"/>
    </xsl:attribute>  
    <xsl:apply-templates />
 </span>
 </xsl:if>
</xsl:template>

<xsl:template match="head">
  <h4>
    <xsl:apply-templates />
 </h4>
</xsl:template>


<xsl:template match="bibl">
  <span class="bibl">
    <xsl:apply-templates />
 </span>
</xsl:template>

<xsl:template match="title">
  <span class="title">
    <xsl:apply-templates />
 </span>
</xsl:template>

<xsl:template match="author">
  <span class="author">
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
  <div class="citation">
    <xsl:apply-templates />
 </div>
</xsl:template>

<xsl:template match="q">
  <span class="citation">
    <xsl:apply-templates />
 </span>
 </xsl:template>
 
 <!-- <xsl:template match="bibl"/> -->
  
 
<xsl:template match="lb">
  <br/>
</xsl:template>

</xsl:stylesheet>
