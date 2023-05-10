% Obtain some information of experiment
prompt = {'被试ID', '姓名', '性别[请填写‘1’或‘2’，1 = 男, 2 = 女]'};
title = '基本信息搜集'; % The title of the dialog box
definput = {'','',''}; % Default input value(s)

% Using inputdlg() to obtain information and save it to cell array
basic_info = inputdlg(prompt,title,[1, 50],definput);