function output = soc_end_v2g(soci, pow, cap, tslot)
    %% EV is modeled as ESS during time period t1, during the following time t2
    % period EV is charged only
    % This function calculates the soc progress during t1 period 
    % Then select the last soc value to be used for charging during t2
    time = length(pow);
    et = zeros(time, 1);
    if(isempty(pow))
        output = soci;
    else
    for i = 1:time
        if (i == 1)
            et(i) = v2g_soc(soci, pow(i), cap, tslot);

        else
            et(i) = v2g_soc(et(i-1), pow(i), cap, tslot);
        end
    end

    output = et(end);

    end
end


