#include <fluidsynth.h>
#include <bindings.dsl.h>

module Bindings.FluidSynth where
#strict_import

#opaque_t fluid_settings_t
#opaque_t fluid_synth_t
#opaque_t fluid_audio_driver_t

-- * Settings
#ccall new_fluid_settings , IO (Ptr <fluid_settings_t>)
#ccall delete_fluid_settings , Ptr <fluid_settings_t> -> IO ()
#ccall fluid_settings_setstr , Ptr <fluid_settings_t> -> CString -> CString -> IO CInt
#ccall fluid_settings_setint , Ptr <fluid_settings_t> -> CString -> CInt -> IO CInt
#ccall fluid_settings_setnum , Ptr <fluid_settings_t> -> CString -> CDouble -> IO CInt

#ccall new_fluid_synth , Ptr <fluid_settings_t> -> IO (Ptr <fluid_synth_t>)
#ccall delete_fluid_synth , Ptr <fluid_synth_t> -> IO ()

#ccall new_fluid_audio_driver , Ptr <fluid_settings_t> -> Ptr <fluid_synth_t> -> IO (Ptr <fluid_audio_driver_t>)
#ccall delete_fluid_audio_driver, Ptr <fluid_audio_driver_t> -> IO ()

-- * SoundFont loading
#ccall fluid_synth_sfload , Ptr <fluid_synth_t> -> CString -> CInt -> IO CInt
#ccall fluid_synth_sfreload , Ptr <fluid_synth_t> -> CUInt -> IO CInt
#ccall fluid_synth_sfunload , Ptr <fluid_synth_t> -> CInt -> CUInt -> IO CInt

-- * Playing notes
#ccall fluid_synth_noteon , Ptr <fluid_synth_t> -> CInt -> CInt -> CInt -> IO CInt
#ccall fluid_synth_noteoff , Ptr <fluid_synth_t> -> CInt -> CInt -> IO CInt
#ccall fluid_synth_pitch_bend , Ptr <fluid_synth_t> -> CInt -> CInt -> IO CInt

-- * Logging
#num FLUID_PANIC
#num FLUID_ERR
#num FLUID_WARN
#num FLUID_DBG
type FluidLogFn = CInt -> CString -> Ptr () -> IO ()
#ccall fluid_set_log_function , CInt -> Ptr FluidLogFn -> Ptr () -> IO (Ptr FluidLogFn)
#ccall fluid_default_log_function , FluidLogFn

-- * Error codes
#num FLUID_FAILED
#num FLUID_OK
