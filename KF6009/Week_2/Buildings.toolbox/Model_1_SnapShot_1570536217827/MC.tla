---- MODULE MC ----
EXTENDS Buildings, TLC

\* CONSTANT definitions @modelParameterConstants:0Buildings
const_157053621661385000 == 
{"b1", "b2"}
----

\* CONSTANT definitions @modelParameterConstants:1People
const_157053621661386000 == 
{"p1", "p2", "p3"}
----

\* INIT definition @modelBehaviorNoSpec:0
init_157053621661387000 ==
FALSE/\location = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_157053621661388000 ==
FALSE/\location' = location
----
=============================================================================
\* Modification History
\* Created Tue Oct 08 13:03:36 BST 2019 by student
