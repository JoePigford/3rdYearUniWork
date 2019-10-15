-------------------------------- MODULE Bank --------------------------------
EXTENDS Integers
Min(a,b) == IF a<b THEN a ELSE b
(*
--algorithm Bank
    variable 
        account = 100
    process Withdraw \in 1..2
        variable current = 0
        begin
        s1: current := account;
        s2: current:= current - 10;
        s3: account := current 
    end process
end algorithm
*)
\* BEGIN TRANSLATION
VARIABLES account, pc, current

vars == << account, pc, current >>

ProcSet == (1..2)

Init == (* Global variables *)
        /\ account = 100
        (* Process Withdraw *)
        /\ current = [self \in 1..2 |-> 0]
        /\ pc = [self \in ProcSet |-> "s1"]

s1(self) == /\ pc[self] = "s1"
            /\ current' = [current EXCEPT ![self] = account]
            /\ pc' = [pc EXCEPT ![self] = "s2"]
            /\ UNCHANGED account

s2(self) == /\ pc[self] = "s2"
            /\ current' = [current EXCEPT ![self] = current[self] - 10]
            /\ pc' = [pc EXCEPT ![self] = "s3"]
            /\ UNCHANGED account

s3(self) == /\ pc[self] = "s3"
            /\ account' = current[self]
            /\ pc' = [pc EXCEPT ![self] = "Done"]
            /\ UNCHANGED current

Withdraw(self) == s1(self) \/ s2(self) \/ s3(self)

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == (\E self \in 1..2: Withdraw(self))
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")
    /\ account = 80

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Tue Oct 15 13:46:23 BST 2019 by student
\* Created Tue Oct 15 13:13:54 BST 2019 by student
