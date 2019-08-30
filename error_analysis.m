y1 = load("your model output here");
ya = load("the actual value here");
thr = 0.25;% set the on power threshold
y1(y1<thr)=0;
y1(y1>1)=1;
y_pre = imbinarize(y1,thr); %convert to on/off
y_acc = imbinarize(ya,thr); %convert to on/off

accurary= 1-(sum(abs(y1-ya))/(2*sum(ya)));% calculate accurary

A = confusionmat(y_acc,y_pre); % create confusionmat
TN = A(1,1);
TP = A(2,2);
FN = A(2,1);
FP = A(1,2);

precision = TP/(TP+FP);
recall = TP/(TP+FN);  
F1 = (2*precision*recall)/(precision+recall);

