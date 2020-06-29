function output = t_departure(depmin, depmax,tslot, ev )
%% Generate Departure Time in hour
%  Convert Departure Time in hour to corresponding Time slots
    if (depmin == 0 && depmax == 0)
        output = ones(1, ev);
    else
        output = (1/tslot)*randi([depmin,depmax],1, ev);
    end
end

