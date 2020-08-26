

This directive is allows to rename atoms in the QM region, based on the
external file which specifies desired name( (1st column) and its PDB
index (2nd column). The file is assumed to be located in the current run
directory.

For example, if we need to rename atoms CB and OG that are part of our
QM region
```
 ...  
 ATOM     13  N   SER     2       0.211   0.284  -1.377        0.00     N  
 ATOM     14  H   SER     2       0.886   1.158  -1.257        0.00     H  
 ATOM     15  CA  SER     2      -0.320  -0.351  -0.166        0.00     C  
 ATOM     16  HA  SER     2      -1.405  -0.183  -0.132        0.00     H  
 ATOM     17  CB  SER     2      -0.001  -1.879  -0.106        0.00     C  
 ATOM     18 2HB  SER     2       1.092  -2.012  -0.038        0.00     H  
 ATOM     19 3HB  SER     2      -0.469  -2.317   0.784        0.00     H  
 ATOM     20  OG  SER     2      -0.452  -2.678  -1.192        0.00     O  
 ATOM     21  HG  SER     2      -1.351  -2.421  -1.392        0.00     H  
 ATOM     22  C   SER     2       0.252   0.338   1.076        0.00     C  
 ...
```
the following qmmm block can be used
```
 ...  
 qmmm  
  ...  
  rename name.dat  
  ...  
 end  
   
 task qmmm dft energy
```
where name.dat file
```
C1 17
OX 20
```
Here atoms are identified by the corresponding PDB atom index and
renamed from default element based naming to C1 and OX.
