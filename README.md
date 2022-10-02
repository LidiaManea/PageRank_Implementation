  Algoritmul PageRank isi propune sa realizeze o ordonare a paginilor
web in functie de importanta lor. Aceasta se bazeaza pe linkurile catre
acea pagina de la alte pagini, adica "noduri vecine".
  Se va implementa in 2 modalitati:
1) iterativ
2) algebric

 Metoda iterativa:
  Aceasta se bazeaza pe relatia de recurenta intre PR la pas anterior
si PR la pas curent. Dupa ce datele au fost luate din fisier, acestea
sunt prelucrate: se construieste matricea de adiacenta, tinandu-se cont
de linkurile unei pagini catre ea insasi. La pasul 0, PR este un vector
alcatuit doar din 1/numar de noduri. Din relatia de recurenta vor fi
aflati vectorii, iar la fiecare etapa se calculeaza si eroarea;
algoritmul se opreste cand norma de PR(t+1)-PR(t) este mai mica decat
epsilon, unde epsilon este dat.

 Metoda algebrica:
  Aceasta se bazeaza pe proprietatile matematice ale matricei de adiacenta.
Deoarece relatiile dintre numarul de noduri si de pagini sunt interdependente,
atunci problema se reduce la a rezolva un sistem de forma Ax=x, unde A este
matricea de adiacenta, x este vectorul de solutii PR. A are o valoare proprie
egala cu 1, deoarece este "column-stochastic" (toate elementele sunt pozitive, 
iar suma tuturor de pe fiecare coloana este 1) (Demonstratia se bazeaza pe
faptul ca A si A^t au aceleasi valori proprii). Asadar, pentru a rezolva
sistemul, se va lua o valoare m care echilibreaza matricea A si matricea
plina de 1. m = 0.15. Astfel, se va rezolva ecuatia x = (1 - m)Ax + ms, unde
1 - m = d, s este un vector coloana plin de 1, iar x este vectorul PR.
Pentru rezolvarea ecuatiei, se descompune B = I - dA cu Gram-Schmidt, iar apoi
se calculeaza inversa acesteia prin sistem superior triunghiular. Astfel,
vectorul x, adica PR, devine (B^-1)*((1-d)/N)*e, unde e este vector coloana
plin de 1.
