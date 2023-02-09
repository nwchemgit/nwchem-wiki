# Ongoing Projects and Future Directions (Obsolete content dating from 2018)

## Density functional theory (DFT), time-dependent DFT (TD-DFT) and properties

* Discrete interaction model/quantum mechanical method (DIM/QM) for describing the response properties of molecules adsorbed on metal nanoparticles. *Developers:* <em>Justin Moore, Lasse Jensen (Penn State University).
* Development of exact two-component relativistic theory and calculations of magnetic response parameters. <strong>Developers:</strong> <em>Jochen Autschbach (SUNY Buffalo).</em></li>
* Generalization of real-time TDDFT to include spin-orbit effects . *Developers*:Niri Govind (PNNL), Ken Lopata (LSU).

### Future projects
Dynamics on excited-state surfaces, surface hopping, GW/BSE for molecular systems, Spin-flip TDDFT, Non-collinear DFT, spin-orbit TDDFT, interface to QWalk Quantum Monte-Carlo Program (w/ Lucas Wagner University of Illinois, Urbana-Champaign)

### Plane-Wave Density Functional Theory (DFT), Ab Initio Molecular Dynamics, and NWPhys

<li>Parallel in Time Algorithms. <strong>Developers:</strong> <em>Eric J. Bylaska (PNNL), Jonathan Q. Weare (University of Chicago), John H. Weare (UCSD).</em></li>
<li>New free energy methods based on diffusion Monte-Carlo algorithm. <strong>Developers:</strong> <em>Eric J. Bylaska (PNNL), Ying Chen (UCSD), John H. Weare (UCSD).</em></li>
<li>Dynamic Mean Field Theory (DMFT). <strong>Developers:</strong> <em>Duo Song (UCSD), Eric J. Bylaska (PNNL), John H. Weare (UCSD).</em></li>
<li>Development of new methods to calculate XPS and XANES spectra. <strong>Developers:</strong> <em>Eric J. Bylaska (PNNL), Niri Govind (PNNL), John Rehr (University of Washington).</em></li>
<li>Implementation of electric field gradients and NMR in NWPW <strong>Developers:</strong> <em>Eric J. Bylaska (PNNL).</em></li>
<li>Implementation of the fast multipole method (FMM) in the combined Ab initio molecular dynamics and molecular dynamics (AIMD/MM) code. <strong>Developers:</strong> <em>Eric J. Bylaska (PNNL).</em></li>
<li>Constant pressure ab initio molecular dynamics. <strong>Developers:</strong> <em>Eric J. Bylaska (PNNL).</em></li>
<li>New implementation of the projector augmented wave method in NWPW. <strong>Developers:</strong> <em>Eric J. Bylaska (PNNL).</em></li>
<li>Initial implementation of orbital free DFT in NWPW. <strong>Developers:</strong> <em>Eric J. Bylaska (PNNL).</em></li>
<li>implementation of Hybrid openmp-mpi and offloading intel MIC algorithms in NWPW. <strong>Developers:</strong> <em>Eric J. Bylaska (PNNL).</em></li>
</ul>
<p><strong>Future projects</strong>: New NWPhys module development (w/ John Rehr University of Washington) which will include new methods to calculate XPS and XANES spectra. Interface to QWalk Quantum Monte-Carlo Program (w/ Lubos Mitas University of North Carolina).</p>
<p><br />

## High-level Coupled-Cluster methods
<ul>
<li>Development of multi-reference coupled-cluster capabilities for quasidegenerate systems. <strong>Developers:</strong> <em>Jiri Pittner (J Heyrovsky Institute of Physical Chemistry), Karol Kowalski (PNNL).</em></li>
<li>Electron-affinity/ionization-potential Equation-of-motion Coupled-Cluster methods. <strong>Developers:</strong> <em>Kiran Bhaskaran-Nair (LSU), Mark Jarrell (LSU), Juana Moreno (LSU), William Shelton (LSU), Karol Kowalski (PNNL).</em></li>
<li>Green function Coupled Cluster formalism. <strong>Developers:</strong> <em>LSU, PNNL.</em></li>
<li>Development of Intel MIC implementation of the CCSD(T) approach <strong>Developers:</strong> <em>Edoardo Apra (PNNL), Michael Klemm (Intel), Karol Kowalski (PNNL).</em></li>
<li>Reduced scaling CC formulations based on the Cholesky Decomposition. <strong>Developers:</strong> <em>Huub van Dam (PNNL), Edoardo Apra (PNNL), Karol Kowalski (PNNL).</em></li>
</ul>
<p><strong>Future projects</strong>: CC/EOMCC analytical gradients, Intel MIC implementations for iterative CC methods, Multi-reference CC formulations employing incomplete model spaces.</p>


### Long-term NWChem development plans

* Development of new algorithms for hybrid computer architectures including GPU and Intel Xeon Phi computer architectures (NWChem offers already GPU implementations of many-body methods, in 6.5 release we will extend these capabilities to Intel Xeon Phi technology) ,  
* Implementation of reduced-scaling methods for electronic structure calculations (local formulations, tensor hypercontractions, resolution-of-identity based approaches),  
*  Development of novel methodologies for extending temporal scales in ab-initio molecular dynamic and molecular dynamics simulations  
* Approximate electronic structure methods for very large-scale simulations (various semi-empirical methods, order N->N<sup>2</sup> DFT algorithms - orbital free DFT)  
* Integration and extension of existing capabilities towards predictive models for mesoscale systems (for example, aerosol particles, soil chemistry, biosystems, hormone-cofactor functionality in proteins, ionic liquids in cells, large-scale reactions containing multiple steps).

