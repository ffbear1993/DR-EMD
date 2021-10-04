clear;
close all;

% Build frame data with IMFs

%10 frames, 15 channels
num_frames = 10;
num_channels = 15;

data = cell(num_frames, num_channels);

for idx_frame = 1:num_frames    
    L = 500; % number of samples for each frame, 500
    u = rand(num_channels, 1);
    o1 = ones(1, L);
    X = kron(u, o1)';

    % To build different signal for each channel, here we add idx_frame for each iteration.
    X = X + idx_frame;
    [m, n] = size(X);

    % Here we use the serial-EMD to decompose the multi-dimensional signals
    % For more details, please visit https://github.com/ffbear1993/serial-emd
    % You can also use other EMD variants to decompose your data
    
    d = 50; % necessary parameter for serial-EMD
    x = concatenate(X, d);
    [xEMD, resx] = emd(x);
    all_xEMD = [xEMD, resx];

    for t = 1:size(all_xEMD, 2)
        % the IMFs for each frame and each channel
        Xd(:, :, t) = deconcatenate(all_xEMD(:, t), m, n, d);
    end

    for idx_channel = 1:num_channels
        data(idx_frame, idx_channel) = {squeeze(Xd(:, idx_channel, :))};
    end

end

save('./toy_data.mat', 'data');
