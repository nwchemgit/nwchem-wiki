
```
link_atoms <(hydrogen||halogen) default halogen>
```
This directive controls the treatment of bonds crossing the boundary
between quantum and classical regions. The use of hydrogen keyword will
trigger truncation of such bonds with hydrogen link atoms. The position
of the hydrogen atom will be calculated from the coordinates of the
quantum and classical atom of the truncated bond using the following
expression

\(\mathbf{R}_{hlink} = (1-g)\mathbf{R}_{quant} + g*\mathbf{R}_{class}\)

where *g* is the scale factor set at 0.709

Setting link\_atoms to halogen will result in the modification of the
quantum atom of the truncated bond to to the fluoride atom. This
fluoride atom will typically carry an effective core potential (ECP)
basis set as specified in link\_ecp directive.
