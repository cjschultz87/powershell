$sum = $(read-host -prompt "sum")

try
{
	$sum = [int]$sum;
}
catch
{
	echo "sum is not an integer.";
	
	exit;
}

$N = $(read-host -prompt "N")

try
{
	$N = [int]$N;
}
catch
{
	echo "N is not an integer.";
	
	exit;
}

$coreN = $(read-host -prompt "coreN")

try
{
	$coreN = [int]$coreN;
}
catch
{
	echo "coreN is not an integer.";
	
	exit;
}

$foxtrot = $(factor $([math]::abs($N)) $coreN)

$bravo = $false

foreach ($f in $foxtrot)
{
	$index = $f.indexof(",");
	
	$factor0 = [int]$f.substring(0,$index);
	
	$factor1 = [int]$f.substring($index + 2, $f.length - ($index + 2));
	
	if ($N -lt 0)
	{
		$factor0 *= -1;
	}
	
	if ($factor0 + $factor1 -eq $sum)
	{
		echo "$factor0, $factor1";
		
		$bravo = $true
	}
}

if ($bravo -eq $false)
{
	echo "no factors have that sum.";
}