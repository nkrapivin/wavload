# wavload
A small example that demonstrates how to externally load .wav files.

Works on GameMaker: Studio 1.4 and above, importing this project into newer GM versions will work.

## Caveats
- Only PCM 16-bit or 8-bit files will work, as that's the only two formats GM supports.
- Only Stereo or Mono, for the same reason, GM also supports some weird "3D Audio (5.1)" format, if the channel number is invalid the script will assume it's that weird 3D Audio, expect issues though.
- Files exported from Adobe Audition maybe won't work, they add some external data to the .wav and I'm too lazy to implement that (same with ffmpeg?). Please just use Audacity, it's perfect.
