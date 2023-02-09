# Ongoing Projects and Future Directions (Obsolete content dating from 2018)

## Density functional theory (DFT), time-dependent DFT (TD-DFT) and properties

* Discrete interaction model/quantum mechanical method (DIM/QM) for describing the response properties of molecules adsorbed on metal nanoparticles. *Developers:* Justin Moore, Lasse Jensen (Penn State University).
* Development of exact two-component relativistic theory and calculations of magnetic response parameters. *Developers:* Jochen Autschbach (SUNY Buffalo).
* Generalization of real-time TDDFT to include spin-orbit effects . *Developers*:Niri Govind (PNNL), Ken Lopata (LSU).

### Future projects
Dynamics on excited-state surfaces, surface hopping, GW/BSE for molecular systems, Spin-flip TDDFT, Non-collinear DFT, spin-orbit TDDFT, interface to QWalk Quantum Monte-Carlo Program (w/ Lucas Wagner University of Illinois, Urbana-Champaign)

## Plane-Wave Density Functional Theory (DFT), Ab Initio Molecular Dynamics, and NWPhys

* Parallel in Time Algorithms. *Developers:* Eric J. Bylaska (PNNL), Jonathan Q. Weare (University of Chicago), John H. Weare (UCSD).
* New free energy methods based on diffusion Monte-Carlo algorithm. *Developers:* Eric J. Bylaska (PNNL), Ying Chen (UCSD), John H. Weare (UCSD).
* Dynamic Mean Field Theory (DMFT). *Developers:* Duo Song (UCSD), Eric J. Bylaska (PNNL), John H. Weare (UCSD).
* Development of new methods to calculate XPS and XANES spectra. *Developers:* Eric J. Bylaska (PNNL), Niri Govind (PNNL), John Rehr (University of Washington).
* Implementation of electric field gradients and NMR in NWPW *Developers:* Eric J. Bylaska (PNNL).
* Implementation of the fast multipole method (FMM) in the combined Ab initio molecular dynamics and molecular dynamics (AIMD/MM) code. *Developers:* Eric J. Bylaska (PNNL).
* Constant pressure ab initio molecular dynamics. *Developers:* Eric J. Bylaska (PNNL).
* New implementation of the projector augmented wave method in NWPW. *Developers:* Eric J. Bylaska (PNNL).
* Initial implementation of orbital free DFT in NWPW. *Developers:* Eric J. Bylaska (PNNL).
* implementation of Hybrid openmp-mpi and offloading intel MIC algorithms in NWPW. *Developers:* Eric J. Bylaska (PNNL).

### Future projects
New NWPhys module development (w/ John Rehr University of Washington) which will include new methods to calculate XPS and XANES spectra. Interface to QWalk Quantum Monte-Carlo Program (w/ Lubos Mitas University of North Carolina).


## High-level Coupled-Cluster methods

* Development of multi-reference coupled-cluster capabilities for quasidegenerate systems. *Developers:* Jiri Pittner (J Heyrovsky Institute of Physical Chemistry), Karol Kowalski (PNNL).
* Electron-affinity/ionization-potential Equation-of-motion Coupled-Cluster methods. *Developers:* Kiran Bhaskaran-Nair (LSU), Mark Jarrell (LSU), Juana Moreno (LSU), William Shelton (LSU), Karol Kowalski (PNNL).
* Green function Coupled Cluster formalism. *Developers:* LSU, PNNL.
* Development of Intel MIC implementation of the CCSD(T) approach *Developers:* Edoardo Apra (PNNL), Michael Klemm (Intel), Karol Kowalski (PNNL).
* Reduced scaling CC formulations based on the Cholesky Decomposition. *Developers:* Edoardo Apra (PNNL), Karol Kowalski (PNNL).
### Future projects
CC/EOMCC analytical gradients, Intel MIC implementations for iterative CC methods, Multi-reference CC formulations employing incomplete model spaces.


## Long-term NWChem development plans

* Development of new algorithms for hybrid computer architectures including GPU and Intel Xeon Phi computer architectures (NWChem offers already GPU implementations of many-body methods, in 6.5 release we will extend these capabilities to Intel Xeon Phi technology) ,  
* Implementation of reduced-scaling methods for electronic structure calculations (local formulations, tensor hypercontractions, resolution-of-identity based approaches),  
*  Development of novel methodologies for extending temporal scales in ab-initio molecular dynamic and molecular dynamics simulations  
* Approximate electronic structure methods for very large-scale simulations (various semi-empirical methods, order N->N<sup>2</sup> DFT algorithms - orbital free DFT)  
* Integration and extension of existing capabilities towards predictive models for mesoscale systems (for example, aerosol particles, soil chemistry, biosystems, hormone-cofactor functionality in proteins, ionic liquids in cells, large-scale reactions containing multiple steps).

