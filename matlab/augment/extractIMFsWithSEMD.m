% Extract IMFs using serial-emd method adaptive for 2D or 3D signal
%
% Description of the function:
%
% imfs = extractIMFsWithSEMD(interval, signal)
% 
% Output:
% 1. imfs (num_signals, num_frames, num_imfs, num_channels) or (num_signals, num_frames, num_imfs)
%
% Inputs:
% 1. interval: hyper-parameter for serial-emd, usually set to 50
% 2. signal: (num_samples, num_frames, num_channels) or (num_samples, num_frames)

function imfs = extractIMFsWithSEMD(interval, signal)
    num_samples = size(signal, 1);
    num_frames = size(signal, 2);
    num_channels = size(signal, 3);
    
    for idx_channel = 1: num_channels
        x = concatenate(signal(:, :, idx_channel), interval);
        [xEMD, resx] = emd(x);
        all_xEMD = [xEMD, resx];
        for t = 1:size(all_xEMD, 2)
            Xd(:, :, t, idx_channel) = deconcatenate(all_xEMD(:, t), num_samples, num_frames, interval);
        end
    end
    imfs = Xd;
end