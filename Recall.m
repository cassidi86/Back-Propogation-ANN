function recallValue=Recall(dataNormalized,weights_ij,weights_jk,numOfNeur)
    for i=1:size(dataNormalized,1)    
        neuronValue=zeros(numOfNeur,1);
        neuronValue=dataNormalized(i,:)*weights_ij;
        neuronValue=(1+exp(-neuronValue)).^(-1);
        outputValue=zeros(size(weights_jk,2),1);
        outputValue=neuronValue*weights_jk;
        outputValue=(1+exp(-outputValue)).^(-1);
        newMatrix(i,:)=outputValue;
    end
    recallValue=newMatrix;
end