function [output1, output2, output3] = price_split(price, g2v, socini, soc_desired, pmax, tslot, cap)
    %% The intervall during EV stay is divided in two, t1 where EV is 
    % modeled as ESS and t2 only charging

    time = length(price);
    int = time - g2v;
    if (int <= 0)
       output1 = 0;
       output2 = price;
       o = (soc_desired-socini)*cap/(pmax*tslot);
       output3 = socini + o*pmax*tslot/cap;
    else
        output1 = price(1:int);
        output2 = price(int+1:time);
        output3 = soc_desired;
    end
end


