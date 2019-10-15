------------------------------ MODULE DieHard ------------------------------
EXTENDS Integers
Min(a,b) == IF a<b THEN a ELSE b
(*
--algorithm DieHard
    variable
        big = 0;
        small = 0;
    begin
        while TRUE do
            either big := 5
            or small := 3
            or big := 0
            or small := 0
            or with poured = Min (5-big, small) do
                big := big + poured;
                small := small - poured
              end with
            or with poured = Min (3-small, big) do
                big := big - poured;
                small := small + poured
              end with
            end either
        end while
end algorithm
*)
\* BEGIN TRANSLATION
VARIABLES big, small

vars == << big, small >>

Init == (* Global variables *)
        /\ big = 0
        /\ small = 0

Next == \/ /\ big' = 5
           /\ small' = small
        \/ /\ small' = 3
           /\ big' = big
        \/ /\ big' = 0
           /\ small' = small
        \/ /\ small' = 0
           /\ big' = big
        \/ /\ LET poured == Min (5-big, small) IN
                /\ big' = big + poured
                /\ small' = small - poured
        \/ /\ LET poured == Min (3-small, big) IN
                /\ big' = big - poured
                /\ small' = small + poured

Spec == Init /\ [][Next]_vars

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Tue Oct 15 13:12:04 BST 2019 by student
\* Created Tue Oct 15 12:01:22 BST 2019 by student
