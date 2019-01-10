 QM/MM optimization is based on multi-region optimization
methodology and is invoked by
```
task qmmm <qmtheory> optimize
```
The overall algorithm involves alternating optimizations of QM and MM
regions until convergence is achieved. This type of approach offers
substantial savings compared to direct optimization of the entire system
as a whole. In the simplest case of two regions (QM and MM) the
algorithm is comprised of the following steps:

1.  Optimization of the QM region keeping MM region fixed
2.  Calculation of reduced electrostatic representation for the QM
    region (e.g. ESP charges)
3.  Optimization of MM region keeping QM region fixed
4.  Repeat from Step 1 until converged

The optimization process is controlled by the following keywords:

  - [**region**](#qmmm_region "wikilink") - **required**
    keyword which specifies which regions will optimized and in which
    order.
  - [**maxiter**](#qmmm_maxiter "wikilink") - number of
    optimizations steps for each region within single optimization pass
  - [**ncycles**](#qmmm_ncycles "wikilink") - number of
    optimization cycles
  - [**density**](#qmmm_density "wikilink") - electrostatic
    representation of the QM region during MM optimization
  - [**xyz**](#qmmm_xyz "wikilink") - output of xyz structure
    files
  - [**convergence**](#qmmm_convergence "wikilink") -
    convergence criteria

Here is an example QM/MM block that provides practical illustration of
all these keywords for a generic optimization case where QM molecule(s)
are embedded in the solvent
```
qmmm
  [region](#qmmm_region "wikilink") qm   solvent
  [maxiter](#qmmm_maxiter "wikilink") 10   3000
  [ncycles](#qmmm_ncycles "wikilink") 5
  [density](#qmmm_density "wikilink") espfit
  [xyz](#qmmm_xyz "wikilink") foo
end
```
We have two regions in the system "qm" and "solvent" and we would like
to optimize them both, thus the line
```
 [region](#qmmm_region "wikilink") qm   solvent
```
Our QM region is presumably small and the maximum number of iterations
(within a single optimization pass) is set to 10. The solvent region is
typically much larger (thousands of atoms) and the maximum number of
iterations is set to a much large number 3000:
```
[maxiter](/Release66:qmmm_maxiter "wikilink") 10   3000
```
We would like to perform a total of 5 optimization passes, giving us a
total of 5\*10=50 optimization steps for QM region and 5\*3000=15000
optimization steps for solvent region:
```
 [ncycles](#qmmm_ncycles "wikilink") 5
```
We are requesting QM region to be represented by point ESP charges
during the solvent optimization:
```
[density](#qmmm_density "wikilink") espfit
```
Finally we are requesting that the coordinates of the first region to be
saved in the form of numbered xyz files:
```
[xyz](#qmmm_xyz "wikilink") foo
```