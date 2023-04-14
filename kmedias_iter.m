function [res_clusters, i] = kmedias_iter(x, cluster_est, tol)
    [n, ~] = size(x); % n puntos de p coordenadas
    [k, p] = size(cluster_est); % k clústers de p coordenadas
    cluster = kmedias(x, cluster_est, n, k, p);
    i = 1;
    res_clusters = [cluster_est; cluster];
    dist = pdist2(cluster_est, cluster);
    dist = diag(dist);
    error = mean(dist);
    while error >= tol && i < 5
        cluster_est = cluster;
        cluster = kmedias(x, cluster_est, n, k, p);
        res_clusters = [res_clusters; cluster];
        i = i+1;

        dist = pdist2(cluster_est, cluster);
        dist = diag(dist);
        error = mean(dist);
    end
end