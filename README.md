# FastSpeech2 with Hybrid Segmentation Training Recipe

## Overview

This repository contains a recipe for training FastSpeech2 with Hybrid Segmentation (HS), a state-of-the-art text-to-speech (TTS) model. The training utilizes the Espnet toolkit and is tailored for the Indian languages, covering 13 major languages of India.

For finer details and comprehensive information, please refer to the [Wiki section](https://github.com/utkarsh2299/Train_FastSpeech2_HS/wiki) of the repository.

## Data

Download the language data from [IIT Madras TTS Database](https://www.iitm.ac.in/donlab/tts/database.php), which includes a special corpus of Indian languages. The dataset comprises 10,000+ spoken sentences/utterances in both mono and English, recorded by male and female native speakers. The speech waveform files are available in .wav format, accompanied by corresponding text.

## Installation

1. Install the [Espnet toolkit](https://espnet.github.io/espnet/installation.html).
2. After installation, update the espnet path in `path.sh`.

## Configuration

1. In `local/data.sh`, adjust dev and eval set divisions (line numbers 79-82) based on the data for training the model.
2. Modify the `run.sh` file:
    - Adjust the waveform to 48 kHz if needed (double the values at `fs`, `n_fft`, and `n_shift`).
    - Make necessary changes to the script according to your requirements.

3. Update configurations in `tts.sh` where necessary.

## Training

1. To check GPU availability: `nvidia-smi`
2. Run the training script: `bash run.sh`
   - **Note:** Execute the script stage by stage, as mentioned in `tts.sh` (usually line numbers 29-30).

## Wiki Reference

For more detailed information, troubleshooting, and tips, please consult the [Wiki section](https://github.com/utkarsh2299/Train_FastSpeech2_HS/wiki) of the repository.

Feel free to contribute, report issues, or provide feedback to enhance the training process and model performance. Happy training!
