<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  Tests a condition and applies child elements if the condition is satisfied.
  A condition is the comparision of the object of the node at the path specified by @of and the value of the operator attribute: @eq (equal), @ne (not equal), @lt (less than), @le (less than or equal), @gt (greater than), @ge (greather than or equal). These operators can be used at the same time.

  If child <then> and <else> elements are present, this template applys child <then> elements if the test is passed and applys the <else> elements if not.

  The object of a node which is used on testing can specified @what attribute. This attribute can take these options: "value"(default), "content", "number", "name", "count", "sum", "index".

  If @data-src attribute is present, this template uses a value of a node in the external file specified by this attribute for testing the condition, but not used for applying child elements.
 -->
 <xsl:template match="if">
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
  <xsl:variable name="_is_not_matched">
   <xsl:call-template name="book:_is_not_matched">
    <xsl:with-param name="object" select="$_result"/>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$data_index"/>
    <xsl:with-param name="data_indexes" select="$data_indexes"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="boolean(then|else)">
    <xsl:choose>
     <xsl:when test="string-length($_is_not_matched) = 0">
      <xsl:apply-templates select="then">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="data_gid" select="$data_gid"/>
       <xsl:with-param name="data_index" select="$data_index"/>
       <xsl:with-param name="data_indexes" select="$data_indexes"/>
       <xsl:with-param name="allow" select="$allow"/>
       <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
       <xsl:with-param name="deny" select="'|attr|else|'"/>
       <xsl:with-param name="arg0" select="$arg0"/>
       <xsl:with-param name="arg1" select="$arg1"/>
       <xsl:with-param name="arg2" select="$arg2"/>
      </xsl:apply-templates>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates select="else">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="data_gid" select="$data_gid"/>
       <xsl:with-param name="data_index" select="$data_index"/>
       <xsl:with-param name="data_indexes" select="$data_indexes"/>
       <xsl:with-param name="allow" select="$allow"/>
       <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
       <xsl:with-param name="deny" select="'|attr|then|'"/>
       <xsl:with-param name="arg0" select="$arg0"/>
       <xsl:with-param name="arg1" select="$arg1"/>
       <xsl:with-param name="arg2" select="$arg2"/>
      </xsl:apply-templates>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
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
  </xsl:choose>
 </xsl:template>


 <xsl:template name="book:_get_evaluated_object">
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


 <xsl:template name="book:_is_not_matched">
  <xsl:param name="object"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="data_index"/>
  <xsl:param name="data_indexes"/>
  <xsl:if test="boolean(@eq)">
   <xsl:if test="$object != @eq">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(@ne)">
   <xsl:if test="$object = @ne">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(@le)">
   <xsl:if test="$object &gt; @le">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(@lt)">
   <xsl:if test="$object &gt;= @lt">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(@ge)">
   <xsl:if test="$object &lt; @ge">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(@gt)">
   <xsl:if test="$object &lt;= @gt">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(attr[@name='eq'])">
   <xsl:variable name="_eq">
    <xsl:call-template name="book:get_attr">
     <xsl:with-param name="name">eq</xsl:with-param>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
     <xsl:with-param name="data_index" select="$data_index"/>
     <xsl:with-param name="data_indexes" select="$data_indexes"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:if test="$object != $_eq">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(attr[@name='ne'])">
   <xsl:variable name="_ne">
    <xsl:call-template name="book:get_attr">
     <xsl:with-param name="name">ne</xsl:with-param>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
     <xsl:with-param name="data_index" select="$data_index"/>
     <xsl:with-param name="data_indexes" select="$data_indexes"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:if test="$object = $_ne">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(attr[@name='le'])">
   <xsl:variable name="_le">
    <xsl:call-template name="book:get_attr">
     <xsl:with-param name="name">le</xsl:with-param>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
     <xsl:with-param name="data_index" select="$data_index"/>
     <xsl:with-param name="data_indexes" select="$data_indexes"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:if test="$object &gt; $_le">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(attr[@name='lt'])">
   <xsl:variable name="_lt">
    <xsl:call-template name="book:get_attr">
     <xsl:with-param name="name">lt</xsl:with-param>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
     <xsl:with-param name="data_index" select="$data_index"/>
     <xsl:with-param name="data_indexes" select="$data_indexes"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:if test="$object &gt;= $_lt">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(attr[@name='ge'])">
   <xsl:variable name="_ge">
    <xsl:call-template name="book:get_attr">
     <xsl:with-param name="name">ge</xsl:with-param>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
     <xsl:with-param name="data_index" select="$data_index"/>
     <xsl:with-param name="data_indexes" select="$data_indexes"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:if test="$object &lt; $_ge">1</xsl:if>
  </xsl:if>
  <xsl:if test="boolean(attr[@name='gt'])">
   <xsl:variable name="_gt">
    <xsl:call-template name="book:get_attr">
     <xsl:with-param name="name">gt</xsl:with-param>
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="data_gid" select="$data_gid"/>
     <xsl:with-param name="data_index" select="$data_index"/>
     <xsl:with-param name="data_indexes" select="$data_indexes"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:if test="$object &lt;= $_gt">1</xsl:if>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
