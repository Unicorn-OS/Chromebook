# Example: chromebook kukui
# from: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_kukui/readme.md

empty_Drive=sdZ
rom_dir=~/.uni/os/rom

rom_image="chromebook_kukui-aarch64-bookworm.img"
rom_url="https://github.com/hexdump0815/imagebuilder/releases/download/230218-01/${rom_image}.gz"

mkdir -p $rom_dir

cd $rom_dir
wget -c $rom_url

gunzip -k ${rom_image}.gz

dd if=$rom_image of=/dev/$empty_Drive
