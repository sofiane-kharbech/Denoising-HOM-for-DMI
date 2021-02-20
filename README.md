# Denoising Higher-Order Moments for Blind Digital Modulation Identification in Multiple-Antenna Systems

## License
Copyright (C) 2020 Sofiane Kharbech, Eric Pierre Simon, Akram Belazi, and Wei Xiang.

This software is under the MIT License.

Paper citation: S. Kharbech, E. P. Simon, A. Belazi and W. Xiang, "Denoising Higher-Order Moments for Blind Digital Modulation Identification in Multiple-Antenna Systems," in IEEE Wireless Communications Letters, vol. 9, no. 6, pp. 765-769, June 2020.

## Main scripts
* `GenDataset.m`: generates a set of HOM the allows identifying the modulation type. In this file, you can edit all the transmitter, channel, and receiver parameters.
* `DetectionResults.m`: shows the detection performance, i.e., the probability of correct identification in terms of the SNR.

## Fonction scripts
* `f_HOS_Extraction.m`: includes the following processes: source signals generation, channel mixing, blind source separation (BSS), and features extraction.
* `f_CalcHOS.m`: given a signal x, this function estimates HOC and both denoised and non-denoised HOM.
* `f_SCMA.m`: is the function that performs the BSS process following the SCMA algorithm.
