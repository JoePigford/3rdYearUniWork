---- MODULE MC ----
EXTENDS bank, TLC

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_15717429889834000 ==
(pc[1]="Done"/\pc[2]="Done") => balance=80
----
=============================================================================
\* Modification History
\* Created Tue Oct 22 12:16:28 BST 2019 by student
