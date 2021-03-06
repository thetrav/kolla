#!/bin/bash

# This script expects the following to be installed:
# curl, libguestfs-tools-c

IMAGE=Fedora-Cloud-Base-20141203-21.x86_64.qcow2
TARGET_DIR=/var/lib/libvirt/images
TARGET=fedora-21-x86_64

if ! [ -f "$IMAGE" ]; then
    echo "Downloading $IMAGE"
    curl -O http://archive.fedoraproject.org/pub/fedora/linux/releases/21/Cloud/Images/x86_64/$IMAGE
fi

echo "Copying $IMAGE to $TARGET"
cp "$IMAGE" $TARGET_DIR/$TARGET

PACKAGES="git,tcpdump"

virt-customize \
    --add $TARGET_DIR/$TARGET \
    --install $PACKAGES \
    --update \
    --install $PACKAGES \
    --run-command "yum clean all" \
    --run-command "cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOF
DEVICE=eth1
BOOTPROTO=none
ONBOOT=yes
DEFROUTE=no
EOF" \

# SELinux relabeling requires virt-customize to have networking disabled
# https://bugzilla.redhat.com/show_bug.cgi?id=1122907
virt-customize --add $TARGET_DIR/$TARGET --selinux-relabel --no-network

echo "Finished building image:"
ls -l $TARGET_DIR/$TARGET
