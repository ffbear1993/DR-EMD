clear;
close all;

%% Here have our signals, the ones we want to decompose with EMD simultaneously
% (num_samples, num_frames, num_channels)

% some parameters for generating toy signals
num_samples = 500;
num_frames = 10;
num_channels = 3;

% Toy signals
X = zeros(num_samples, num_frames, num_channels);
for idx_channel = 1: num_channels
    X(:, :, idx_channel) = kron(rand(num_frames, 1), ones(1, num_samples))';
end

% SEMD concatenate stage and deconcatenate stage
% Xd is the IMFs(num_signals, num_frames, num_channels, num_imfs)
d = 50;
for idx_channel = 1: num_channels
    x = concatenate(X(:, :, idx_channel), d);
    [xEMD, resx] = emd(x);
    all_xEMD = [xEMD, resx];
    for t = 1:size(all_xEMD, 2)
        Xd(:, :, t, idx_channel) = deconcatenate(all_xEMD(:, t), num_samples, num_frames, d);
    end
end

% Build IMFs data structure for creating artifacial frames
data = cell(num_frames, num_channels);
for idx_frame = 1:num_frames
    for idx_channel = 1:num_channels
        data(idx_frame, idx_channel) = {squeeze(Xd(:, idx_frame, idx_channel, :))};
    end
end

% CreateArtificialFrames, seed parameter is Optional
setOfFrames = [1, 2, 3, 4, 5];
numOfFrames = 100;
imf = data;
indexIMFs = [1, 2, 3];
seed = 1;
artificialFrames = createArtificialFrames(setOfFrames, numOfFrames, imf, indexIMFs, seed);
