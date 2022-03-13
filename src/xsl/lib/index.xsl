<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  Get index of an above loop.
  If @of attribute is present, get the index of the parent or ancestor loop with @id attribute which is equals to this @of attribute.
  Unless, get the index of the parent loop.
 -->
 <xsl:template match="index">
  <!--** Index of parent loop element. -->
  <xsl:param name="data_index"/>
  <!--** Index set of ancestor <for> elements. -->
  <xsl:param name="data_indexes"/>
  <!--** An URL of external data file from an ancestor element. -->
  <xsl:param name="data_url"/>
  <!--** A generated ID of a base node in a data source. -->
  <xsl:param name="data_gid"/>
  <xsl:variable name="_index_id">
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
  <xsl:variable name="_index">
   <xsl:call-template name="book:_get_index">
    <xsl:with-param name="index" select="$data_index"/>
    <xsl:with-param name="index_set" select="$data_indexes"/>
    <xsl:with-param name="index_id" select="$_index_id"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:if test="string-length($_index) != 0">
   <xsl:value-of select="$_prefix"/>
   <xsl:value-of select="$_index"/>
   <xsl:value-of select="$_suffix"/>
  </xsl:if>
 </xsl:template>


 <xsl:template name="book:_get_index">
  <xsl:param name="index"/>
  <xsl:param name="index_set"/>
  <xsl:param name="index_id"/>
  <xsl:choose>
   <xsl:when test="string-length($index_id) = 0">
    <xsl:value-of select="$index"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="substring-before(substring-after($index_set, concat($do:_object_sep, $index_id, $do:_cond_op_sep)), $do:_object_sep)"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>

