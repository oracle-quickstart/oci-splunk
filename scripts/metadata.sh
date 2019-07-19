
echo "Gathering metadata..."

# Config is assumed to be in this location in instance metadata
export CONFIG_LOCATION='.metadata.config'

public_ip=$(oci-public-ip -j | jq -r '.publicIp')
private_ip=$(hostname -I)

json=$(curl -sSL http://169.254.169.254/opc/v1/instance/)
shape=$(echo $json | jq -r .shape)

echo "$public_ip $private_ip $shape"

echo $json | jq $CONFIG_LOCATION

#diskCount used by disks.sh
diskCount=$(echo $json | jq -r $CONFIG_LOCATION.disk_count)
