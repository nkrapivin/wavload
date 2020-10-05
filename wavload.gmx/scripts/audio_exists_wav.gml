///audio_exists_wav(snd)

return is_array(argument0)
    && array_length_1d(argument0) == 2
    && is_real(argument0[@ 1])
    && is_real(argument0[@ 0])
    && buffer_exists(argument0[@ 1])
    && (argument0[@ 0] > -1);
