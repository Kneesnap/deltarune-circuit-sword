# This should be saved as /home/pi/RetroPie-Setup/scriptmodules/ports/deltarune.sh
#!/usr/bin/env bash

rp_module_id="deltarune"
rp_module_desc="Deltarune by Toby Fox, ported by Kneesnap"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_deltarune() {
    getDepends libopenal-dev
}

function install_bin_deltarune() {
    wget -O- -q https://github.com/Kneesnap/deltarune-circuit-sword/releases/download/latest/deltarune.tar.gz | tar -xvz -C "$md_inst"
}

function configure_deltarune() {
    mkRomDir "ports"
    addPort "$md_id" "Deltarune" "Deltarune" "$md_inst/Deltarune"
}