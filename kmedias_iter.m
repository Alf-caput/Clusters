function [cluster, i] = kmedias_iter(x, cluster_est, tol)
    [n, ~] = size(x); % n puntos de p coordenadas
    [k, p] = size(cluster_est); % k clústers de p coordenadas
    cluster = kmedias(x, cluster_est, k, p);
    dist = pdist2(cluster_est, cluster);
    error = mean(diag(dist));
    i = 1;
    while error >= tol
    cluster = kmedias(x, cluster_est, n, k, p);
    dist = pdist2(cluster_est, cluster);
    error = mean(diag(dist));
    i = i+1;
    end
end