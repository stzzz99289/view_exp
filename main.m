% set sync test level
Screen('Preference', 'SkipSyncTests', 0);   
Screen('Preference', 'VisualDebugLevel', 0);

% reset the environment
clear;
clc;
sca;

% trail params
gaze_time = 12 / 60;
stimu_time = 6 / 60;
max_stimu_num = 30;
letter_lst = 'ABCDFHJKLNPRTVXY';
len = length(letter_lst);
norep_len = 5;
all_indices = 1:len;
trail_count = 0;

% define keys
KbName('UnifyKeyNames');
left_key = KbName('LeftArrow');
right_key = KbName('RightArrow');
esc_key = KbName('escape');
return_key = KbName('return');
space_key = KbName('space');
num_keys = [KbName('1') KbName('2') KbName('3') KbName('4') ...
    KbName('5') KbName('6') KbName('7') KbName('8') KbName('9')];
zero_key = KbName('0');
q_key = KbName('Q');
p_key = KbName('P');

% define letter keys
letter_keys = zeros(1, length(letter_lst));
for i = 1:length(letter_lst)
    letter_keys(i) = KbName(letter_lst(i));
end

% define screen info
screenid = 0;
width = 1920;
height = 1080;
view_angle = 196.5; % view angle of window in degrees
display_angle = 0; % current letter display angle

% define some color rgb values
black_color = [0 0 0];
white_color = [255 255 255];
green_color = [0 255 0];
gray_color = [128 128 128];

% set experiment specific params
exp_type = 2;
if exp_type == 1
    offset_lst = [1 2 3 4 5 6 7 8];  % possible values of lag between T1 and T2
    angle_lst = [0];
    total_block_num = 2;
    rest_trails = 39;
    t1_len = 13;
    t2_len = length(offset_lst);
    data_row_num = total_block_num*(t1_len*t2_len)+1;

    welcome_img = Screen('MakeTexture', wptr, imread('./pictures/exp1_welcome.tiff'));
    welcome_end_img = Screen('MakeTexture', wptr, imread('./pictures/exp1_welcome_end.tiff'));

elseif exp_type == 2
    offset_lst = [1 2 4 8];  % possible values of lag between T1 and T2
    angle_lst = [-30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30];
    total_block_num = 10;
    rest_trails = 130;
    t1_len = 13;
    t2_len = length(offset_lst);
    angle_len = length(angle_lst);
    data_row_num = total_block_num*(2*t2_len*angle_len)+1;

    welcome_img = Screen('MakeTexture', wptr, imread('./pictures/exp2_welcome.tiff'));
    welcome_end_img = Screen('MakeTexture', wptr, imread('./pictures/exp2_welcome_end.tiff'));
end
t1_pos = randperm(t1_len)+5;
angle_pos = angle_lst(randperm(angle_len));
p1 = 10;
p2 = 15;

% initialize experiment data
data_column_num = 11;
exp_data = cell(data_row_num, data_column_num);
current_datarow = 1;

% write data header
exp_data(current_datarow, :) = {'BlockIndex', 'TrailIndex', 'GroundTruth1', 'Result1', ...
    'GrounTruth2', 'Result2', 'lag', 'Correct1', 'Correct2', 'RespondTime1', 'RespondTime2'};
current_datarow = current_datarow + 1;

% perform experiment
try

    % get info
    run("scripts/get_info.m");

    % Open a grey backgound window
    development = true;
    if development
        [wptr, wrect] = Screen('OpenWindow', screenid, gray_color, ...
             [width 0 width*2 height]);
        [center_x, center_y] = RectCenter(wrect);
    else
        [wptr, wrect] = Screen('OpenWindow', screenid, gray_color, ...
            [0 0 width height]);
        [center_x, center_y] = RectCenter(wrect); 
    end

    % Preparation for query images
    query1_img = Screen('MakeTexture', wptr, imread('./pictures/letter_query1.tiff'));
    query2_img = Screen('MakeTexture', wptr, imread('./pictures/letter_query2.tiff'));
    rest_img = Screen('MakeTexture', wptr, imread('./pictures/query5.tiff'));

    % set and get some screen parameters
    ifi = Screen('GetFlipInterval', wptr);
    gaze_frames = round(gaze_time / ifi); 
    stimu_frames = round(stimu_time / ifi);
    Screen('TextFont', wptr, 'Arial');
    Screen('TextSize', wptr, 48);

    % experiment preparation
    % HideCursor;

    % run welcome
    run("scripts/welcome.m");

    % run blocks
    for block_num = 1:total_block_num
        run('scripts/run_block.m');
    end

    % save exp data
    run('scripts/save_data.m');

    ShowCursor;
    sca;
    
catch
    ShowCursor;
    sca;
    psychrethrow(psychlasterror);
end
