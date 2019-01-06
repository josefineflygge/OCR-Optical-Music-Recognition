function [StaffLines] = FindStaffLines(ImLines)
%% Find staff lines
h = sum(ImLines, 2); % Histogram of staff lines

[pks,locs] = findpeaks(h); % Find longest lines

maxLocs = locs(pks > 130); % Find the rows where the peaks have a value greater than 130

%% Find first line and last line in staff bar

% Array containing row number of first staff line and last staff line 
% of every staff bar 
staffArray = [];

% Varibles containing first and last line in a staff bar 
first = 1;
last = 0;

% Go through every line, if there are more than 4 lines in a row with less
% than 15px between every line, it is assumed to be a complete staff bar
% and is divided into a sub image. 
for i = 1:length(maxLocs)-1
    if(maxLocs(i+1) - maxLocs(i)  > 15)
        last = i;
        if(length(maxLocs(first:last)) > 4)
            staffArray = [staffArray; DetermineLines(maxLocs(first:last))];
        end
        first = i+1;
    end
end
    last = i+1;



% Divide the last staff bar aswell, if it contains more than 4 lines
if(length(maxLocs(first:last)) > 4) 
    staffArray = [staffArray; DetermineLines(maxLocs(first:last))];
end

StaffLines = staffArray;


end

