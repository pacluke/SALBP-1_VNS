set TASKS;
set WORKSTATIONS;
set PRECEDENCE dimen 2;


param t{i in TASKS} integer;
param c default 0;

var q = 0;
/* param c => tempo de ciclo das estacoes */

var x{s in WORKSTATIONS, i in TASKS} >= 0 binary;
var y{s in WORKSTATIONS} >= 0 binary;

minimize numberOfWorkstations: sum{s in WORKSTATIONS} y[s];

s.t. maxOne{i in TASKS}: sum{s in WORKSTATIONS} x[s,i] = 1;

s.t. precedencia{(i,j) in PRECEDENCE, w in WORKSTATIONS}: sum{s in 1..w} x[s, i] >= x[w,j]; 

s.t. ciclo{s in WORKSTATIONS}: sum{i in TASKS} t[i]*x[s,i] <= c*y[s];

end;

