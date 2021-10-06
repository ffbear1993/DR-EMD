## DR-EMD: Data augmentation based on a decomposition-recombination strategy through EMD

### Introduction

It is a method of generating artificial signals through empirical mode decomposition (EMD) and subsequent recombination, originally developed for BCI of EEG-based motor imagery and other EEG-type signals, but which can be extended to any other type of signals/data.

This method has been applied in the following papers:

- Dinarès-Ferran, J., Ortner, R., Guger, C., & Solé-Casals, J. (2018). A new method to generate artificial frames using the empirical mode decomposition for an EEG-based motor imagery BCI. *Frontiers in neuroscience*, *12*, 308.

- Zhang, Z., Duan, F., Solé-Casals, J., Dinarès-Ferran, J., Cichocki, A., Yang, Z., & Sun, Z. (2019). A novel deep learning approach with data augmentation to classify motor imagery signals. *IEEE Access*, *7*, 15945-15954.
- Li, B., Zhang, Z., Duan, F., Yang, Z., Zhao, Q., Sun, Z., & Solé-Casals, J. (2021). Component-mixing Strategy: A Decomposition-based Data Augmentation Algorithm for Motor Imagery Signals. *Neurocomputing*.

There will be slight differences in the data structure of the EEG signal, so please refer to the details in the first paper (https://doi.org/10.3389/fnins.2018.00308), where this code was first introduced, to understand the implementation process of this method. Here we only use the following figure to show the process of this method (Figure 3 in the second paper: https://doi.org/10.1109/ACCESS.2019.2895133).

![](https://github.com/ffbear1993/DR-EMD/blob/main/pics/process.gif)

Mixing modes strategy for creating artificial EEG frames. In this example we can see that the new artificial frame is created by summing together the IMF-1 from original frame 2, the IMF-2 from original frame 1, the IMF-3 from original frame 3... and the IMF-N from original frame M.

### Installation

The source code is available on GitHub. To download the code you can either go to the source code page and click `Code -> Download ZIP`, or use git command line

 `$ git clone https://github.com/ffbear1993/DR-EMD.git`

We provide two implementations, python version and matlab version.

#### PYTHON Version

###### Environment:

python 3.6 or above with numpy and scipy (for `.mat` data load)

For EMD and variants, we recommand the following repositories that work well with our code.

- PyEMD: <https://github.com/laszukdawid/PyEMD>, implements standard EMD and its variants for one-dimensional signal.
- Serial-EMD: <https://github.com/ffbear1993/serial-emd>, can speed up the decomposition process for multi-dimensional signals (best choice!).

#### MATLAB Version

###### Environment:

MATLAB R2018b or above, which provide the default emd function. For other variants, please visit the following site:

- eemd: <https://github.com/HirojiSawatari/EEMD-Project>
- ceemdan: <https://github.com/helske/Rlibeemd>
- Serial-EMD: <https://github.com/ffbear1993/serial-emd>

or you can contact us to get these methods' source code.

### Toy Example

#### Data

Please access `./data/toy_data_generate.m` to check how to generate the toy data, or you can use the `./data/toy_data.mat` directly for both PYTHON code and MATLAB code.

The toy data is a two-dimensional cell array [Frame, Channel]. We used the Serial-EMD to decompose a signal with 10 frames and 15 channels and get its IMFs, which is saved in `./data/toy_data.mat`.

For PYTHON user, the `toy_data.mat` must be transformed the numpy array with four dimensions: `[num_samples, num_imfs, num_frames, num_channels]`, thus, please access `./python/augment/toy_example.py` to check how to generate the numpy array for `toy_data.mat`.

#### Function Details

For both PYTHON and MATLAB code, the function `create_artificial_frames` receives the same parameters and outputs the same result. Please check `./augment/create_artificial_frame.py` and `./augment/createArtificialFrame.m` to get the more details. Here we list the input parameters for MATLAB user (same parameters with PYTHON user):

- setOfFrames: Set of indices of the real frames of the **same class** that we want to use to create the artificial ones.
- numOfFrames: Number of artificial frames you want to generate.
- imf: IMFs of the real frames in a two-dimensional cell array [frames, channel], (`toy_data.mat` should be referenced here)
- indexIMFs: Vector with the IMFs you want to use to generate the new frames.

If you want to apply this method on your own data, you can reuse `./augment/toy_example.py` or `./augment/toyExample.m` and replace the input parameters. In these `toy_example` code, we want to use the first 5 frames with the first 3 IMFs to generate 100 artificial frames, so you can customize which frames or IMFs are used to generate the artificial signal frames. 

### Contact 

Feel free to contact me with any questions, requests. It's always nice to know that I've helped someone or made their work easier. Contributing to the project is also acceptable and warmly welcomed.

#### Citation

If you found this package useful please cite it in your work using the following structure:

```
@ARTICLE{10.3389/fnins.2018.00308,  
  author={Dinar{\`e}s-Ferran, Josep and Ortner, Rupert and Guger, Christoph and Sol{\'e}-Casals, Jordi},
  journal={Frontiers in Neuroscience},	
  title={A New Method to Generate Artificial Frames Using the Empirical Mode Decomposition for an EEG-Based Motor Imagery BCI},
  year={2018},
  volume={12},
  number={},
  pages={308},
  doi={10.3389/fnins.2018.00308},
  issn={1662-453X}  
}
```

```
@ARTICLE{8630915,
  author={Zhang, Zhiwen and Duan, Feng and Sol{\'e}-Casals, Jordi and Dinar{\`e}s-Ferran, Josep and Cichocki, Andrzej and Yang, Zhenglu and Sun, Zhe},
  journal={IEEE Access}, 
  title={A Novel Deep Learning Approach With Data Augmentation to Classify Motor Imagery Signals}, 
  year={2019},
  volume={7},
  number={},
  pages={15945-15954},
  doi={10.1109/ACCESS.2019.2895133}}
```

```
@ARTICLE{LI2021325,
  author = {Binghua Li and Zhiwen Zhang and Feng Duan and Zhenglu Yang and Qibin Zhao and Zhe Sun and Jordi Sol{\'e}-Casals},
  journal = {Neurocomputing},
  title = {Component-mixing strategy: A decomposition-based data augmentation algorithm for motor imagery signals},
  year = {2021},
  volume = {465},
  pages = {325-335},
  doi = {https://doi.org/10.1016/j.neucom.2021.08.119},
  issn = {0925-2312}
}
```







