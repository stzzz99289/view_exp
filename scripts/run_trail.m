% run single trail

% randomly shuffle letters before each trail
display_indices = randperm(len, norep_len);
for i = (norep_len+1):max_stimu_num
    choice_indices = setdiff(all_indices, display_indices(i-norep_len:i-1));
    display_indices(i) = choice_indices(randi([1, len-norep_len], 1));
end
display_letters = letter_lst(display_indices);

% display gaze point
bbox = Screen('TextBounds', wptr, '+');
for i = 1:gaze_frames
    % Screen('DrawText', wptr, '+', center_x-radius, center_y+radius, black_color);
    % Screen('DrawDots', wptr, [center_x, center_y], radius, [255 255 255], [], 1);
    Screen('DrawText', wptr, '+', wrect(3)/2-bbox(3)/2, ...
        wrect(4)/2-bbox(4)/2, black_color);
    [~, lastVisualOnset] = Screen('Flip', wptr);
end

% display letters
for i = 1:max_stimu_num
    if i == p1 || i == p2
        disp_color = green_color;
    else
        disp_color = black_color;
    end

    if i == p2
        posx = wrect(3)/2 + (display_angle/view_angle)*wrect(3);
    else
        posx = wrect(3)/2;
    end
    posy = wrect(4)/2;
    bbox = Screen('TextBounds', wptr, display_letters(i));
    Screen('DrawText', wptr, display_letters(i), posx-bbox(3)/2, ...
        posy-bbox(4)/2, disp_color);
    [~, lastVisualOnset] = Screen('Flip', wptr, lastVisualOnset+((stimu_frames - 0.5) * ifi));
end

% display query 1
Screen('DrawTexture', wptr, query1_img, []);
Screen('Flip', wptr);
tic;

% press keys to continue
while 1
    [secs, keycode, deltasecs] = KbPressWait;
    if keycode(space_key)
        pressed_letter1 = 'forget';
        break;
    elseif keycode(zero_key)
        pressed_letter1 = 'None';
        break;
    elseif contains(letter_lst, upper(KbName(find(keycode))))
        pressed_letter1 = upper(KbName(find(keycode)));
        break;
    end
end
respondtime = toc;
exp_data(current_datarow, 10) = num2cell(respondtime);
exp_data(current_datarow, 4) = cellstr(pressed_letter1);

% display query 2
Screen('DrawTexture', wptr, query2_img, []);
Screen('Flip', wptr);
tic;

% press keys to continue
while 1
    [secs, keycode, deltasecs] = KbPressWait;
    if keycode(space_key)
        pressed_letter2 = 'forget';
        break;
    elseif keycode(zero_key)
        pressed_letter2 = 'None';
        break;
    elseif contains(letter_lst, upper(KbName(find(keycode))))
        pressed_letter2 = upper(KbName(find(keycode)));
        break;
    end
end
respondtime = toc;
exp_data(current_datarow, 11) = num2cell(respondtime);
exp_data(current_datarow, 6) = cellstr(pressed_letter2);

trail_count = trail_count + 1;
if mod(trail_count, rest_trails)==0
    % display rest query
    Screen('DrawTexture', wptr, rest_img, []);
    Screen('Flip', wptr);

    % press keys to continue
    while 1
        [secs, keycode, deltasecs] = KbPressWait;
        if keycode(space_key)
            break;
        end
    end
end