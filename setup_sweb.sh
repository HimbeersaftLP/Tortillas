#!/bin/bash
[ "$#" -eq 3 ] || die "usage: setup_sweb.sh <tortillas_path> <sweb_path> <example>"

tortillas_path=$1
sweb_path=$2
example_dir="$tortillas_path/examples/$3"

# Patch sweb
git -C $sweb_path apply --ignore-whitespace $tortillas_path/examples/base/sweb_patches/*.diff

if ["$3" -ne "base"] && [ -d "$example_dir/sweb_patches" ]; then
    git -C $sweb_path apply --ignore-whitespace $example_dir/sweb_patches/*.diff
fi

# Copy tortillas_config.yml
if ["$3" -ne "base"] && [ -f "$example_dir/tortillas_config.yml"]; then
    cp "$example_dir/tortillas_config.yml" $sweb_path/
else
    cp "$tortillas_path/examples/base/tortillas_config.yml" $sweb_path/tortillas_config.yml
fi
