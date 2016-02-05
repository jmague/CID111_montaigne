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

</xsl:stylesheet>
