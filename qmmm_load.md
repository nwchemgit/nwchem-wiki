### QMMM load
```
load  < esp > [<filename>]
```
This directive instructs to load external file (located in permanent
directory) containing esp charges for QM region. If filename is not
provided it will be constructed from the name of the restart file by
replacing ".rst" suffix with ".esp". Note that file containing esp
charges is always generated whenever esp charge calculation is performed
