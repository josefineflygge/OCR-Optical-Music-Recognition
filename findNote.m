function [noteStr] = findNote(rows, notePos, rythm)
    maxSpace = max(diff(rows));
    noteNames = ["E4"; "D4"; "C4"; 
                "B3"; "A3"; "G3"; "F3"; "E3"; "D3"; "C3"; 
                "B2"; "A2"; "G2"; "F2"; "E2"; "D2"; "C2"; 
                "B1"; "A1"; "G1"];

    [val, index] = min(abs(rows-notePos));
    if(val < maxSpace)
        if(rythm > 1)
            noteStr = '';
        elseif(rythm > 0)
            noteStr = lower(noteNames(index)); 
        else
            noteStr = noteNames(index);  
        end
    else
        noteStr = '';
    end
    
end

