function [] = simulink_progress(i)
    fprintf("|");
    if mod(i,5)==0
        fprintf(" ");
    end
    
    if mod(i,10)==0
        fprintf("\n");
    end
end