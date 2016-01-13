val f = let val a = ref 0 and r = ref 1
fun f0 x = (if x = 0 then 1 else x ∗ f
0
(x − 1))
in
fn x => ((if x = !a then () else (a := x; r := f
0 x)); !r)
end
