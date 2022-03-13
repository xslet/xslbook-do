<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  Get an URL of a data source by @data-src attribute or a parameter from an ancestor element.
 -->
 <xsl:template name="book:get_data_url">
  <!--** An URL of external data file from an ancestor element. -->
  <xsl:param name="data_url"/>
  <!--** A generated ID of a base node in a data source. -->
  <xsl:param name="data_gid"/>
  <!--** Index of parent &lt;for&gt; element. -->
  <xsl:param name="data_index"/>
  <!--** Index set of ancestor &lt;for&gt; elements. -->
  <xsl:param name="data_indexes"/>
  <xsl:choose>
   <xsl:when test="boolean(@data-src)">
    <xsl:value-of select="@data-src"/>
   </xsl:when>
   <xsl:when test="boolean(attr[@name='data-src'])">
    <xsl:apply-templates select="attr[@name='data-src']">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
     <xsl:with-param name="data_index" select="$data_index"/>
     <xsl:with-param name="data_indexes" select="$data_indexes"/>
    </xsl:apply-templates>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$data_url"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
