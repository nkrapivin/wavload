///audio_load_wav_buffer(buffer,[offset])

// If you don't specify an offset, 0 is assumed.
var _mainbuf = argument[0];
var _offset = 0;
if (argument_count > 1) _offset = argument[1];

if (!buffer_exists(_mainbuf))
{
    show_error("Unable to load WAV File.", true);
    return -1;
}

buffer_seek(_mainbuf, buffer_seek_start, _offset);

var _RIFF = $46464952;
var _fRIFF = buffer_read(_mainbuf, buffer_u32); // "RIFF" header.
if (_fRIFF != _RIFF)
{
    buffer_delete(_mainbuf);
    show_error("Invalid RIFF header, got " + string(_fRIFF), true);
    return -1;
}

buffer_read(_mainbuf, buffer_u32); // file size.

var _WAVE = $45564157;
var _fWAVE = buffer_read(_mainbuf, buffer_u32); // "WAVE" header.
if (_fWAVE != _WAVE)
{
    show_error("Invalid WAVE header, got " + string(_fWAVE), true);
    return -1;
}

var _FMT = $20746D66;
var _fFMT = buffer_read(_mainbuf, buffer_u32); // "fmt " header.
if (_fFMT != _FMT)
{
    show_error("Invalid fmt  header, got " + string(_fFMT), true);
    return -1;
}

buffer_read(_mainbuf, buffer_u32); // "fmt " chunk size.

var _PCMAUDIOFMT = 1;
var _AUDIOFMT = buffer_read(_mainbuf, buffer_u16);
if (_AUDIOFMT != _PCMAUDIOFMT)
{
    show_error("GM:S 1.4/GMS 2 only supports PCM audio format, got " + string(_AUDIOFMT), true);
    return -1;
}

var _ChanNum = buffer_read(_mainbuf, buffer_u16); // amount of channels.
var _SampFrq = buffer_read(_mainbuf, buffer_u32); // 48000 for example.
var _BytsPsq = buffer_read(_mainbuf, buffer_u32); // bytes per second.
var _BlokAln = buffer_read(_mainbuf, buffer_u16); // block align.
var _BitsPsq = buffer_read(_mainbuf, buffer_u16); // bits per sample.
var _GMBitsPsq, _GMChanNum;
switch (_BitsPsq)
{
    case 16:
        _GMBitsPsq = buffer_s16;
        break;
    case 8:
        _GMBitsPsq = buffer_u8;
        break;
    default:
        show_error("Invalid Bits Per Second value, got " + string(_BitsPsq), true);
        return -1;
}

switch (_ChanNum)
{
    case 1:
        _GMChanNum = audio_mono;
        break;
    case 2:
        _GMChanNum = audio_stereo;
        break;
    default: // ????????? may be wrong!
        _GMChanNum = audio_3d;
        show_debug_message("Invalid channel num " + string(_ChanNum) + ", assuming 3D (5.1) Audio...");
        break;
}

var _DATA = $61746164;
var _fDATA = buffer_read(_mainbuf, buffer_u32);

if (_fDATA != _DATA)
{
    show_error("Invalid data header, got " + string(_fDATA), true);
    return -1;
}

var _DataLen = buffer_read(_mainbuf, buffer_u32); // sampled data length.
if (_DataLen != (buffer_get_size(_mainbuf) - buffer_tell(_mainbuf)))
{
    show_debug_message("Extra data after the end of the file.");
}

show_debug_message("Parsed everything, trying to make the sound...");

var _buf = buffer_create(_DataLen, buffer_fixed, _BlokAln);
buffer_copy(_mainbuf, buffer_tell(_mainbuf), _DataLen, _buf, 0);
var _sound = audio_create_buffer_sound(_buf, _GMBitsPsq, _SampFrq, 0, _DataLen, _GMChanNum);
var _retarr;
_retarr[1] = _buf;
_retarr[0] = _sound;
return _retarr;
