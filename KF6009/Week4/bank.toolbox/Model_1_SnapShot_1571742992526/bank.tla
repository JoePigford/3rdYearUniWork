-------------------------------- MODULE bank --------------------------------
EXTENDS Integers

(*
--algorithm BankAccount
    variable balance = 100;
             semaphore = 1;
    process Withdraw \in 1..2
        variable current = 0;
        begin
        enter: await semaphore > 0 ; semaphore := semaphore-1;
        s1: current := balance;
        s2: current := current - 10;
        s3: balance := current;
        exit: semaphore := semaphore + 1;
    end process
end algorithm
*)
\* BEGIN TRANSLATION
VARIABLES balance, semaphore, pc, current

vars == << balance, semaphore, pc, current >>

ProcSet == (1..2)

Init == (* Global variables *)
        /\ balance = 100
        /\ semaphore = 1
        (* Process Withdraw *)
        /\ current = [self \in 1..2 |-> 0]
        /\ pc = [self \in ProcSet |-> "enter"]

enter(self) == /\ pc[self] = "enter"
               /\ semaphore > 0
               /\ semaphore' = semaphore-1
               /\ pc' = [pc EXCEPT ![self] = "s1"]
               /\ UNCHANGED << balance, current >>

s1(self) == /\ pc[self] = "s1"
            /\ current' = [current EXCEPT ![self] = balance]
            /\ pc' = [pc EXCEPT ![self] = "s2"]
            /\ UNCHANGED << balance, semaphore >>

s2(self) == /\ pc[self] = "s2"
            /\ current' = [current EXCEPT ![self] = current[self] - 10]
            /\ pc' = [pc EXCEPT ![self] = "s3"]
            /\ UNCHANGED << balance, semaphore >>

s3(self) == /\ pc[self] = "s3"
            /\ balance' = current[self]
            /\ pc' = [pc EXCEPT ![self] = "exit"]
            /\ UNCHANGED << semaphore, current >>

exit(self) == /\ pc[self] = "exit"
              /\ semaphore' = semaphore + 1
              /\ pc' = [pc EXCEPT ![self] = "Done"]
              /\ UNCHANGED << balance, current >>

Withdraw(self) == enter(self) \/ s1(self) \/ s2(self) \/ s3(self)
                     \/ exit(self)

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == (\E self \in 1..2: Withdraw(self))
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Tue Oct 22 12:16:17 BST 2019 by student
\* Created Tue Oct 22 12:04:54 BST 2019 by student
