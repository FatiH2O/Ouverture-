(* Question 1.1 *)
type monome = int * int 
and polynome = monome list ;;


(* Exemples de polynômes *)
let poly1:polynome = [(2,2); (-12,1); (22,0)];;
let poly2:polynome = [(-12,1); (2,1); (22,0); (5,1)];;
let poly3:polynome = [(0,1); (5,1); (0,0)];; 
let poly4:polynome = [(5,3); (2,1); (22,0); (-2,1)];;
let poly5:polynome = [(0,1)];;
let poly6:polynome = [];;


(* Question 1.2 *)
let canonique (p:polynome) : polynome = 
  
  let remove_double (p:polynome) : polynome = 
    let aux (c, d) table =
      let existing_values = try Hashtbl.find table d with Not_found -> [] in
      Hashtbl.replace table d (c :: existing_values) 
    in let table = Hashtbl.create (List.length p) in 
    List.iter (fun monome -> aux monome table) p; 
    Hashtbl.fold (fun d list_c acc -> (List.fold_left (+) 0 list_c, d) :: acc) table []
      
  in let sort_by_degree (p:polynome) : polynome =
       List.sort (fun (k1, v1) (k2, v2) -> if v1 = v2 then compare k1 k2 else compare v1 v2) p
         
  in let remove_null (p:polynome) : polynome =
       List.filter (fun (c, d) -> c <> 0) p
         
  in remove_null (sort_by_degree (remove_double p));;

canonique poly1;; 
canonique poly2;; 
canonique poly3;; 
canonique poly4;; 
canonique poly5;; 
canonique poly6;; 


(* Question 1.4 *)
let poly_prod (p1:polynome) (p2:polynome) : polynome =
  
  let rec monome_prod (m:monome) (p:polynome) : polynome = 
    match p with
    | [] -> []
    | (c,d)::t -> (c*(fst m), d+(snd m))::(monome_prod m t)
  
  in let rec aux (p1:polynome) (p2:polynome) : polynome  = 
       match p1 with
       | []-> [] 
       | m1::t1 -> (monome_prod m1 p2) @ (aux t1 p2)
  
  in canonique (aux p1 p2);; 

poly_prod (canonique poly1) (canonique poly2);; 
poly_prod (canonique poly2) (canonique poly3);; 
poly_prod (canonique poly4) (canonique poly5);; 
