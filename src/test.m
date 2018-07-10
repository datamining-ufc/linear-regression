%% MULTIPLE LINEAR REGRESSION 

%% INPUT DATA
dataset_name = 'data/dataset.csv';
fprintf("Reading data...\n")
T = readtable(dataset_name)
[rows, columns] = size(T);
y = T{:, columns};
T_X = T(:, 1:columns-1);

%% VARIABLE SELECTION

%% FORWARD SELECTION
fprintf("Applying forward selection...\n")
vars1 = forward_selection(T_X, y); 
display(vars1)

%% BACKWARD SELECTION
fprintf("Applying backward selection...\n")
vars2 = backward_selection(T_X, y);
display(vars2)