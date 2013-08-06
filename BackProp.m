clear;
clc;
learningCoef=.5;
alphaValue=.9;
%inputDataMatrix=[-.2 .1 .3 -.4;.6 -.1 .7 -.5;.8 .1 -.6  0];
%expectedDataMatrix=[.4 .6 .5 .7;.1 .3 .2 .9;.7 .1 .2 .1];
%inputDataMatrix=[0.3 0.4;0.3 0.9];
inputDataMatrix=[42,23,17;32,26,20;55,32,22;17,34,23;20,24,12;20,24,12;20,24,12;32,31,19;17,26,13;17,26,13;44,34,21;42,31,18;5,34,21;26,29,16;43,37,22;28,34,16;23,40,21;23,40,21;23,40,21;42,49,29;38,41,21;30,43,22;36,44,22;36,44,22;40,45,23;14,42,19;69,53,28;55,51,25;55,51,25;36,59,32;50,59,30;70,57,27;70,57,27;70,57,27;76,95,65;58,57,26;43,59,28;52,58,26;52,60,27;52,60,27;52,60,27;37,76,43;37,76,43;47,60,27;52,65,32;50,57,24;35,76,43;35,58,24;47,64,29;30,60,25;47,62,26;52,64,28;52,64,28;52,64,28;70,67,31;51,59,23;36,57,21;36,57,21;36,57,21;46,62,26;46,62,26;51,63,26;64,62,24;58,68,28;58,68,28;58,68,28;58,73,32;58,73,32;53,66,24;47,70,27;80,71,28;58,73,30;55,71,28;52,62,18;33,83,39;58,75,29;58,75,29;58,75,29;58,75,29;58,75,29;58,75,29;73,78,32;65,165,119;70,82,33;70,82,33;48,73,24;48,73,24;48,73,24;48,73,24;40,86,37;55,80,29;55,80,29;55,80,29;50,78,27;55,83,32;30,96,45;55,82,29;57,82,28;83,101,44;50,85,27;58,79,21;50,94,34;60,93,32;59,95,34;68,106,40;58,96,25;70,106,35;58,121,40;50,117,35;52,113,22;56,145,42;64,161,29;88,184,48;88,184,48;88,184,48;85,351,31];
%expectedDataMatrix=[0.1;0.6];
expectedDataMatrix=[31;10.1000000000000;27.5000000000000;27.5000000000000;31;29.7000000000000;30;12.1000000000000;30;28.5000000000000;29.2000000000000;27.9000000000000;24;25.3000000000000;26.6000000000000;23.8000000000000;19.4000000000000;18.4000000000000;23;10.6000000000000;28.7000000000000;24;19;16.8000000000000;10.7000000000000;24.4000000000000;13;16;16.5000000000000;6.30000000000000;9.20000000000000;13.2000000000000;13.8000000000000;12.8000000000000;35;19;8.10000000000000;10.7000000000000;13.4000000000000;12.5000000000000;12.1000000000000;13;16;14.5000000000000;8.70000000000000;9.40000000000000;15.5000000000000;20;14;8.50000000000000;8.60000000000000;12.7000000000000;11;9.90000000000000;28.8000000000000;7.10000000000000;19;20;18.9000000000000;8.20000000000000;7.80000000000000;7.30000000000000;9.50000000000000;8;8.50000000000000;12.2000000000000;12;15;8;18;14;16;7.10000000000000;15.6000000000000;11;10.2000000000000;13.5000000000000;12.4000000000000;13.4000000000000;12;11.1000000000000;13;39;11.1000000000000;9.60000000000000;7.70000000000000;6.80000000000000;6.60000000000000;6.10000000000000;11;13.3000000000000;12.3000000000000;11.8000000000000;12;15;11;16;8.40000000000000;24.5000000000000;6.60000000000000;10.8000000000000;12.6000000000000;7;9.40000000000000;9.10000000000000;5.70000000000000;10.2000000000000;9.10000000000000;6.30000000000000;5.50000000000000;5.70000000000000;6.90000000000000;6.30000000000000;5.10000000000000;5.90000000000000;3.10000000000000];
numOfReps=1000;
numOfNeur=3;
matrixErrorValue=.05;
%inputDataMatrix=inputDataMatrix*.5+.5;

inputDataMatrix1=zeros(size(inputDataMatrix));
for a=1:size(inputDataMatrix,1)
    for b=1:size(inputDataMatrix,2)
        inputDataMatrix1(a,b)=(inputDataMatrix(a,b)-min(inputDataMatrix(:,b)))/(max(inputDataMatrix(:,b))-min(inputDataMatrix(:,b)));
    end
end

inputDataMatrix=inputDataMatrix1;

expectedDataMatrix1=zeros(size(expectedDataMatrix));

for b=1:size(expectedDataMatrix,2)
    maximum(b)=max(expectedDataMatrix(:,b));
    minimum(b)=min(expectedDataMatrix(:,b));
    for a=1:size(expectedDataMatrix,1)
  
        expectedDataMatrix1(a,b)=(expectedDataMatrix(a,b)-min(expectedDataMatrix(:,b)))/(max(expectedDataMatrix(:,b))-min(expectedDataMatrix(:,b)));
    end
end

expectedDataMatrix=expectedDataMatrix1;


rng(3)
weights_ij=rand(size(inputDataMatrix,2),numOfNeur);
weights_ij=(weights_ij-.5)*2;
rng(3)
weights_jk=rand(numOfNeur,size(expectedDataMatrix,2));
weights_jk=(weights_jk-.5)*2;
deltaIJ_old=zeros(size(weights_ij));
deltaJK_old=zeros(size(weights_jk));

plotTable=zeros(1,numOfReps);

for reps=1:numOfReps
    tic
    weights_ij_noise=(rand(size(weights_ij))-.5)*2*matrixErrorValue;
    weights_ij_noise=weights_ij_noise.*weights_ij;
    weights_jk_noise=(rand(size(weights_jk))-.5)*2*matrixErrorValue;
    weights_jk_noise=weights_jk_noise.*weights_jk;
    weights_ij=weights_ij+weights_ij_noise;
    weights_jk=weights_jk+weights_jk_noise;
    for eachInput=1:size(inputDataMatrix,1)
        %calculate output value
        inputData=inputDataMatrix(eachInput,:);
        expectedData=expectedDataMatrix(eachInput,:);
        neuronValue=inputData*weights_ij;
        neuronValue=(1+exp(-neuronValue)).^(-1);
        outputValue=neuronValue*weights_jk;
        neuronValue=neuronValue';
        outputValue=outputValue';
        outputValue=(1+exp(-outputValue)).^(-1);

        %
        %calculate delta value for j-k
        deltaValue_k=zeros(size(expectedData,2),1);
        for k=1:size(expectedData,2)
            deltaValue_k(k,1)=(expectedData(k)-outputValue(k))*(1-outputValue(k))*(outputValue(k));
        %
        %calculate new weights for j-k
            deltaJK_new=learningCoef*deltaValue_k(k)*neuronValue;
            weights_jk(:,k)=weights_jk(:,k)+deltaJK_new+deltaJK_old(k)*alphaValue;
            deltaJK_old(:,k)=deltaJK_new;
        end
        %
        %calculate delta value for i-j
        deltaValue_j=zeros(numOfNeur,1);
        for j=1:numOfNeur
            deltaValue_j(j,1)=weights_jk(j,:)*deltaValue_k*(1-neuronValue(j))*(neuronValue(j));
            deltaIJ_new=learningCoef*deltaValue_j(j)*inputData';
            weights_ij(:,j)=weights_ij(:,j)+deltaIJ_new+deltaIJ_old(j)*alphaValue;
            deltaIJ_old(:,j)=deltaIJ_new;
        end %weights_ij=weights_ij+(deltaValue_ij)*rot90(inputData)*learningCoef;
        %
    end
    %calculate RMS
    toc
    fprintf('%d',reps);
    outputMatrix=Recall(inputDataMatrix,weights_ij,weights_jk,numOfNeur);
    RMS=sqrt(sum(sum((expectedDataMatrix-outputMatrix).^2))/(size(inputDataMatrix,1)*size(expectedDataMatrix,2)));
  %  RMS=abs(sum(sum(outputMatrix-expectedDataMatrix)));
      plotTable(1,reps)=RMS;

end

cla;
plot(plotTable');
xlabel('reps');
ylabel('rms');
title('rms vs reps');
legend('RMS');
%axis([0 numOfReps 0 max(plotTable)]); 
Recall(inputDataMatrix,weights_ij,weights_jk,numOfNeur)*(maximum-minimum)+minimum
