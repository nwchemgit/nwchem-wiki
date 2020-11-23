# QM/MM eref
```
eref <double precision default 0.0d0>
```
This directive sets the relative zero of energy for the QM component of
the system. The need for this directive arises from different
definitions of zero energy for QM and MM methods. In QM methods the zero
of energy for the system is typically vacuum. The zero of energy for the
MM system is by definition of most parameterized force fields the
separated atom energy. Therefore in many cases the energetics of the QM
system will likely overshadow the MM component of the system. This
imbalance can be corrected by suitably chosen value of `eref`. In most
cases *IT IS OK* to leave `eref` at its default value of zero.
