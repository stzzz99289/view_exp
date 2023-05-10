trail_count = 0;
for p1i=1:t1_len
    t2_offset = offset_lst(randperm(t2_len));  % zero offset means that there is no t2
    for p2i=1:t2_len
        % TODO: introduce iterate over angle
        if t2_offset(p2i) == 0
            p1 = randperm(21, 1) + 5;
        else
            p1 = t1_pos(p1i);
        end
        p2 = p1 + t2_offset(p2i);
        
        % set letters and run trail
        display_indices = randperm(len, norep_len);
        for i = (norep_len+1):max_stimu_num
            choice_indices = setdiff(all_indices, display_indices(i-norep_len:i-1));
            display_indices(i) = choice_indices(randi([1, len-norep_len], 1));
        end
        display_letters = letter_lst(display_indices);
        run("run_trail.m");

        % record data
        display_letter1 = display_letters(p1);
        exp_data(current_datarow, 1) = num2cell(current_datarow-1);
        exp_data(current_datarow, 2) = cellstr(display_letter1);
        if p1==p2
            display_letter2 = 'None';
        else
            display_letter2 = display_letters(p2);
        end
        exp_data(current_datarow, 4) = cellstr(display_letter2);
        exp_data(current_datarow, 6) = num2cell(t2_offset(p2i));
        correct1 = (display_letter1 == pressed_letter1);
        correct2 = (display_letter2 == pressed_letter2);
        exp_data(current_datarow, 7) = num2cell(logical(sum(correct1)));
        exp_data(current_datarow, 8) = num2cell(logical(sum(correct2)));
        current_datarow = current_datarow + 1;
    end
end

% save data
scores_t = cell2table(exp_data(2:end, :), 'VariableNames', exp_data(1, :));
if isunix
    datafile = append('./data/', datestr(now, 'yyyymmdd-'), string(basic_info(1)), ...
    '-block', string(block_num), '.csv');
else
    datafile = append('.\data\', datestr(now, 'yyyymmdd-'), string(basic_info(1)), ...
    '-block', string(block_num), '.csv');
end
writetable(scores_t, datafile);