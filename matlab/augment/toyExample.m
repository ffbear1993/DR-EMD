clear;
close all;

data = load('../../data/toy_data.mat');
data = data.data;

setOfFrames = [1, 2, 3, 4, 5];
numOfFrames = 1;
imf = data;
indexIMFs = [1, 2, 3];
artificialFrames = createArtificialFrames(setOfFrames, numOfFrames, imf, indexIMFs);
result = artificialFrames(1,:,1);