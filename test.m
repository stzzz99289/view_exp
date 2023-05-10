letter_lst = 'ABCDFHJKLNPRTVXY';
max_stimu_num = 30;
len = length(letter_lst);
norep_len = 5;

all_indices = 1:len;
display_indices = randperm(len, norep_len);

for i = (norep_len+1):max_stimu_num
    choice_indices = setdiff(all_indices, display_indices(i-norep_len:i-1));
    display_indices(i) = choice_indices(randi([1, len-norep_len], 1));
end
