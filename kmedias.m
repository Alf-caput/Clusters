function cluster = kmedias(x, cluster_est, n, k, p)
% Función que calcula los clusters de un conjunto de puntos de manera no
% jerárquica.
% El algoritmo utilizado es k-medias.
% Inputs:
%   x = matriz que lleva por filas coordenadas de los puntos dato
%   cluster_est = matriz que lleva por filas coordenadas
%   de los clusters estimados
%   n = nº de observaciones
%   k = nº de clusters
%   p = nº de coordenadas de los puntos
% Outputs:
%   cluster = matriz que lleva por filas coordenadas de los clusters 
%   solución
    cluster = zeros(k, p);
    % Primero se asocia cada punto a un cluster, cada punto al
    % clúster que tenga más cerca
    % Para ello se calculan las distancias de todos los puntos a todos los
    % clústers
    U = pdist2(x, cluster_est, 'euclidean');
    % Representamos con una matriz lógica (adyancencia) la pertenencia de 
    % cada punto a un clúster
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