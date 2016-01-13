(*
 Implementation of fibonacci in Coq!
*)

Require Import Arith.

(* The direct implementation *)
Fixpoint fib_direct (n : nat) : nat :=
  match n with
    | 0 => 0
    | S n' => match n' with
                | 0 => 1
                | S n'' => fib_direct n' + fib_direct n''
              end
  end.

Compute fib_direct 10.


(* The tail recursive Fibonacci *)
Fixpoint fib_accumulator (n : nat) (a : nat) (b : nat) : nat :=
  match n with
    | 0     => b
    | (S n') => fib_accumulator n' (a+b) a
  end.

(* An alias to scrape away unnecessary information *)
Definition fib_acc (n : nat) := fib_accumulator n 1 0.

(* Test that it *)
Compute fib_acc 10.


(**** As Coq is a proof assistant, we try to
  prove that the two above functions are in equivalent ****)

(* We define what fibonacci is *)
Definition specification_of_fibonacci (f : nat -> nat) :=
  f 0 = 0
  /\
  f 1 = 1
  /\
  forall n : nat,
    f (S (S n)) = f (S n) + f n.


(* We make sure that the definition is unambigious. This lemma is also necesarry
 to prove theorems later on *)
Lemma there_is_only_one_fib :
  forall f1 f2 : nat -> nat,
    specification_of_fibonacci f1 ->
    specification_of_fibonacci f2 ->
    forall n : nat,
      f1 n = f2 n.
Proof.
  unfold specification_of_fibonacci.
  intros f1 f2.
  intros [ bc_f1_0 [ bc_f1_1 ic_f1 ] ]. (* Destruct the conjunctive clauses *)
  intros [ bc_f2_0 [ bc_f2_1 ic_f2 ] ].
   
  (* strengthening the induction hypothesis *)
  assert (H_fib : forall m : nat,
                    f1 m = f2 m /\ f1 (S m) = f2 (S m)).
  intro m.
  induction m as [| m' [IHm' IHSm']].
  
  split.
    rewrite bc_f1_0.
    rewrite bc_f2_0.
    reflexivity.

    rewrite bc_f1_1.
    rewrite bc_f2_1.
    reflexivity.

  split.
    apply IHSm'.
    
    rewrite ic_f1.
    rewrite ic_f2.
    rewrite IHm'.
    rewrite IHSm'.
    reflexivity.
    
  intro n.
  destruct (H_fib n) as [hf _].
  apply hf.
Qed.


(**** Proof that the first implementation satisfies specification ****)

(* It might seem cumbersome to have this lemma. But it is necesarry later. *)
Lemma unfold_fib_direct_bc0 :
  fib_direct 0 = 0.
Proof.
  unfold fib_direct.
  reflexivity.
Qed.
Lemma unfold_fib_direct_bc1 :
  fib_direct 1 = 1.
Proof.
  unfold fib_direct.
  reflexivity.
Qed.


Lemma unfold_fib_direct_ic :
  forall n : nat,
    fib_direct (S (S n)) = fib_direct (S n) + fib_direct n.
Proof.
  intro n.
  unfold fib_direct; fold fib_direct.
  reflexivity.
Qed.

Lemma fib_direct_satisfies_specification :
  specification_of_fibonacci fib_direct.
Proof.
  unfold specification_of_fibonacci.
  split.
  unfold fib_direct.
  reflexivity.
  
  split.
  unfold fib_direct.
  reflexivity.

  intro n.
  rewrite unfold_fib_direct_ic.
  reflexivity.
Qed.


(* Proof that the second implementation satisfies specification *)
Lemma unfold_fib_accumulator_bc0 :
  fib_accumulator 0 1 0  = 0.
Proof.
  unfold fib_accumulator.
  reflexivity.
Qed.

Lemma unfold_fib_accumulator_bc1 :
  forall a b : nat,
    fib_accumulator 0 a b = b.
Proof.
  intros a b.
  unfold fib_accumulator.
  reflexivity.
Qed.

Lemma unfold_fib_acc_base_case_1 :
  fib_accumulator 1 1 0 = 1.
Proof.
  unfold fib_accumulator.
  reflexivity.
Qed.

Lemma unfold_fib_acc_induction_case :
  forall n' a1 a0 : nat,
    fib_accumulator (S n') a1 a0 = fib_accumulator n' (a1 + a0) a1.
Proof.
  intros n' a1 a0.
  unfold fib_acc; fold fib_acc.
  reflexivity.
Qed.

Lemma about_fib_acc :
  forall f : nat -> nat,
    specification_of_fibonacci f ->
    forall k i : nat,
      fib_accumulator k (f (S i)) (f i) = f (k + i).
Proof.
  intro f.
  intros [_ [_ ic]].
  intros k.
  
  induction k as [ | k' IHk'].

  intro i.
  rewrite -> unfold_fib_accumulator_bc1.
  reflexivity.

  intro i.
  rewrite -> unfold_fib_acc_induction_case.
  rewrite <- (ic i).
  rewrite -> (IHk' (S i)).
  rewrite plus_Snm_nSm.
  reflexivity.
Qed.

Lemma fib_acc_satisfies_specification :
  specification_of_fibonacci fib_acc.
Proof.
  unfold specification_of_fibonacci.
  split.

  unfold fib_acc.
  rewrite unfold_fib_accumulator_bc1.
  reflexivity.

  split.
  unfold fib_acc.
  rewrite unfold_fib_acc_base_case_1.
  reflexivity.

  intros n.
   

  unfold fib_acc.  
  rewrite <- unfold_fib_direct_bc1 at 1. 
  rewrite <- unfold_fib_direct_bc0 at 2.
  rewrite -> (about_fib_acc fib_direct fib_direct_satisfies_specification (S (S n)) 0).
  rewrite -> plus_0_r.

  rewrite <- unfold_fib_direct_bc1.
  rewrite <- unfold_fib_direct_bc0 at 2.
  rewrite -> (about_fib_acc fib_direct fib_direct_satisfies_specification (S n) 0).
  rewrite -> plus_0_r.
 
  rewrite <- unfold_fib_direct_bc0 at 2.
  rewrite -> (about_fib_acc fib_direct fib_direct_satisfies_specification n 0).  
  rewrite -> plus_0_r.

  apply unfold_fib_direct_ic.
Qed.

(* We use the fact that the specification is unambigious to prove this quickly *)
Theorem fib_direct_is_equivalent_to_fib_acc :
  forall n: nat,
    fib_acc n = fib_direct n.
Proof.
  intros n.
  rewrite (there_is_only_one_fib fib_acc 
                                 fib_direct 
                                 fib_acc_satisfies_specification
                                 fib_direct_satisfies_specification).
  reflexivity.
Qed.

