///audio_free_wav(arr)

// actually free stuff...
audio_free_buffer_sound(argument0[@ 0]);
buffer_delete(argument0[@ 1]);

// set the values to -1 so they won't be reused.
argument0[@ 1] = -1;
argument0[@ 0] = -1;

// free the array.
argument0 = 0;

return true;
