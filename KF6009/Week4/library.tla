------------------------------ MODULE library ------------------------------
EXTENDS Naturals, Sequences, FiniteSets,TLC
(*
--algorithm Library
    variables Position = {"lower", "lock", "upper"};
              WaterLevel = {"lower", "upper"};
              Boats = {"A", "B", "C", "D"}
              Passed = {};
              mutex = "empty";
             
    process travelToUpperLock
    variable boat := 
    end process
    
    process travelToLowerLock
    end process

end algorithm
*)
\* BEGIN TRANSLATION
\* Process variable message of process writer at line 14 col 12 changed to message_
CONSTANT defaultInitValue
VARIABLES buffer, capacity, available, data, recieved, pc, message_, message

vars == << buffer, capacity, available, data, recieved, pc, message_, message
        >>

ProcSet == {"w"} \cup {"r"}

Init == (* Global variables *)
        /\ buffer = <<>>
        /\ capacity = 3
        /\ available = 0
        /\ data = Messages
        /\ recieved = {}
        (* Process writer *)
        /\ message_ = defaultInitValue
        (* Process reader *)
        /\ message = defaultInitValue
        /\ pc = [self \in ProcSet |-> CASE self = "w" -> "sending"
                                        [] self = "r" -> "listening"]

sending == /\ pc["w"] = "sending"
           /\ IF Cardinality(data)>0
                 THEN /\ message_' = (CHOOSE m \in data : TRUE)
                      /\ pc' = [pc EXCEPT !["w"] = "send"]
                 ELSE /\ pc' = [pc EXCEPT !["w"] = "Done"]
                      /\ UNCHANGED message_
           /\ UNCHANGED << buffer, capacity, available, data, recieved, 
                           message >>

send == /\ pc["w"] = "send"
        /\ capacity>0
        /\ capacity' = capacity - 1
        /\ buffer' = Append(buffer, message_)
        /\ available' = available + 1
        /\ data' = data \ {message_}
        /\ pc' = [pc EXCEPT !["w"] = "sending"]
        /\ UNCHANGED << recieved, message_, message >>

writer == sending \/ send

listening == /\ pc["r"] = "listening"
             /\ IF Cardinality(recieved)<Cardinality(Messages)
                   THEN /\ pc' = [pc EXCEPT !["r"] = "recv"]
                   ELSE /\ PrintT(recieved)
                        /\ pc' = [pc EXCEPT !["r"] = "Done"]
             /\ UNCHANGED << buffer, capacity, available, data, recieved, 
                             message_, message >>

recv == /\ pc["r"] = "recv"
        /\ available>0
        /\ available' = available - 1
        /\ message' = Head(buffer)
        /\ buffer' = Tail(buffer)
        /\ capacity' = capacity + 1
        /\ recieved' = (recieved \union {message'})
        /\ pc' = [pc EXCEPT !["r"] = "listening"]
        /\ UNCHANGED << data, message_ >>

reader == listening \/ recv

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == writer \/ reader
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Tue Oct 22 13:48:17 BST 2019 by student
\* Created Tue Oct 22 12:28:11 BST 2019 by student
