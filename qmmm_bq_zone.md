
```
bqzone <double precision default 9.0d0>
```
This directive defines the radius of the zone (in angstroms) around the
quantum region where classical residues/segments will be allowed to
interact with quantum region both electrostatically and through Van der
Waals interactions. It should be noted that classical atoms interacting
with quantum region via bonded interactions are always included (this is
true even if bqzone is set to 0). In addition, even if one atom of a
given charged group is in the bqzone (residues are typically treated as
one charged group) then the whole group will be included.
