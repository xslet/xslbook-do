<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  Get a generated ID by `generate-id()` of a base node in an data source file.
  If a current node has @data-src attribute, this returns an empty string to reset the generated ID.
 -->
 <xsl:template name="book:get_data_gid">
  <!--** A generated ID of a base node in a data source. -->
  <xsl:param name="data_gid"/>
  <xsl:if test="not(boolean(@data-src))">
   <xsl:value-of select="$data_gid"/>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
