function output = t_arrival(armin, armax,tslot, ev )
%% Generate Arrival Time in hour
%  Convert Arrival Time in hour to corresponding Time slots
    if (armin == 0 && armax == 0)
        output = ones(1, ev);
    else
        output = (1/tslot)*randi([armin,armax],1, ev);
    end
end


