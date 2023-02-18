function [Gtot_no_pz] = remove_pz(Gtot)
[z,p,k] = zpkdata(Gtot,'v');
Gtot_no_pz=Gtot;
for row=1:length(z(:,1))
    for column=1:length(z(1,:))
        positive_zero_index{row,column} = find(real(cell2mat(z(row,column)))>0);
        positive_zero{row,column} = [z{row,column}(positive_zero_index{row,column})];
        
        if positive_zero{row,column}
            Gtot_no_pz(row,column)=Gtot(row,column)/tf((zp2tf(positive_zero{row,column},[],1)),1);
        end

    end
end
Gtot_no_pz = minreal(Gtot_no_pz);
% positive_zero_index;
% positive_zero;
% Gtot_no_pz(:,:)
% [z,p_n,k]=zpkdata(Gtot_no_pz,'v');

return;