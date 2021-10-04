import numpy as np

# Generating artificial frames using the EMD decomposition
# Here we provide the python code to execute the same function as the matlab code for python user.
#
# OUTPUT
# Tensor containing the new frames, organized as [num_frames, num_samples, num_channels]

# INPUT:
# set_real_FRMs_idx: Set of indices of the real frames of the same class that we want to use to create the artificial ones.
# num_arti_FRMs: Number of artificial frames you want to generate.
# set_real_IMFs: [num_samples, num_imfs, num_frames, num_channels], which is slightly different with the matlab version,
# Please visit ./python/augment/toy_example.py to get how to generate the corrected format set_real_IMFs.
# set_real_IMFs_idx: Vector with the IMFs you want to use to generate the new frames.


def create_artifical_frame(set_real_FRMs_idx: list, num_arti_FRMs: int, set_real_IMFs: np.array, set_real_IMFs_idx: list):
    num_samples, num_channels = set_real_IMFs.shape[0], set_real_IMFs.shape[-1]

    arti_FRMs = np.zeros([num_arti_FRMs, num_samples, num_channels])
    for idx_FRM in range(num_arti_FRMs):
        max_arti_IMFs = len(set_real_IMFs_idx)
        item_FRM_IMFs = np.zeros([num_samples, max_arti_IMFs, num_channels])

        seq_FRMs_idx = []
        while(len(seq_FRMs_idx) < max_arti_IMFs):
            seq_FRMs_idx.extend(np.random.permutation(len(set_real_FRMs_idx)))

        seq_FRMs_idx = [int(item) for item in seq_FRMs_idx]

        seq_FRMs_idx = seq_FRMs_idx[:max_arti_IMFs]

        for idx_IMF in range(max_arti_IMFs):
            for idx_channel in range(num_channels):
                idx_IMF_real = set_real_IMFs_idx[idx_IMF]
                idx_FRM_real = set_real_FRMs_idx[seq_FRMs_idx[idx_IMF]]
                selected_IMF = set_real_IMFs[:,
                                             idx_IMF_real, idx_FRM_real, idx_channel]
                item_FRM_IMFs[:, idx_IMF, idx_channel] = selected_IMF

        arti_FRMs[idx_FRM, :, :] = np.sum(item_FRM_IMFs, 1)
    return arti_FRMs
