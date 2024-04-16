clear;
close all;

%% Here have our signals, the ones we want to decompose with EMD simultaneously
% (num_samples, num_frames, num_channels)

% some parameters for generating toy signals
num_samples = 500;
num_frames = 10;
num_channels = 3;

% Toy signals (num_samples, num_frames, num_channels) or (num_samples, num_frames)
X = zeros(num_samples, num_frames, num_channels);
for idx_channel = 1: num_channels
    X(:, :, idx_channel) = kron(rand(num_frames, 1), ones(1, num_samples))';
end

% SEMD concatenate stage and deconcatenate stage
% interval is the hyper-parameter in SEMD
% imfs (num_signals, num_frames, num_imfs, num_channels) or (num_signals, num_frames, num_imfs)
interval = 50;
imfs = extractIMFsWithSEMD(interval, X);

% Build IMFs data structure for creating artifacial frames
% imfsCellArray (num_frames, num_channels)
imfsCellArray = buildIMFsCellArray(imfs);

% CreateArtificialFrames, seed parameter is Optional
setOfFrames = [1, 2, 3, 4, 5];
numOfFrames = 100;
imf = imfsCellArray;
indexIMFs = [1, 2, 3];
seed = 1;
artificialFrames = createArtificialFrames(setOfFrames, numOfFrames, imf, indexIMFs, seed);
