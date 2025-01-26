#!/bin/sh
rm -r ./build
mkdir -p build/mods build/config build/resourcepacks build/meteor-client
cp -r ./repos/additive/versions/fabric/1.21.4/mods/* ./build/mods/
cp -r ./repos/additive/versions/fabric/1.21.4/config/* ./build/config/
cp -r ./repos/additive/versions/fabric/1.21.4/resourcepacks/* ./build/resourcepacks/
cp -rf ./repos/simply_optimized/so\ 1.21.4\ building/mods/* ./build/mods/
cp -rf ./repos/simply_optimized/so\ 1.21.4\ building/config/* ./build/config/
symlinks=$(find -L ./mods -xtype l)
for symlink in $symlinks
do
ln --force --symbolic "$(readlink --canonicalize "$symlink")" "$symlink"
done
cp -rf ./mods/* ./build/mods/
for symlink in $symlinks
do
ln --force --symbolic "$(readlink --canonicalize ./build/"$symlink")" ./build/"$symlink"
done
cp -rf ./resourcepacks/* ./build/resourcepacks/
cp -rf ./config/* ./build/config/
cp -r ./meteor-client/* ./build/meteor-client/
cp ./pack.toml ./index.toml ./options.txt ./build/
cd ./build
packwiz refresh
packwiz modrinth export
