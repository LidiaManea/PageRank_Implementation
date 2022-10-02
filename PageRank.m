function [R1, R2] = PageRank(file, d, eps)
    fid = fopen(file, 'r');
    line = fgets(fid);
    N = str2double(line);
    i = 1;
    while (i <= N) %am trecut peste matrice fara sa memorez datele
        line = fgets(fid);
        i = i + 1;
    end
    line = fgets(fid);
    val1 = str2double(line); %am salvat val1 si val2
    line = fgets(fid);
    val2 = str2double(line);
    a = 1/(val2 - val1);
    b = (-1) * val1/(val2 - val1);
    fclose(fid);
    [~, name, ~] = fileparts(file);
    newname = strcat(name, ".out"); %am format numele fisierului
    fid = fopen(newname, "w");
    PR = Iterative(file, d, eps);
    fprintf(fid, '%d\n', N);
    for i=1:N
        fprintf(fid, '%.6f\n', PR(i));
    end
    fprintf(fid, '\n');
    R2 = Algebraic(file, d);
    for i=1:N
        fprintf(fid, '%.6f\n', R2(i));
    end
    fprintf(fid, '\n');
    R1 = R2;
    for i=2:N
        key = R1(i);
        j = i - 1;
        while (j >= 1 & R1(j) < key)
            R1(j + 1) = R1(j);
            j = j - 1;
        end
        R1(j + 1) = key;
    end
    for i=1:N
        fprintf(fid, '%d ', i);
        for j=1:N
            if R1(i) == R2(j)
                fprintf(fid, '%d ', j);
                break;
            end
        end
        if R1(i) < val1
            fprintf(fid, '0.000000');
            fprintf(fid, '\n');
        elseif R1(i) > val2
            fprintf(fid, '1.000000');
            fprintf(fid, '\n');
        else
            fprintf(fid, '%.6f\n', a*R1(i) + b);
        end
    end
    fclose(fid);
end






