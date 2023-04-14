function cluster = kmedias_nojer(x, cluster_est)
% Función que calcula los clusters de un conjunto de puntos de manera no
% jerárquica.
% El algoritmo utilizado es k-medias.
% Inputs:
%   x = matriz que lleva por filas coordenadas de los puntos dato
%   cluster_est = matriz que lleva por filas coordenadas
%                 de los clusters estimados
% Outputs:
%   cluster = matriz que lleva por filas coordenadas de clusters solución
% El error se calcula como la distancia media entre clusters entre
% iteraciones.
% (Cada distancia será del i-ésimo clúster con el i-ésimo clúster de la 
% iteración anterior).
    [n, ~] = size(x); % n puntos de p coordenadas
    [k, p] = size(cluster_est); % k clústers de p coordenadas
    cluster = cluster_est;
    % Primero se asocia cada punto a un cluster, asociando cada punto al
    % clúster que tenga más cerca.
    % Para ello se calculan las distancias de todos los puntos a todos los
    % clústers
    U = pdist2(x, cluster_est, 'euclidean');
    % Y se asocia con una matriz lógica la pertenencia de cada punto
    % Si el i-ésimo punto pertenece al j-ésimo clúster se representa con
    % un uno en la posición i,j y el resto de la fila será de ceros
    for i = 1:n
        [~, index] = min(U(i, :));
        U(i, :) = 0;
        U(i, index) = 1;
    end
    % Se calcula el nuevo clúster calculando el centroide de los puntos
    % asociados al clúster estimado
    for i = 1:k
        for j = 1:p
            cluster(i, j) = sum(U(:, i).*x(:, j)) / sum(U(:, i));
        end
    end
end