<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  Gets sum of number values of nodes at the specified path.
  The path is specified with @of attribute.
  The prefix and suffix for a value can be specified with @prefix and @suffix attributes.
  If @data-src attribute is present, this template gets a value of a node in the external file specified by this attribute.
 -->
 <xsl:template match="sum">
  <!--** An URL of external data file from an ancestor element. -->
  <xsl:param name="data_url"/>
  <!--** A generated ID of a base node in a data source. -->
  <xsl:param name="data_gid"/>
  <!--** Index of parent <for> element. -->
  <xsl:param name="data_index"/>
  <!--** Index set of ancestor <for> elements. -->
  <xsl:param name="data_indexes"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="book:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_data_gid">
   <xsl:call-template name="book:get_data_gid">
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_path">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">of</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_prefix">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">prefix</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_suffix">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">suffix</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_sum">
   <xsl:call-template name="_calc_sum">
    <xsl:with-param name="path" select="$_path"/>
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="data_gid" select="$_data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:value-of select="$_prefix"/>
  <xsl:value-of select="$_sum"/>
  <xsl:value-of select="$_suffix"/>
 </xsl:template>


 <xsl:template name="_calc_sum">
  <xsl:param name="path"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:variable name="_numbers">
   <xsl:call-template name="do:get_objects_by_path">
    <xsl:with-param name="path" select="$path"/>
    <xsl:with-param name="what">number</xsl:with-param>
    <xsl:with-param name="prefix"></xsl:with-param>
    <xsl:with-param name="suffix">|</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="_calc_sum_rcr">
   <xsl:with-param name="sum">0</xsl:with-param>
   <xsl:with-param name="nums" select="$_numbers"/>
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="_calc_sum_rcr">
  <xsl:param name="sum"/>
  <xsl:param name="nums"/>
  <xsl:variable name="_num" select="substring-before($nums, '|')"/>
  <xsl:variable name="_nums" select="substring-after($nums, '|')"/>
  <xsl:choose>
   <xsl:when test="string-length($nums) = 0">
    <xsl:value-of select="$sum"/>
   </xsl:when>
   <xsl:when test="$_num = 'NaN'">
    <xsl:call-template name="_calc_sum_rcr">
     <xsl:with-param name="sum" select="$sum"/>
     <xsl:with-param name="nums" select="$_nums"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="_calc_sum_rcr">
     <xsl:with-param name="sum" select="$sum + $_num"/>
     <xsl:with-param name="nums" select="$_nums"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
