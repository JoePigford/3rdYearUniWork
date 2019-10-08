---- MODULE MC ----
EXTENDS Functions, TLC

\* CONSTANT definitions @modelParameterConstants:0R
const_157053512155750000 == 
{1, 3}
----

\* CONSTANT definitions @modelParameterConstants:1S
const_157053512155751000 == 
{"a", "b"}
----

\* CONSTANT definitions @modelParameterConstants:2T
const_157053512155752000 == 
{2, 3}
----

\* CONSTANT definitions @modelParameterConstants:3U
const_157053512155753000 == 
{1, 2, 3, 4}
----

\* Constant expression definition @modelExpressionEval
const_expr_157053512155754000 == 
Cardinality (rs) 
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_157053512155754000>>)
----

=============================================================================
\* Modification History
\* Created Tue Oct 08 12:45:21 BST 2019 by student
