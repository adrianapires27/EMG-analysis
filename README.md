# EMG Signal Processing and Analysis

## Project Overview

This academic project, developed as part of the **Introduction to Signal Analysis and Processing** course at the University of Aveiro, focuses on the analysis and comparison of electromyographic (EMG) signals.

Three EMG recordings were studied, representing different conditions:

- **Healthy:** Recording from an individual without a history of neuromuscular disease.
- **Myopathy:** Recording from an individual with myopathy associated with a history of polymyositis.
- **Neuropathy:** Recording from an individual with chronic lower back pain.

The project explores signal characteristics in both the time and frequency domains using MATLAB.

## Project Objectives

- Analyse and compare different EMG recordings.
- Examine signal amplitude and duration.
- Calculate signal energy, noise energy and Signal-to-Noise Ratio (SNR).
- Apply digital filters to the EMG recordings.
- Analyse frequency components using the Fast Fourier Transform (FFT).

## Implementation

The MATLAB code performs the following operations:

**1. Signal Loading and Time-Domain Analysis**
- Loads the three EMG recordings.
- Separates time and amplitude data.
- Plots the signals in the time domain.
- Calculates signal amplitude and duration.

**2. Energy and SNR Analysis**
- Calculates the total signal energy.
- Estimates noise energy using the first 300 samples.
- Calculates the Signal-to-Noise Ratio (SNR) in decibels (dB).
- Compares SNR values across the three recordings.

**3. Digital Filtering**

Implements second-order Butterworth filters:

- Low-pass filter.
- High-pass filter.
- Band-stop filter (45–55 Hz).
- Band-pass filter (20–60 Hz).

**4. Frequency-Domain Analysis**
- Applies the Fast Fourier Transform (FFT).
- Analyses the frequency spectra of the original signals.
- Examines the frequency spectra of the filtered signals.
- Compares spectral characteristics across the three recordings.

## Tools and Technologies

- MATLAB
- Digital Signal Processing
- Butterworth Filters
- Fast Fourier Transform (FFT)
- Electromyography (EMG) Signal Analysis

## Dataset

The EMG recordings were obtained from the PhysioNet EMG Database:

https://www.physionet.org/content/emgdb/1.0.0/

The original recordings were sampled at 50 kHz and subsequently downsampled to 4 kHz.

## Academic Information

- **Author:** Adriana Pires
- **Institution:** University of Aveiro
- **Degree:** Bachelor's in Electrical and Computer Engineering
- **Course:** Introduction to Signal Analysis and Processing
- **Academic Year:** 2023/2024
- **Instructor:** Armando J. Pinho
