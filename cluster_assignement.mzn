include "globals.mzn";

int: n;
int: total;
set of int:ENBS = 1..n;
set of int:CLUSTERS = 1..n;
array[ENBS,ENBS] of int: simmilarities;
array[ENBS, CLUSTERS] of var 0..1: cluster_assignement;
array [1..n] of var int: sums;

var int: obj;

constraint forall (i in ENBS) (sum (j in CLUSTERS) (cluster_assignement[i,j]) <=1 );
constraint forall (j in CLUSTERS) (sum (i in ENBS) (cluster_assignement[i,j]) <=total );

constraint forall (j in CLUSTERS) (sums[j] = sum (k in ENBS, i in ENBS, where cluster_assignement[k,j]=1/\cluster_assignement[i,j]=1/\i<k ) 
                                        (simmilarities[k,i]));
constraint obj = sum (sums);

%constraint lex2(cluster_assignement);
%constraint forall (j in 2..n) (lex_greater([cluster_assignement[i,j-1]|i in ENBS],[cluster_assignement[i,j]|i in ENBS]));

solve maximize obj; 

output ["obj=\(obj)\n"]++
[ show(cluster_assignement[i,j]) ++ " " ++
if i == n then "\n" else "" endif |
 j in CLUSTERS, i in ENBS ];