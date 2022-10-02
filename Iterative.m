function R = Iterative(file, d, eps)
    fid = fopen(file, 'r');
    line = fgets(fid);
    N = str2double(line);
    B = zeros(N);
    C = zeros(N);
    i = 1;
    p = 1;
    while (i <= N) %we parse the matrix line by line
       line = fgets(fid);
       newstrr = split(line, " ");
       i = str2double(newstrr(1)); %node number
       L(i) = str2double(newstrr(2)); %number of neighbors
       r = 1;
       J(i) = L(i);
       for k=3:2+L(i)
           if str2double(newstrr(k)) == i %checks if a page has a link to itself
               J(i) = J(i) - 1; 
           end
       end
       for j=3:2+L(i) %builds the matrix on which the operations are made
           k = str2double(newstrr(j));
           C(p, 1) = i;
           r = r + 1;
           C(p, r) = k;
           if k == i 
               B(k, i) = 0;
           else
               B(k, i) = 1/J(i); %divides by the number of links
           end
       end
        B(i, i) = 0;
        i = i + 1;
        p = p + 1;
    end
    fclose(fid);
    flag = 1;
    R = (1/N).*ones(N, 1); %PR at 0-step
    W = R; %PR at k-step
    T = R; %PR at k+!-step
    while flag
        W = T;
        T = ((1 - d)/N).*ones(N, 1) + d.*B*W; %the mathematical formula for PR
        U = T - W;
        flag = 0; %if there is the certain error, it is retained
        if norm(U) >= eps
            flag = 1;
        end
    end
    R = W;
end

