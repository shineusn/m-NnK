function [KSTA,KEVNT,WFP,WFS,WFC,WFE,cut,absP,absS,absC,absE,message]=NNK_selectarrivals(out,fen,codafen,secutim,pathtoNNKdtec,pickimportcomand,listefichier,lesstat,zero1,DELTA,pha)

init = zeros(secutim+fen,2) ;
codainit = zeros(secutim+codafen,2) ; 
[KSTA,KEVNT,P,S,C,E,absP,absS,absC,absE]=NNK_getpick(out,[pathtoNNKdtec '/' pickimportcomand],listefichier,lesstat,zero1,DELTA);

% Zeroing P, S and coda windows %%%%%%%
WFP = init ;
WFS = init ;
WFC = codainit ;
WFE = codainit ;
cut = '';

if find(pha=='P') > 0 & numel(P) > 0 % Windowing from P-secutim to P+fen %%%
    indout = [max([1 P-secutim])  min([size(out,1) (P+fen-1)])] ;
    indwf(1) = max([(P-secutim)*(-1) 1])  ;
    indwf(2) = indwf(1)+diff(indout) ;
    WFP(indwf(1):indwf(2),1:2) = out(indout(1):indout(2),1:2);
    cut = [cut;'P'];
end


if find(pha=='S') > 0 & numel(S) > 0 % Windowing from S-secutim to S+fen %%%
    indout = [max([1 S-secutim])  min([size(out,1) (S+fen-1)])] ;
    indwf(1) = max([(S-secutim)*(-1) 1])  ;
    indwf(2) = indwf(1)+diff(indout) ;
    WFS(indwf(1):indwf(2),1:2) = out(indout(1):indout(2),1:2);
    cut = [cut;'S'];
end

if find(pha=='C') > 0 & numel(C) > 0 % Windowing from C-secutim to C+codafen
    indout = [max([1 C-secutim])  min([size(out,1) (C+codafen-1)])] ;
    indwf(1) = max([(C-secutim)*(-1) 1])  ;
    indwf(2) = indwf(1)+diff(indout) ;
    WFC(indwf(1):indwf(2),1:2) = out(indout(1):indout(2),1:2); 
    cut = [cut;'C'];   
end

if find(pha=='E') > 0 & numel(E) > 0 % Windowing from P-secutim to E
    indout = [max([1 P-secutim])  min([size(out,1) (E)])] ;
    indwf(1) = max([(P-secutim)*(-1) 1])  ;
    indwf(2) = indwf(1)+diff(indout) ;
    WFE(indwf(1):indwf(2),1:2) = out(indout(1):indout(2),[1 4]);
    cut = [cut;'E'];
end
test=' ,  ,  ,  ,  ,  ';test(1:3:length(cut)*3)=cut;test = test(1:3:length(cut)*3);
message= ([test ' picks found for ' lesstat ]);
