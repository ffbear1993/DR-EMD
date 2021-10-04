import scipy.io
import numpy as np
from create_artificial_frame import create_artifical_frame

if __name__ == '__main__':
    # Load the IMFs with 10 frames and 15 channels
    data = scipy.io.loadmat('../../data/toy_data.mat')
    data = data[list(data.keys())[-1]]
    data = np.array(data)

    # some dimensional information for building set_real_IMFs
    num_samples = len(data[0][0])
    num_imfs = 0
    num_frames = data.shape[0]
    num_channels = data.shape[1]

    # check the max number of IMFs for each channel and frame
    for i in range(num_frames):
        for j in range(num_channels):
            item_imf = np.array(data[i, j])
            if num_imfs < item_imf.shape[1]:
                num_imfs = item_imf.shape[1]

    # build set_real_IMFs from raw mat data
    data_trans = np.zeros([num_samples, num_imfs, num_frames, num_channels])
    for i in range(num_frames):
        for j in range(num_channels):
            item_imf = np.array(data[i, j])
            data_trans[:, :item_imf.shape[1], i, j] = item_imf

    data = data_trans

    # Genereate 100 artificial Frames with top 5 frames using top 3 IMFs
    set_real_FRMs_idx = [0, 1, 2, 3, 4]
    num_arti_FRMs = 100
    set_real_IMFs = data
    set_real_IMFs_idx = [0, 1, 2]

    arti_frames = create_artifical_frame(set_real_FRMs_idx,
                                         num_arti_FRMs,
                                         set_real_IMFs,
                                         set_real_IMFs_idx)
