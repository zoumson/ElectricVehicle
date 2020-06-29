function rank = priority_discharge(socini, socmin, ti, tf, pmax, tslot, ev)
%% EV DisCharging prioriy is calculated by applying the formulae below
% Function 
    function y = priordis(socini, socmin, ti, tf, cap, tslot)

        if socini == socmin
            y =0;
        else
            y = (socini - socmin)*cap*tslot*(tf - ti);
        end

    end

    z = zeros(1,ev);
    for i = 1:ev
        z(i) = priordis(socini(i), socmin(i), ti(i), tf(i), pmax, tslot);

    end



    ztot = sum(z);
    pp = zeros(1,ev);
    for i = 1:ev
        pp(i) = z(i)/ztot;
    end
% Priority Indices are returned
    [~,  rank] = sort(pp,'descend');


end

