function R = Iterative(file, d, eps)
    fid = fopen(file, 'r');
    line = fgets(fid);
    N = str2double(line);
    B = zeros(N);
    C = zeros(N);
    i = 1;
    p = 1;
    while (i <= N) %se citeste linie cu linie pentru a parsa matricea
       line = fgets(fid);
       newstrr = split(line, " ");
       i = str2double(newstrr(1)); %numarul nodului
       L(i) = str2double(newstrr(2)); %numarul de vecini
       r = 1;
       J(i) = L(i);
       for k=3:2+L(i)
           if str2double(newstrr(k)) == i %se verifica daca o pagina are link la ea insasi
               J(i) = J(i) - 1; %se micsoreaza numarul de vecini in caz afirmativ
           end
       end
       for j=3:2+L(i) %se construieste matricea pe care se efectueaza operatiile
           k = str2double(newstrr(j));
           C(p, 1) = i;
           r = r + 1;
           C(p, r) = k;
           if k == i 
               B(k, i) = 0;
           else
               B(k, i) = 1/J(i); %se imparte la numarul de linkuri
           end
       end
        B(i, i) = 0;
        i = i + 1;
        p = p + 1;
    end
    fclose(fid);
    flag = 1;
    R = (1/N).*ones(N, 1); %PR la pasul initial
    W = R; %PR la pasul k
    T = R; %PR la pasul k+1
    while flag
        W = T;
        T = ((1 - d)/N).*ones(N, 1) + d.*B*W; %formula matematica pentru aflare PR 
        U = T - W;
        flag = 0; %retine daca s-a atins marja de eroare
        if norm(U) >= eps
            flag = 1;
        end
    end
    R = W;
end

