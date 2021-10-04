### Artificial EEG signal generation method based on EMD and variants

#### Introduction

This is an artificial frame generation method using the empirical mode decomposition (EMD) for EEG-based motor imagery BCI and other EEG-type signals.

This method has been applied in the following papers:

- Dinarès-Ferran, J., Ortner, R., Guger, C., & Solé-Casals, J. (2018). A new method to generate artificial frames using the empirical mode decomposition for an EEG-based motor imagery BCI. *Frontiers in neuroscience*, *12*, 308.

- Zhang, Z., Duan, F., Solé-Casals, J., Dinares-Ferran, J., Cichocki, A., Yang, Z., & Sun, Z. (2019). A novel deep learning approach with data augmentation to classify motor imagery signals. *IEEE Access*, *7*, 15945-15954.
- Li, B., Zhang, Z., Duan, F., Yang, Z., Zhao, Q., Sun, Z., & Solé-Casals, J. (2021). Component-mixing Strategy: A Decomposition-based Data Augmentation Algorithm for Motor Imagery Signals. *Neurocomputing*.

There will be slight differences in the data structure of the EEG signal, so please refer to the details in the first paper (https://doi.org/10.3389/fnins.2018.00308), where this code was first presented, to understand the implementation process of this method. Here we only use the figure(Figure 3 in the second paper: https://doi.org/10.1109/ACCESS.2019.2895133) to show the process of this method.

![](https://github.com/ffbear1993/aug-med/blob/main/pics/process.gif)

Mixing modes strategy for creating artificial EEG frames. In this example we can see that the new artificial frame is created by summing together the IMF-1 from original frame 2, the IMF-2 from original frame 1, the IMF-3 from original frame 3... and the IMF-N from original frame M.