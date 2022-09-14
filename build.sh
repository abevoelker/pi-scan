#!/bin/bash
# Usage: build.sh --input mouse|touch --arch arm32|arm64

script_path=$(realpath "$0")
dir_path=$(dirname "$script_path")
build_path="$dir_path/build-image"
pi_gen_path="$build_path/pi-gen"

# https://stackoverflow.com/a/14203146
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    -i|--input)
      INPUT="$2"
      shift # past argument
      shift # past value
      ;;
    -a|--arch)
      ARCH="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

# default values
INPUT="${INPUT:-mouse}"
ARCH="${ARCH:-arm32}"

# Clone Pi-Gen
if sudo mount | grep -q "$pi_gen_path"
then
  printf "Error clearing previous pi-gen install. You have to manually unmount everything under $pi_gen_path first:\n\n";
  sudo mount | grep -h "$pi_gen_path"
  exit 4
fi
sudo rm -rf "$pi_gen_path"
if [ "$ARCH" == "arm32" ]; then
  git clone --depth 1 https://github.com/RPI-Distro/pi-gen.git "$pi_gen_path"
elif [ "$ARCH" == "arm64" ]; then
  git clone --depth 1 --branch arm64 https://github.com/RPI-Distro/pi-gen.git "$pi_gen_path"
else
  echo "Error: -a/--arch option must be either 'arm32' or 'arm64'"
  exit 1
fi

# Apply our changes
cp -a "$build_path/stage-piscan" "$pi_gen_path/"
cp -a "$build_path/config" "$pi_gen_path/"
echo "BUILD_INPUT='${INPUT}'" >> "$pi_gen_path/config"
echo "BUILD_ARCH='${ARCH}'" >> "$pi_gen_path/config"
touch "$pi_gen_path/stage2/SKIP_IMAGES"

if [ "$INPUT" == "mouse" ]; then
  cp -a "$dir_path/config/mouse.ini" "$pi_gen_path/stage-piscan/04-install-setup/files/config.ini"
elif [ "$INPUT" == "touch" ]; then
  cp -a "$dir_path/config/touch.ini" "$pi_gen_path/stage-piscan/04-install-setup/files/config.ini"
else
  echo "Error: -i/--input option must be either 'mouse' or 'touch'"
  exit 1
fi

# Perform build
cd "$pi_gen_path" || exit 3
if sudo "./build.sh"; then
    echo "Your built Pi Scan image is in $pi_gen_path/deploy"
else
    echo "There was an error building the Pi Scan image"
fi
