///audio_load_wav(fname)

var _fname = string(argument0);
if (!file_exists(_fname))
{
    show_error("WAV File " + _fname + " does not exist!", true);
    return -1;
}
else
{
    var _buffer = buffer_load(_fname);
    var _soundret = audio_load_wav_buffer(_buffer, 0);
    buffer_delete(_buffer);
    return _soundret;
}
