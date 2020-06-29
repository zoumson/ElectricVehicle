function rank = priority_charge(socini, desired_soc, ti, tf, pmin, tslot, ev)
%% EV Charging prioriy is calculated by applying the formulae below
% Function 
    pmin = abs(pmin);
    function y = prior(socini, desired_soc, ti, tf, pmin, tslot)

            y = (socini - desired_soc)*pmin/(tslot*(tf - ti));

            y = 1/y;
    end

    y = zeros(1,ev);
    for i = 1:ev
        y(i) = prior(socini(i), desired_soc(i), ti(i), tf(i), pmin, tslot);
    end
    ytot = sum(y);
    p = zeros(1,ev);
    for i = 1:ev
        p(i) = y(i)/abs(ytot);
    end
% Priority Indices are returned
    [~,  rank] = sort(p,'descend');

end



