## VEM (Vertical Excitation or Emission) Model

The VEM is a model for calculating the vertical excitation (absorption)
or vertical emission (fluorescence) energy in solution according to a
two-time-scale model of solvent polarization. The model is described in

Marenich, A. V.; Cramer, C. J.; Truhlar, D. G.; Guido, C. A.; Mennucci,
B.; Scalmani, G.; Frisch, M. J. Practical computation of electronic
excitation in solution: vertical excitation model. Chem. Science 2011,
2, 2143-2161; <http://dx.doi.org/10.1039/C1SC00313E>

The current implementation is based on the VEM(d,RD) algorithm as
described in the above paper. The method is available only at the TDDFT
level of theory, including both full-linear response TDDFT (sometimes
called LR-TDDFT or regular TDDFT) and the Tamm–Dancoff approximation,
TDDFT-TDA (sometimes just called TDA). The configuration interaction
singles (CIS) wave function method can also be used along with VEM by
considering CIS to be a special case of TDDFT-TDA.

The abbreviation VEM originally referred to the vertical excitation
model of

Li, J.; Cramer, C. J.; Truhlar, D. G. Two-response-time model based on
CM2/INDO/S2 electrostatic potentials for the dielectric polarization
component of solvatochromic shifts on vertical excitation energies. Int.
J. Quantum Chem. 2000, 77, 264-280; DOI:
\[[http://dx.doi.org/10.1002/(SICI)1097-461X(2000)77:1\<264](http://dx.doi.org/10.1002/\(SICI\)1097-461X\(2000\)77:1%3C264)::AID-QUA24\>3.0.CO;2-J
10.1002/(SICI)1097-461X(2000)77:1\<264::AID-QUA24\>3.0.CO;2-J\]

but the current implementation of VEM extends to both excitation and
emission calculations in solution, and the E in VEM now stands for
excitation/emission. Furthermore, the current version of VEM \[based on
the Marenich et al. reference already given {insert reference}\] does
not reduce to the original VEM of Li et al., but is improved as
described in the Marenich et al. paper given above.

The VEM model is based on a nonequilibrium dielectric-continuum approach
in terms of two-time-scale solvent response. The solvent's
bulk-electrostatic polarization is described by using the reaction field
partitioned into slow and fast components, and only the fast component
is self-consistently (iteratively) equilibrated with the charge density
of the solute molecule in its final state. During the VEM calculation,
the slow component is kept in equilibrium with the initial state's
solute charge density but not with the final state's one. In the case of
vertical absorption the initial state is the ground electronic state of
the solute molecule in solution and the final state is an excited
electronic state in solution (and vice versa in the case of an emission
spectrum). Both the ground- and excited-state calculations involve an
integration of the nonhomogeneous-dielectric Poisson equation for bulk
electrostatics in terms of the COSMO model as implemented in NWChem with
the modified COSMO scaling factor ("iscren 0") and by using the SMD
intrinsic atomic Coulomb radii (by default; see the section of the
manual describing SMD). The excited-state electron density is calculated
using the Z-Vector "relaxed density" approach.

The VEM excitation or emission energy includes only a bulk-electrostatic
contribution without any cavity–dispersion–solvent-structure (CDS)
contributions (such contributions are used in SMD ground-state
calculations as described in the SMD section of this manual, but are not
used in VEM calculations). When one considers solvatochromic shifts, the
main contributions beyond bulk electrostatics are solute–solvent
dispersion interactions, hydrogen bonding (the latter is most important
in protic solvents), and perhaps charge transfer between the solute and
the solvent. To explicitly account for solute–solvent charge transfer
and hydrogen bonding, the user can run a VEM calculation on a
supersolute that involves a solute–solvent molecular cluster with one or
a few solvent molecules added explicitly to a bare solute. The
solute–solvent dispersion contribution to the solvatochromic shift, if
desired, can be estimated by the solvation model with state-specific
polarizability (SMSSP) described in:

Marenich, A. V.; Cramer, C. J.; Truhlar, D. G. Uniform treatment of
solute-solvent dispersion in the ground and excited electronic states of
the solute based on a solvation model with state-specific
polarizability. J. Chem. Theory Comput. 2013, 9, 3649-3659;
<http://dx.doi.org/10.1021/ct400329u>

In this case, the user needs to provide values of ground- and
excited-state spherically averaged molecular polarizabilities of the
solvent.

The VEM-specific input options are as
follows:

`do_cosmo_vem (integer input))`  
`0 (do not do any VEM calculation even if the task tddft gradient line is present; default)`  
`1 (do a nonequilibrium VEM excitation energy calculation; in this case the task tddft gradient line should be present, too)`  
`2 (do an equilibrium VEM excitation energy calculation followed by a nonequilibrium emission energy calculation; task tddft gradient line should be present)`

The VEM solvent (which is water by default) can be specified by using
the solvent keyword described in the SMD section of this manual or by
specifying the VEM solvent descriptors such
as

`dielec (real input)`  
`static dielectric constant`

`dielecinf (real input)`  
`optical dielectric constant which is set (by default) to the squared value of the solvent's index of refraction (see the keyword soln, but note `  
`that if the solvent is specified with the solvent keyword, the refractive index is set by the program without needing the user to supply it. `  

Solvent descriptors set by the program are based on the Minnesota
Solvent Descriptor Database:

Winget, P.; Dolney, D. M.; Giesen, D. J.; Cramer, C. J.; Truhlar, D. G.
Minnesota Solvent Descriptor Database. University of Minnesota:
Minneapolis, MN, 2010. <http://comp.chem.umn.edu/solvation/mnsddb.pdf>

If the option 'do\_cosmo\_vem 1' or 'do\_cosmo\_vem 2' is specified the
program will run VEM ground- and excited-state bulk-electrostatic
calculations using the COSMO algorithm with the SMD Coulomb radii by
default. If the user wants to use the default COSMO radii in such
calculations (this is not recommended) the option 'do\_cosmo\_smd
.false.' should be specified.

If the SMSSP estimate of a solute–solvent dispersion contribution to the
solvatochromic shift is desired, the following options should be
used:

`polgs_cosmo_vem (real input)`  
`user-provided value of the spherically-averaged molecular polarizability of the solute in the ground state (in Å3)`

`poles_cosmo_vem (real input)`  
`user-provided value of the spherically-averaged molecular polarizability of the solute in an exited state of interest (in Å3)`

An example of the VEM input file is provided
below.

`echo`  
`title  'VEM/TDDFT-B3LYP/6-311+G(d) vertical excitation energy + SMSSP for formaldehyde in methanol'`  
`start`  
`geometry nocenter`  
` O    0.0000000000    0.0000000000    0.6743110000`  
` C    0.0000000000    0.0000000000   -0.5278530000`  
` H    0.0000000000    0.9370330000   -1.1136860000`  
` H    0.0000000000   -0.9370330000   -1.1136860000`  
`symmetry c1`  
`end`  
`basis`  
`* library 6-311+G*`  
`end`  
`dft`  
` XC b3lyp`  
`end`  
`cosmo`  
` do_cosmo_smd true`  
` do_cosmo_vem 1`  
` solvent methanol`  
` polgs_cosmo_vem 2.429`  
` poles_cosmo_vem 3.208`  
`end`  
`tddft`  
` nroots 10`  
` target 1`  
` singlet`  
` notriplet`  
` algorithm 1`  
` civecs`  
`end`  
`grad`  
`  root 1`  
`  solve_thresh 1d-05`  
`end`  
`task tddft gradient`
