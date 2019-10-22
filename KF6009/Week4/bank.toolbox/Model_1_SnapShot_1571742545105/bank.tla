-------------------------------- MODULE bank --------------------------------
EXTENDS Integers

(*
--algorithm 
    BankAccountvariable balance = 100
    process Withdraw \in 1..2
        variable current = 0
        begin
        s1: current := balance;
        s2: current := current - 10;
        s3: balance := current
    end process
end algorithm
*)
=============================================================================
\* Modification History
\* Last modified Tue Oct 22 12:09:02 BST 2019 by student
\* Created Tue Oct 22 12:04:54 BST 2019 by student
