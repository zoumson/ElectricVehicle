function output = constant_price(price, low, high)
    %% This function return a boolean value, True is the portion time period 
    % Electricity price stays the same, that's constant
    % We have 2 prices: low and high
    % we suppose its either only low constant price either only high
    % constant price
    % If successive price are different we know price is not constant
    l = length(price);
    low_out = true;
    high_out = true;
    for i = 1:l
        if(price(i)~=low)
             low_out = false;
             break;
        end


    end
    for i = 1:l
        if(price(i)~=high)
             high_out = false;
             break;
        end


    end
    output = (low_out ||high_out);

end

