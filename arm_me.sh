#arm - flexnet utilites
export PATH=/usr/local/FlexNet/BX002-PT-00007-r11p17-02rel0:$PATH;

arm_licence()
{
cat << 'EOF'
lmutil lmdown -c $HOME/arm_licences/license_fvp.dat
nohup lmgrd -c $HOME/arm_licences/license_fvp.dat -l $HOME/arm_licences/license_fvp.dat.log &
tail -f $HOME/arm_licences/license_fvp.dat.log

lsof -i -P -n | grep LISTEN
EOF
}

arm_models()
{
#ls $HOME/arm_licences/FVP_ARM_Std_Library/FVP_Base/FVP_Base*
cat << 'EOF'
fvp=$HOME/arm_licences/FVP_ARM_Std_Library
test -d $fvp || { echo "no fvp lib, install it"; exit; }
#export MODEL=/$HOME/Downloads/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3/FVP_Base_RevC-2xAEMvA
export MODEL=$fvp/FVP_Base/FVP_Base_Cortex-A53x4

WORKSPACE=$HOME/fvp
SCRIPTS=$HOME/repos/landing-teams-working-arm-model-scripts
export IMAGE=${WORKSPACE}/build-poky/tmp-poky/deploy/images/fvp-base/Image
export BL1=${WORKSPACE}/build-poky/tmp-poky/deploy/images/fvp-base/bl1-fvp.bin
export FIP=${WORKSPACE}/build-poky/tmp-poky/deploy/images/fvp-base/fip-fvp.bin
export DISK=${WORKSPACE}/build-poky/tmp-poky/deploy/images/fvp-base/core-image-minimal-fvp-base.disk.img
export DTB=${WORKSPACE}/build-poky/tmp-poky/deploy/images/fvp-base/fvp-base-gicv3-psci-custom.dtb
cd $SCRIPTS/fvp; ./run_model.sh
EOF
}
