
clc
clear
close all

tslot_generated = 5/60;
low_generated = 1.69;
high_generated = 3.62;
low_time_generated = 7.5/tslot_generated;
high_time_generated = 15/tslot_generated; 
last_time_generated = 1.5/tslot_generated;

price_generated = normal_price(low_generated, high_generated,...
    low_time_generated, high_time_generated, last_time_generated);
num_ev_generated = [200, 400, 500];

for monte_generated = 1:3

        for num_generated = 1:numel(num_ev_generated)
                ev_generated = num_ev_generated(num_generated );
                % arrival = randi([2,8],1, ev);
                arrival_generated = randi([2,9],1, ev_generated);
                departure_generated = randi([16,22],1, ev_generated);
                socin_generated = unifrnd(0.4,0.65, 1, ev_generated);
                socmin_generated = unifrnd(0.05,0.1, 1, ev_generated);
                socmax_generated = unifrnd(0.95,1, 1, ev_generated);
                desired_soc_generated = unifrnd(0.85,0.90, 1, ev_generated);

                M_generated = [arrival_generated.',...
                    departure_generated.', socin_generated.',...
                    desired_soc_generated.', socmin_generated.',...
                    socmax_generated.'];

                file_name_generated = strcat('doc_',num2str(monte_generated),...
                    '_ev_', num2str(ev_generated), '.xls');
                writematrix(M_generated,file_name_generated);
                
%                 pathh_generated = strcat('data_', num2str(monte_generated));
%                 cd old_data_ev
%                 new_fold_generated = strcat('data_', num2str(monte_generated));
%                 mkdir(new_fold_generated)
%                 % save(fullfile(tempdir, 'myParityCheck.mat'), 'Data', '-mat');
%                 save(fullfile(pathh_generated,file_name_generated), 'M', '-mat');
%                 cd ..

        end
end

