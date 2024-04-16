% Build IMFs Cell Array Data Structure for Creating Artificial Frames
%
% Description of the function:
%
% imfsCellArray = buildIMFsCellArray(imfs)
% 
% Output:
% 1. imfsCellArray: (num_frames, num_channels)
%
% Inputs:
% 1. imfs: (num_signals, num_frames, num_imfs, num_channels) or (num_signals, num_frames, num_imfs)

function imfsCellArray = buildIMFsCellArray(imfs)
    num_frames = size(imfs, 2);
    num_channels = size(imfs, 4);
    
    imfsCellArray = cell(num_frames, num_channels);
    for idx_frame = 1: num_frames
        for idx_channel = 1:num_channels
            imfsCellArray(idx_frame, idx_channel) = {squeeze(imfs(:, idx_frame, :, idx_channel))};
        end
    end
end