### EPR and Paramagnetic NMR NWChem Tutorial

This tutorial involves tensor/matrix operations,
which can be readily done with [Octave](https://octave.org/),
a GNU license MATLAB-like program,
freely available in any Linux or Cygwin (Windows) distribution.
Octave will be
used to demonstrate tensor manipulation and calculation of g-tensor, A-tensor,
and paramagnetic NMR
parameters obtained from an example NWChem output.  

Example input:
```
echo
start ch3radical_rot
title ch3radical_rot
geometry noautoz units angstrom nocenter
symmetry c1
c +0.00000000 +0.00000000 +0.00000000
h -0.21385373 +0.98738914 +0.39826283
h -0.78597592 -0.69448290 +0.28059107
h +0.09050298 +0.04455726 -1.08102723
end
BASIS "ao basis" PRINT
* library 6-311G
END
relativistic
zora on
zora:cutoff_NMR 1d-8
zora:cutoff 1d-30
end
dft
odft
mult 2
xc b3lyp
end
task dft
property
gshift
hyperfine
shielding
end
task dft property
```

First, the following constants and values are needed:
```
>ge = 2.002319304; Be = 9.27400915e-24; k = 1.3806504e-23; u0 = 4*pi*(10^7);
h = 6.62606896e-34; BN = 5.05078317e-27; gnC = 1.4044;
```
gnC is the nuclear g-factor for a <sup>13</sup>C nucleus;
it is calculated from the measured gyromagnetic ratio
(in 10<sup>6</sup> rad s<sup>-1</sup> T<sup>-1</sup>) for <sup>13</sup>C:
```
>gammaC = 67.262;
>gnC = gammaC*(h/(2*pi))/BN*(10^6);
```
Note that the example system CH<sub>3</sub> ground state is a doublet.
```
>S = 0.5;
```
Since paramagnetic NMR is temperature-dependent, specify a temperature in Kelvin:
```
>T = 305.15;
```
Reconciling the g-tensor from NWChem calculation:
Note that the tensor from a g-shift (&Delta;g) calculation from NWChem is in ppt (parts-per-thousand).
Enter the total &Delta;g (g-shift) tensor into Octave:
```
>GShiftTens = [0.1740 0.2216 -0.2640; 0.2216 0.6888 0.0981; -0.2640
0.0981 0.6542];
```
Transform &Delta;g tensor to g tensor:
```
>GTens = 0.001*GShiftTens + (ge*eye(3))
2.0025e+00 2.2160e-04 -2.6400e-04
2.2160e-04 2.0030e+00 9.8100e-05
-2.6400e-04 9.8100e-05 2.0030e+00
```
Note that `eye(3)` stands for the 3x3 identity matrix (diagonal 1's and off-diagonal 0's).
To obtain gxx, gyy, and gzz from the g tensor matrix, find the eigenvalues of ggT and take the square root of the eigenvalues:
```
>sqrt(eig(GTens*transpose(GTens)))
ans =
2.0023
2.0031
2.0031
```
To obtain g<sub>iso</sub> , take the trace of g and divide by 3:
```
>trace(GTens)/3
2.0028
```
Reconciling the A-tensor from NWChem calculation:
Enter the total A tensor (for convenience use the tensor that is in MHz) for the first carbon atom listed:
```
>ATensC = [428.6293 -58.2145 69.3689;-58.2145 293.3841 -25.7459; 69.3689 -
25.7459 302.4571];
```
Correct this matrix by rotating it into the reference frame of the g-tensor (obtained in the last section):
```
>ATensC_Corr = (ATensC/ge)*GTens
428.651 -58.184 69.332
-58.184 293.477 -25.732
69.332 -25.732 302.546
```
To find Axx, Ayy, Azz, find the eigenvalues of AAT and take the square root of the eigenvalues:
```
> sqrt(eig(ATensC_Corr*transpose(ATensC_Corr)))
ans =
271.88
271.88
480.91
```
To calculate A<sub>iso</sub> , take the trace of the corrected A tensor and divide by 3:
```
>trace(ATensC_Corr)/3
341.56
```
Reconciling the pNMR parameters from NWChem calculation:
Calculate the dipolar form of the corrected A tensor for the carbon atom:
```
>ATensC_Corr_Dip = ATensC_Corr – (trace(ATensC_Corr)/3)*eye(3)
87.093 -58.184 69.332
-58.184 -48.081 -25.732
69.332 -25.732 -39.012
```
For convenience, convert the hyperfine tensors units from MHz to J:
```
>ATensC_Energy = (10^6)*h*ATensC
2.8401e-25 -3.8573e-26 4.5964e-26
-3.8573e-26 1.9440e-25 -1.7059e-26
4.5964e-26 -1.7059e-26 2.0041e-25
>ATensC_Corr_Energy = (10^6)*h*ATensC_Corr
2.8403e-25 -3.8553e-26 4.5940e-26
-3.8553e-26 1.9446e-25 -1.7050e-26
4.5940e-26 -1.7050e-26 2.0047e-25
>ATensC_Corr_Dip_Energy =(10^6)*h*ATensC_Corr_Dip
5.7708e-26 -3.8553e-26 4.5940e-26
-3.8553e-26 -3.1859e-26 -1.7050e-26
4.5940e-26 -1.7050e-26 -2.5850e-26
```
To calculate the Fermi contact shift:
```
>FCShiftC =
(10^6)*trace(GTens)/3*Be/(gnC*BN)*(S*(S+1))/(3*k*T)*trace(ATensC_Energy)/3
FCShiftC = 3.5159e+04
```
To calculate the pseudocontact shift (in ppm):
```
>PCShiftC =
(10^6)*(S*(S+1))/(9*k*T)*Be/(gnC*BN)*trace(ATensC_Corr_Dip_Energy*GTens)
PCShiftC = -1.9008
```
From the shielding calculation in NWChem,
```
>OrbShldC = 83.7136
```
Putting it all together, the total chemical shielding in ppm is:
```
>TotShldC = OrbShldC – FCShiftC – PCShiftC
TotShldC = -3.5074e+04
```
Subtract this value from the appropriate reference to obtain the chemical shift.
We can repeat these steps for the hydrogen atom. The proton nuclear g-factor is:
```
>gnH = 5.5856947
```
The hyperfine A tensor for the hydrogen atom from the NWChem output is:
```
>ATensH = [-39.8498 -17.0675 5.2453; -17.0675 0.9102 23.3706; 5.2453
23.3706 -46.3284];
```
Correct this tensor by transforming it into the reference frame of the g-tensor:
```
>ATensH_Corr = (ATensH/ge)*GTens
-39.85584 -17.07752 5.25143
-17.07196 0.90977 23.38053
5.25445 23.37695 -46.34308
```
Calculate the dipolar form of the corrected A tensor for the H atom:
```
>ATensH_Corr_Dip = ATensH_Corr - (trace(ATensH_Corr))/3*eye(3)
-11.4261 -17.0775 5.2514
-17.0720 29.3395 23.3805
5.2545 23.3770 -17.9134
```
Convert the hyperfine tensors units from MHz to J:
```
>ATensH_Energy = (10^6)*h*ATensH
-2.6405e-26 -1.1309e-26 3.4756e-27
-1.1309e-26 6.0310e-28 1.5486e-26
3.4756e-27 1.5486e-26 -3.0698e-26
>ATensH_Corr_Energy = (10^6)*h*ATensH_Corr
-2.6409e-26 -1.1316e-26 3.4796e-27
-1.1312e-26 6.0282e-28 1.5492e-26
3.4816e-27 1.5490e-26 -3.0707e-26
>ATensH_Corr_Dip_Energy =(10^6)*h*ATensH_Corr_Dip
-7.5710e-27 -1.1316e-26 3.4796e-27
-1.1312e-26 1.9441e-26 1.5492e-26
3.4816e-27 1.5490e-26 -1.1870e-26
```
Calculate the Fermi Contact Shift:
```
>FCShiftH =
(10^6)*trace(GTens)/3*Be/(gnH*BN)*(S*(S+1))/(3*k*T)*trace(ATensH_Energy)/3
FCShiftH = -735.76
```
Calculate the pseudocontact shift:
```
>PCShiftH =
(10^6)*(S*(S+1))/(9*k*T)*Be/(gnH*BN)*trace(ATensH_Corr_Dip_Energy*GTens)
PCShiftH = 0.0032218
```
From the NWChem output, the orbital shielding is:
```
>OrbShldH = 28.1923
```
Putting it all together, the total chemical shielding in ppm is:
```
>TotShldH = OrbShldH - FCShiftH – PCShiftH
TotShldH = 763.95
```