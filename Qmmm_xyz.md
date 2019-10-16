```
xyz   [filename1]  [filename2]  [filename3]
```
This directive triggers generation for numbered xyz files during QM/MM
optimization. Files are saved into the permanent directory in the
following form
```
system_nnn_kkk.xyz
```
where nnn is a optimization cycle number and kkk is the iteration
counter. No xyz output will be performed for solvent region.
