<?xml version="1.0" encoding="utf-8"?>

<!--**
 xslbook-do is a XSLT library which provides XSLT match templates to operate XML data for xslbook. This library enables to let users to operate XML data without exposing XSLT and XPath specifications to them.

 This library implements the match templates to get an object/objects or to loop child nodes. These XSLT templates basically wrap the named templates of xsldo, and the path specifications and so on follow xsldo's specification.

 This program is written in XSLT 1.0.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--** A set of utilities for XSLT programs on Web browsers. -->
 <xsl:import href="xslutil.xsl"/>

 <!--** XML data operation libraries for XSLT programs on Web browsers.  -->
 <xsl:import href="xsldo.xsl"/>

</xsl:stylesheet>
