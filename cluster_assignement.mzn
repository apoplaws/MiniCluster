int: n;
int: total;
set of int:ENBS = 1..n;
set of int:CLUSTERS = 1..n;
array[ENBS,ENBS] of int: simmilarities;
array[ENBS, CLUSTERS] of var bool: cluster_assignement;
array [1..n] of var int: sums;

var int: obj;

constraint forall (i in ENBS) (sum (j in CLUSTERS) (cluster_assignement[i,j]) <=1 );
constraint forall (j in CLUSTERS) (sum (i in ENBS) (cluster_assignement[i,j]) <=total );

constraint forall (j in CLUSTERS) (sums[j] = sum (k in ENBS, i in ENBS, where cluster_assignement[k,j]/\cluster_assignement[i,j]/\i<k ) 
                                        (simmilarities[k,i]));
constraint obj = sum (sums);

solve maximize obj; 