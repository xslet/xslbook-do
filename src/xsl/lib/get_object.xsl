<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


 <xsl:template name="book:_get_object">
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="index"/>
  <xsl:param name="index_set"/>
  <xsl:param name="path"/>
  <xsl:param name="what"/>
  <xsl:choose>
   <xsl:when test="string-length($what) = 0">
    <xsl:call-template name="do:first_object_by_path">
     <xsl:with-param name="path" select="$path"/>
     <xsl:with-param name="what">text</xsl:with-param>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="$what = 'index'">
    <xsl:call-template name="book:_get_index">
     <xsl:with-param name="index" select="$index"/>
     <xsl:with-param name="index_set" select="$index_set"/>
     <xsl:with-param name="index_id" select="$path"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="$what = 'count'">
    <xsl:call-template name="do:count_nodes_by_path">
     <xsl:with-param name="path" select="$path"/>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="$what = 'sum'">
    <xsl:call-template name="_calc_sum">
     <xsl:with-param name="path" select="$path"/>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="$what = 'value'">
    <xsl:call-template name="do:first_object_by_path">
     <xsl:with-param name="path" select="$path"/>
     <xsl:with-param name="what">text</xsl:with-param>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="$what = 'text'"/>
   <xsl:otherwise>
    <xsl:call-template name="do:first_object_by_path">
     <xsl:with-param name="path" select="$path"/>
     <xsl:with-param name="what" select="$what"/>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
