<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  Loop child nodes for each node at the specified path with @each attribute.

  This loop can sort by the specified terminal node, in the specified direction, as the specified type.
  @sort-by attribute sort result node orders by child element or attribute of which name is specified by this attribute.
  @sort-dir attribute sort result node orders in direction specified by this attribute. This attribute can take either "asc" or "desc", and the default is "asc".
  @sort-type attribute specifies the sorting type by which each node evaluate. This attribute can take either "text" or "number", and the default is "text".

  @reverse attribute sort result node orders in reverse when it's value is 'true'.
  @index attribute specifies the index ID for this loop. If this ID is specified, the current index of this loop can be obrained by descendant <index> element, Unless, only child <index> can obtain this current index.

  If @data-src attribute is present, this template loops for nodes in the external file by this attribute.
 -->
 <xsl:template match="for[boolean(@each) or boolean(attr/@name='each')]">
  <!--** An URL of external data file from an ancestor element. -->
  <xsl:param name="data_url"/>
  <!--** A generated ID of a base node in a data source. -->
  <xsl:param name="data_gid"/>
  <!--** Index of parent <for> element. -->
  <xsl:param name="data_index"/>
  <!--** Index set of ancestor <for> elements. -->
  <xsl:param name="data_indexes"/>
  <!--** Elements which are allowed to be applied. -->
  <xsl:param name="allow"/>
  <!--** A flag if text node is allowed. -->
  <xsl:param name="allow_text_node" select="$ut:true"/>
  <!--** Elements which are denied to be applied. -->
  <xsl:param name="deny"/>
  <!--** Any attribute 0. -->
  <xsl:param name="arg0"/>
  <!--** Any attribute 1. -->
  <xsl:param name="arg1"/>
  <!--** Any attribute 2. -->
  <xsl:param name="arg2"/>
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
    <xsl:with-param name="name">each</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_index_id">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">index</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_reverse">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">reverse</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_sort_name">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">sort-by</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_sort_dir">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">sort-dir</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_sort_type">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">sort-type</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="do:for_by_path">
   <xsl:with-param name="path" select="$_path"/>
   <xsl:with-param name="data_url" select="$_data_url"/>
   <xsl:with-param name="data_gid" select="$_data_gid"/>
   <xsl:with-param name="index_id" select="$_index_id"/>
   <xsl:with-param name="index_set" select="$data_indexes"/>
   <xsl:with-param name="reverse" select="$_reverse"/>
   <xsl:with-param name="sort_name" select="$_sort_name"/>
   <xsl:with-param name="sort_dir" select="$_sort_dir"/>
   <xsl:with-param name="sort_type" select="$_sort_type"/>
   <xsl:with-param name="allow" select="$allow"/>
   <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
   <xsl:with-param name="deny">|attr|</xsl:with-param>
   <xsl:with-param name="arg0" select="$arg0"/>
   <xsl:with-param name="arg1" select="$arg1"/>
   <xsl:with-param name="arg2" select="$arg2"/>
  </xsl:call-template>
 </xsl:template>

</xsl:stylesheet>
