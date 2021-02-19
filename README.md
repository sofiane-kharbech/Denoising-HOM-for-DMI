# Denoising Higher-Order Moments for Blind Digital Modulation Identification in Multiple-Antenna Systems

## License
Copyright (C) 2020 Sofiane Kharbech, Eric Pierre Simon, Akram Belazi, and Wei Xiang.
This software is under the MIT License.

## Main scripts
* GenDataset.m: generates a set of HOM allowing the identification of the modulation type. In this file, you can edit all the transmitter, channel, and receiver parameters.
* DetectionResults.m: shows the detection performance, i.e., the probability of correct identification in tersm of the SNR.

## Fonctions scripts
* f_HOS_Extraction.m: includes the following processes. Source signals generation, channel mixing, blind source separation (BSS), and features extraction.
* f_CalcHOS.m: given a signal x, this fonction estimates HOC and both denoised and non-denoised HOM.
* f_SCMA.m: is the fonction that perform the BSS process following the SCMA algorithm. `put-your-code-here` and `www`
