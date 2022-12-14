# Functionalities

## Overview

NWChem provides many methods for computing the properties of molecular
and periodic systems using standard quantum mechanical descriptions of
the electronic wavefunction or density. Its classical molecular dynamics
capabilities provide for the simulation of macromolecules and solutions,
including the computation of free energies using a variety of force
fields. These approaches may be combined to perform mixed
quantum-mechanics and molecular-mechanics simulations.

The specific methods for determining molecular electronic structure,
molecular dynamics, and pseudopotential plane-wave electronic structure
and related attributes are listed in the following sections.

## Molecular Electronic Structure

Methods for determining energies and analytic first derivatives with
respect to atomic coordinates include the following:

  - Hartree-Fock (RHF, UHF, high-spin ROHF)
  - Gaussian orbital-based density functional theory (DFT) using many
    local and non-local exchange-correlation potentials (LDA, LSDA)
  - second-order perturbation theory (MP2) with RHF and UHF references
  - complete active space self-consistent field theory (CASSCF).

Analytic second derivatives with respect to atomic coordinates are
available for RHF and UHF, and closed-shell DFT with all functionals.

The following methods are available to compute energies only:

  - iterative CCSD, CCSDT, and CCSDTQ methods and their EOM-CC
    counterparts for RHF, ROHF, and UHF references
  - active-space CCSDt and EOM-CCSDt approaches
  - completely renormalized CR-CCSD(T), and CR-EOM-CCSD(T) correction to
    EOM-CCSD excitation energies
  - locally renormalized CCSD(T) and CCSD(TQ) approaches
  - non-iterative approaches based on similarity transformed
    Hamiltonian: the CCSD(2)T and CCSD(2) formalisms.
  - MP2 with RHF reference and resolution of the identity integral
    approximation MP2 (RI-MP2) with RHF and UHF references
  - selected CI with second-order perturbation correction.

For all methods, the following may be performed:

  - single point energy calculations
  - geometry optimization with constraints (minimization and transition
    state)
  - molecular dynamics on the fully ab initio potential energy surface
  - automatic computation of numerical first and second derivatives
  - normal mode vibrational analysis in Cartesian coordinates
  - ONIOM hybrid calculations
  - Conductor-Like Screening Model (COSMO) calculations
  - electrostatic potential from fit of atomic partial charges
  - spin-free one-electron Douglas-Kroll calculations
  - electron transfer (ET)
  - vibrational SCF and DFT.

At the SCF and DFT level of theory various (response) properties are
available, including NMR shielding tensors and indirect spin-spin
coupling.

## Quantum Mechanics/Molecular Mechanics (QM/MM)

The QM/MM module in NWChem provides a comprehensive set of capabilities
to study ground and excited state properties of large-molecular systems.
The QM/MM module can be used with practically any quantum mechanical
method available in NWChem. The following tasks are supported

  - single point energy and property calculations
  - excited states calculation
  - optimizations and transition state search
  - dynamics
  - free energy calculations.

## Pseudopotential Plane-Wave Electronic Structure

The NWChem Plane-Wave (NWPW) module uses pseudopotentials and plane-wave
basis sets to perform DFT calculations. This method's efficiency and
accuracy make it a desirable first principles method of simulation in
the study of complex molecular, liquid, and solid-state systems.
Applications for this first principles method include the calculation of
free energies, search for global minima, explicit simulation of solvated
molecules, and simulations of complex vibrational modes that cannot be
described within the harmonic approximation.

The NWPW module is a collection of three modules:

  - PSPW (PSeudopotential Plane-Wave) A gamma point code for calculating
    molecules, liquids, crystals, and surfaces.
  - Band A band structure code for calculating crystals and surfaces
    with small band gaps (e.g. semi-conductors and metals).
  - PAW (Projector Augmented Wave) a gamma point projector augmented
    plane-wave code for calculating molecules, crystals, and surfaces.

These capabilities are available:

  - constant energy and constant temperature Car-Parrinello molecular
    dynamics (extended Lagrangian dynamics)
  - LDA, PBE96, and PBE0, exchange-correlation potentials (restricted
    and unrestricted)
  - SIC, pert-OEP, Hartree-Fock, and hybrid functionals (restricted and
    unrestricted)
  - Hamann, Troullier-Martins, Hartwigsen-Goedecker-Hutter
    norm-conserving pseudopotentials with semicore corrections
  - geometry/unit cell optimization, frequency, transition-states
  - fractional occupation of molecular orbitals for metals
  - AIMD/MM capability in PSPW
  - constraints needed for potential of mean force (PMF) calculation
  - wavefunction, density, electrostatic, Wannier plotting
  - band structure and density of states generation

## Molecular Dynamics

The NWChem Molecular Dynamics (MD) module can perform classical
simulations using the AMBER and CHARMM force fields, quantum dynamical
simulations using any of the quantum mechanical methods capable of
returning gradients, and mixed quantum mechanics molecular dynamics
simulation and molecular mechanics energy minimization.

Classical molecular simulation functionality includes the following
methods:

  - single configuration energy evaluation
  - energy minimization
  - molecular dynamics simulation
  - free energy simulation (MCTI and MSTP with single or dual
    topologies, double-wide sampling, and separation-shifted scaling).

The classical force field includes the following elements:

  - effective pair potentials
  - first-order polarization
  - self-consistent polarization
  - smooth particle mesh Ewald
  - twin-range energy and force evaluation
  - periodic boundary conditions
  - SHAKE constraints
  - constant temperature and/or pressure ensembles
  - dynamic proton hopping using the Q-HOP methodology
  - advanced system setup capabilities for biomolecular membranes.
