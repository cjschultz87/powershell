$sierra = $(read-host -prompt "exe array")

$sAlpha = @()

$sL = $sierra.length

$index = 0

while ($index -lt $sierra.length)
{
	$index_prime = $sierra.substring($index,$sL - $index).indexof(",");
	
	if ($index_prime -lt 0)
	{
		$index_prime = $sierra.length - $index;
	}
	
	$sAlpha += $sierra.substring($index,$index_prime);
	
	$index += $index_prime + 1;
}

$alpha = $(netstat -nbao)

for ($i = 4; $i -lt $alpha.length;$i += 1)
{	
	$bravo = $false;
	
	$sierra = $alpha[$i].tostring();
	
	if ($sierra.length -gt 5)
	{
		foreach ($sA in $sAlpha)
		{
			if ($sierra -like $sA)
			{
				$bravo = $true
			
				break;
			}
		}
	
		if ($bravo -eq $true -and !($sierra.substring(2,3) -like "*UDP*" -or $sierra.substring(2,3) -like "*TCP*"))
		{
			$i_prime = $i - 1;
		
			$sierra_prime = $alpha[$i_prime]; 
		
			while ($sierra_prime.length -gt 5 -and ($sierra_prime.substring(2,3) -like "*TCP*" -or $sierra_prime.substring(2,3) -like "*UDP*"))
			{
				echo $sierra_prime;
			
				$i_prime -= 1;
			
				$sierra_prime = $alpha[$i_prime]
			}
			
			echo $sierra;
		}
	}
}