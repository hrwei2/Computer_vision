function [K, R, t] = estimate_params(P)
    % Compute camera center
    [~, ~, V] = svd(P);
    c = V(1:3,end) / V(end,end);
    
    % Compute intrinsic and rotation
    [K,R] = rq(P(:,1:3));
    K = K / K(3,3);
    
    % Compute translation
    t = -R*c;
end


function [R, Q] = rq(A)
    [Q,R] = qr(flipud(A)');
    R = flipud(R');
    R = fliplr(R);
    Q = Q';
    Q = flipud(Q);
    for n = 1:3
        if R(n,n) < 0
            R(:,n) = -R(:,n);
            Q(n,:) = -Q(n,:);
        end
    end
end
