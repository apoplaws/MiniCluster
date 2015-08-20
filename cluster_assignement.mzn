int: n;
int: k;
array[1..n,1..n] of int: simmilarities;
array [1..n] of var set of int: sets;
array [1..n] of var float: sums;
set of int:ENBS = 1..n;
array[1..n] of var ENBS: cluster_assignement; 
var int: obj;

constraint forall (i in ENBS) (sets[i] = {j| j in ENBS, where cluster_assignement[j]=i});
constraint obj = sum (sums);
constraint forall (i in ENBS) (sums[i] = sum (k in sets[i], j in sets[i]) 
                                        (simmilarities[j,k]));
%constraint obj = 1;
constraint forall (i in ENBS) (card(sets[i]) <= k);

solve maximize obj;