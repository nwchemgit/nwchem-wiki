### Example of QM/MM optimization

The example below illustrates QM/MM optimization at DFT/B3LYP level of
theory for quantum water molecule embedded into 20 angstrom box of
classical SPCE/E water molecules.

The restart ([wtr_ref.rst](wtr_ref.rst)) and topology
([wtr.top](wtr.top)) files are assumed to be generated
[elsewhere](qmmm_example6).
```
  start wtr  
  
  permanent_dir ./perm  
  scratch_dir ./data  
  
  md  
  system wtr_ref  
  end  
  
  basis  
  * library "6-31G"  
  end  
  
  dft  
  xc b3lyp  
  end  
  
  qmmm  
  region  qm   solvent  
  maxiter 10   1000  
  ncycles 5  
  density espfit  
  xyz    foo  
  end  
  
  task qmmm dft optimize
```
