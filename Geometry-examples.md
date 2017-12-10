# Examples of geometries using symmetry

Below are examples of the use of the SYMMETRY directive in the compound
[GEOMETRY directive](Geometry "wikilink"). The z axis is
always the primary rotation axis. When in doubt about which axes and
planes are used for the group elements, the keyword print may be added
to the SYMMETRY directive to obtain this information.

## <img alt="$C_{s}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/65f3c9b1deba7946ded03a6f3ee637a4.svg?invert_in_darkmode&sanitize=true" align=middle width="17.886165pt" height="22.38192pt"/> methanol

The <img alt="$\sigma_h$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f2681289ef765e2c206a33f464717f29.svg?invert_in_darkmode&sanitize=true" align=middle width="17.02536pt" height="14.10255pt"/> plane is the xy plane.

` geometry units angstroms`  
`   C    0.11931097    -0.66334875     0.00000000`  
`   H    1.20599017    -0.87824237     0.00000000`  
`   H   -0.32267592    -1.15740001     0.89812652`  
`   O   -0.01716588     0.78143468     0.00000000`  
`   H   -1.04379735     0.88169812     0.00000000`  
`   symmetry cs`  
` end`

## <img alt="$C_{2v}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/fbae2e8884819f6fd147d3039ef3a9bc.svg?invert_in_darkmode&sanitize=true" align=middle width="25.19517pt" height="22.38192pt"/> water

The z axis is the <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis and the <img alt="$\sigma_v$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/427cc947be21a51a1864c29ff4aea221.svg?invert_in_darkmode&sanitize=true" align=middle width="16.32015pt" height="14.10255pt"/> may be either the xz
or the yz planes.

` geometry units au`  
`   O     0.00000000    0.00000000    0.00000000`  
`   H     0.00000000    1.43042809   -1.10715266`  
`   symmetry group c2v`  
` end`

## <img alt="$D_{2h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/9435721d1c731be00e9a0dbd0129f6a3.svg?invert_in_darkmode&sanitize=true" align=middle width="27.754155pt" height="22.38192pt"/> acetylene

Although acetylene has symmetry <img alt="$D_{\infty h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/ab62aa1e031c2b1c2a67f743473c2abe.svg?invert_in_darkmode&sanitize=true" align=middle width="34.282215pt" height="22.38192pt"/> the subgroup <img alt="$D_{2h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/9435721d1c731be00e9a0dbd0129f6a3.svg?invert_in_darkmode&sanitize=true" align=middle width="27.754155pt" height="22.38192pt"/>
includes all operations that interchange equivalent atoms which is what
determines how much speedup you gain from using symmetry in building a
Fock matrix.

The <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axes are the x, y, and z axes. The σ planes are the xy, xz
and yz planes. Generally, the unique atoms are placed to use the z as
the primary rotational axis and use the xz or yz planes as the σ plane.

` geometry units au`  
`   symmetry group d2h`  
`   C      0.000000000    0.000000000   -1.115108538`  
`   H      0.000000000    0.000000000   -3.106737425`  
` end`

## <img alt="$D_{2h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/9435721d1c731be00e9a0dbd0129f6a3.svg?invert_in_darkmode&sanitize=true" align=middle width="27.754155pt" height="22.38192pt"/> ethylene

The <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axes are the x, y, and z axes. The σ planes are the xy, xz
and yz planes. Generally, the unique atoms are placed to use the z as
the primary rotational axis and use the xz or yz planes as the σ plane.

` geometry units angstroms`  
`   C 0 0 0.659250 `  
`   H 0 0.916366 1.224352 `  
`   symmetry d2h`  
` end`

## <img alt="$T_d$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/dab24416a3b37335c1fa411413282831.svg?invert_in_darkmode&sanitize=true" align=middle width="16.3878pt" height="22.38192pt"/> methane

For ease of use, the primary <img alt="$C_3$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d19cc08043728c4034ea85a9fd4e254f.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis should be the x=y=z axis. The
3 <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axes are the x, y, and z.

` geometry units au`  
`   c   0.0000000      0.0000000      0.0000000`  
`   h   1.1828637      1.1828637      1.1828637`  
`   symmetry group Td`  
` end`

## <img alt="$I_h$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/cb7a60250ec3ed03533037d233e9de6c.svg?invert_in_darkmode&sanitize=true" align=middle width="14.866335pt" height="22.38192pt"/> buckminsterfullerene

One of the <img alt="$C_5$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/c585dc013630a6a779d5f4f39ebefddc.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axes is the z axis and the point of inversion is the
origin.

` geometry units angstroms # Bonds = 1.4445, 1.3945`  
`   symmetry group Ih`  
`   c   -1.2287651   0.0   3.3143121`  
` end`

## <img alt="$S_4$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/26a4b92ab105a03e05a9c71e86316570.svg?invert_in_darkmode&sanitize=true" align=middle width="16.570455pt" height="22.38192pt"/> porphyrin

The <img alt="$S_4$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/26a4b92ab105a03e05a9c71e86316570.svg?invert_in_darkmode&sanitize=true" align=middle width="16.570455pt" height="22.38192pt"/> and <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> rotation axis is the z axis. The reflection
plane for the <img alt="$S_4$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/26a4b92ab105a03e05a9c71e86316570.svg?invert_in_darkmode&sanitize=true" align=middle width="16.570455pt" height="22.38192pt"/> operation is the xy plane.

` geometry units angstroms`  
`    symmetry group s4`  
`    `  
`    fe                0.000  0.000  0.000         `  
`    h                 2.242  6.496 -3.320   `  
`    h                 1.542  4.304 -2.811`  
`    c                 1.947  6.284 -2.433`  
`    c                 1.568  4.987 -2.084`  
`    h                 2.252  8.213 -1.695`  
`    c                 1.993  7.278 -1.458`  
`    h                 5.474 -1.041 -1.143`  
`    c                 1.234  4.676 -0.765`  
`    h                 7.738 -1.714 -0.606`  
`    c                 0.857  3.276 -0.417`  
`    h                 1.380 -4.889 -0.413`  
`    c                 1.875  2.341 -0.234`  
`    h                 3.629  3.659 -0.234`  
`    c                 0.493 -2.964 -0.229`  
`    c                 1.551 -3.933 -0.221`  
`    c                 5.678 -1.273 -0.198`  
`    c                 1.656  6.974 -0.144`  
`    c                 3.261  2.696 -0.100`  
`    n                 1.702  0.990 -0.035`  
` end`

## <img alt="$D_{3h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/2f7f6fe5e3e341910fb9983ce765025f.svg?invert_in_darkmode&sanitize=true" align=middle width="27.754155pt" height="22.38192pt"/> iron penta-carbonyl

The <img alt="$C_3$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d19cc08043728c4034ea85a9fd4e254f.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis. The <img alt="$\sigma_h$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f2681289ef765e2c206a33f464717f29.svg?invert_in_darkmode&sanitize=true" align=middle width="17.02536pt" height="14.10255pt"/> plane is the xy plane.
One of the perpendicular <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axes is the x=y axis. One of the
<img alt="$\sigma_v$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/427cc947be21a51a1864c29ff4aea221.svg?invert_in_darkmode&sanitize=true" align=middle width="16.32015pt" height="14.10255pt"/> planes is the plane containing the x=y axis and the z axis.
(The other axes and planes are generated by the <img alt="$C_3$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d19cc08043728c4034ea85a9fd4e254f.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> operation.)

` geometry units au`  
`   symmetry group d3h`  
`  `  
`   fe        0.0         0.0         0.0`  
`   `  
`   c         0.0         0.0         3.414358`  
`   o         0.0         0.0         5.591323`  
`   `  
`   c         2.4417087   2.4417087   0.0`  
`   o         3.9810552   3.9810552   0.0`  
` end`

## <img alt="$D_{3d}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/256e7cce19415f71329beec53f4f123b.svg?invert_in_darkmode&sanitize=true" align=middle width="26.904405pt" height="22.38192pt"/> sodium crown ether

The <img alt="$C_3$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d19cc08043728c4034ea85a9fd4e254f.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis. The point of inversion is the origin.
One of the perpendicular <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axes is the x=y axis. One of the
<img alt="$\sigma_d$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/0f24297b17130e91cbc7746bbdd78dee.svg?invert_in_darkmode&sanitize=true" align=middle width="16.17561pt" height="14.10255pt"/> planes is the plane containing the -x=y axis and the z
axis.

Note that the oxygen atom is rotated in the x-y plane 15 degrees away
from the y-axis so that it lies in a mirror plane. There is a total of
six atoms generated from the unique oxygen, in contrast to twelve from
each of the carbon and hydrogen atoms.

` geometry units au`  
`   symmetry D3d`  
`   `  
`  NA     .0000000000    .0000000000   .0000000000`  
`  O     1.3384771885   4.9952647969   .1544089284`  
`  H     6.7342048019  -0.6723850379  2.6581562148`  
`  C     6.7599180056  -0.4844977035   .6136583870`  
`  H     8.6497577017   0.0709194071   .0345361934`  
`   `  
` end`

## <img alt="$C_{3v}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/5022ced9d67e7ebea24a9ba38b75d3d6.svg?invert_in_darkmode&sanitize=true" align=middle width="25.19517pt" height="22.38192pt"/> ammonia

The <img alt="$C_3$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d19cc08043728c4034ea85a9fd4e254f.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis. One of the <img alt="$\sigma_v$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/427cc947be21a51a1864c29ff4aea221.svg?invert_in_darkmode&sanitize=true" align=middle width="16.32015pt" height="14.10255pt"/> planes is the
plane containing the x=y axis and the z axis.

` geometry units angstroms`  
`   N 0     0     -0.055 `  
`   H 0.665 0.665 -0.481 `  
`   symmetry c3v`  
` end`

## <img alt="$D_{6h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/46b705bb1aa13bd5015ec8d4fb50f5ae.svg?invert_in_darkmode&sanitize=true" align=middle width="27.754155pt" height="22.38192pt"/> benzene

The <img alt="$C_6$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/b1a57ffb35b6053ddad04400a4b2a017.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis. The point of inversion is the origin.
One of the 6 perpendicular <img alt="$C_{2}'$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f49c513a19452c7794cc88a0196f0762.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="24.66849pt"/> axes is the x=y axis. (-x=y works
as a <img alt="$C_{2}''$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/2ff0fa09a3bd96d0485e4221f22ad76f.svg?invert_in_darkmode&sanitize=true" align=middle width="20.432445pt" height="24.66849pt"/> axis.) The <img alt="$\sigma_h$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f2681289ef765e2c206a33f464717f29.svg?invert_in_darkmode&sanitize=true" align=middle width="17.02536pt" height="14.10255pt"/> plane is the xy plane. The
<img alt="$\sigma_d$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/0f24297b17130e91cbc7746bbdd78dee.svg?invert_in_darkmode&sanitize=true" align=middle width="16.17561pt" height="14.10255pt"/> planes contain the <img alt="$C_{2}''$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/2ff0fa09a3bd96d0485e4221f22ad76f.svg?invert_in_darkmode&sanitize=true" align=middle width="20.432445pt" height="24.66849pt"/> axis and the z axis. The
<img alt="$\sigma_v$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/427cc947be21a51a1864c29ff4aea221.svg?invert_in_darkmode&sanitize=true" align=middle width="16.32015pt" height="14.10255pt"/> planes contain the <img alt="$C_{2}'$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f49c513a19452c7794cc88a0196f0762.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="24.66849pt"/> axis and the z axis.

` geometry units au`  
`   C 1.855 1.855 0 `  
`   H 3.289 3.289 0 `  
`   symmetry D6h`  
` end`

## <img alt="$C_{3h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/29940c43d7c55cdf7bcfe9ba8c4c7351.svg?invert_in_darkmode&sanitize=true" align=middle width="25.90038pt" height="22.38192pt"/> <img alt="$BO_{3}H_{3}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/90e3bb1bf71b296dfa3a9fd3819cacbb.svg?invert_in_darkmode&sanitize=true" align=middle width="53.25474pt" height="22.38192pt"/>

The <img alt="$C_3$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d19cc08043728c4034ea85a9fd4e254f.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis. The <img alt="$\sigma_h$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f2681289ef765e2c206a33f464717f29.svg?invert_in_darkmode&sanitize=true" align=middle width="17.02536pt" height="14.10255pt"/> plane is the xy plane.

` geometry units au`  
`   b 0 0 0 `  
`   o 2.27238285 1.19464491 0.00000000 `  
`   h 2.10895420 2.97347707 0.00000000 `  
`  symmetry C3h`  
` end`

## <img alt="$D_{5d}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/01892e1f9fc6fed8a674536f94de0cd9.svg?invert_in_darkmode&sanitize=true" align=middle width="26.904405pt" height="22.38192pt"/> ferrocene

The <img alt="$C_5$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/c585dc013630a6a779d5f4f39ebefddc.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis. The center of inversion is the origin.
One of the perpendicular <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axes is the x axis. One of the
<img alt="$\sigma_d$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/0f24297b17130e91cbc7746bbdd78dee.svg?invert_in_darkmode&sanitize=true" align=middle width="16.17561pt" height="14.10255pt"/> planes is the yz plane.

` geometry units angstroms`  
`   symmetry d5d`  
`  `  
`   fe 0 0     0 `  
`   c  0 1.194 1.789 `  
`   h  0 2.256 1.789 `  
` end`

## <img alt="$C_{4v}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/205eb6d1ce000d015d4de858df44d8d0.svg?invert_in_darkmode&sanitize=true" align=middle width="25.19517pt" height="22.38192pt"/> <img alt="$SF_{5}Cl$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/6e5aa92a58c16ce8c9eaf25e6d7a6ef9.svg?invert_in_darkmode&sanitize=true" align=middle width="46.98507pt" height="22.74591pt"/>

The <img alt="$C_4$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/60fe977bd0752a4efa88e64770ef019b.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis. The <img alt="$\sigma_v$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/427cc947be21a51a1864c29ff4aea221.svg?invert_in_darkmode&sanitize=true" align=middle width="16.32015pt" height="14.10255pt"/> planes are the yz and
the xz planes. The <img alt="$\sigma_d$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/0f24297b17130e91cbc7746bbdd78dee.svg?invert_in_darkmode&sanitize=true" align=middle width="16.17561pt" height="14.10255pt"/> planes are: 1) the plane containing the
x=y axis and the z axis and 2) the plane containing the -x=y axis and
the z axis.

` geometry units au`  
`   S  0.00000000 0.00000000 -0.14917600 `  
`   Cl 0.00000000 0.00000000  4.03279700 `  
`   F  3.13694200 0.00000000 -0.15321800 `  
`   F  0.00000000 0.00000000 -3.27074500 `  
`  `  
`   symmetry C4v`  
` end`

## <img alt="$C_{2h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/dd474ebcc0f1cdea4583f818b81476da.svg?invert_in_darkmode&sanitize=true" align=middle width="25.90038pt" height="22.38192pt"/> trans-dichloroethylene

The <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis. The origin is the inversion center. The
<img alt="$\sigma_h$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f2681289ef765e2c206a33f464717f29.svg?invert_in_darkmode&sanitize=true" align=middle width="17.02536pt" height="14.10255pt"/> plane is the xy plane.

` geometry units angstroms`  
`   C  0.65051239 -0.08305064 0 `  
`   Cl 1.75249381  1.30491767 0 `  
`   H  1.14820954 -1.04789741 0 `  
`   symmetry C2h`  
` end`

## <img alt="$D_{2d}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/04608c2c218c46f92a2c5998d5bd929a.svg?invert_in_darkmode&sanitize=true" align=middle width="26.904405pt" height="22.38192pt"/> <img alt="$CH_{2}CCH_{2}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/9d0ab2fc2311c7d50cf5a568808b6210.svg?invert_in_darkmode&sanitize=true" align=middle width="79.77156pt" height="22.38192pt"/>

The <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis (z is also the <img alt="$S_4$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/26a4b92ab105a03e05a9c71e86316570.svg?invert_in_darkmode&sanitize=true" align=middle width="16.570455pt" height="22.38192pt"/> axis). The x and y
axes are the perpendicular <img alt="$C_{2}'$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f49c513a19452c7794cc88a0196f0762.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="24.66849pt"/>s. The <img alt="$\sigma_d$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/0f24297b17130e91cbc7746bbdd78dee.svg?invert_in_darkmode&sanitize=true" align=middle width="16.17561pt" height="14.10255pt"/> planes are: 1)
the plane containing the x=y axis and the z axis and 2) the plane
containing the -x=y axis and the z axis.

` geometry units angstroms`  
`   symmetry d2d`  
`   c 0     0     0 `  
`   c 0     0     1.300 `  
`   h 0.656 0.656 1.857 `  
` end`

## <img alt="$D_{5h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/e7ffbadf88dafada2cbfab62df846d59.svg?invert_in_darkmode&sanitize=true" align=middle width="27.754155pt" height="22.38192pt"/> cyclopentadiene anion

The <img alt="$C_5$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/c585dc013630a6a779d5f4f39ebefddc.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis (z is also the <img alt="$S_5$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/2a8dec627a0c73f9adb52acbbc1c26d6.svg?invert_in_darkmode&sanitize=true" align=middle width="16.570455pt" height="22.38192pt"/> axis). The y axis
is one of the perpendicular <img alt="$C_2$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/85f3e1190907b9a8e94ce25bec4ec435.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axes. The <img alt="$\sigma_h$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f2681289ef765e2c206a33f464717f29.svg?invert_in_darkmode&sanitize=true" align=middle width="17.02536pt" height="14.10255pt"/> plane is the
xy plane and one of the <img alt="$\sigma_d$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/0f24297b17130e91cbc7746bbdd78dee.svg?invert_in_darkmode&sanitize=true" align=middle width="16.17561pt" height="14.10255pt"/> planes is the yz plane.

` charge -1`  
` geometry units angstroms`  
`   symmetry d5h`  
`   c 0 1.1853 0 `  
`   h 0 2.2654 0 `  
` end`

## <img alt="$D_{4h}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/ebe412def5675dc95e216199b0eade82.svg?invert_in_darkmode&sanitize=true" align=middle width="27.754155pt" height="22.38192pt"/> gold tetrachloride

The <img alt="$C_4$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/60fe977bd0752a4efa88e64770ef019b.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="22.38192pt"/> axis is the z axis (z is also the <img alt="$S_4$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/26a4b92ab105a03e05a9c71e86316570.svg?invert_in_darkmode&sanitize=true" align=middle width="16.570455pt" height="22.38192pt"/> axis). The
<img alt="$C_{2}'$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f49c513a19452c7794cc88a0196f0762.svg?invert_in_darkmode&sanitize=true" align=middle width="18.232995pt" height="24.66849pt"/> axes are the x and y axes and the <img alt="$C_{2}''$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/2ff0fa09a3bd96d0485e4221f22ad76f.svg?invert_in_darkmode&sanitize=true" align=middle width="20.432445pt" height="24.66849pt"/> axes are the
x=y axis and the x=-y axis. The inversion center is the origin. The
<img alt="$\sigma_h$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/f2681289ef765e2c206a33f464717f29.svg?invert_in_darkmode&sanitize=true" align=middle width="17.02536pt" height="14.10255pt"/> plane is the xy plane. The <img alt="$\sigma_v$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/427cc947be21a51a1864c29ff4aea221.svg?invert_in_darkmode&sanitize=true" align=middle width="16.32015pt" height="14.10255pt"/> planes are the xz
and yz planes and the <img alt="$\sigma_d$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/0f24297b17130e91cbc7746bbdd78dee.svg?invert_in_darkmode&sanitize=true" align=middle width="16.17561pt" height="14.10255pt"/> planes are 1) the plane containing
the x=-y axis and the z axis and 2) the plane containing the x=y axis
and the z axis.

` geometry units au`  
`   Au 0 0     0 `  
`   Cl 0 4.033 0`  
`   symmetry D4h`  
` end`