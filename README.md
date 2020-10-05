# wavload
A small example that demonstrates how to externally load .wav files.

Works on GameMaker: Studio 1.4 and above, importing this project into newer GM versions will work.

## Usage
- `audio_load_wav(fname)` loads file `fname` and returns the wav array.
- `audio_load_wav_buffer(buffer,[offset])` loads sound from `buffer` starting from `offset`, if none specified offset 0 is assumed.
- `audio_free_wav(arr)` properly frees the wav sound loaded by `audio_load_wav*` functions, the array must not be used after you called this function.
- `audio_exists_wav(snd)` checks that the wav array is valid.
- WAV Array:
  - [0] - GM:S Audio Index, use in `audio_*` functions except `audio_exists` and `audio_destroy_stream`.
  - [1] - Raw Sound Data Buffer Index, DO NOT FREE this buffer, it's only there just so `audio_free_wav` can free it.

## Caveats
- Only PCM 16-bit or 8-bit files will work, as that's the only two formats GM supports.
- Only Stereo or Mono, for the same reason, GM also supports some weird "3D Audio (5.1)" format, if the channel number is invalid the script will assume it's that weird 3D Audio, expect issues though.
- Files exported from Adobe Audition maybe won't work, they add some external data to the .wav and I'm too lazy to implement that (same with ffmpeg?). Please just use Audacity, it's perfect.
