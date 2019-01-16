#!/sbin/sh
#====================================================
#       FILE: set_audio_effects.sh
#       AUTHOR: ImbaWind @ XDA
#       BASED ON: guitardedhero @ XDA's  Dolby Atmos update-binary & function
#       DESCRIPTION: Add Dolby Atmos processors to audio_effects.conf
#====================================================
v_audio_effects_conf=/system/vendor/etc/audio_effects.conf
audio_effects_conf=/system/etc/audio_effects.conf
if [ -e "$v_audio_effects_conf" ]; then
    conf=$v_audio_effects_conf
    dolby=$(grep "library dap" $v_audio_effects_conf)
else
    conf=$audio_effects_conf
    dolby=$(grep "library dap" $audio_effects_conf)
fi
pre_proc=$(grep "pre_processing {" $conf)
output_session_processing=$(grep "output_session_processing {" $conf)
if [ ! "$dolby" ]; then
    sed -i 's/^libraries {/libraries {\n# Dolby AudioEffect\n  dap {\n    path \/system\/lib\/soundfx\/libswdap.so\n  }/g' $conf
    sed -i 's/^effects {/effects {\n#Dolby AudioEffect\n  dap {\n    library dap\n    uuid 9d4921da-8225-4f29-aefa-39537a04bcaa\n  }/g' $conf
    echo "
pre_processing {
}
" >> $conf
    if [ ! "$output_session_processing" ]; then
    echo "
output_session_processing {
    music {
        sa3d {}
    }
    ring {
        sa3d {}
    }
    alarm {
        sa3d {}
    }
}
" >> $conf
    fi
else
    echo "Dolby already installed."
fi