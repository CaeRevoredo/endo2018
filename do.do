clear all
cd "C:\Users\user\Downloads\BD STATA" 
use BaseENDO2018.dta 
****
*Edad promedio de los docentes de escuelas primarias en zonas rurales?

sum P109_D_01 if Estrato==2
sum P109_D_01 if Estrato==2 [iw= FACTOREXPANSION]  // con factor de expansión

*Sexo docentes escuelas primarias zonas rurales
replace P109_C_01=0 if P109_C_01==2 
sum P109_C_01 if Estrato==2 [iw= FACTOREXPANSION]
tab P109_C_01 if Estrato==2 [iw= FACTOREXPANSION]

*Conexión a internet(acceso)
tab P108A_15  if Estrato==2 [iw= FACTOREXPANSION]

*Computadora o laptop
tab P108A_12 if Estrato==2 [iw= FACTOREXPANSION]

*Nivel educativo del padre (secundario completa o más)
tab P120P if Estrato==2 [iw= FACTOREXPANSION]
g secuo=1
replace secuo=0 if P120P<=5 | P120P==99
tab secuo if Estrato==2 [iw= FACTOREXPANSION]

*Nivel educativo de la madre (secundario completa o más)
g secuom=1
replace secuom=0 if P120M<=5 | P120M==99
tab secuom if Estrato==2 [iw= FACTOREXPANSION]
**Primaria incompleta o menos *** No considera sin instrucción
drop secuom
g secuom=1
replace secuom=0 if P120M==3 | P120M==2
tab secuom if Estrato==2 [iw= FACTOREXPANSION]

*Condición laboral
tab P306B if Estrato==2 [iw= FACTOREXPANSION] //68.8% son nombrados

*Estudios
tab P208_1 if Estrato==2 [iw= FACTOREXPANSION]

*Primera escala de CPM
tab P308 if Estrato==2 [iw= FACTOREXPANSION], m

*Completó carrera en educación en un instituto superior pedagódico
tab P202A if Estrato==2 & P202B==1  [iw= FACTOREXPANSION], m

*Teléfono inteligente
tab P703 if Estrato==2 [iw= FACTOREXPANSION], m 

*Capacitación en TIC
tab P604 if Estrato==2 [iw= FACTOREXPANSION], m 

*
 graph hbar if Estrato==2 [aw= FACTOREXPANSION], over( P701B_1) blabel(bar)

*
grstyle init
grstyle set legend 6, klength(3)
catplot P707_1 [aw= FACTOREXPANSION], over(P109_C_01) asyvars stack percent (P109_C_01) blabel(bar, position(center) format(%3.1f))
*
g obs=_n
longshape P707*, i(obs) j(Question) y(Answer) replace
catplot Answer Question[aw= FACTOREXPANSION] if Estrato==2 , stack asyvars percent(Question) blabel(bar, position(center) format(%3.1f))

catplot Answer Question[aw= FACTOREXPANSION] if Estrato==2 , stack asyvars percent(Question) blabel(bar, position(center) format(%3.1f))legend(rows(1) position(6) size(vsmall) lcolor(black))  ylabel(,labsize(small))

catplot Answer Question[aw= FACTOREXPANSION] if Estrato==2 , stack asyvars percent(Question) blabel(bar, position(center) format(%3.1f))legend(rows(1) position(6) symysize(.5)size(vsmall))  ylabel(,labsize(small)) var2opts(relabel(`r(relabel)') label(labsize(vsmall))) ytitle("%", size(medsmall)) scheme(burd2)


tab P707_1 
