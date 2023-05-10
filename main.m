% set sync test level
Screen('Preference', 'SkipSyncTests', 0);   
Screen('Preference', 'VisualDebugLevel', 0);

% reset the environment
clear;
clc;
sca;

% define screen id
screenid = 0;

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
screen_lst = [0]; % same order as in windows display settings
screen_num = 1;
first_id = screen_lst(1);
width = 1920;
total_width = width*screen_num;
height = 1080;
% wrect = [0 0 total_width height]; % assume all displays are the same
view_angle = 26; % view angle of single display (in degrees)
total_angle = view_angle*screen_num / 2;
radius = 30; % radius of letter in pixels

% define some color rgb values
black_color = [0 0 0];
white_color = [255 255 255];
green_color = [0 255 0];
gray_color = [128 128 128];

% letters lag and pos params
exp_type = 1;
if exp_type == 1
    offset_lst = [0 1 2 3 4 5 6 7 8];
    angle_lst = [0];
elseif exp_type == 2
    offset_lst = [1 2 4 8];
    angle_lst = [-10 -5 0 5 10];
elseif exp_type == 3
    offset_lst = [1 2 4 8];
    angle_lst = [-20 -15 -10 10 15 20];
elseif exp_type == 4
    offset_lst = [1 2 4 8];
    angle_lst = [-30 -25 -20 20 25 30];
end
t1_len = 13;
t2_len = length(offset_lst);
t1_pos = randperm(t1_len)+5;
p1 = 10;
p2 = 15;

% initialize experiment data
exp_data = cell(t1_len*t2_len+1, 8);
current_datarow = 1;
exp_data(current_datarow, :) = {'trail_index', 'GroundTruth1', 'Result1', ...
    'GrounTruth2', 'Result2', 'lag', 'Correct1', 'Correct2'};
current_datarow = current_datarow + 1;


% perform experiment
try

    % get info
    run("scripts/get_info.m");

    % Open a grey backgound window
    [wptr, wrect] = Screen('OpenWindow', screenid, gray_color, ...
        [width 0 width*2 height]);
    [center_x, center_y] = RectCenter(wrect);

    % Preparation for querys
    query1_img = Screen('MakeTexture', wptr, imread('./pictures/query3.tiff'));
    query2_img = Screen('MakeTexture', wptr, imread('./pictures/query4.tiff'));
    exp_instruction1 = Screen('MakeTexture', wptr, imread('./pictures/query1.tiff'));
    exp_instruction2 = Screen('MakeTexture', wptr, imread('./pictures/query2.tiff'));
    rest_img = Screen('MakeTexture', wptr, imread('./pictures/query5.tiff'));

    % set and get some screen parameters
    ifi = Screen('GetFlipInterval', wptr);
    gaze_frames = round(gaze_time / ifi); 
    stimu_frames = round(stimu_time / ifi);
    Screen('TextFont', wptr, 'Arial');
    Screen('TextSize', wptr, 48);

    % experiment preparation
    % HideCursor;

    % set letters and run welcome
    display_indices = randperm(len, norep_len);
    for i = (norep_len+1):max_stimu_num
        choice_indices = setdiff(all_indices, display_indices(i-norep_len:i-1));
        display_indices(i) = choice_indices(randi([1, len-norep_len], 1));
    end
    display_letters = letter_lst(display_indices);
    run("scripts/welcome.m");

    % run 2 blocks
    for block_num = 1:2
        run('scripts/run_block.m');
    end

    ShowCursor;
    sca;
    
catch
    ShowCursor;
    sca;
    psychrethrow(psychlasterror);
end
