  The example below illustrates single point energy calculation at DFT/B3LYP level for ethanol molecule embedded into 20 angstrom box of SPCE/E water molecules.
```
  start etl

  permanent_dir ./perm
  scratch_dir ./data

  prepare
  source etl0.pdb
  new_top new_seq
  new_rst
  modify atom 1:_C1  quantum
  modify atom 1:2H1  quantum
  modify atom 1:3H1  quantum
  modify atom 1:4H1  quantum
  center
  orient
  solvate box 3.0
  update lists
  ignore
  write etl_ref.rst
  write etl_ref.pdb
  end
  task prepare

  md
  system etl_ref
  end

  basis
  * library "6-31G"
  end
  dft
  xc b3lyp
  end

  qmmm
    link_atoms hydrogen
  end

  task qmmm dft energy
```
