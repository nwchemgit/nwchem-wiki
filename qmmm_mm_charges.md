
```
mm_charges [exclude <(none||all||linkbond||linkbond_H) default none>]
           [expand  <none||all||solute||solvent> default none]
           [update  <integer default 0>]
```
This directive controls treatment of classical point (MM) charges that
are interacting with QM region. For most QM/MM applications the use of
directive will be not be necessary. Its absence would be simply mean
that all MM charges within the cuttof distance ( as specified by cutoff
) as well those belonging to the charges groups directly bonded to QM
region will be allowed to interact with QM region.

Keyword exclude specifies the subset MM charges that will be
specifically excluded from interacting with QM region.

  - none default value reverts to the original set of MM charges as
    described above.
  - all excludes all MM charges from interacting with QM region ("gas
    phase" calculation).
  - linkbond excludes MM charges that are connected to a quantum region
    by at most two bonds,
  - linkbond\_H similar to linkbond but excludes only hydrogen atoms.

Keyword expand expands the set MM charges interacting with QM region
beyond the limits imposed by cutoff value.

  - none default value reverts to the original set of MM charges
  - solute expands electrostatic interaction to all solute MM charges
  - solvent expands electrostatic interaction to all solvent MM charges
  - all expands electrostatic interaction to all MM charges

Keyword update specifies how often list of MM charges will be updated in
the course of the calculation. Default behavior is not to update.
