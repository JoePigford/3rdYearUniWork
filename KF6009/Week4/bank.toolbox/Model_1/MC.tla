---- MODULE MC ----
EXTENDS bank, TLC

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_15717436476956000 ==
(pc[1]="Done"/\pc[2]="Done") => balance=80
----
=============================================================================
\* Modification History
\* Created Tue Oct 22 12:27:27 BST 2019 by student
