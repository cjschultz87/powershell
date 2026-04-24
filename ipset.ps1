$interface = $(read-host -prompt "interface").tolower()

$gateway = $(read-host -prompt "gateway")

$mask = $(read-host -prompt "mask")

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

$gatewayAlpha = @(0,0,0,0)

$index = 0

while ($index -lt $gatewayAlpha.length)
{
	$stringIndex = $gateway.indexof(".");
	
	if ($stringIndex -ge 0)
	{
		$gatewayAlpha[$index] = [int]$gateway.substring(0,$stringIndex);
		
		$stringIndex += 1;
	}
	else
	{
		$gatewayAlpha[$index] = [int]$gateway.substring(0,$gateway.length);
		
		$stringIndex = 0;
	}
	
	$gateway = $gateway.substring($stringIndex,$gateway.length - $stringIndex);
	
	$index += 1;
}


$maskAlpha = @(0,0,0,0)

$index = 0

while ($index -lt $maskAlpha.length)
{
	$stringIndex = $mask.indexof(".");
	
	if ($stringIndex -ge 0)
	{
		$maskAlpha[$index] = [int]$mask.substring(0,$stringIndex);
		
		$stringIndex += 1;
	}
	else
	{
		$maskAlpha[$index] = [int]$mask.substring(0,$mask.length);
		
		$stringIndex = 0;
	}
	
	$mask = $mask.substring($stringIndex,$mask.length - $stringIndex);
	
	$index += 1;
}

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

set-netipaddress -interfaceindex $interfaceIndex -prefixlength $prefix

ipconfig
