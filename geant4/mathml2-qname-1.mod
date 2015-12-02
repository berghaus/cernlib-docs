<!-- ....................................................................... -->
<!-- MathML Qualified Names Module  ........................................ -->
<!-- file: mathml2-qname-1.mod

     This is the Mathematical Markup Language (MathML) 2.0, an XML 
     application for describing mathematical notation and capturing 
     both its structure and content.

     Copyright 1998-2000 W3C (MIT, INRIA, Keio), All Rights Reserved.
     Revision: $Id: mathml2-qname-1.mod,v 1.3 2000/04/03 14:37:42 davidc Exp $ 

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

       PUBLIC "-//W3C//ENTITIES MathML 2.0 Qualified Names 1.0//EN"
       SYSTEM "mathml2-qname-1.mod"

     Revisions:
     (none)
     ....................................................................... -->

<!-- MathML Qualified Names

     This module is contained in two parts, labeled Section 'A' and 'B':

       Section A declares parameter entities to support namespace-
       qualified names, namespace declarations, and name prefixing 
       for MathML.
    
       Section B declares parameter entities used to provide
       namespace-qualified names for all MathML element types.

     This module is derived from the XHTML Qualified Names Template module.
-->

<!-- Section A: XHTML XML Namespace Framework :::::::::::::::::::: -->

<!ENTITY % NS.prefixed     "IGNORE" >
<!ENTITY % MATHML.prefixed "%NS.prefixed;" >

<!-- XLink ............... -->

<!ENTITY % XLINK.xmlns "http://www.w3.org/1999/xlink" >
<!ENTITY % XLINK.xmlns.attrib
     "xmlns:xlink  CDATA           #FIXED '%XLINK.xmlns;'"
>

<!-- MathML .............. -->

<!ENTITY % MATHML.xmlns    "http://www.w3.org/1998/Math/MathML" >
<!ENTITY % MATHML.prefix   "m" >
<![%MATHML.prefixed;[
<!ENTITY % MATHML.xmlns.extra.attrib  "" >
]]>
<!ENTITY % MATHML.xmlns.extra.attrib 
     "%XLINK.xmlns.attrib;" >

<![%MATHML.prefixed;[
<!ENTITY % MATHML.pfx  "%MATHML.prefix;:" >
<!ENTITY % MATHML.xmlns.attrib
     "xmlns:%MATHML.prefix;  CDATA   #FIXED '%MATHML.xmlns;'
      %MATHML.xmlns.extra.attrib;"
>
]]>
<!ENTITY % MATHML.pfx  "" >
<!ENTITY % MATHML.xmlns.attrib
     "xmlns        CDATA           #FIXED '%MATHML.xmlns;'
      %MATHML.xmlns.extra.attrib;"
>

<![%NS.prefixed;[
<!ENTITY % XHTML.xmlns.extra.attrib 
     "%MATHML.xmlns.attrib;" >
]]>
<!ENTITY % XHTML.xmlns.extra.attrib
     "%XLINK.xmlns.attrib;"
>

<!-- Section B: MathML Qualified Names ::::::::::::::::::::::::::::: -->

<!-- 9. This section declares parameter entities used to provide
        namespace-qualified names for all MathML element types.
-->

<!ENTITY % mspace.qname         "%MATHML.pfx;mspace" >
<!ENTITY % mprescripts.qname    "%MATHML.pfx;mprescripts" >
<!ENTITY % none.qname           "%MATHML.pfx;none" >
<!ENTITY % malignmark.qname     "%MATHML.pfx;malignmark" >
<!ENTITY % maligngroup.qname    "%MATHML.pfx;maligngroup" >
<!ENTITY % mchar.qname          "%MATHML.pfx;mchar" >
<!ENTITY % mglyph.qname         "%MATHML.pfx;mglyph" >
<!ENTITY % integers.qname       "%MATHML.pfx;integers" >
<!ENTITY % reals.qname          "%MATHML.pfx;reals" >
<!ENTITY % rationals.qname      "%MATHML.pfx;rationals" >
<!ENTITY % naturalnumbers.qname "%MATHML.pfx;naturalnumbers" >
<!ENTITY % complexes.qname      "%MATHML.pfx;complexes" >
<!ENTITY % primes.qname         "%MATHML.pfx;primes" >
<!ENTITY % exponentiale.qname   "%MATHML.pfx;exponentiale" >
<!ENTITY % imaginaryi.qname     "%MATHML.pfx;imaginaryi" >
<!ENTITY % notanumber.qname     "%MATHML.pfx;notanumber" >
<!ENTITY % true.qname           "%MATHML.pfx;true" >
<!ENTITY % false.qname          "%MATHML.pfx;false" >
<!ENTITY % emptyset.qname       "%MATHML.pfx;emptyset" >
<!ENTITY % pi.qname             "%MATHML.pfx;pi" >
<!ENTITY % eulergamma.qname     "%MATHML.pfx;eulergamma" >
<!ENTITY % infinity.qname       "%MATHML.pfx;infinity" >
<!ENTITY % sep.qname            "%MATHML.pfx;sep" >
<!ENTITY % inverse.qname        "%MATHML.pfx;inverse" >
<!ENTITY % ident.qname          "%MATHML.pfx;ident" >
<!ENTITY % compose.qname        "%MATHML.pfx;compose" >
<!ENTITY % exp.qname            "%MATHML.pfx;exp" >
<!ENTITY % abs.qname            "%MATHML.pfx;abs" >
<!ENTITY % arg.qname            "%MATHML.pfx;arg" >
<!ENTITY % real.qname           "%MATHML.pfx;real" >
<!ENTITY % imaginary.qname      "%MATHML.pfx;imaginary" >
<!ENTITY % conjugate.qname      "%MATHML.pfx;conjugate" >
<!ENTITY % factorial.qname      "%MATHML.pfx;factorial" >
<!ENTITY % minus.qname          "%MATHML.pfx;minus" >
<!ENTITY % quotient.qname       "%MATHML.pfx;quotient" >
<!ENTITY % divide.qname         "%MATHML.pfx;divide" >
<!ENTITY % power.qname          "%MATHML.pfx;power" >
<!ENTITY % rem.qname            "%MATHML.pfx;rem" >
<!ENTITY % plus.qname           "%MATHML.pfx;plus" >
<!ENTITY % max.qname            "%MATHML.pfx;max" >
<!ENTITY % min.qname            "%MATHML.pfx;min" >
<!ENTITY % times.qname          "%MATHML.pfx;times" >
<!ENTITY % gcd.qname            "%MATHML.pfx;gcd" >
<!ENTITY % lcm.qname            "%MATHML.pfx;lcm" >
<!ENTITY % root.qname           "%MATHML.pfx;root" >
<!ENTITY % exists.qname         "%MATHML.pfx;exists" >
<!ENTITY % forall.qname         "%MATHML.pfx;forall" >
<!ENTITY % and.qname            "%MATHML.pfx;and" >
<!ENTITY % or.qname             "%MATHML.pfx;or" >
<!ENTITY % xor.qname            "%MATHML.pfx;xor" >
<!ENTITY % not.qname            "%MATHML.pfx;not" >
<!ENTITY % implies.qname        "%MATHML.pfx;implies" >
<!ENTITY % divergence.qname     "%MATHML.pfx;divergence" >
<!ENTITY % grad.qname           "%MATHML.pfx;grad" >
<!ENTITY % curl.qname           "%MATHML.pfx;curl" >
<!ENTITY % laplacian.qname      "%MATHML.pfx;laplacian" >
<!ENTITY % log.qname            "%MATHML.pfx;log" >
<!ENTITY % int.qname            "%MATHML.pfx;int" >
<!ENTITY % diff.qname           "%MATHML.pfx;diff" >
<!ENTITY % partialdiff.qname    "%MATHML.pfx;partialdiff" >
<!ENTITY % ln.qname             "%MATHML.pfx;ln" >
<!ENTITY % card.qname           "%MATHML.pfx;card" >
<!ENTITY % setdiff.qname        "%MATHML.pfx;setdiff" >
<!ENTITY % union.qname          "%MATHML.pfx;union" >
<!ENTITY % intersect.qname      "%MATHML.pfx;intersect" >
<!ENTITY % sum.qname            "%MATHML.pfx;sum" >
<!ENTITY % product.qname        "%MATHML.pfx;product" >
<!ENTITY % limit.qname          "%MATHML.pfx;limit" >
<!ENTITY % sin.qname            "%MATHML.pfx;sin" >
<!ENTITY % cos.qname            "%MATHML.pfx;cos" >
<!ENTITY % tan.qname            "%MATHML.pfx;tan" >
<!ENTITY % sec.qname            "%MATHML.pfx;sec" >
<!ENTITY % csc.qname            "%MATHML.pfx;csc" >
<!ENTITY % cot.qname            "%MATHML.pfx;cot" >
<!ENTITY % sinh.qname           "%MATHML.pfx;sinh" >
<!ENTITY % cosh.qname           "%MATHML.pfx;cosh" >
<!ENTITY % tanh.qname           "%MATHML.pfx;tanh" >
<!ENTITY % sech.qname           "%MATHML.pfx;sech" >
<!ENTITY % csch.qname           "%MATHML.pfx;csch" >
<!ENTITY % coth.qname           "%MATHML.pfx;coth" >
<!ENTITY % arcsin.qname         "%MATHML.pfx;arcsin" >
<!ENTITY % arccos.qname         "%MATHML.pfx;arccos" >
<!ENTITY % arctan.qname         "%MATHML.pfx;arctan" >
<!ENTITY % mean.qname           "%MATHML.pfx;mean" >
<!ENTITY % sdev.qname           "%MATHML.pfx;sdev" >
<!ENTITY % variance.qname       "%MATHML.pfx;variance" >
<!ENTITY % median.qname         "%MATHML.pfx;median" >
<!ENTITY % mode.qname           "%MATHML.pfx;mode" >
<!ENTITY % moment.qname         "%MATHML.pfx;moment" >
<!ENTITY % determinant.qname    "%MATHML.pfx;determinant" >
<!ENTITY % transpose.qname      "%MATHML.pfx;transpose" >
<!ENTITY % vectorproduct.qname  "%MATHML.pfx;vectorproduct" >
<!ENTITY % scalarproduct.qname  "%MATHML.pfx;scalarproduct" >
<!ENTITY % outerproduct.qname   "%MATHML.pfx;outerproduct" >
<!ENTITY % selector.qname       "%MATHML.pfx;selector" >
<!ENTITY % neq.qname            "%MATHML.pfx;neq" >
<!ENTITY % eq.qname             "%MATHML.pfx;eq" >
<!ENTITY % equivalent.qname     "%MATHML.pfx;equivalent" >
<!ENTITY % approx.qname         "%MATHML.pfx;approx" >
<!ENTITY % gt.qname             "%MATHML.pfx;gt" >
<!ENTITY % lt.qname             "%MATHML.pfx;lt" >
<!ENTITY % geq.qname            "%MATHML.pfx;geq" >
<!ENTITY % leq.qname            "%MATHML.pfx;leq" >
<!ENTITY % in.qname             "%MATHML.pfx;in" >
<!ENTITY % notin.qname          "%MATHML.pfx;notin" >
<!ENTITY % notsubset.qname      "%MATHML.pfx;notsubset" >
<!ENTITY % notprsubset.qname    "%MATHML.pfx;notprsubset" >
<!ENTITY % subset.qname         "%MATHML.pfx;subset" >
<!ENTITY % prsubset.qname       "%MATHML.pfx;prsubset" >
<!ENTITY % tendsto.qname        "%MATHML.pfx;tendsto" >
<!ENTITY % ci.qname             "%MATHML.pfx;ci" >
<!ENTITY % csymbol.qname        "%MATHML.pfx;csymbol" >
<!ENTITY % cn.qname             "%MATHML.pfx;cn" >
<!ENTITY % apply.qname          "%MATHML.pfx;apply" >
<!ENTITY % reln.qname           "%MATHML.pfx;reln" >
<!ENTITY % lambda.qname         "%MATHML.pfx;lambda" >
<!ENTITY % condition.qname      "%MATHML.pfx;condition" >
<!ENTITY % declare.qname        "%MATHML.pfx;declare" >
<!ENTITY % semantics.qname      "%MATHML.pfx;semantics" >
<!ENTITY % annotation.qname     "%MATHML.pfx;annotation" >
<!ENTITY % annotation-xml.qname "%MATHML.pfx;annotation-xml" >
<!ENTITY % interval.qname       "%MATHML.pfx;interval" >
<!ENTITY % set.qname            "%MATHML.pfx;set" >
<!ENTITY % list.qname           "%MATHML.pfx;list" >
<!ENTITY % vector.qname         "%MATHML.pfx;vector" >
<!ENTITY % matrix.qname         "%MATHML.pfx;matrix" >
<!ENTITY % matrixrow.qname      "%MATHML.pfx;matrixrow" >
<!ENTITY % fn.qname             "%MATHML.pfx;fn" >
<!ENTITY % lowlimit.qname       "%MATHML.pfx;lowlimit" >
<!ENTITY % uplimit.qname        "%MATHML.pfx;uplimit" >
<!ENTITY % bvar.qname           "%MATHML.pfx;bvar" >
<!ENTITY % degree.qname         "%MATHML.pfx;degree" >
<!ENTITY % logbase.qname        "%MATHML.pfx;logbase" >
<!ENTITY % mstyle.qname         "%MATHML.pfx;mstyle" >
<!ENTITY % merror.qname         "%MATHML.pfx;merror" >
<!ENTITY % mphantom.qname       "%MATHML.pfx;mphantom" >
<!ENTITY % mrow.qname           "%MATHML.pfx;mrow" >
<!ENTITY % mfrac.qname          "%MATHML.pfx;mfrac" >
<!ENTITY % msqrt.qname          "%MATHML.pfx;msqrt" >
<!ENTITY % menclose.qname       "%MATHML.pfx;menclose" >
<!ENTITY % mroot.qname          "%MATHML.pfx;mroot" >
<!ENTITY % msub.qname           "%MATHML.pfx;msub" >
<!ENTITY % msup.qname           "%MATHML.pfx;msup" >
<!ENTITY % msubsup.qname        "%MATHML.pfx;msubsup" >
<!ENTITY % mmultiscripts.qname  "%MATHML.pfx;mmultiscripts" >
<!ENTITY % munder.qname         "%MATHML.pfx;munder" >
<!ENTITY % mover.qname          "%MATHML.pfx;mover" >
<!ENTITY % munderover.qname     "%MATHML.pfx;munderover" >
<!ENTITY % mtable.qname         "%MATHML.pfx;mtable" >
<!ENTITY % mtr.qname            "%MATHML.pfx;mtr" >
<!ENTITY % mlabeledtr.qname     "%MATHML.pfx;mlabeledtr" >
<!ENTITY % mtd.qname            "%MATHML.pfx;mtd" >
<!ENTITY % maction.qname        "%MATHML.pfx;maction" >
<!ENTITY % mfenced.qname        "%MATHML.pfx;mfenced" >
<!ENTITY % mpadded.qname        "%MATHML.pfx;mpadded" >
<!ENTITY % mi.qname             "%MATHML.pfx;mi" >
<!ENTITY % mn.qname             "%MATHML.pfx;mn" >
<!ENTITY % mo.qname             "%MATHML.pfx;mo" >
<!ENTITY % mtext.qname          "%MATHML.pfx;mtext" >
<!ENTITY % ms.qname             "%MATHML.pfx;ms" >
<!ENTITY % math.qname           "%MATHML.pfx;math" >


<!-- ignores subsequent instantiation of this module when
     used as external subset rather than module fragment.
     NOTE: Do not modify this parameter entity, otherwise
     a recursive parsing situation may result.
-->
<!ENTITY % mathml-qname.module "IGNORE" >

<!-- end of template-qname-1.mod -->
