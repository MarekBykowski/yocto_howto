bb_show()
{
cat << 'EOF'
# source env. for fvp
export DISTRO="poky"
export MACHINE="fvp-base"
source setup-environment

# source and build for corstone-100
# note, it uses kas
kas shell meta-arm/kas/corstone1000-fvp.yml
bitbake corstone1000-image
# to run model built
cd ./run-scripts/corstone1000
run_model.sh /home/bykowmar/FVP_Corstone_1000/models/Linux64_GCC-9.3/FVP_Corstone-1000 -D ""


# show all recipes
bitbake-layers show-recipes

# find patterned recipe
bitbake-layers show-recipes "*-image-*"
bitbake-layers show-recipes "*u-boot*"
	# Output:
	# Summary: There was 1 WARNING message shown.
	# === Matching recipes: ===
	# u-boot:
	#   meta                 1:2020.01
	# u-boot-tools:
	#   meta                 1:2020.01

# find recipe's file (bb and bbappend)
find -name "*u-boot*.bb*"

# list all the tasks of u-boot recipe
bitbake linux-yocto -c listtasks
bitbake u-boot -c listtasks

# fetch and unpack the sources (if such tasks are there)
bitbake u-boot -c do_fetch -c do_unpack

# find work dir, the sources should be there in git dir
bitbake -e u-boot|grep -w ^WORKDIR

# grep for any given variable, eg. SRC_URI
bitbake -e linux-yocto|grep ^SRC_URI
EOF
}
echo "bb_show()"

corstone_show()
{
cat << 'EOF'
cor # alias cor='cd /home/bykowmar/yocto/corstone'
# source and build for corstone-100
# note, it uses kas
kas shell meta-arm/kas/corstone1000-fvp.yml
bitbake corstone1000-image
# to run model built
cd ./run-scripts/corstone1000
run_model.sh /home/bykowmar/FVP_Corstone_1000/models/Linux64_GCC-9.3/FVP_Corstone-1000 -D ""
EOF
}
echo "corstone_show()"

bb_append()
{
cat << 'EOF'
You can append values to existing variables using the _append method. Note that this operator does not add any additional space, and it is applied after all the +=, and =+ operators have been applied.

The following example show the space being explicitly added to the start to ensure the appended value is not merged with the existing value:
SRC_URI_append = " file://fix-makefile.patch;patch=1"

The _append method can also be used with overrides, which result in the actions only being performed for the specified target or machine: [TODO: Link to section on overrides]
SRC_URI_append_sh4 = " file://fix-makefile.patch;patch=1"

Note that the appended information is a variable itself, and therefore it's possible to used += or =+ to assign variables to the _append information:
SRC_URI_append = " file://fix-makefile.patch;patch=1"
SRC_URI_append += "file://fix-install.patch;patch=1"
EOF
}
echo "bb_append()"

bb_uboot()
{
cat << 'EOF'
bitbake -c clean u-boot
alias im="cd /home/bykowmar/yocto/fvp/build-poky/tmp-poky/deploy/images/fvp-base"
im
ll -rt
alias yo="cd /home/bykowmar/yocto/fvp"
yo; cd build-poky/
bitbake -c devshell u-boot # change bootdelay from defconfig

# no auto, exit devshell

bitbake -c listtasks u-boot
bitbake -C do_configure u-boot # generate .config and run all the subsequent tasks
im; ll -rt
vim u-boot-initial-env
bitbake -c clean trusted-firmware-a
bitbake trusted-firmware-a
EOF
}
echo "bb_uboot()"

yocto_sdk()
{
cat << 'EOF'
ll meta*/recipes*/images/*.bb
source oe-init-build-env
bitbake core-image-kernel-dev -c populate_sdk
bitbake core-image-kernel-dev -c populate_sdk_ext
export DEPLOY_DIR_IMAGE="/home/xxbykowm/containers/poky/build/tmp/deploy/images/qemux86-64"
EOF
}
echo "yocto_sdk()"

yocto_images()
{
cat << 'EOF'
ll ./poky/meta/recipes*/image*/*bb
bitbake -g <image> && \
cat pn-buildlist| grep -v -e '-native' | grep -v digraph | grep -v -e '-image' | awk '{print $1}' | sort | uniq
EOF
}
echo yocto_images()

alias bb="bitbake"
