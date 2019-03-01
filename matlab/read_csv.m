function T = read_csv(filename)
% READ_CSV reads a FILENAME (source path) in 
% a table form.
% REF: https://www.mathworks.com/help/matlab/ref/readtable.html
    T = readtable(filename);
end
