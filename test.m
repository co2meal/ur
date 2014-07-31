numeric = csvread('numeric.csv');

disp('loaded!');

r = spconvert(numeric);

disp(size(r));
