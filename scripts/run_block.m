trail_count = 0;

if exp_type == 1
    for p1i=1:t1_len
        t2_offset = offset_lst(randperm(t2_len));  % zero offset means that there is no t2
        for p2i=1:t2_len
            if t2_offset(p2i) == 0
                p1 = randperm(21, 1) + 5;
            else
                p1 = t1_pos(p1i);
            end
            p2 = p1 + t2_offset(p2i);
            
            % run trail
            display_angle = 0;
            run("run_trail.m");
    
            % record data
            display_letter1 = display_letters(p1);
            exp_data(current_datarow, 1) = num2cell(block_num);
            exp_data(current_datarow, 2) = num2cell(current_datarow-1);
            exp_data(current_datarow, 3) = cellstr(display_letter1);
            if p1==p2
                display_letter2 = 'None';
            else
                display_letter2 = display_letters(p2);
            end
            exp_data(current_datarow, 5) = cellstr(display_letter2);
            exp_data(current_datarow, 7) = num2cell(t2_offset(p2i));
            correct1 = (display_letter1 == pressed_letter1);
            correct2 = (display_letter2 == pressed_letter2);
            exp_data(current_datarow, 8) = num2cell(logical(sum(correct1)));
            exp_data(current_datarow, 9) = num2cell(logical(sum(correct2)));
            current_datarow = current_datarow + 1;
        end
    end

elseif exp_type == 2
    for p1i=1:2
        p1 = t1_pos(randi(t1_len));
        t2_offset = offset_lst(randperm(t2_len));
        for p2i=1:t2_len
            if t2_offset(p2i) == 0
                p1 = randperm(21, 1) + 5;
            else
                p1 = t1_pos(p1i);
            end
            p2 = p1 + t2_offset(p2i);

            angle_pos = angle_lst(randperm(angle_len));
            for ai=1:angle_len
                % run trail
                display_angle = angle_pos(ai);
                run("run_trail.m");

                % record data
                display_letter1 = display_letters(p1);
                exp_data(current_datarow, 1) = num2cell(block_num);
                exp_data(current_datarow, 2) = num2cell(current_datarow-1);
                exp_data(current_datarow, 3) = cellstr(display_letter1);
                if p1==p2
                    display_letter2 = 'None';
                else
                    display_letter2 = display_letters(p2);
                end
                exp_data(current_datarow, 5) = cellstr(display_letter2);
                exp_data(current_datarow, 7) = num2cell(t2_offset(p2i));
                correct1 = (display_letter1 == pressed_letter1);
                correct2 = (display_letter2 == pressed_letter2);
                exp_data(current_datarow, 8) = num2cell(logical(sum(correct1)));
                exp_data(current_datarow, 9) = num2cell(logical(sum(correct2)));
                current_datarow = current_datarow + 1;
            end
        end
    end

end

