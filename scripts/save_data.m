% save data
data_table = cell2table(exp_data(2:end, :), 'VariableNames', exp_data(1, :));
if isunix
    datafile = append('../data/', datestr(now, 'yyyymmdd-'), 'id', ...
    string(basic_info(1)), '.csv');
else
    datafile = append('..\data\', datestr(now, 'yyyymmdd-'), 'id', ...
    string(basic_info(1)), '.csv');
end
writetable(data_table, datafile);