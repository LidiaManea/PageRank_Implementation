function R = Algebraic(file, d)
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
           if str2double(newstrr(k)) == i %se verifica daca pagina are link la ea insasi
               J(i) = J(i) - 1; %se micsoreaza numarul de vecini in caz negativ
           end
       end
       for j=3:2+L(i) %se construieste matricea de adiacenta
           k = str2double(newstrr(j));
           C(p, 1) = i;
           r = r + 1;
           C(p, r) = k;
           if k == i
               B(k, i) = 0;
           else
               B(k, i) = 1/J(i);
           end
       end
        B(i, i) = 0;
        i = i + 1;
        p = p + 1;
    end
    fclose(fid);
    I = eye(N) - d*B;
    Q = zeros(N);
    S = zeros(N);
    %am implementat si adaptat algoritmul Gram-Schmidt si rezolvarea
    %sistemului superior triunghiular din laboratoare
    for j=1:N
        for i=1:j-1
            S(i, j) = transpose(Q(:, i)) * I(:, j);
        end
        s = zeros(N, 1);
        s = Q(:, 1:j-1) * S(1:j-1, j);
        aux = I(:, j) - s;
        S(j ,j) = norm(aux);
        Q(:, j) = aux./S(j ,j);   
    end
    M = transpose(Q);
    H = zeros(N, N);
    for i=1:N
        Y = M(:, i);
        X = zeros(N, 1);
        X(N) = Y(N)/S(N, N);
        for j=N - 1:-1:1
             sum = S(j, (j + 1):N) * X((j + 1):N);
             X(j) = (Y(j) - sum)/S(j, j);
        end
        H(:, i) = X;
    end
    e = ones(N, 1);
    R = H*((1-d)/N)*e; %formula matematica pentru PR
end
