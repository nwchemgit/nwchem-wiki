

# Density Functional Theory

The NWChem density functional theory (DFT) module uses the Gaussian
basis set approach to compute closed shell and open shell densities and
Kohn-Sham orbitals in the:

  - local density approximation (LDA),
  - non-local density approximation (NLDA),
  - local spin-density approximation (LSD),
  - non-local spin-density approximation (NLSD),
  - non-local meta-GGA approximation (metaGGA),
  - any empirical mixture of local and non-local approximations
    (including exact exchange), and
  - asymptotically corrected exchange-correlation potentials.

The formal scaling of the DFT computation can be reduced by choosing to
use auxiliary Gaussian basis sets to fit the charge density (CD) and/or
fit the exchange-correlation (XC) potential.

DFT input is provided using the compound DFT directive

` DFT`  
`   ...`  
` END`

The actual DFT calculation will be performed when the input module
encounters the [TASK](Top-level#TASK "wikilink") directive.

` TASK DFT`

Once a user has specified a geometry and a Kohn-Sham orbital basis set
the DFT module can be invoked with no input directives (defaults invoked
throughout). There are sub-directives which allow for customized
application; those currently provided as options for the DFT module
are:

` VECTORS [[input] (<string input_movecs default atomic>) || \`  
`                  (project <string basisname> <string filename>`)] \`  
`          [swap [alpha||beta] <integer vec1 vec2> ...] \`  
`          [output <string output_filename default input_movecs>] \`  
` XC [[acm] [b3lyp] [beckehandh] [pbe0]\`  
`    [becke97]  [becke97-1] [becke97-2] [becke97-3] [becke97-d] [becke98] \`  
`     [hcth] [hcth120] [hcth147]\`  
`     [hcth407] [becke97gga1]  [hcth407p]\`  
`     [mpw91] [mpw1k] [xft97] [cft97] [ft97] [op] [bop] [pbeop]\`  
`     [xpkzb99] [cpkzb99] [xtpss03] [ctpss03] [xctpssh]\`  
`     [b1b95] [bb1k] [mpw1b95] [mpwb1k] [pw6b95] [pwb6k] [m05] [m05-2x] [vs98] \`  
`     [m06] [m06-hf] [m06-L] [m06-2x] \`  
`     [HFexch <real prefactor default 1.0>] \`  
`     [becke88 [nonlocal] <real prefactor default 1.0>] \`  
`     [xperdew91 [nonlocal] <real prefactor default 1.0>] \`  
`     [xpbe96 [nonlocal] <real prefactor default 1.0>] \`  
`     [gill96 [nonlocal] <real prefactor default 1.0>] \`  
`     [lyp <real prefactor default 1.0>] \`  
`     [perdew81 <real prefactor default 1.0>] \`  
`     [perdew86 [nonlocal] <real prefactor default 1.0>] \`  
`     [perdew91 [nonlocal] <real prefactor default 1.0>] \`  
`     [cpbe96 [nonlocal] <real prefactor default 1.0>] \`  
`     [pw91lda <real prefactor default 1.0>] \`  
`     [slater <real prefactor default 1.0>] \`  
`     [vwn_1 <real prefactor default 1.0>] \`  
`     [vwn_2 <real prefactor default 1.0>] \`  
`     [vwn_3 <real prefactor default 1.0>] \`  
`     [vwn_4 <real prefactor default 1.0>] \`  
`     [vwn_5 <real prefactor default 1.0>] \`  
`     [vwn_1_rpa <real prefactor default 1.0>] \`  
`     [xtpss03 [nonlocal] <real prefactor default 1.0>] \`  
`     [ctpss03 [nonlocal] <real prefactor default 1.0>] \`  
`     [bc95 [nonlocal] <real prefactor default 1.0>] \`  
`     [xpw6b95 [nonlocal] <real prefactor default 1.0>] \`  
`     [xpwb6k [nonlocal] <real prefactor default 1.0>] \`  
`     [xm05 [nonlocal] <real prefactor default 1.0>] \`  
`     [xm05-2x [nonlocal] <real prefactor default 1.0>] \`  
`     [cpw6b95 [nonlocal] <real prefactor default 1.0>] \`  
`     [cpwb6k [nonlocal] <real prefactor default 1.0>] \`  
`     [cm05 [nonlocal] <real prefactor default 1.0>] \`  
`     [cm05-2x [nonlocal] <real prefactor default 1.0>]] \`  
`     [xvs98 [nonlocal] <real prefactor default 1.0>]] \`  
`     [cvs98 [nonlocal] <real prefactor default 1.0>]] \`  
`     [xm06-L [nonlocal] <real prefactor default 1.0>]] \`  
`     [xm06-hf [nonlocal] <real prefactor default 1.0>]] \`  
`     [xm06 [nonlocal] <real prefactor default 1.0>]] \`  
`     [xm06-2x [nonlocal] <real prefactor default 1.0>]] \`  
`     [cm06-L [nonlocal] <real prefactor default 1.0>]] \`  
`     [cm06-hf [nonlocal] <real prefactor default 1.0>]] \`  
`     [cm06 [nonlocal] <real prefactor default 1.0>]] \`  
`     [cm06-2x [nonlocal] <real prefactor default 1.0>]] `  
` CONVERGENCE [[energy <real energy default 1e-7>] \`  
`              [density <real density default 1e-5>] \`  
`              [gradient <real gradient default 5e-4>] \`  
`              [dampon <real dampon default 0.0>] \`  
`              [dampoff <real dampoff default 0.0>] \`  
`              [diison <real diison default 0.0>] \`  
`              [diisoff <real diisoff default 0.0>] \`  
`              [levlon <real levlon default 0.0>] \`  
`              [levloff <real levloff default 0.0>] \`  
`              [ncydp <integer ncydp default 2>] \`  
`              [ncyds <integer ncyds default 30>] \`  
`              [ncysh <integer ncysh default 30>] \`  
`              [damp <integer ndamp default 0>] [nodamping] \`  
`              [diis [nfock <integer nfock default 10>]] \`  
`              [nodiis] [lshift <real lshift default 0.5>] \`  
`              [nolevelshifting] \`  
`              [hl_tol <real hl_tol default 0.1>] \`  
`              [rabuck [n_rabuck <integer n_rabuck default 25>]]`  
` GRID [(xcoarse||coarse||medium||fine||xfine) default medium] \`  
`      [(gausleg||lebedev ) default lebedev ] \`  
`      [(becke||erf1||erf2||ssf) default erf1] \`  
`      [(euler||mura||treutler) default mura] \`  
`      [rm <real rm default 2.0>] \`  
`      [nodisk]`  
` TOLERANCES [[tight] [tol_rho <real tol_rho default 1e-10>] \`  
`             [accCoul <integer accCoul default 8>] \`  
`             [radius <real radius default 25.0>]]`  
` [(LB94||CS00 `<real shift default none>`)]`  
` DECOMP`  
` ODFT`  
` DIRECT`  
` SEMIDIRECT [filesize <integer filesize default disksize>]`  
`            [memsize  <integer memsize default available>]`  
`            [filename <string filename default $file_prefix.aoints$>]`
` INCORE`  
` ITERATIONS <integer iterations default 30>`  
` MAX_OVL`  
` CGMIN`  
` RODFT`  
` MULLIKEN`  
` DISP`  
` XDM [ a1 <real a1> ]   [ a2 <real a2> ]`  
` MULT <integer mult default 1>`  
` NOIO`  
` PRINT||NOPRINT`

The following sections describe these keywords and optional
sub-directives that can be specified for a DFT calculation in NWChem.

## Specification of Basis Sets for the DFT Module

The DFT module requires at a minimum the basis set for the Kohn-Sham
molecular orbitals. This basis set must be in the default basis set
named "ao basis", or it must be assigned to this default name using the
[SET](Top-level#SET "wikilink") directive.

In addition to the basis set for the Kohn-Sham orbitals, the charge
density fitting basis set can also be specified in the input directives
for the DFT module. This basis set is used for the evaluation of the
Coulomb potential in the Dunlap scheme. The charge density fitting basis
set must have the name "cd basis". This can be the actual name of a
basis set, or a basis set can be assigned this name using the
[SET](Top-level#SET "wikilink") directive. If this basis set is not
defined by input, the <img alt="$O(N^4)$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/6841e6deec263483fbfcac7124b2da91.svg?invert_in_darkmode&sanitize=true" align=middle width="48.01137pt" height="26.70657pt"/> exact Coulomb contribution is computed.

The user also has the option of specifying a third basis set for the
evaluation of the exchange-correlation potential. This basis set must
have the name "xc basis". If this basis set is not specified by input,
the exchange contribution (XC) is evaluated by numerical quadrature. In
most applications, this approach is efficient enough, so the "xc basis"
basis set is not generally required.

For the DFT module, the input options for defining the basis sets in a
given calculation can be summarized as follows;

  - "ao basis" - Kohn-Sham molecular orbitals; required for all
    calculations
  - "cd basis" - charge density fitting basis set; optional, but
    recommended for evaluation of the Coulomb potential
  - "xc basis" - exchange-correlation (XC) fitting basis set; optional,
    and usually not recommended

## VECTORS and MAX\_OVL -- KS-MO Vectors

The VECTORS directive is the same as that in the SCF module (Section
10.5). Currently, the LOCK keyword is not supported by the DFT module,
however the directive

` MAX_OVL`

has the same
effect.

## XC and DECOMP -- Exchange-Correlation Potentials

` XC [[acm] [b3lyp] [beckehandh] [pbe0] [bhlyp]\`  
`    [becke97]  [becke97-1] [becke97-2] [becke97-3] [becke98] [hcth] [hcth120] [hcth147] \`  
`     [hcth407] [becke97gga1] [hcth407p] \`  
`     [optx] [hcthp14] [mpw91] [mpw1k] [xft97] [cft97] [ft97] [op] [bop] [pbeop]\`  
`     [m05] [m05-2x] [m06] [m06-l] [m06-2x] [m06-hf] [m08-hx] [m08-so] [m11] [m11-l]\`  
`     [HFexch <real prefactor default 1.0>] \`  
`     [becke88 [nonlocal] <real prefactor default 1.0>] \`  
`     [xperdew91 [nonlocal] <real prefactor default 1.0>] \`  
`     [xpbe96 [nonlocal] <real prefactor default 1.0>] \`  
`     [gill96 [nonlocal] <real prefactor default 1.0>] \`  
`     [lyp <real prefactor default 1.0>] \`  
`     [perdew81 <real prefactor default 1.0>] \`  
`     [perdew86 [nonlocal] <real prefactor default 1.0>] \`  
`     [perdew91 [nonlocal] <real prefactor default 1.0>] \`  
`     [cpbe96 [nonlocal] <real prefactor default 1.0>] \`  
`     [pw91lda <real prefactor default 1.0>] \`  
`     [slater <real prefactor default 1.0>] \`  
`     [vwn_1 <real prefactor default 1.0>] \`  
`     [vwn_2 <real prefactor default 1.0>] \`  
`     [vwn_3 <real prefactor default 1.0>] \`  
`     [vwn_4 <real prefactor default 1.0>] \`  
`     [vwn_5 <real prefactor default 1.0>] \`  
`     [vwn_1_rpa <real prefactor default 1.0>]]`

The user has the option of specifying the exchange-correlation treatment
in the DFT Module (see table below for full list of functionals). The
default exchange-correlation functional is defined as the local density
approximation (LDA) for closed shell systems and its counterpart the
local spin-density (LSD) approximation for open shell systems. Within
this approximation the exchange functional is the Slater <img alt="$\rho^{1/3}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/9d1e8d8cdb10bf2a8f81456e9af8ad9b.svg?invert_in_darkmode&sanitize=true" align=middle width="28.233315pt" height="29.12679pt"/>
functional (from J.C. Slater, Quantum Theory of Molecules and Solids,
Vol. 4: The Self-Consistent Field for Molecules and Solids (McGraw-Hill,
New York, 1974)), and the correlation functional is the
Vosko-Wilk-Nusair (VWN) functional (functional V) (S.J. Vosko, L. Wilk
and M. Nusair, Can. J. Phys. 58, 1200 (1980)). The parameters used in
this formula are obtained by fitting to the Ceperley and Alder Quantum
Monte-Carlo solution of the homogeneous electron gas.

These defaults can be invoked explicitly by specifying the following
keywords within the DFT module input directive, XC slater vwn\_5.

That is, this statement in the input file

`dft`  
` XC slater vwn_5`  
`end`  
`task dft`

is equivalent to the simple line

`task dft`

The DECOMP directive causes the components of the energy corresponding
to each functional to be printed, rather than just the total
exchange-correlation energy which is the default. You can see an example
of this directive in the [sample
input](DFT#Sample_input_file "wikilink").

Many alternative exchange and correlation functionals are available to
the user as listed in the table below. The following sections describe
how to use these options.

### Exchange-Correlation Functionals

There are several Exchange and Correlation functionals in addition to
the default slater and vwn\_5 functionals. These are either local or
gradient-corrected functionals (GCA); a full list can be found in the
table below.

The Hartree-Fock exact exchange functional, (which has <img alt="$O(N^4)$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/6841e6deec263483fbfcac7124b2da91.svg?invert_in_darkmode&sanitize=true" align=middle width="48.01137pt" height="26.70657pt"/>
computation expense), is invoked by specifying

`  XC HFexch`

Note that the user also has the ability to include only the local or
nonlocal contributions of a given functional. In addition the user can
specify a multiplicative prefactor (the variable <prefactor> in the
input) for the local/nonlocal component or total. An example of this
might be,

`  XC becke88 nonlocal 0.72`

The user should be aware that the Becke88 local component is simply the
Slater exchange and should be input as such.

Any combination of the supported exchange functional options can be
used. For example the popular Gaussian B3 exchange could be specified
as:

`  XC slater 0.8 becke88 nonlocal 0.72 HFexch 0.2`

Any combination of the supported correlation functional options can be
used. For example B3LYP could be specified
as:

`XC vwn_1_rpa 0.19 lyp 0.81 HFexch 0.20  slater 0.80 becke88 nonlocal 0.72`

and X3LYP as:

`xc vwn_1_rpa 0.129 lyp 0.871 hfexch 0.218 slater 0.782 \`  
`becke88 nonlocal 0.542  xperdew91 nonlocal 0.167`

### Setting up common exchange-correlation functionals

  - B3LYP: xc b3lyp
  - PBE0: xc pbe0
  - PBE96: xc xpbe96 cpbe96
  - PW91: xc xperdew91 perdew91
  - BHLYP: xc bhlyp
  - Becke Half and Half: xc beckehandh
  - BP86: xc becke88 perdew86
  - BP91: xc becke88 perdew91
  - BLYP: xc becke88 lyp

Minnesota Functionals

  - xc m05
  - xc m05-2x
  - xc m06
  - xc m06-l
  - xc m06-2x
  - xc m06-hf
  - xc m08-hx
  - xc m08-so
  - xc m11
  - xc m11-l

Analytic second derivatives are not supported with the Minnesota
functionals yet.

### Combined Exchange and Correlation Functionals

In addition to the options listed above for the exchange and correlation
functionals, the user has the alternative of specifying combined
exchange and correlation functionals.

The available hybrid functionals (where a Hartree-Fock Exchange
component is present) consist of the Becke "half and half" (see A.D.
Becke, J. Chem. Phys. 98, 1372 (1992)), the adiabatic connection method
(see A.D. Becke, J. Chem. Phys. 98, 5648 (1993)), B3LYP (popularized by
Gaussian9X), Becke 1997 ("Becke V" paper: A.D.Becke, J. Chem. Phys.,
107, 8554 (1997)).

The keyword beckehandh specifies that the exchange-correlation energy
will be computed
as

<img alt="$E_{XC} \,\! \approx \frac{1}{2} E^{\rm HF}_X + \frac{1}{2} E^{\rm Slater}_{X} + \frac{1}{2} E^{\rm PW91LDA}_{C}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/2c82a18810a5431295a20d39049f7ae7.svg?invert_in_darkmode&sanitize=true" align=middle width="283.185045pt" height="27.85299pt"/>

We know this is NOT the correct Becke prescribed implementation which
requires the XC potential in the energy expression. But this is what is
currently implemented as an approximation to it.

The keyword acm specifies that the exchange-correlation energy is
computed as

<img alt="$\begin{array}{lcl}&#10;  E_{XC} &amp; = &amp; a_0 E^{\rm HF}_X + (1-a_0) E^{\rm Slater}_{X} + a_X\delta E_{X}^{Becke88} + E_{C}^{VWN} + a_C\delta E_{C}^{Perdew91} \\&#10;  &amp; &amp; where \\&#10;  a_0 &amp; = &amp; 0.20, a_X = 0.72, a_C = 0.81  &#10;\end{array}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/8cb8a436911d6ac7c7f25dfba0964860.svg?invert_in_darkmode&sanitize=true" align=middle width="554.92305pt" height="67.48566pt"/>

and Δ stands for a non-local component.

The keyword b3lyp specifies that the exchange-correlation energy is
computed as

<img alt="$\begin{array}{lcl}&#10;  E_{XC} &amp; = &amp; a_0 E^{\rm HF}_X + (1-a_0) E^{\rm Slater}_{X} + a_X\delta E_{X}^{Becke88} + (1-a_C)E_{C}^{VWN\_1\_RPA}  +  a_C\delta E_{C}^{LYP} \\&#10;  &amp; &amp; where \\&#10;  a_0 &amp; = &amp; 0.20, a_X = 0.72, a_C = 0.81  &#10;\end{array}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/252b71c145ea8f4cbbb3fc10290d48b1.svg?invert_in_darkmode&sanitize=true" align=middle width="632.56875pt" height="67.48566pt"/>

<center>

|             |    |    |     |      |       |     |        |
| ----------- | -- | -- | --- | ---- | ----- | --- | ------ |
| Keyword     | X  | C  | GGA | Meta | Hybr. | 2nd | Ref.   |
| slater      | \* |    |     |      |       | Y   | \[1\]  |
| vwn\_1      |    | \* |     |      |       | Y   | \[2\]  |
| vwn\_2      |    | \* |     |      |       | Y   | \[2\]  |
| vwn\_3      |    | \* |     |      |       | Y   | \[2\]  |
| vwn\_4      |    | \* |     |      |       | Y   | \[2\]  |
| vwn\_5      |    | \* |     |      |       | Y   | \[2\]  |
| vwn\_1\_rpa |    | \* |     |      |       | Y   | \[2\]  |
| perdew81    |    | \* |     |      |       | Y   | \[3\]  |
| pw91lda     |    | \* |     |      |       | Y   | \[4\]  |
| xbecke86b   | \* |    | \*  |      |       | N   | \[54\] |
| becke88     | \* |    | \*  |      |       | Y   | \[5\]  |
| xperdew86   | \* |    | \*  |      |       | N   | \[53\] |
| xperdew91   | \* |    | \*  |      |       | Y   | \[6\]  |
| xpbe96      | \* |    | \*  |      |       | Y   | \[7\]  |
| gill96      | \* |    | \*  |      |       | Y   | \[8\]  |
| optx        | \* |    | \*  |      |       | N   | \[20\] |
| mpw91       | \* |    | \*  |      |       | Y   | \[23\] |
| xft97       | \* |    | \*  |      |       | N   | \[24\] |
| rpbe        | \* |    | \*  |      |       | Y   | \[33\] |
| revpbe      | \* |    | \*  |      |       | Y   | \[34\] |
| xpw6b95     | \* |    | \*  |      |       | N   | \[36\] |
| xpwb6k      | \* |    | \*  |      |       | N   | \[36\] |
| perdew86    |    | \* | \*  |      |       | Y   | \[9\]  |
| lyp         |    | \* | \*  |      |       | Y   | \[10\] |
| perdew91    |    | \* | \*  |      |       | Y   | \[6\]  |
| cpbe96      |    | \* | \*  |      |       | Y   | \[7\]  |
| cft97       |    | \* | \*  |      |       | N   | \[24\] |
| op          |    | \* | \*  |      |       | N   | \[31\] |
| hcth        | \* | \* | \*  |      |       | N   | \[11\] |
| hcth120     | \* | \* | \*  |      |       | N   | \[12\] |
| hcth147     | \* | \* | \*  |      |       | N   | \[12\] |
| hcth407     | \* | \* | \*  |      |       | N   | \[19\] |
| becke97gga1 | \* | \* | \*  |      |       | N   | \[18\] |
| hcthp14     | \* | \* | \*  |      |       | N   | \[21\] |
| ft97        | \* | \* | \*  |      |       | N   | \[24\] |
| htch407p    | \* | \* | \*  |      |       | N   | \[27\] |
| bop         | \* | \* | \*  |      |       | N   | \[31\] |
| pbeop       | \* | \* | \*  |      |       | N   | \[32\] |
| xpkzb99     | \* |    |     | \*   |       | N   | \[26\] |
| cpkzb99     |    | \* |     | \*   |       | N   | \[26\] |
| xtpss03     | \* |    |     | \*   |       | N   | \[28\] |
| ctpss03     |    | \* |     | \*   |       | N   | \[28\] |
| bc95        |    | \* |     | \*   |       | N   | \[33\] |
| cpw6b95     |    | \* |     | \*   |       | N   | \[36\] |
| cpwb6k      |    | \* |     | \*   |       | N   | \[36\] |
| xm05        | \* |    |     | \*   | \*    | N   | \[37\] |
| cm05        |    | \* |     | \*   |       | N   | \[37\] |
| m05-2x      | \* | \* |     | \*   | \*    | N   | \[38\] |
| xm05-2x     | \* |    |     | \*   | \*    | N   | \[38\] |
| cm05-2x     |    | \* |     | \*   |       | N   | \[38\] |
| xctpssh     |    |    |     | \*   | \*    | N   | \[29\] |
| bb1k        |    |    |     | \*   | \*    | N   | \[34\] |
| mpw1b95     |    |    |     | \*   | \*    | N   | \[35\] |
| mpwb1k      |    |    |     | \*   | \*    | N   | \[35\] |
| pw6b95      |    |    |     | \*   | \*    | N   | \[36\] |
| pwb6k       |    |    |     | \*   | \*    | N   | \[36\] |
| m05         |    |    |     | \*   | \*    | N   | \[37\] |
| vs98        |    |    |     | \*   | \*    | N   | \[41\] |
| xvs98       | \* |    |     | \*   |       | N   | \[41\] |
| cvs98       |    | \* |     | \*   |       | N   | \[41\] |
| m06-L       | \* | \* |     | \*   |       | N   | \[40\] |
| xm06-L      | \* |    |     | \*   |       | N   | \[40\] |
| cm06-L      |    | \* |     | \*   |       | N   | \[40\] |
| m06-hf      |    |    |     | \*   | \*    | N   | \[41\] |
| xm06-hf     | \* |    |     | \*   | \*    | N   | \[41\] |
| cm06-hf     |    | \* |     | \*   |       | N   | \[41\] |
| m06         |    |    |     | \*   | \*    | N   | \[42\] |
| xm06        | \* |    |     | \*   | \*    | N   | \[42\] |
| cm06        |    | \* |     | \*   |       | N   | \[42\] |
| m06-2x      |    |    |     | \*   | \*    | N   | \[42\] |
| xm06-2x     | \* |    |     | \*   | \*    | N   | \[42\] |
| cm06-2x     |    | \* |     | \*   |       | N   | \[42\] |
| cm08-hx     |    | \* |     | \*   |       | N   | \[46\] |
| xm08-hx     | \* |    |     | \*   |       | N   | \[46\] |
| m08-hx      | \* | \* |     | \*   | \*    | N   | \[46\] |
| cm08-so     |    | \* |     | \*   |       | N   | \[46\] |
| xm08-so     | \* |    |     | \*   |       | N   | \[46\] |
| m08-so      | \* | \* |     | \*   | \*    | N   | \[46\] |
| cm11        |    | \* |     | \*   |       | N   | \[47\] |
| xm11        | \* |    |     | \*   |       | N   | \[47\] |
| m11         | \* | \* |     | \*   | \*    | N   | \[47\] |
| cm11-l      |    | \* |     | \*   |       | N   | \[48\] |
| xm11-l      | \* |    |     | \*   |       | N   | \[48\] |
| m11-l       | \* | \* |     | \*   |       | N   | \[48\] |
| csogga      |    | \* | \*  |      |       | N   | \[49\] |
| xsogga      | \* |    | \*  |      |       | N   | \[49\] |
| sogga       | \* | \* | \*  |      |       | N   | \[49\] |
| csogga11    |    | \* | \*  |      |       | N   | \[50\] |
| xsogga11    | \* |    | \*  |      |       | N   | \[50\] |
| sogga11     | \* | \* | \*  |      |       | N   | \[50\] |
| csogga11-x  |    | \* |     |      |       | N   | \[51\] |
| xsogga11-x  | \* |    | \*  |      |       | N   | \[51\] |
| sogga11-x   | \* | \* | \*  |      | \*    | N   | \[51\] |
| dldf        | \* | \* |     | \*   | \*    | N   | \[52\] |
| beckehandh  | \* | \* |     |      | \*    | Y   | \[13\] |
| b3lyp       | \* | \* | \*  |      | \*    | Y   | \[14\] |
| acm         | \* | \* | \*  |      | \*    | Y   | \[14\] |
| becke97     | \* | \* | \*  |      | \*    | N   | \[15\] |
| becke97-1   | \* | \* | \*  |      | \*    | N   | \[11\] |
| becke97-2   | \* | \* | \*  |      | \*    | N   | \[22\] |
| becke97-3   | \* | \* | \*  |      | \*    | N   | \[30\] |
| becke97-d   | \* | \* | \*  |      | \*    | N   | \[45\] |
| becke98     | \* | \* | \*  |      | \*    | N   | \[16\] |
| pbe0        | \* | \* | \*  |      | \*    | Y   | \[17\] |
| mpw1k       | \* | \* | \*  |      | \*    | Y   | \[25\] |
| xmvs15      | \* |    |     | \*   |       | N   | \[55\] |
|  |

Table of available Exchange (X) and Correlation (C) functionals. GGA is
the Generalized Gradient Approximation, and Meta refers to Meta-GGAs.
The column 2nd refers to second derivatives of the energy with respect
to nuclear position.

</center>

1.  J.C. Slater and K. H. Johnson, Phys. Rev. B 5, 844 (1972)
2.  S.J. Vosko, L. Wilk and M. Nusair, Can. J. Phys. 58, 1200 (1980)
3.  J. P. Perdew and A. Zunger, Phys. Rev. B 23, 5048 (1981).
4.  J.P. Perdew and Y. Wang, Phys. Rev. B 45, 13244 (1992)
5.  A.D. Becke, Phys. Rev. A 88, 3098 (1988)
6.  J.P. Perdew, J.A. Chevary, S.H. Vosko, K.A. Jackson, M.R. Pederson,
    D.J. Singh and C. Fiolhais, Phys. Rev. B 46, 6671 (1992)
7.  J.P. Perdew, K. Burke and M. Ernzerhof, Phys. Rev. Lett. 77, 3865
    (1996); 78 , 1396 (1997)
8.  P.W.Gill , Mol. Phys. 89, 433 (1996)
9.  J. P. Perdew, Phys. Rev. B 33, 8822 (1986)
10. C. Lee, W. Yang and R. G. Parr, Phys. Rev. B 37, 785 (1988)
11. F.A.Hamprecht, A.J.Cohen, D.J.Tozer and N.C. Handy, J. Chem. Phys.
    109, 6264 (1998)
12. A.D.Boese, N.L.Doltsinis, N.C.Handy and M.Sprik. J. Chem. Phys. 112,
    1670 (2000)
13. A.D. Becke, J. Chem. Phys. 98, 1372 (1992)
14. A.D. Becke, J. Chem. Phys. 98, 5648 (1993)
15. A.D.Becke, J. Chem. Phys. 107, 8554 (1997)
16. H.L.Schmider and A.D. Becke, J. Chem. Phys. 108, 9624 (1998)
17. C.Adamo and V.Barone, J. Chem. Phys. 110, 6158 (1999)
18. A.J.Cohen and N.C. Handy, Chem. Phys. Lett. 316, 160 (2000)
19. A.D.Boese, N.C.Handy, J. Chem. Phys. 114, 5497 (2001)
20. N.C.Handy, A.J. Cohen, Mol. Phys. 99, 403 (2001)
21. G. Menconi, P.J. Wilson, D.J. Tozer, J. Chem. Phys 114, 3958 (2001)
22. P.J. Wilson, T.J. Bradley, D.J. Tozer, J. Chem. Phys 115, 9233
    (2001)
23. C. Adamo and V. Barone, J. Chem. Phys. 108, 664 (1998); Y. Zhao and
    D.G. Truhlar, J. Phys. Chem. A 109, 5656 (2005)
24. M.Filatov and W.Thiel, Mol.Phys. 91, 847 (1997). M.Filatov and
    W.Thiel, Int.J.Quantum Chem. 62, 603 (1997)
25. B.J. Lynch, P.L. Fast, M. Harris and D.G. Truhlar, J. Phys. Chem. A
    104, 4811(2000)
26. J.P. Perdew, S. Kurth, A. Zupan and P. Blaha, Phys. Rev. Lett. 82,
    2544 (1999)
27. A. D. Boese, A. Chandra, J. M. L. Martin and D. Marx, J. Chem. Phys.
    119, 5965 (2003)
28. J. Tao,J.Perdew, V. Staroverov and G. Scuseria, Phys. Rev. Let. 91,
    146401-1 (2003)
29. V. Staroverov, G. Scuseria, J. Tao and J.Perdew, J. Chem.Phys. 119,
    12129 (2003)
30. T.W. Keal, D.J. Tozer, J. Chem. Phys 123, 121103 (2005)
31. T. Tsuneda, T. Suzumura and K. Hirao, J. Chem Phys. 110, 10664
    (1999)
32. T. Tsuneda, T. Suzumura and K. Hirao, J. Chem Phys. 111, 5656 (1999)
33. B. Hammer, L. B. Hansen and J. Nørskov , Phys. Rev. B 58, 7413
    (1999)
34. Y. Zhang and W. Yang, Phys. Rev. Letters 80, 890 (1998)
35. A. D. Becke, J. Chem. Phys. 104, 1040 (1996)
36. Y. Zhao and D. G. Truhlar, J. Phys. Chem. A 108, 2715 (2004)
37. Y. Zhao and D. G. Truhlar, J. Phys. Chem. A 108, 6908 (2004)
38. Y. Zhao and D. G. Truhlar, J. Phys. Chem. A 109, 5656 (2005)
39. Y. Zhao, N. E. Schultz and D. G. Truhlar, J. Chem. Phys. 123, 161103
    (2005)
40. Y. Zhao, N. E. Schultz and D. G. Truhlar, J. Chem. Theory Comput. 2,
    364 (2006)
41. T. Van Voorhis, G. E. Scuseria, J. Chem. Phys. 109, 400 (1998)
42. Y. Zhao, D. G. Truhlar, J. Chem. Phys. 125, 194101 (2006)
43. Y. Zhao, D. G. Truhlar, J. Phys. Chem. A. 110, 13126 (2006)
44. Y. Zhao, D. G. Truhlar, Theor. Chem. Acc. (2006)
45. S. Grimme, J. Comp. Chem. 27, 1787 (2006).
46. Y. Zhao and D. G. Truhlar, J. Chem. Theory Comput. 4, 1849 (2008)
47. R. Peverati and D. G. Truhlar, J. Phys. Chem. Letters 2, 2810 (2011)
48. R. Peverati and D. G. Truhlar, J. Phys. Chem. Letters 3, 117 (2012)
49. Y. Zhao and D. G. Truhlar, J. Chem. Phys. 128, 184109 (2008)
50. R. Peverati, Y. Zhao and D. G. Truhlar, J. Phys. Chem. Lett. 2, 1911
    (2011)
51. R. Peverati and D.G. Truhlar, J. Chem. Phys. , 135, 191102 (2011)
52. K. Pernal, R. Podeszwa, K. Patkowski and K. Szalewicz, Phys. Rev.
    Lett. 103, 263201 (2009)
53. J. P. Perdew and W. Yue, Phys. Rev. B 33, 8800 (1986)
54. A. D. Becke, J. Chem. Phys. 85, 7184 (1986)
55. J. Sun, J. P. Perdew, and A. Ruzsinszky, PNAS 112, 685 (2015).

### Meta-GGA Functionals

One way to calculate meta-GGA energies is to use orbitals and densities
from fully self-consistent GGA or LDA calculations and run them in one
iteration in the meta-GGA functional. It is expected that meta-GGA
energies obtained this way will be close to fully self consistent
meta-GGA calculations.

It is possible to calculate metaGGA energies both ways in NWChem, that
is, self-consistently or with GGA/LDA orbitals and densities. However,
since second derivatives are not available for metaGGAs, in order to
calculate frequencies, one must use task dft freq numerical. A sample
file with this is shown below, in [Sample input
file](#Sample_input_file "wikilink"). In this instance, the energy is
calculated self-consistently and geometry is optimized using the
analytical gradients.

(For more information on metaGGAs, see S. Kurth, J. Perdew, P. Blaha,
Int. J. Quant. Chem 75, 889 (1999) for a brief description of meta-GGAs,
and citations 14-27 therein for thorough background )

Note: both TPSS and PKZB correlation require the PBE GGA CORRELATION
(which is itself dependent on an LDA). The decision has been made to use
these functionals with the accompanying local PW91LDA. The user does not
have the ability to set the local part of these metaGGA functionals.

### Range-Separated Functionals

Using the Ewald
decomposition

<img alt="$\frac{1}{r_{12}} = \frac{\alpha + \beta \texttt{erf}(\mu r_{12})}{r_{12}} +  &#10;\frac{1 - [\alpha + \beta \texttt{erf}(\mu r_{12})]}{r_{12}}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/702839e7c548f54d8f5b49f0a3ad6824.svg?invert_in_darkmode&sanitize=true" align=middle width="254.98902pt" height="33.14091pt"/>

we can split the the Exchange interaction as

<img alt="$E_{X} = E_X^{LR} + E_X^{SR}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/7b23a639e12d5c9a1bfa2148db98ab10.svg?invert_in_darkmode&sanitize=true" align=middle width="130.9704pt" height="27.59823pt"/>

Therefore the long-range HF Exchange energy
becomes

<img alt="$E_X^{LR} = \alpha E_X^{HF} - \frac{\beta}{2} \sum_i \sum_j \int \int \phi_i(r_1)\phi_j(r_1)\frac{\texttt{erf}(\mu r_{12})}{r_{12}} \phi_i(r_2)\phi_j(r_2)$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f3c7b6943ed1cbb2f44e5c597ff1f40b.svg?invert_in_darkmode&sanitize=true" align=middle width="448.107495pt" height="33.14091pt"/>

` cam `<real cam>` cam_alpha `<real cam_alpha>` cam_beta `<cam_beta>

`cam` represents the attenuation parameter <img alt="$\mu$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/07617f9d8fe48b4a7b3f523d6730eef0.svg?invert_in_darkmode&sanitize=true" align=middle width="9.86799pt" height="14.10255pt"/> , `cam_alpha` and
`cam_beta` are parameters <img alt="$\alpha$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/c745b9b57c145ec5577b82542b2df546.svg?invert_in_darkmode&sanitize=true" align=middle width="10.537065pt" height="14.10255pt"/> and <img alt="$\beta$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/8217ed3c32a785f0b5aad4055f432ad8.svg?invert_in_darkmode&sanitize=true" align=middle width="10.1277pt" height="22.74591pt"/> that control the
amount of short-range DFT and long-range HF Exchange according to the
Ewald decomposition. As <img alt="$r_{12} \rightarrow 0$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/8175ba1917135d1efdde5463e7eb7c98.svg?invert_in_darkmode&sanitize=true" align=middle width="55.01331pt" height="21.10812pt"/>, the HF exchange
fraction is <img alt="$\alpha$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/c745b9b57c145ec5577b82542b2df546.svg?invert_in_darkmode&sanitize=true" align=middle width="10.537065pt" height="14.10255pt"/>, while the DFT exchange fraction is
<img alt="$(1-\alpha)$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/491890f3829ee2642d52fc90dd9a270f.svg?invert_in_darkmode&sanitize=true" align=middle width="51.506895pt" height="24.56553pt"/>. As <img alt="$r_{12} \rightarrow \infty$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/c0e7cebce699a3e05c018ea42a78a091.svg?invert_in_darkmode&sanitize=true" align=middle width="63.201765pt" height="14.10255pt"/>, the HF exchange
fraction approaches <img alt="$\alpha + \beta$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/c1a73141d41bf7fb1026a4ac24f6110a.svg?invert_in_darkmode&sanitize=true" align=middle width="40.708305pt" height="22.74591pt"/> and the DFT exchange fraction
approaches <img alt="$(1- \alpha - \beta)$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/5457bd6eac3dc5ac9a603bfc82e48e38.svg?invert_in_darkmode&sanitize=true" align=middle width="81.681105pt" height="24.56553pt"/>. In the HSE functional, the HF part
is short-ranged and DFT is long-ranged.

Range separated functionals (or long-range corrected or LC) can be
specified as follows:

CAM-B3LYP:

`xc xcamb88 1.00 lyp 0.81 vwn_5 0.19 hfexch 1.00`  
`cam 0.33 cam_alpha 0.19 cam_beta 0.46`

LC-BLYP:

`xc xcamb88 1.00 lyp 1.0 hfexch 1.00`  
`cam 0.33 cam_alpha 0.0 cam_beta 1.0`

LC-PBE:

`xc xcampbe96 1.0 cpbe96 1.0 HFexch 1.0`  
`cam 0.30 cam_alpha 0.0 cam_beta 1.0`

LC-PBE0 or CAM-PBE0:

`xc xcampbe96 1.0 cpbe96 1.0 HFexch 1.0`  
`cam 0.30 cam_alpha 0.25 cam_beta 0.75`

BNL (Baer, Neuhauser,
Lifshifts):

`xc xbnl07 0.90 lyp 1.00 hfexch 1.00`  
`cam 0.33 cam_alpha 0.0 cam_beta 1.0`

LC-wPBE:

`xc xwpbe 1.00 cpbe96 1.0 hfexch 1.00`  
`cam 0.3 cam_alpha 0.00 cam_beta 1.00`

LC-wPBEh:

`xc xwpbe 0.80 cpbe96 1.0 hfexch 1.00`  
`cam 0.2 cam_alpha 0.20 cam_beta 0.80`

QTP-00

`xc xcamb88 1.00 lyp 0.80 vwn_5 0.2 hfexch 1.00`  
`cam 0.29 cam_alpha 0.54 cam_beta 0.37`

rCAM-B3LYP

`xc xcamb88 1.00 lyp 1.0 vwn_5 0. hfexch 1.00 becke88 nonlocal 0.13590`  
`cam 0.33 cam_alpha 0.18352 cam_beta 0.94979`

HSE03 functional: 0.25\*Ex(HF-SR) - 0.25\*Ex(PBE-SR) + Ex(PBE) +
Ec(PBE), where gamma(HF-SR) = gamma(PBE-SR)

`xc hse03`

or it can be explicitly set as

`xc xpbe96 1.0 xcampbe96 -0.25 cpbe96 1.0 srhfexch 0.25`  
`cam 0.33 cam_alpha 0.0 cam_beta 1.0`

HSE06 functional:

`xc xpbe96 1.0 xcampbe96 -0.25 cpbe96 1.0 srhfexch 0.25`  
`cam 0.11 cam_alpha 0.0 cam_beta 1.0`

Please see the following papers (not a complete list) for further
details about the theory behind these functionals and applications.

1.  A. Savin, In Recent Advances in Density Functional Methods Part I;
    D.P. Chong, Ed.; World Scientific: Singapore, 1995; Vol. 129.
2.  H. Iikura, T. Tsuneda, T. Yanai, K. Hirao, J. Chem. Phys. 115, 3540
    (2001)
3.  Y. Tawada, T. Tsuneda, S. Yanahisawa, T. Yanai, K. Hirao, J. Chem.
    Phys. 120, 8425 (2004)
4.  T. Yanai, D.P. Tew, N.C. Handy, Chem. Phys. Lett. 393, 51 (2004)
5.  M. J. G. Peach, A. J. Cohen, D. J. Tozer, Phys. Chem. Chem. Phys. 8,
    4543 (2006)
6.  J.-W. Song, T. Hirosawa, T. Tsuneda, K. Hirao, J. Chem. Phys. 126,
    154105 (2007)
7.  E. Livshits, R. Baer, Phys. Chem. Chem. Phys. 9, 2932 (2007)
8.  A. J. Cohen, P. Mori-Sanchez, and W. Yang, J. Chem. Phys. 126,
    191109 (2007)
9.  M.A. Rohrdanz, J.M. Herbert, J. Chem. Phys. 129 034107 (2008)
10. N. Govind, M. Valiev, L. Jensen, K. Kowalski, J. Phys. Chem. A, 113,
    6041 (2009)
11. R. Baer, E. Livshits, U. Salzner, Annu. Rev. Phys. Chem. 61, 85
    (2010)
12. J. Autschbach, M. Srebro, Acc. Chem. Res. 47, 2592 (2014)
13. P. Verma and R. J. Bartlett, J. Chem. Phys. 140, 18A534 (2014)

Example illustrating the CAM-B3LYP functional:

`start h2o-camb3lyp`  
`geometry units angstrom`  
`   O      0.00000000     0.00000000     0.11726921`  
`   H      0.75698224     0.00000000    -0.46907685`  
`   H     -0.75698224     0.00000000    -0.46907685`  
`end`  
`basis spherical`  
` * library aug-cc-pvdz`  
`end`  
`dft`  
` xc xcamb88 1.00 lyp 0.81 vwn_5 0.19 hfexch 1.00`  
` cam 0.33 cam_alpha 0.19 cam_beta 0.46`  
` direct`  
` iterations 100`  
`end`  
`task dft energy`

Example illustrating the HSE03 functional:

`echo`  
`start h2o-hse`  
`geometry units angstrom`  
`O      0.00000000     0.00000000     0.11726921`  
`H      0.75698224     0.00000000    -0.46907685`  
`H     -0.75698224     0.00000000    -0.46907685`  
`end`  
`basis spherical`  
` * library aug-cc-pvdz`  
`end`  
`dft`  
` xc hse03`  
` iterations 100`  
` direct`  
` end`  
`task dft energy`  
`#or alternatively`  
`dft`  
` xc xpbe96 1.0 xcampbe96 -0.25 cpbe96 1.0 srhfexch 0.25`  
` cam 0.33 cam_alpha 0.0 cam_beta 1.0`  
` iterations 100`  
` direct`  
`end`  
`task dft energy`

### SSB-D functional

The recently developed SSB-D is a small correction to the non-empirical
PBE functional and includes a portion of Grimme's dispersion correction
(s6=0.847455). It is designed to reproduce the good results of OPBE for
spin-state splittings and reaction barriers, and the good results of PBE
for weak interactions. The SSB-D functional works excellent for these
systems, including for difficult systems for DFT (dimerization of
anthracene, branching of octane, water-hexamer isomers, C12H12 isomers,
stacked adenine dimers), and for NMR chemical shieldings.

1.  M. Swart, M. Solà, F.M. Bickelhaupt, J. Chem. Phys. 131, 094103
    (2009)
2.  M. Swart, M. Solà, F.M. Bickelhaupt, J. Comp. Meth. Sci. Engin. 9,
    69 (2009)

It can be specified as

`xc ssb-d`

### Semi-empirical hybrid DFT combined with perturbative MP2

This theory combines hybrid density functional theory with MP2
semi-empirically. The B2PLYP functional, which is an example of this
approximation, can be specified as:

`dft`  
` xc HFexch 0.53 becke88 0.47 lyp 0.73 mp2 0.27`  
` dftmp2 direct`  
` direct`  
` convergence energy 1e-8`  
` iterations 100`  
`end`

This can also be performed in semidirect mode as

`dft`  
` xc HFexch 0.53 becke88 0.47 lyp 0.73 mp2 0.27`  
` dftmp2 semidirect`  
` direct`  
` convergence energy 1e-8`  
` iterations 100`  
`end`

For details of the theory, please see the following reference:

1.  S. Grimme, "Semiempirical hybrid density functional with
    perturbative second-order correlation" Journal of Chemical Physics
    124, 034108 (2006)

### LB94 and CS00 -- Asymptotic correction

The keyword LB94 will correct the asymptotic region of the XC definition
of exchange-correlation potential by the van-Leeuwen-Baerends
exchange-correlation potential that has the correct <img alt="$-1/r$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/3053de24294b49c2329426a84757d7d1.svg?invert_in_darkmode&sanitize=true" align=middle width="36.958185pt" height="24.56553pt"/> asymptotic
behavior. The total energy will be computed by the XC definition of
exchange-correlation functional. This scheme is known to tend to
overcorrect the deficiency of most uncorrected exchange-correlation
potentials.

The keyword CS00, when supplied with a real value of shift (in atomic
units), will perform Casida-Salahub '00 asymptotic correction. This is
primarily intended for use in conjunction with
[TDDFT](Excited-State_Calculations "wikilink"). The shift is normally
positive (which means that the original uncorrected exchange-correlation
potential must be shifted down).

When the keyword CS00 is specified without the value of shift, the
program will automatically supply it according to the semi-empirical
formula of Zhan, Nichols, and Dixon (again, see
[TDDFT](Excited-State_Calculations "wikilink") for more details and
references). As the Zhan's formula is calibrated against B3LYP results,
it is most meaningful to use this in conjunction with the B3LYP
functional, although the program does not prohibit (or even warn) the
use of any other functional.

Sample input files of asymptotically corrected TDDFT calculations can be
found in the corresponding
[section](Excited-State_Calculations "wikilink").

### NWXC -- higher order derivatives for density functionals

Whereas first order derivatives of density functionals are sufficient to
calculate the Kohn-Sham energy and perform geometry optimizations,
higher order derivatives are required for many properties. These
properties include commonly used vibrational frequencies and excitation
energies as well as others. To address the need for these derivatives a
new library of density functionals was added that generates derivatives
using either automatic differentiation or symbolic algebra approaches.

To request a functional from this library add the NEW keyword to the XC
line. By default this will use the automatic differentiation based
implementation. However, the automatic differentiation based
implementation can also be requested explicitly by adding the AUTODIFF
keyword. The alternative symbolic algebra implementation can be
requested by adding the MAXIMA keyword.

Examples:

` xc new b3lyp`

` xc new autodiff b3lyp`

` xc new maxima b3lyp`

All three these examples request the B3LYP functional. The first two
examples are equivalent in that they both use the automatic
differentiation approach. The third example uses the symbolic algebra
generated code.

The library in question is also available in the NWPW module providing
the same set of functionals to the plane wave capabilities as are
available in the local basis set DFT capabilities.

## Sample input file

A simple example calculates the geometry of water, using the metaGGA
functionals xtpss03 and ctpss03. This also highlights some of the print
features in the DFT module. Note that you must use the line task dft
freq numerical because analytic hessians are not available for the
metaGGAs:

`title "WATER 6-311G* meta-GGA XC geometry"`  
`echo`  
`geometry units angstroms`  
` O       0.0  0.0  0.0`  
` H       0.0  0.0  1.0`  
` H       0.0  1.0  0.0`  
`end`  
`basis`  
` H library 6-311G*`  
` O library 6-311G*`  
`end`  
`dft`  
` iterations 50`  
` print  kinetic_energy`  
` xc xtpss03 ctpss03`  
` decomp`  
`end`  
`task dft optimize `  
`task dft freq numerical`

## ITERATIONS or MAXITER -- Number of SCF iterations

` ITERATIONS or MAXITER <integer iterations default 30>`

The default optimization in the DFT module is to iterate on the
Kohn-Sham (SCF) equations for a specified number of iterations (default
30). The keyword that controls this optimization is ITERATIONS, and has
the following general form,

`  iterations <integer iterations default 30>`

or

`  maxiter <integer iterations default 30>`

The optimization procedure will stop when the specified number of
iterations is reached or convergence is met. See an example that uses
this directive in [Sample input
file](#Sample_input_file "wikilink").

## CONVERGENCE -- SCF Convergence Control

` CONVERGENCE [energy <real energy default 1e-6>] \`  
`             [density <real density default 1e-5>] \`  
`             [gradient <real gradient default 5e-4>] \`  
`             [hl_tol <real hl_tol default 0.1>]`  
`             [dampon <real dampon default 0.0>] \`  
`             [dampoff <real dampoff default 0.0>] \`  
`             [ncydp <integer ncydp default 2>] \`  
`             [ncyds <integer ncyds default 30>] \`  
`             [ncysh <integer ncysh default 30>] \`  
`             [damp <integer ndamp default 0>] [nodamping] \`  
`             [diison <real diison default 0.0>] \`  
`             [diisoff <real diisoff default 0.0>] \`  
`             [(diis [nfock <integer nfock default 10>]) || nodiis] \`  
`             [levlon <real levlon default 0.0>] \`  
`             [levloff <real levloff default 0.0>] \`  
`             [(lshift <real lshift default 0.5>) || nolevelshifting] \`  
`             [rabuck [n_rabuck <integer n_rabuck default 25>]]`

Convergence is satisfied by meeting any or all of three criteria;

  - convergence of the total energy; this is defined to be when the
    total DFT energy at iteration N and at iteration N-1 differ by a
    value less than some value (the default is 1e-6). This value can be
    modified using the key word,

`       CONVERGENCE energy <real energy default 1e-6>`

  - convergence of the total density; this is defined to be when the
    total DFT density matrix at iteration N and at iteration N-1 have a
    RMS difference less than some value (the default is 1e-5). This
    value can be modified using the key word,

`       CONVERGENCE density <real density default 1e-5>`

  - convergence of the orbital gradient; this is defined to be when the
    DIIS error vector becomes less than some value (the default is
    5e-4). This value can be modified using the key word,

`       CONVERGENCE gradient <real gradient default 5e-4>`

The default optimization strategy is to immediately begin direct
inversion of the iterative subspace. Damping is also initiated (using
70% of the previous density) for the first 2 iteration. In addition, if
the HOMO - LUMO gap is small and the Fock matrix somewhat diagonally
dominant, then level-shifting is automatically initiated. There are a
variety of ways to customize this procedure to whatever is desired.

An alternative optimization strategy is to specify, by using the change
in total energy (from iterations when N and N-1), when to turn damping,
level-shifting, and/or DIIS on/off. Start and stop keywords for each of
these is available as,

` CONVERGENCE  [dampon <real dampon default 0.0>] \`  
`              [dampoff <real dampoff default 0.0>] \`  
`              [diison <real diison default 0.0>] \`  
`              [diisoff <real diisoff default 0.0>] \`  
`              [levlon <real levlon default 0.0>] \`  
`              [levloff <real levloff default 0.0>]`

So, for example, damping, DIIS, and/or level-shifting can be turned
on/off as desired.

Another strategy can be to simply specify how many iterations (cycles)
you wish each type of procedure to be used. The necessary keywords to
control the number of damping cycles (ncydp), the number of DIIS cycles
(ncyds), and the number of level-shifting cycles (ncysh) are input as,

` CONVERGENCE  [ncydp <integer ncydp default 2>] \`  
`              [ncyds <integer ncyds default 30>] \`  
`              [ncysh <integer ncysh default 0>]`

The amount of damping, level-shifting, time at which level-shifting is
automatically imposed, and Fock matrices used in the DIIS extrapolation
can be modified by the following keywords

` CONVERGENCE  [damp <integer ndamp default 0>] \`  
`              [diis [nfock <integer nfock default 10>]] \`  
`              [lshift <real lshift default 0.5>] \`  
`              [hl_tol <real hl_tol default 0.1>]]`

Damping is defined to be the percentage of the previous iterations
density mixed with the current iterations density. So, for example

` CONVERGENCE damp 70`

would mix 30% of the current iteration density with 70% of the previous
iteration density.

Level-Shifting is defined as the amount of shift applied to the diagonal
elements of the unoccupied block of the Fock matrix. The shift is
specified by the keyword lshift. For example the directive,

` CONVERGENCE lshift 0.5`

causes the diagonal elements of the Fock matrix corresponding to the
virtual orbitals to be shifted by 0.5 a.u. By default, this
level-shifting procedure is switched on whenever the HOMO-LUMO gap is
small. Small is defined by default to be 0.05 au but can be modified by
the directive hl\_tol. An example of changing the HOMO-LUMO gap
tolerance to 0.01 would be,

` CONVERGENCE hl_tol 0.01`

Direct inversion of the iterative subspace with extrapolation of up to
10 Fock matrices is a default optimization procedure. For large
molecular systems the amount of available memory may preclude the
ability to store this number of <img alt="$N^2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/4c87ee198ded31321f89b44a38a0ad5a.svg?invert_in_darkmode&sanitize=true" align=middle width="21.47871pt" height="26.70657pt"/> arrays in global memory. The
user may then specify the number of Fock matrices to be used in the
extrapolation (must be greater than three (3) to be effective). To set
the number of Fock matrices stored and used in the extrapolation
procedure to 3 would take the form,

` CONVERGENCE diis 3`

The user has the ability to simply turn off any optimization procedures
deemed undesirable with the obvious keywords,

` CONVERGENCE [nodamping] [nodiis] [nolevelshifting]`

For systems where the initial guess is very poor, the user can try using
fractional occupation of the orbital levels during the initial cycles of
the SCF convergence (A. D. Rabuck and G. E. Scuseria, J. Chem. Phys
110,695 (1999)). The input has the following form

` CONVERGENCE rabuck [n_rabuck <integer n_rabuck default 25>]]`

where the optional value n\_rabuck determines the number of SCF cycles
during which the method will be active. For example, to set equal to 30
the number of cycles where the Rabuck method is active, you need to use
the following line

` CONVERGENCE rabuck 30`

## CDFT -- Constrained DFT

This option enables the constrained DFT formalism by Wu and Van Voorhis
described in the paper: Q. Wu, T. Van Voorhis, Phys. Rev. A 72, 024502
(2005).

` CDFT `<integer fatom1 latom1>` [`<integer fatom2 latom2>`] (charge||spin `<real constaint_value>`) \`  
`      [pop (becke||mulliken||lowdin) default lowdin]`

Variables fatom1 and latom1 define the first and last atom of the group
of atoms to which the constraint will be applied. Therefore the atoms in
the same group should be placed continuously in the geometry input. If
fatom2 and latom2 are specified, the difference between group 1 and 2
(i.e. 1-2) is constrained.

The constraint can be either on the charge or the spin density (\# of
alpha - beta electrons) with a user specified constraint\_value. Note:
No gradients have been implemented for the spin constraints case.
Geometry optimizations can only be performed using the charge
constraint.

To calculate the charge or spin density, the Becke, Mulliken, and Lowdin
population schemes can be used. The Lowdin scheme is default while the
Mulliken scheme is not recommended. If basis sets with many diffuse
functions are used, the Becke population scheme is recommended.

Multiple constraints can be defined simultaniously by defining multiple
cdft lines in the input. The same population scheme will be used for all
constraints and only needs to be specified once. If multiple population
options are defined, the last one will be used. When there are
convergence problems with multiple constraints, the user is advised to
do one constraint first and to use the resulting orbitals for the next
step of the constrained calculations.

It is best to put "convergence nolevelshifting" in the dft directive to
avoid issues with gradient calculations and convergence in CDFT. Use
orbital swap to get a broken-symmetry solution.

An input example is given below.

`geometry`  
`symmetry`  
` C  0.0  0.0  0.0`  
` O  1.2  0.0  0.0`  
` C  0.0  0.0  2.0`  
` O  1.2  0.0  2.0`  
`end`  
`basis`  
` * library 6-31G*`  
`end`  
`dft`  
` xc b3lyp`  
` convergence nolevelshifting`  
` odft`  
` mult 1`  
` vectors swap beta 14 15`  
` cdft 1 2 charge 1.0`  
`end`  
`task dft`

## SMEAR -- Fractional Occupation of the Molecular Orbitals

The SMEAR keyword is useful in cases with many degenerate states near
the HOMO (eg metallic clusters)

` SMEAR <real smear default 0.001>`

This option allows fractional occupation of the molecular orbitals. A
Gaussian broadening function of exponent smear is used as described in
the paper: R.W. Warren and B.I. Dunlap, Chem. Phys. Letters 262, 384
(1996). The user must be aware that an additional energy term is added
to the total energy in order to have energies and gradients consistent.

## FON -- Calculations with fractional numbers of electrons

  - Restricted

fon partial 3 electrons 1.8 filled 2

Here 1.8 electrons will be equally divided over 3 valence orbitals and 2
orbitals are fully filled. The total number of electrons here is 5.8

Example input:

`echo`  
`title "carbon atom"`  
`start carbon_fon`  
`geometry units angstrom nocenter`  
`symmetry c1`  
`  C   0.0 0.0 0.0`  
`end`  
`basis`  
` * library 6-31G`  
`end`  
`dft`  
` direct`  
` grid xfine`  
` convergence energy 1d-8`  
` xc pbe0`  
` fon partial 3 electrons 1.8 filled 2`  
`end`  
`task dft energy`

  - Unrestricted

fon alpha partial 3 electrons 0.9 filled 2 fon beta partial 3 electrons
0.9 filled 2

Here 0.9 electrons will be equally divided over 3 alpha valence orbitals
and 2 alpha orbitals are fully filled. Similarly for beta. The total
number of electrons here is 5.8

Example input:

`echo`  
`title "carbon atom"`  
`start carbon_fon`  
`geometry units angstrom nocenter`  
`symmetry c1`  
` C   0.0 0.0 0.0`  
`end`  
`basis`  
` * library 6-31G`  
`end`  
`dft`  
` odft`  
` fon alpha partial 3 electrons 0.9 filled 2`  
` fon beta partial 3 electrons 0.9 filled 2`  
`end`  
`task dft energy`

To set fractional numbers in the core orbitals, add the following
directive in the input file:

  - set dft:core\_fon .true.

Example input:

`dft`  
` print "final vectors analysis"`  
` odft`  
` direct`  
` fon alpha partial 2 electrons 1.0 filled 2`  
` fon beta partial 2 electrons 1.0 filled 2`  
` xc pbe0`  
` convergence energy 1d-8`  
`end`  
`task dft`

## OCCUP -- Controlling the occupations of molecular orbitals

Example:

`echo`  
`start h2o_core_hole`  
`memory 1000 mb`  
`geometry units au`  
` O 0       0        0`  
` H 0       1.430   -1.107`  
` H 0      -1.430   -1.107`  
`end`  
`basis`  
` O library 6-31g*`  
` H library 6-31g*`  
`end`  
`occup   `  
` 6 6 # core-hole in beta`  
` 1.0 0.0`  
` 1.0 1.0`  
` 1.0 1.0`  
` 1.0 1.0`  
` 1.0 1.0`  
` 0.0 0.0`  
`end`  
`dft`  
` odft`  
` mult 1`  
` xc beckehandh`  
`end`  
`task dft`

## GRID -- Numerical Integration of the XC Potential

` GRID [(xcoarse||coarse||medium||fine||xfine) default medium] \`  
`      [(gausleg||lebedev ) default lebedev ] \`  
`      [(becke||erf1||erf2||ssf) default erf1] \`  
`      [(euler||mura||treutler) default mura] \`  
`      [rm <real rm default 2.0>] \`  
`      [nodisk]`

A numerical integration is necessary for the evaluation of the
exchange-correlation contribution to the density functional. The default
quadrature used for the numerical integration is an Euler-MacLaurin
scheme for the radial components (with a modified Mura-Knowles
transformation) and a Lebedev scheme for the angular components. Within
this numerical integration procedure various levels of accuracy have
been defined and are available to the user. The user can specify the
level of accuracy with the keywords; xcoarse, coarse, medium, fine, and
xfine. The default is medium.

` GRID [xcoarse||coarse||medium||fine||xfine]`

Our intent is to have a numerical integration scheme which would give us
approximately the accuracy defined below regardless of molecular
composition.

<center>

|         |                              |
| ------- | ---------------------------- |
| Keyword | Total Energy Target Accuracy |
| xcoarse | <img alt="$1x10^{-4}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/e9204e6ea06c5d60eb28d4f0d8dbf698.svg?invert_in_darkmode&sanitize=true" align=middle width="50.689155pt" height="26.70657pt"/>                |
| coarse  | <img alt="$1x10^{-5}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/06402e7d4ac92f15928568757dcca7c1.svg?invert_in_darkmode&sanitize=true" align=middle width="50.689155pt" height="26.70657pt"/>                |
| medium  | <img alt="$1x10^{-6}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f8b99c7c9adab0a75d75d910a35583b4.svg?invert_in_darkmode&sanitize=true" align=middle width="50.689155pt" height="26.70657pt"/>                |
| fine    | <img alt="$1x10^{-7}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/419ab033df52905a0129c4813abc9c5b.svg?invert_in_darkmode&sanitize=true" align=middle width="50.689155pt" height="26.70657pt"/>                |
| xfine   | <img alt="$1x10^{-8}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/8658f05cb7be04ba551e8e6d9a85d8a4.svg?invert_in_darkmode&sanitize=true" align=middle width="50.689155pt" height="26.70657pt"/>                |
|  |

</center>

In order to determine the level of radial and angular quadrature needed
to give us the target accuracy we computed total DFT energies at the LDA
level of theory for many homonuclear atomic, diatomic and triatomic
systems in rows 1-4 of the periodic table. In each case all bond lengths
were set to twice the Bragg-Slater radius. The total DFT energy of the
system was computed using the converged SCF density with atoms having
radial shells ranging from 35-235 (at fixed 48/96 angular quadratures)
and angular quadratures of 12/24-48/96 (at fixed 235 radial shells). The
error of the numerical integration was determined by comparison to a
"best" or most accurate calculation in which a grid of 235 radial points
48 theta and 96 phi angular points on each atom was used. This
corresponds to approximately 1 million points per atom. The following
tables were empirically determined to give the desired target accuracy
for DFT total energies. These tables below show the number of radial and
angular shells which the DFT module will use for for a given atom
depending on the row it is in (in the periodic table) and the desired
accuracy. Note, differing atom types in a given molecular system will
most likely have differing associated numerical grids. The intent is to
generate the desired energy accuracy (with utter disregard for speed).

<center>

|         |        |         |
| ------- | ------ | ------- |
| Keyword | Radial | Angular |
| xcoarse | 21     | 194     |
| coarse  | 35     | 302     |
| medium  | 49     | 434     |
| fine    | 70     | 590     |
| xfine   | 100    | 1202    |
|  |

Program default number of radial and angular shells empirically
determined for Row 1 atoms (Li <img alt="$\rightarrow$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/e5d134f35dc4949fab12ec64d186248a.svg?invert_in_darkmode&sanitize=true" align=middle width="16.377075pt" height="14.10255pt"/> F) to reach the desired
accuracies.

</center>

<center>

|         |         |
| ------- | ------- |
| Radial  | Angular |
| xcoarse | 42      |
| coarse  | 70      |
| medium  | 88      |
| fine    | 123     |
| xfine   | 125     |
|  |

Program default number of radial and angular shells empirically
determined for Row 2 atoms (Na <img alt="$\rightarrow$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/e5d134f35dc4949fab12ec64d186248a.svg?invert_in_darkmode&sanitize=true" align=middle width="16.377075pt" height="14.10255pt"/> Cl) to reach the desired
accuracies.

</center>

<center>

|         |         |
| ------- | ------- |
| Radial  | Angular |
| xcoarse | 75      |
| coarse  | 95      |
| medium  | 112     |
| fine    | 130     |
| xfine   | 160     |
|  |

Program default number of radial and angular shells empirically
determined for Row 3 atoms (K <img alt="$\rightarrow$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/e5d134f35dc4949fab12ec64d186248a.svg?invert_in_darkmode&sanitize=true" align=middle width="16.377075pt" height="14.10255pt"/> Br) to reach the desired
accuracies.

</center>

<center>

|         |         |
| ------- | ------- |
| Radial  | Angular |
| xcoarse | 84      |
| coarse  | 104     |
| medium  | 123     |
| fine    | 141     |
| xfine   | 205     |
|  |

Program default number of radial and angular shells empirically
determined for Row 4 atoms (Rb <img alt="$\rightarrow$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/e5d134f35dc4949fab12ec64d186248a.svg?invert_in_darkmode&sanitize=true" align=middle width="16.377075pt" height="14.10255pt"/> I) to reach the desired
accuracies.

</center>

### Angular grids

In addition to the simple keyword specifying the desired accuracy as
described above, the user has the option of specifying a custom
quadrature of this type in which ALL atoms have the same grid
specification. This is accomplished by using the gausleg keyword.

#### Gauss-Legendre angular grid

` GRID gausleg <integer nradpts default 50> <integer nagrid default 10>`

In this type of grid, the number of phi points is twice the number of
theta points. So, for example, a specification of,

` GRID gausleg 80 20`

would be interpreted as 80 radial points, 20 theta points, and 40 phi
points per center (or 64000 points per center before pruning).

#### Lebedev angular grid

A second quadrature is the Lebedev scheme for the angular
components11.6. Within this numerical integration procedure various
levels of accuracy have also been defined and are available to the user.
The input for this type of grid takes the form,

` GRID lebedev `<integer radpts >` `<integer iangquad >

In this context the variable iangquad specifies a certain number of
angular points as indicated by the table below:

<center>

|              |                 |       |
| ------------ | --------------- | ----- |
| <img alt="$IANGQUAD$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/1155c630b831ae7b88cb7f5dea440245.svg?invert_in_darkmode&sanitize=true" align=middle width="100.81599pt" height="22.38192pt"/> | <img alt="$N_{angular}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d8da1653fe865d485d10dc0e3051ed3f.svg?invert_in_darkmode&sanitize=true" align=middle width="60.64839pt" height="22.38192pt"/> | <img alt="$l$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/2f2322dff5bde89c37bcae4116fe20a8.svg?invert_in_darkmode&sanitize=true" align=middle width="5.2088685pt" height="22.74591pt"/> |
| 1            | 38              | 9     |
| 2            | 50              | 11    |
| 3            | 74              | 13    |
| 4            | 86              | 15    |
| 5            | 110             | 17    |
| 6            | 146             | 19    |
| 7            | 170             | 21    |
| 8            | 194             | 23    |
| 9            | 230             | 25    |
| 10           | 266             | 27    |
| 11           | 302             | 29    |
| 12           | 350             | 31    |
| 13           | 434             | 35    |
| 14           | 590             | 41    |
| 15           | 770             | 47    |
| 16           | 974             | 53    |
| 17           | 1202            | 59    |
| 18           | 1454            | 65    |
| 19           | 1730            | 71    |
| 20           | 2030            | 77    |
| 21           | 2354            | 83    |
| 22           | 2702            | 89    |
| 23           | 3074            | 95    |
| 24           | 3470            | 101   |
| 25           | 3890            | 107   |
| 26           | 4334            | 113   |
| 27           | 4802            | 119   |
| 28           | 5294            | 125   |
| 29           | 5810            | 131   |
|  |

List of Lebedev quadratures

</center>

Therefore the user can specify any number of radial points along with
the level of angular quadrature (1-29).

The user can also specify grid parameters specific for a given atom
type: parameters that must be supplied are: atom tag and number of
radial points. As an example, here is a grid input line for the water
molecule

`grid lebedev 80 11 H 70 8  O 90 11`

### Partitioning functions

`GRID [(becke||erf1||erf2||ssf) default erf1]`

  - becke : A. D. Becke, J. Chem. Phys. 88, 1053 (1988).
  - ssf : R.E.Stratmann, G.Scuseria and M.J.Frisch, Chem. Phys. Lett.
    257, 213 (1996).
  - erf1 : modified ssf
  - erf2 : modified ssf

Erf<img alt="$n$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode&sanitize=true" align=middle width="9.83004pt" height="14.10255pt"/> partioning functions

<img alt="$\begin{array}{lcl}&#10;  w_A(r) &amp; = &amp; \prod_{B\neq A}\frac{1}{2} \left[1 \ - \ erf(\mu^\prime_{AB})\right] \\&#10;  \mu^\prime_{AB} &amp; = &amp; \frac{1}{\alpha} \ \frac{\mu_{AB}}{(1-\mu_{AB}^2)^n} \\&#10;  \mu_{AB} &amp; = &amp; \frac{{\mathbf r}_A - {\mathbf r}_B} {\left|{\mathbf r}_A - {\mathbf r}_B \right|}&#10;\end{array}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/a6929e5f4f1fbe470b2d9bf0fe184888.svg?invert_in_darkmode&sanitize=true" align=middle width="268.96155pt" height="75.55119pt"/>

### Radial grids

` GRID [[euler||mura||treutler]  default mura]`

  - euler : Euler-McLaurin quadrature wih the transformation devised by
    C.W. Murray, N.C. Handy, and G.L. Laming, Mol. Phys.78, 997 (1993).
  - mura : Modification of the Murray-Handy-Laming scheme by M.E.Mura
    and P.J.Knowles, J Chem Phys 104, 9848 (1996) (we are not using the
    scaling factors proposed in this paper).
  - treutler : Gauss-Chebyshev using the transformation suggested by
    O.Treutler and R.Alrhichs, J.Chem.Phys 102, 346 (1995).

### Disk usage for Grid

` NODISK`

This keyword turns off storage of grid points and weights on disk.

## TOLERANCES -- Screening tolerances

` TOLERANCES [[tight] [tol_rho <real tol_rho default 1e-10>] \`  
`             [accCoul <integer accCoul default 8>] \`  
`             [radius <real radius default 25.0>]]`

The user has the option of controlling screening for the tolerances in
the integral evaluations for the DFT module. In most applications, the
default values will be adequate for the calculation, but different
values can be specified in the input for the DFT module using the
keywords described below.

The input parameter accCoul is used to define the tolerance in Schwarz
screening for the Coulomb integrals. Only integrals with estimated
values greater than <img alt="$10^{(-accCoul)}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/564fa44e7bfa893835654c63524ec3fd.svg?invert_in_darkmode&sanitize=true" align=middle width="84.27243pt" height="29.12679pt"/> are evaluated.

` TOLERANCES accCoul <integer accCoul default 8>`

Screening away needless computation of the XC functional (on the grid)
due to negligible density is also possible with the use of,

` TOLERANCES tol_rho <real tol_rho default 1e-10>`

XC functional computation is bypassed if the corresponding density
elements are less than tol\_rho.

A screening parameter, radius, used in the screening of the Becke or
Delley spatial weights is also available as,

` TOLERANCES radius <real radius default 25.0>`

where radius is the cutoff value in bohr.

The tolerances as discussed previously are insured at convergence. More
sleazy tolerances are invoked early in the iterative process which can
speed things up a bit. This can also be problematic at times because it
introduces a discontinuity in the convergence process. To avoid use of
initial sleazy tolerances the user can invoke the tight option:

` TOLERANCES tight`

This option sets all tolerances to their default/user specified values
at the very first
iteration.

## DIRECT, SEMIDIRECT and NOIO -- Hardware Resource Control

` DIRECT||INCORE`  
` SEMIDIRECT [filesize `<integer filesize default disksize>`]`  
`            [memsize  `<integer memsize default available>`]`  
`            [filename <string filename default $file_prefix.aoints$]`  
` NOIO`

The inverted charge-density and exchange-correlation matrices for a DFT
calculation are normally written to disk storage. The user can prevent
this by specifying the keyword noio within the input for the DFT
directive. The input to exercise this option is as follows,

`  noio`

If this keyword is encountered, then the two matrices (inverted
charge-density and exchange-correlation) are computed \`\`on-the-fly''
whenever needed.

The INCORE option is always assumed to be true but can be overridden
with the option DIRECT in which case all integrals are computed
\`\`on-the-fly''.

The SEMIDIRECT option controls caching of integrals. A full description
of this option is described in User Manual 10.8. Some functionality
which is only compatible with the DIRECT option will not, at present,
work when using SEMIDIRECT.

## ODFT and MULT -- Open shell systems

` ODFT`  
` MULT <integer mult default 1>`

Both closed-shell and open-shell systems can be studied using the DFT
module. Specifying the keyword MULT within the DFT directive allows the
user to define the spin multiplicity of the system. The form of the
input line is as follows;

`  MULT <integer mult default 1>`

When the keyword MULT is specified, the user can define the integer
variable mult, where mult is equal to the number of alpha electrons
minus beta electrons, plus 1.

When MULT is set to a negative number. For example, if MULT = -3, a
triplet calculation will be performed with the beta electrons
preferentially occupied. For MULT = 3, the alpha electrons will be
preferentially occupied.

The keyword ODFT is unnecessary except in the context of forcing a
singlet system to be computed as an open shell system (i.e., using a
spin-unrestricted wavefunction).

## CGMIN -- Quadratic convergence algorithm

The cgmin keyword will use the quadratic convergence algorithm. It is
possible to turn the use of the quadratic convergence algorithm off with
the nocgmin keyword.

## RODFT -- Restricted open-shell DFT

The rodft keyword will perform restricted open-shell calculations. This
keyword can only be used with the CGMIN keyword.

## SIC -- Self-Interaction Correction

`sic [perturbative || oep || oep-loc `

<default perturbative>

\]

The Perdew and Zunger (see J. P. Perdew and A. Zunger, Phys. Rev. B 23,
5048 (1981)) method to remove the self-interaction contained in many
exchange-correlation functionals has been implemented with the Optimized
Effective Potential method (see R. T. Sharp and G. K. Horton, Phys. Rev.
90, 317 (1953), J. D. Talman and W. F. Shadwick, Phys. Rev. A 14, 36
(1976)) within the Krieger-Li-Iafrate approximation (J. B. Krieger, Y.
Li, and G. J. Iafrate, Phys. Rev. A 45, 101 (1992); 46, 5453 (1992); 47,
165 (1993)) Three variants of these methods are included in NWChem:

  - sic perturbative This is the default option for the sic directive.
    After a self-consistent calculation, the Kohn-Sham orbitals are
    localized with the Foster-Boys algorithm (see section 10.15) and the
    self-interaction energy is added to the total energy. All
    exchange-correlation functionals implemented in the NWChem can be
    used with this option.
  - sic oep With this option the optimized effective potential is built
    in each step of the self-consistent process. Because the
    electrostatic potential generated for each orbital involves a
    numerical integration, this method can be expensive.
  - sic oep-loc This option is similar to the oep option with the
    addition of localization of the Kohn-Sham orbitals in each step of
    the self-consistent process.

With oep and oep-loc options a xfine grid (see section 11.10) must be
used in order to avoid numerical noise, furthermore the hybrid
functionals can not be used with these options. More details of the
implementation of this method can be found in J. Garza, J. A. Nichols
and D. A. Dixon, J. Chem. Phys. 112, 7880 (2000). The components of the
sic energy can be printed out using:

`print "SIC information"`

## MULLIKEN -- Mulliken analysis

Mulliken analysis of the charge distribution is invoked by the keyword:

` MULLIKEN`

When this keyword is encountered, Mulliken analysis of both the input
density as well as the output density will occur. For example, to
perform a mulliken analysis and print the explicit population analysis
of the basis functions, use the following

`dft`  
` mulliken`  
` print "mulliken ao"`  
`end`  
`task dft`

## FUKUI -- Fukui Indices

Fukui inidces analysis is invked by the keyword:

` FUKUI`

When this keyword is encounters, the condensed Fukui indices will be
calculated and printed in the output. Detailed information about the
analysis can be obtained using the following

` dft`  
`   fukui`  
`   print "Fukui information"`  
` end`  
` task dft`

## BSSE -- Basis Set Superposition Error

Particular care is required to compute BSSE by the counter-poise method
for the DFT module. In order to include terms deriving from the
numerical grid used in the XC integration, the user must label the ghost
atoms not just bq, but bq followed by the given atomic symbol. For
example, the first component needed to compute the BSSE for the water
dimer, should be written as follows

`geometry h2o autosym units au`  
` O        0.00000000     0.00000000     0.22143139`  
` H        1.43042868     0.00000000    -0.88572555`  
` H       -1.43042868     0.00000000    -0.88572555`  
` bqH      0.71521434     0.00000000    -0.33214708`  
` bqH     -0.71521434     0.00000000    -0.33214708`  
` bqO      0.00000000     0.00000000    -0.88572555`  
`end`  
`basis`  
` H library aug-cc-pvdz`  
` O library aug-cc-pvdz`  
` bqH library H aug-cc-pvdz`  
` bqO library O aug-cc-pvdz`  
`end`

Please note that the \`\`ghost'' oxygen atom has been labeled bqO, and
not just bq.

## DISP -- Empirical Long-range Contribution (vdW)

` DISP `  
`      [ vdw <real vdw integer default 2]]`  
`      [[s6 `<real s6 default depends on XC functional>`] \`  
`      [ alpha <real s6 default 20.0d0] \`  
`      [ off ] \`

When systems with high dependence on van der Waals interactions are
computed, the dispersion term may be added empirically through
long-range contribution DFT-D, i.e. <img alt="$E_{DFT-D}=E_{DFT-KS}+E_{disp}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d77ef4554f554b6ea525e8857f0dd78e.svg?invert_in_darkmode&sanitize=true" align=middle width="217.894545pt" height="22.38192pt"/>,
where:

<img alt="$E_{disp}=-s_6\sum^{N_{atom}-1}_{i=1}\sum^{N_{atom}}_{j=i+1} \frac{C_{6}^{ij}}{R_{ij}^{6}} \left( 1+e^{-\alpha (R_{ij}/R_{vdw}-1)} \right)^{-1}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/3666d4a12cd1c98a47524620f9a0e3c5.svg?invert_in_darkmode&sanitize=true" align=middle width="425.340795pt" height="39.36735pt"/>

In this equation, the <img alt="$s_6$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/e9349752e05540dee73fddefcedf36f1.svg?invert_in_darkmode&sanitize=true" align=middle width="14.20485pt" height="14.10255pt"/> term depends in the functional and basis
set used, <img alt="$C_6^{ij}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/1d08f5f7b2ad785243464d2366c2de89.svg?invert_in_darkmode&sanitize=true" align=middle width="23.59599pt" height="30.9705pt"/> is the dispersion coefficient between pairs of
atoms. <img alt="$R_{vdw}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/999715cd04ee6ac29e6dfbacdae8273d.svg?invert_in_darkmode&sanitize=true" align=middle width="35.99871pt" height="22.38192pt"/> and <img alt="$R_{ij}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/52acdd56bf90ef8224aaf3db0446f911.svg?invert_in_darkmode&sanitize=true" align=middle width="23.15016pt" height="22.38192pt"/> are related with van der Waals atom
radii and the nucleus distance respectively. The <img alt="$\alpha$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/c745b9b57c145ec5577b82542b2df546.svg?invert_in_darkmode&sanitize=true" align=middle width="10.537065pt" height="14.10255pt"/> value
contributes to control the corrections at intermediate distances.

There are available three ways to compute   *C<sup>6</sup><sub>ij</sub>:* 

1.  <img alt="$C_6^{ij}= \,\! \frac{2(C_6^{i}C_6^{j})^{2/3}(N_{eff i}N_{eff j})^{1/3}} {C_6^{i}(N_{eff i}^2)^{1/3}+(C_6^{i}N_{eff j}^2)^{1/3}}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/5bf882455a6d3bcb9b85b665b64325fe.svg?invert_in_darkmode&sanitize=true" align=middle width="216.419445pt" height="39.53334pt"/>  
where *N<sub>eff</sub>* and *C<sub>6</sub>* are obtained from Q. Wu and W. Yang,
J. Chem. Phys. 116 515 (2002) and U. Zimmerli, M Parrinello and P.
Koumoutsakos J. Chem. Phys. 120 2693 (2004). (Use vdw 0)  

2.  <img alt="$C_6^{ij}=2\,\!\frac{C_6^{i}C_6^{j}}{C_6^{i}+C_6^{j}}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/05c8b505216f0ee8c8f4b944f827a35b.svg?invert_in_darkmode&sanitize=true" align=middle width="98.800185pt" height="39.36735pt"/>. See details in S. Grimme J. Comp. Chem. 25 1463 (2004). (Use vdw 1)  

3.  <img alt="$C_6^{ij}=\sqrt{C_6^{i}C_6^{j}}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/c0dafc8fd3d85bac68dd41116a615d55.svg?invert_in_darkmode&sanitize=true" align=middle width="101.74065pt" height="42.19875pt"/> See details in S. Grimme J. Comp. Chem. 271787 (2006). (Use vdw 2)  

Note that in each option there is a certain set of <img alt="$C_6$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/b1a57ffb35b6053ddad04400a4b2a017.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> and
<img alt="$R_{vdw}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/999715cd04ee6ac29e6dfbacdae8273d.svg?invert_in_darkmode&sanitize=true" align=middle width="35.99871pt" height="22.38192pt"/>. ALso note that Grimme only defined parameters for elements
up to Z=54 for the dispersion correction above. <img alt="$C_6$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/b1a57ffb35b6053ddad04400a4b2a017.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> values for
elements above Z=54 have been set to zero.

For options vdw 1 and vdw 2 , there are <img alt="$s_6$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/e9349752e05540dee73fddefcedf36f1.svg?invert_in_darkmode&sanitize=true" align=middle width="14.20485pt" height="14.10255pt"/> values by default for
some functionals and triple-zeta plus double polarization basis set
(TZV2P):

  - vdw 1. BLYP 1.40, PBE 0.70 and BP86 1.30.
  - vdw 2. BLYP 1.20, PBE 0.75, BP86 1.05, B3LYP 1.05, Becke97-D 1.25
    and TPSS 1.00.

Grimme's DFT-D3 is also available. Here the dispersion term has the
following
form:

<img alt="$E_{disp}=\sum_{ij}\sum_{n=6,8} s_{n} \frac{C_{n}^{ij}}{R_{ij}^{n}} \left( 1+6(R_{ij}/(s_{r,n} R^{ij}_{0}))^-\alpha_{n}\right)^{-1}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/14898efab2ad476cd83e15161536a456.svg?invert_in_darkmode&sanitize=true" align=middle width="402.963495pt" height="44.45628pt"/>

This new dispersion correction covers elements through Z=94.
<img alt="$C^{ij}_{n} (n=6,8)$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/4ac510c831b43d15c8ac9326e45069b3.svg?invert_in_darkmode&sanitize=true" align=middle width="92.56137pt" height="27.10224pt"/> are coordination and geometry dependent. Details
about the functional form can be found in S. Grimme, J. Antony, S.
Ehrlich, H. Krieg, J. Chem. Phys. 132, 154104 (2010).

To use the Grimme DFT-D3 dispersion correction, use the option

  - vdw 3 (s6 and alpha cannot be set manually). Functionals for which
    DFT-D3 is available in NWChem are BLYP, B3LYP, BP86, Becke97-D,
    PBE96, TPSS, PBE0, B2PLYP, BHLYP, TPSSH, PWB6K, B1B95, SSB-D,
    MPW1B95, MPWB1K, M05, M05-2X, M06L, M06, M06-2X, and M06HF

<!-- end list -->

  - vdw 4 triggers the DFT-D3BJ dispersion model. Currently only BLYP,
    B3LYP, BHLYP, TPSS, TPSSh,  B2-PLYP, B97-D, BP86, PBE96, PW6B95, revPBE, B3PW91, pwb6k, b1b95, CAM-B3LYP, LC-wPBE,  HCTH120, MPW1B95, BOP, OLYP,  BPBE, OPBE and SSB  are supported.

This capability is also supported for energy gradients and Hessian. Is
possible to be deactivated with OFF.

## NOSCF --Non Self-Consistent Calculations

The noscf keyword allows one to calculate the non self-consistent energy
for a set of input vectors. For example, the following input shows how a
non self-consistent B3LYP energy can be calculated using a
self-consistent set of vectors calculated at the Hartree-Fock level.

`start h2o-noscf`

`geometry units angstrom`  
`  O      0.00000000     0.00000000     0.11726921`  
`  H      0.75698224     0.00000000    -0.46907685`  
`  H     -0.75698224     0.00000000    -0.46907685`  
`end`

`basis spherical`  
` * library aug-cc-pvdz`  
`end`  
`dft`  
` xc hfexch`  
` vectors output hf.movecs `  
`end`  
`task dft energy`  
`dft`  
` xc b3lyp`  
` vectors input hf.movecs `  
` noscf `  
`end`  
`task dft energy`

## XDM -- Exchange-hole dipole moment dispersion model

`XDM `  
`      [ a1 `<real a1>` ]   [ a2 `<real a2>` ]`

See details (including list of a1 and a2 parameters) in A.
Otero-de-la-Roza and E. R. Johnson, J. Chem. Phys. 138, 204109 (2013)
and the website <http://gatsby.ucmerced.edu/wiki/XDM>

    geometry 
      O         -0.190010095135     -1.168397415155      0.925531922479
      H         -0.124425719598     -0.832776238160      1.818190662986
      H         -0.063897685990     -0.392575837594      0.364048725248
      O          0.174717244879      1.084630474836     -0.860510672419
      H         -0.566281023931      1.301941006866     -1.427261487135
      H          0.935093179777      1.047335209207     -1.441842151158
    end
    
    basis spherical
      * library aug-cc-pvdz
    end
    
    dft
       direct
       xc b3lyp
       xdm a1 0.6224 a2 1.7068
    end
    
    task dft optimize

## Print Control

` PRINT||NOPRINT`

The PRINT||NOPRINT options control the level of output in the DFT.
Please see some examples using this directive in [Sample input
file](#Sample_input_file "wikilink"). Known controllable print options
are:

<center>

|                            |                 |                                                      |
| -------------------------- | --------------- | ---------------------------------------------------- |
| **Name**                   | **Print Level** | **Description**                                      |
| "all vector symmetries"    | high            | symmetries of all molecular orbitals                 |
| "alpha partner info"       | high            | unpaired alpha orbital analysis                      |
| "common"                   | debug           | dump of common blocks                                |
| "convergence"              | default         | convergence of SCF procedure                         |
| "coulomb fit"              | high            | fitting electronic charge density                    |
| "dft timings"              | high            |                                                      |
| "final vectors"            | high            |                                                      |
| "final vectors analysis"   | high            | print all orbital energies and orbitals              |
| "final vector symmetries"  | default         | symmetries of final molecular orbitals               |
| "information"              | low             | general information                                  |
| "initial vectors"          | high            |                                                      |
| "intermediate energy info" | high            |                                                      |
| "intermediate evals"       | high            | intermediate orbital energies                        |
| "intermediate fock matrix" | high            |                                                      |
| "intermediate overlap"     | high            | overlaps between the alpha and beta sets             |
| "intermediate S2"          | high            | values of S2                                         |
| "intermediate vectors"     | high            | intermediate molecular orbitals                      |
| "interm vector symm"       | high            | symmetries of intermediate orbitals                  |
| "io info"                  | debug           | reading from and writing to disk                     |
| "kinetic\_energy"          | high            | kinetic energy                                       |
| "mulliken ao"              | high            | mulliken atomic orbital population                   |
| "multipole"                | default         | moments of alpha, beta, and nuclear charge densities |
| "parameters"               | default         | input parameters                                     |
| "quadrature"               | high            | numerical quadrature                                 |
| "schwarz"                  | high            | integral screening info & stats at completion        |
| "screening parameters"     | high            | integral accuracies                                  |
| "semi-direct info"         | default         | semi direct algorithm                                |
|  |

DFT Print Control Specifications

</center>

# Spin-Orbit Density Functional Theory (SODFT)

The spin-orbit DFT module (SODFT) in the NWChem code allows for the
variational treatment of the one-electron spin-orbit operator within the
DFT framework. The implementation requires the definition of an
effective core potential (ECP) and a matching spin-orbit potential (SO).
The current implementation does NOT use symmetry.

The actual SODFT calculation will be performed when the input module
encounters the TASK directive ([TASK](Top-level#TASK "wikilink")).

` TASK SODFT`

Input parameters are the same as for the DFT. Some of the DFT options
are not available in the SODFT. These are max\_ovl and sic.

Besides using the standard ECP and basis sets, see [Effective Core
Potentials](ECP "wikilink") for details, one also has to specify a
spin-orbit (SO) potential. The input specification for the SO potential
can be found in [Effective Core
Potentials](ECP#Spin-orbit_ECPs "wikilink"). At this time we have not
included any spin-orbit potentials in the basis set library.

Note: One should use a combination of ECP and SO potentials that were
designed for the same size core, i.e. don't use a small core ECP
potential with a large core SO potential (it will produce erroneous
results).

Also, note that charge fitting basis sets will not work with spin-orbit
calculations.

The following is an example of a calculation of <img alt="$UO_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/06f075d510ceac444f473cefd7f488b2.svg?invert_in_darkmode&sanitize=true" align=middle width="31.993995pt" height="22.38192pt"/>:

`start uo2_sodft`  
`echo`  
`Memory 32 mw`  
`charge 2`  
`geometry noautoz noautosym units angstrom`  
` U     0.00000      0.00000     0.00000`  
` O     0.00000      0.00000     1.68000`  
` O     0.00000      0.00000    -1.68000`  
`end`  
`basis "ao basis" cartesian print`  
`U    S`  
`       12.12525300         0.02192100`  
`        7.16154500        -0.22516000`  
`        4.77483600         0.56029900`  
`        2.01169300        -1.07120900`  
`U    S`  
`        0.58685200         1.00000000`  
`U    S`  
`        0.27911500         1.00000000`  
`U    S`  
`        0.06337200         1.00000000`  
`U    S`  
`        0.02561100         1.00000000`  
`U    P`  
`       17.25477000         0.00139800`  
`        7.73535600        -0.03334600`  
`        5.15587800         0.11057800`  
`        2.24167000        -0.31726800`  
`U    P`  
`        0.58185800         1.00000000`  
`U    P`  
`        0.26790800         1.00000000`  
`U    P`  
`        0.08344200         1.00000000`  
`U    P`  
`        0.03213000         1.00000000`  
`U    D`  
`        4.84107000         0.00573100`  
`        2.16016200        -0.05723600`  
`        0.57563000         0.23882800`  
`U    D`  
`        0.27813600         1.00000000`  
`U    D`  
`        0.12487900         1.00000000`  
`U    D`  
`        0.05154800         1.00000000`  
`U    F`  
`        2.43644100         0.35501100`  
`        1.14468200         0.40084600`  
`        0.52969300         0.30467900`  
`U    F`  
`        0.24059600         1.00000000`  
`U    F`  
`        0.10186700         1.00000000`  
`O    S`  
`       47.10551800        -0.01440800`  
`        5.91134600         0.12956800`  
`        0.97648300        -0.56311800`  
`O    S`  
`        0.29607000         1.00000000`  
`O    P`  
`       16.69221900         0.04485600`  
`        3.90070200         0.22261300`  
`        1.07825300         0.50018800`  
`O    P`  
`        0.28418900         1.00000000`  
`O    P`  
`        0.07020000         1.00000000`  
`END`  
`ECP`  
` U nelec 78`  
` U s`  
`   2          4.06365300        112.92010300`  
`   2          1.88399500         15.64750000`  
`   2          0.88656700         -3.68997100`  
` U p`  
`   2          3.98618100        118.75801600`  
`   2          2.00016000         15.07722800`  
`   2          0.96084100          0.55672000`  
` U d`  
`   2          4.14797200         60.85589200`  
`   2          2.23456300         29.28004700`  
`   2          0.91369500          4.99802900`  
` U f`  
`   2          3.99893800         49.92403500`  
`   2          1.99884000        -24.67404200`  
`   2          0.99564100          1.38948000`  
` U g`  
`   2          3.81742200        -36.04097700`  
`   2          0.26250100          -0.09051100`  
` O nelec 2`  
` O s`  
`   2         10.44567000         50.77106900`  
` O p`  
`   2         18.04517400         -4.90355100`  
` O d`  
`   2          8.16479800         -3.31212400`  
`END`  
`SO`  
` U p`  
` 2    3.986181      1.816350`  
` 2    2.000160     11.543940`  
` 2    0.960841      0.794644`  
` U d`  
` 2    4.147972      0.353683`  
` 2    2.234563      3.499282`  
` 2    0.913695      0.514635`  
` U f`  
` 2    3.998938      4.744214`  
` 2    1.998840     -5.211731`  
` 2    0.995641      1.867860`  
`END`  
`dft`  
` mult 1`  
` xc hfexch`  
` odft`  
` grid fine`  
` convergence energy 1.000000E-06`  
` convergence density 1.000000E-05`  
` convergence gradient 1E-05`  
` iterations 100`  
` mulliken`  
`end`  
`task sodft`
