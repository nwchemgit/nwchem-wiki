# QMMM Single Point Calculations

The task directive for QM/MM
single point energy and gradient calculations is given by
```
task qmmm <qmtheory> energy
```
or
```
task qmmm <qmtheory> gradient [numerical]
```
where `qmtheory` refers to the level of QM theory (e.g. dft, tce, mp2,
...).

The ground state QM/MM energy calculations should be possible with all
QM descriptions available in NWChem, however most of testing was
performed using core QM methods (scf,dft,mp2,tce). The ground state
QM/MM gradient calculations can be performed analytically with
scf,dft,mp2 levels of theory and numerically for all the others.

The relevant settings for QM/MM interface block for energy and gradient
calculations include

  - [bqzone](qmmm_bq_zone)
  - [mm_charges](qmmm_mm_charges)
  - [link_atoms](qmmm_link_atoms)
  - [link_ecp](qmmm_link_ecp).

[qmmm_example3](qmmm_example3)
