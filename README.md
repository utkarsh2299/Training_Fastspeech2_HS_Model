# FastSpeech2 with Hybrid Segmentation Training Recipe

## Overview

This repository contains a recipe for training FastSpeech2 with Hybrid Segmentation (HS), a state-of-the-art text-to-speech (TTS) model. The training utilizes the Espnet toolkit and is tailored for the Indian languages, covering 13 major languages of India.

For finer details and comprehensive information, please refer to the [Wiki section](https://github.com/utkarsh2299/Train_FastSpeech2_HS/wiki) of the repository.

<ins>**We are providing the training text and duration info for each language. User can use their data and can generate their own duration info. See below:**</ins>    
## Data

Download the language data from [IIT Madras TTS Database](https://www.iitm.ac.in/donlab/tts/database.php), which includes a special corpus of 13 Indian languages. The dataset comprises 10,000+ spoken sentences/utterances in both mono and English, recorded by male and female native speakers. The speech waveform files are available in .wav format, accompanied by corresponding text.

### Duration info of the text data
In FastSpeech2, which is a neural TTS model, the duration file is used to represent the durations of phonemes in the input text. During the training of FastSpeech2, the model learns to predict these durations as part of the overall sequence-to-sequence training.  <br>

We are using the Hybrid segmentation (lab grown aligner) for getting the duration files. Another popular forced aligner is the Montreal Forced Aligner (MFA) which can be installed from [here](https://montreal-forced-aligner.readthedocs.io/en/latest/getting_started.html). 

<ins> **We have already provided the Training TEXT and respective duration info of each language model.** </ins>


## Installation

1. Install the [Espnet toolkit](https://espnet.github.io/espnet/installation.html).
2. After installation, update the espnet path and kaldi path in `path.sh`.

## Configuration 
>Please follow [Wiki section](https://github.com/utkarsh2299/Train_FastSpeech2_HS/wiki) for more details of each file.

1. In `local/data.sh`, adjust dev and eval set divisions (line numbers 79-82) based on the data for training the model. 
2. Modify the `run.sh` file:
    - Adjust the waveform to 48 kHz if needed (double the values at `fs`, `n_fft`, and `n_shift`).
    - Make necessary changes to the script according to your requirements.

3. Make changes to the duration_info folder (See [Wiki section](https://github.com/utkarsh2299/Train_FastSpeech2_HS/wiki)) 
4. Update configurations in `tts.sh` where necessary.(Important: Add the duration file and Point to _duration_info_ path for the _teacher_dumpdir_ variable )

## Training

1. To check GPU availability: `nvidia-smi`
2. Run the training script: `bash run.sh`
   - **Note 1:** Try to execute the script stage by stage, as mentioned in `tts.sh` (usually line numbers 29-30) as it'll be helpful in finding the errors.
   - **Note 2:** Run the training part using the screen utuility of linux.

## Synthesis of unseen text

After the completion of training (till stage 7), Follow the steps below to set up the environment and perform text synthesis.

## Preparation

1. Create a "model" folder:

    ```bash
    mkdir model
    ```

2. Copy the following files to the "model" folder:

   - `dump/raw/eval1/feats_type` (or use the one from train/validation)
   - `exp/tts_stats_raw_char_None/train/feats_stats.npz`
   - `exp/tts_train_raw_char_None/train.loss.ave.pth` (you can try other models as well, modify accordingly in synthesis scripts)
   - `exp/tts_train_raw_char_None/config.yaml` (modify `stats_file` to `model/feats_stats.npz` or provide the full path to the "model" folder)

3. Create a "test_folder" containing the text for synthesis in Kaldi format, following the pattern used during training.

4. Prepare `run_synthesis.sh` and `tts_synthesis.sh`. In `run_synthesis.sh`, set the path to `test_folder`, `model_path`, and modify `$inference_config`.

5. Ensure that the feature extraction part in `tts_synthesis.sh` matches the configuration used during training.

## Text Synthesis

Run the following command to synthesize text:

```bash
bash run_synthesis.sh
```

(The output files will be located in exp/tts_train_raw_char_None/decode_train.loss.ave/test_folder.)

## Wiki Reference

For more detailed information, troubleshooting, and tips, please consult the [Wiki section](https://github.com/utkarsh2299/Train_FastSpeech2_HS/wiki) of the repository.

Happy training!
