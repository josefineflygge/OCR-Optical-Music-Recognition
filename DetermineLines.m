function [outRows] = DetermineLines(inRows)
    
    if(length(inRows) > 5) % Staff bar has more than 5 lines detected
        
        for e = 1:length(inRows)-5
            [minDist, index] = min(diff(inRows));
            value = ceil((inRows(index) + inRows(index+1)) /2);
            inRows(index) = value;
            inRows(index+1) = [];
        end   
    elseif(length(inRows) < 5) % Staff bar has less than 5 lines detected
        spaces = diff(inRows);
        medianSpace = median(spaces);
        firstLine = inRows(1);
        inRows = [0; 1; 2; 3; 4] .* medianSpace + firstLine; 
    end
    
        spaces = diff(inRows);
        medianSpace = median(spaces);
        firstLine = inRows(1);
        lastLine = inRows(length(inRows));
        before = [-3; -2; -1] .* medianSpace + firstLine; 
        after = [1; 2;] .* medianSpace + lastLine;
        outLines = [before; inRows; after];
        outMid = zeros(9,1);
        for i = 1:9
            outMid(i) = (outLines(i+1) - outLines(i))/2 + outLines(i);
        end
        
        outRows = zeros(1, 18);
        for i= 1:18
            if(mod(i,2) == 0)
                outRows(i) = outMid(i/2);
            else
                outRows(i) = outLines(i/2 + 1/2);
            end
        end  
        outRows = round(outRows);
    
    
end

