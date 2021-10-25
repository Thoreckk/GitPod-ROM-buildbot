# Rom building script for CircleCI
# coded by bruh™ aka Live0verfl0w

MANIFEST_LINK=git://github.com/aex-tmp/manifest.git
BRANCH=12.x
ROM_NAME=aosp
DEVICE_CODENAME=X00TD
GITHUB_USER=Navin136
GITHUB_EMAIL=nkwhitehat@gmail.com
WORK_DIR=$(pwd)/${ROM_NAME}
JOBS=nproc

# Set up git!
git config --global user.name ${GITHUB_USER}
git config --global user.email ${GITHUB_EMAIL}

# make directories
mkdir ${WORK_DIR} && cd ${WORK_DIR}

# set up rom repo
repo init --depth=1 -u ${MANIFEST_LINK} -b ${BRANCH}
repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j${JOBS}

# clone device sources
rm -rf $ROM/device/asus/X00TD && git clone https://github.com/navin136/device_asus_X00TD -b twelve $ROM/device/asus/X00TD && rm -rf $ROM/device/asus/sdm660-common && git clone https://github.com/navin136/device_asus_sdm660-common -b twelve $ROM/device/asus/sdm660-common && rm -rf $ROM/vendor/asus && git clone https://github.com/navin136/vendor_asus -b twelve $ROM/vendor/asus --depth=1 && rm -rf $ROM/kernel/asus/sdm660 && git clone https://github.com/navin136/velocity -b twelve $ROM/kernel/asus/sdm660 --depth=1

# Start building!
. build/envsetup.sh
lunch aosp_${DEVICE_CODENAME}-eng
mka bacon -j${JOBS}

