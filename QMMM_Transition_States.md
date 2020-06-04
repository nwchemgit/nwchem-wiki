QM/MM transition states calculations for qm or qmlink regions can be
performed using

`task qmmm `<qmtheory>` saddle`

The overall algorithm is very similar to QM/MM optimization
calculations, but instead of optimization, transition state search will
be performed for [qm](Qmmm_region#qm "wikilink") or
[qmlink](Qmmm_region#qmlink "wikilink") region for specified number of
steps ( as defined by [maxiter](qmmm_maxiter "wikilink") keyword). The
remaining classical regions (if any) will be optimized following the
standard optimization protocol, which may involve, if specified, ESP
charge representation of the QM atoms (a recommended option).

The success transition state calculations is strongly dependent on the
initial guess. User may consider generation of the latter using QM/MM
reaction pathway calculation. Another useful strategy involves
precalculation of the Hessian. Following the example presented above one
could have precalculated numerical Hessian for the qm region

`...`  
`qmmm`  
`region qm`  
`end`  
  
`freq`  
`animate`  
`end`  
  
`task qmmm dft freq`

and then used this information in the TS calculation

`...`  
`driver`  
` clear`  
` inhess 2  #read in hessian from perm directory`  
` moddir 1  #follow 1st mode`  
`end`  
  
`qmmm`  
` bqzone 15.0`  
` region  qm solvent`  
` xyz  ts`  
` maxiter 10 1000`  
` ncycles 2`  
` density espfit`  
`end`  
  
`task qmmm dft saddle`
