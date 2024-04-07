% Generating artificial frames using the EMD decomposition
%
% Description of the function:
%
% artificialFrames = createArtificialFrames(setOfFrames, numOfFrames, imf, indexIMFs, seed);
%
% Output:
%  1.Tensor containing the new frames, organized as [frames, samples, channels]
%
% Inputs:
% 1. Set of indices of the real frames of the same class that we want to use to create the artificial ones.
% 2. Number of artificial frames you want to generate.
% 3. IMFs of the real frames in a two-dimensional cell array [frames, channel]
% 4. Vector with the IMFs you want to use to generate the new frames.
%    For example: if you indicate [2 3 4 5] then these four MFIs would only be used to create the artificial frames.
%    Another example: 1:15 would take all IMFs up to 15 (usually EEG from motor imaging only have up to 10 or 11 IMFs, but you can change this value)%
% 5. (Optional) rng(seed) for randperm() when you want to generate the same permutations.
%
%
% This code was firts presented in the following paper:
%   Dinarès-Ferran J, Ortner R, Guger C and Solé-Casals J (2018)
%   A New Method to Generate Artificial Frames Using the Empirical Mode Decomposition
%   for an EEG-Based Motor Imagery BCI.
%   Front. Neurosci. 12:308. doi: 10.3389/fnins.2018.00308
%   https://www.frontiersin.org/articles/10.3389/fnins.2018.00308/full
% And was used in a deep learning scenario in the following paper:
%   Zhiwen Zhang, Feng Duan, Jordi Solé-Casals, Josep Dinarès-Ferran,
%   Andrzej Cichocki ,Zhenglu Yang; Zhe Sun, “A Novel Deep Learning
%   Approach With Data Augmentation to Classify Motor Imagery Signals”,
%   IEEE Access vol 7, pp 15945 – 15954 doi: 10.1109/ACCESS.2019.2895133
%   https://ieeexplore.ieee.org/document/8630915
%
%  Please cite both papers if you use our code.
%
% Josep Dinarès-Ferran & Jordi Solé-Casals
% Catalonia, July 2018

%%
function artificialFrames = createArtificialFrames(setOfFrames, numOfFrames, imf, indexIMFs, seed)

    % optional parameter when you want to generate the same permutations
    if exist('seed', 'var')
        rng(seed);
    end
    % necessary to make the function backwards compatibility:
    %   in the previous version we only pass the number of max IMFs
    %   that a new frame should have. In that case, we build a new
    %   matrix of index from 1 to the passed value
    if size(indexIMFs, 1) == 1 && size(indexIMFs, 2) == 1
        indexIMFs = 1:indexIMFs;
    end

    numSamples = size(imf{1}, 1); % get the number of sample for each channel
    numChannels = size(imf, 2); % get the number of channels for each frame
    numIMFs = size(indexIMFs, 2); % get the number of maximum IMFs in one signal

    % initialize the set of frames to be returned
    artificialFrames = zeros(numOfFrames, numSamples, numChannels);

    for fr = 1:numOfFrames
        % initializes the matrix to save the selected IMFs to create an
        % artificial frame
        imfFrame = zeros(numSamples, numChannels, numIMFs);

        % select the frames that will contribute to create the new one
        pickedFramesVector = [];

        while (1)
            pickedFramesVector = [pickedFramesVector randperm(size(setOfFrames, 2))];

            % used only if the numIMFs is greater than the number of frames
            % in the set (setOfFrames).
            if size(pickedFramesVector, 2) >= numIMFs; break; end
        end

        % get only the needed values
        pickedFramesVector = pickedFramesVector(1:numIMFs);

        for iIMF = 1:size(pickedFramesVector, 2)

            for ch = 1:numChannels
                % selectedIMF = imf{pickedFramesVector(iIMF), ch};
                selectedIMF = imf{setOfFrames(pickedFramesVector(iIMF)), ch};

                % check that there is an IMF in this channel
                if size(selectedIMF, 2) >= indexIMFs(iIMF)
                    imfFrame(:, ch, iIMF) = selectedIMF(:, indexIMFs(iIMF));
                end

            end

        end

        % build the artificial frame (class 0) from the IMF's
        artificialFrames(fr, :, :) = sum(imfFrame, 3);

    end

end
