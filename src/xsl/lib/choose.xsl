<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  Tests multiple conditions and applies a child element of a child <when> element of which the condition is satisfied or a child <otherwise> element.
  If a <when> element has @of or @what attribute, its test compares the object of the node specified by these attributes with the value of the operator attribute.
  If a <when> element has neither @of and @what attributes, its test compares the object of the node at the path specified by the choose's @of with the value of the operator attribute of the <when> element.
  If there is no <when> element which satisfies its condition, a <otherwise> elements are applied.
  The operator attribute can take these options: @eq (equal), @ne (not equal), @lt (less than), @le (less than or equal), @gt (greater than), @ge (greater than or equal). These operators can be used at the same time.

    The object of a node which is used on testing can specified @what attribute. This attribute can take these options: "content", "value", "number", "name", "count", "sum", "index".

  If @data-src attribute is present, this template uses a value of a node in the external file specified by this attribute for testing the condition, but not used for applying child elements.
 -->
 <xsl:template match="choose">
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
  <!--** Any argument 0. -->
  <xsl:param name="arg0"/>
  <!--** Any argument 1. -->
  <xsl:param name="arg1"/>
  <!--** Any argument 2. -->
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
    <xsl:with-param name="name">of</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_what">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">what</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_result">
   <xsl:call-template name="book:_get_evaluated_object">
    <xsl:with-param name="path" select="$_path"/>
    <xsl:with-param name="what" select="$_what"/>
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="data_gid" select="$_data_gid"/>
    <xsl:with-param name="index" select="$data_index"/>
    <xsl:with-param name="index_set" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_when_count">
   <xsl:value-of select="count(when)"/>
  </xsl:variable>
  <xsl:for-each select="when[1]">
   <xsl:call-template name="book:_choose_when">
    <xsl:with-param name="result" select="$_result"/>
    <xsl:with-param name="when_index" select="1"/>
    <xsl:with-param name="when_count" select="$_when_count"/>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
    <xsl:with-param name="allow" select="$allow"/>
    <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
    <xsl:with-param name="arg0" select="$arg0"/>
    <xsl:with-param name="arg1" select="$arg1"/>
    <xsl:with-param name="arg2" select="$arg2"/>
   </xsl:call-template>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="book:_choose_when">
  <xsl:param name="result"/>
  <xsl:param name="when_index"/>
  <xsl:param name="when_count"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="data_index"/>
  <xsl:param name="data_indexes"/>
  <xsl:param name="allow"/>
  <xsl:param name="allow_text_node"/>
  <xsl:param name="arg0"/>
  <xsl:param name="arg1"/>
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
  <xsl:variable name="_result">
   <xsl:choose>
    <xsl:when test="boolean(@of) or boolean(attr[@name='of']) or boolean(@what) or boolean(attr[@name='what'])">
     <xsl:variable name="_path">
      <xsl:call-template name="book:get_attr">
       <xsl:with-param name="name">of</xsl:with-param>
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="data_gid" select="$data_gid"/>
       <xsl:with-param name="data_index" select="$data_index"/>
       <xsl:with-param name="data_indexes" select="$data_indexes"/>
      </xsl:call-template>
     </xsl:variable>
     <xsl:variable name="_what">
      <xsl:call-template name="book:get_attr">
       <xsl:with-param name="name">what</xsl:with-param>
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="data_gid" select="$data_gid"/>
       <xsl:with-param name="data_index" select="$data_index"/>
       <xsl:with-param name="data_indexes" select="$data_indexes"/>
      </xsl:call-template>
     </xsl:variable>
     <xsl:call-template name="book:_get_evaluated_object">
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="data_gid" select="$_data_gid"/>
      <xsl:with-param name="index_set" select="$data_indexes"/>
      <xsl:with-param name="index" select="$data_index"/>
      <xsl:with-param name="path" select="$_path"/>
      <xsl:with-param name="what" select="$_what"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$result"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_is_not_matched">
   <xsl:call-template name="book:_is_not_matched">
    <xsl:with-param name="object" select="$_result"/>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($_is_not_matched) = 0">
    <xsl:apply-templates select="text()|*[name()!='attr']">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
     <xsl:with-param name="data_index" select="$data_index"/>
     <xsl:with-param name="data_indexes" select="$data_indexes"/>
     <xsl:with-param name="allow" select="$allow"/>
     <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
     <xsl:with-param name="arg0" select="$arg0"/>
     <xsl:with-param name="arg1" select="$arg1"/>
     <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:apply-templates>
   </xsl:when>
   <xsl:when test="$when_index &lt; $when_count">
    <xsl:for-each select="../when[position() = $when_index + 1]">
     <xsl:call-template name="book:_choose_when">
      <xsl:with-param name="result" select="$result"/>
      <xsl:with-param name="when_index" select="$when_index + 1"/>
      <xsl:with-param name="when_count" select="$when_count"/>
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="data_gid" select="$data_gid"/>
      <xsl:with-param name="data_index" select="$data_index"/>
      <xsl:with-param name="data_indexes" select="$data_indexes"/>
      <xsl:with-param name="allow" select="$allow"/>
      <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
      <xsl:with-param name="arg0" select="$arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:call-template>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="../otherwise[1]">
     <xsl:apply-templates select="text()|*[name()!='attr']">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="data_gid" select="$data_gid"/>
      <xsl:with-param name="data_index" select="$data_index"/>
      <xsl:with-param name="data_indexes" select="$data_indexes"/>
      <xsl:with-param name="allow" select="$allow"/>
      <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
      <xsl:with-param name="arg0" select="$arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:apply-templates>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
