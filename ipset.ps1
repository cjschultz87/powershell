$interface = $(read-host -prompt "interface").tolower()

$iota = $(netsh interface ipv4 show interfaces).tolower()

$index = 3

while ($index -lt $iota.length)
{	
	$sierra = $iota[$index];
	
	if ($sierra.indexof("$interface") -ge 0)
	{
		break;
	}
	
	$index += 1;
}

if ($index -eq $iota.length)
{
	echo "couldn't find interface";
	
	exit;
}

$interfaceIndex = $iota[$index].tostring()

$index = $interfaceIndex.substring(1,$interfaceIndex.length - 1).indexof(" ")

$interfaceIndex = $interfaceIndex.substring(1,$index)

$gatewayAlpha = @(10,0,0,1)

$maskAlpha = @(255,255,255,0)

$ipAlpha = @(0,0,0,0)

$index = 0

while ($index -lt $ipAlpha.length)
{
	$iota = $(get-random -minimum 2 -maximum 254);
	
	$ipAlpha[$index] = ($maskAlpha[$index] -bxor 255) -band $iota;
	
	$ipAlpha[$index] = $ipAlpha[$index] -bxor $gatewayAlpha[$index];
	
	$index += 1;
}

$gateway = $gatewayAlpha[0].tostring() + "." + $gatewayAlpha[1].tostring() + "." + $gatewayAlpha[2].tostring() + "." + $gatewayAlpha[3].toString()

$sierra = $ipAlpha[0].tostring() + "." + $ipAlpha[1].tostring() + "." + $ipAlpha[2].tostring() + "." + $ipAlpha[3].tostring()

echo "setting ipv4 $sierra"

$prefix = 0

$index = 0

while ($index -lt $maskAlpha.length)
{
	$prefix += [convert]::tostring($maskAlpha[$index],2).length;
	
	$index += 1;
}

$prefix -= 1

new-netipaddress -interfaceindex $interfaceIndex -ipaddress $sierra

ipconfig