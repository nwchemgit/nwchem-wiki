Delete data in the RTDB.

This directive gives the user a way to delete simple entries from the
database. The general form of the directive is as follows:
```
UNSET <string name>[*]
```
This directive cannot be used with complex objects such as geometries
and basis sets. Complex objects are stored using a structured naming
convention that is not matched by a simple wild card. A wild-card `(*)`
specified at the end of the `string <name>` will cause all entries whose
name begins with that string to be deleted. This is very useful as a way
to reset modules to their default behavior, since modules typically
store information in the database with names that begin with `module:`.
For example, the SCF program can be restored to its default behavior by
deleting all database entries beginning with `scf:`, using the directive
```
unset scf:*
```
The section on [fragment
guess](Hartree-Fock-Theory-for-Molecules.md#vectors-fragment-superposition-of-fragment-molecular-orbitals) has an example using unset on a water dimer
calculation.

The following example makes an entry in the database using the SET
directive, and then immediately deletes it using the UNSET directive:
```
set mylist 1 2 3 4   
unset mylist
```
