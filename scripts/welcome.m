% show welcome message

% display first welcome instruction
Screen('DrawTexture', wptr, exp_instruction1, []);
Screen('Flip', wptr);

% press space to continue
while 1
    [secs, keycode, deltasecs] = KbStrokeWait;
    if keycode(q_key)
        break;
    end
end

% start one trail
end_trail = false;
while 1
    for practice_num = 1:10
        if exp_type == 1
            display_angle = 0;
        elseif exp_type == 2
            display_angle = angle_pos(practice_num);
        end
        
        run("run_trail.m");
    end
    
    % display second welcome instruction
    Screen('DrawTexture', wptr, exp_instruction2, []);
    Screen('Flip', wptr);

    % press q or p to continue or re-practice
    while 1
        [secs, keycode, deltasecs] = KbStrokeWait;
        if keycode(q_key)
            break;
        elseif keycode(p_key)
            end_trail = true;
            break;
        end
    end

    % end practice or re-practice
    if end_trail
        break;
    else
        continue;
    end
end