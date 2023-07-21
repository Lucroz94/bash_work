# installing libguestfs-tools only required once, prior to first run
apt update -y
apt install libguestfs-tools -y

# remove existing image in case last execution did not complete successfully
rm debian-12-genericcloud-amd64.qcow2
wget https://cdimage.debian.org/cdimage/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2
virt-customize -a debian-12-genericcloud-amd64.qcow2 --install qemu-guest-agent
qm create YOUR_VM_ID --name "YOUR_VM_TEMPLATE_NAME" --memory 1024 --cores 1 --net0 virtio,bridge=vmbr0
qm importdisk YOUR_VM_ID debian-12-genericcloud-amd64.qcow2 YOUR_LVM_STORAGE
qm set YOUR_VM_ID --scsihw virtio-scsi-pci --scsi0 YOUR_LVM_STORAGE:vm-YOUR_VM_ID-disk-0
qm set YOUR_VM_ID --boot c --bootdisk scsi0
qm set YOUR_VM_ID --ide2 YOUR_LVM_STORAGE:cloudinit
qm set YOUR_VM_ID --serial0 socket --vga serial0
qm set YOUR_VM_ID --agent enabled=1
qm template YOUR_VM_ID
rm debian-12-genericcloud-amd64.qcow2
echo "next up, clone VM, then expand the disk"
echo "you also still need to copy ssh keys to the newly cloned VM"