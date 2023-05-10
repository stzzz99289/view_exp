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
    run("run_trail.m");
    
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
    if end_trail
        break;
    else
        continue;
    end
end