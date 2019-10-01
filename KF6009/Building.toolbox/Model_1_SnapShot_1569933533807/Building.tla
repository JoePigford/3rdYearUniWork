------------------------------ MODULE Building ------------------------------
CONSTANT PEOPLE

VARIABLE register,
         in,
         out
         
Init ==
        /\ register = {}
        /\ in = {}
        /\ out = {}
      
Register(p) ==
              /\ p \in PEOPLE \ register
              /\ register' = register 
              /\ out' = out \cup {p}
              /\ in' = in
              
Enter(p) ==
           /\ p \in PEOPLE /\ p \in register /\ p \in out
           /\ in' = in \cup {p}
           /\ out' = out \ {p}
           /\ register' = register
           
Leave(p) ==
          /\ p \in in
          /\ in' = in \ {p}
          /\ out' = out \cup {p}
          /\ register' = register
          
Next ==
     \E p \in PEOPLE :
        \/ Register(p)
        \/ Enter(p)
        \/ Leave(p)
        
TypeOK == 
        /\ register \subseteq PEOPLE      
        /\ register = in \cup out        
        /\ in \cap out = {}           
=============================================================================
\* Modification History
\* Last modified Tue Oct 01 13:32:26 BST 2019 by student
\* Created Tue Oct 01 12:58:47 BST 2019 by student
