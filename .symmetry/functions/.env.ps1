# Will return all the environment variables in KEY=VALUE format
function Get-EnvironmentVariables {
	return (Get-ChildItem "ENV:" | foreach { "WIN_$(Get-LinuxSafeValue -Value ($_.Name -replace '\(|\)','').ToUpper())=$(Convert-ToWSLPath -Path $_.Value)" })
}

# converts the C:\foo\bar path to the WSL counter part of /mnt/c/foo/bar
function Convert-ToWSLPath {
	param (
		[Parameter(Mandatory=$true)]
		$Path
	)
	return (Get-LinuxSafeValue -Value (($Path -split ';' | foreach {
		if ($_ -ne $null -and $_ -ne '' -and $_.Length -gt 0) {
			(( (Fix-Path -Path $_) -replace '(^[A-Za-z])\:(.*)', '/mnt/$1$2') -replace '\\','/')
		}
	} ) -join ':'));
}

function Fix-Path {
	param (
		[Parameter(Mandatory=$true)]
		$Path
	)
	if ( $Path -match '^[A-Z]\:' ) {
		return $Path.Substring(0,1).ToLower()+$Path.Substring(1);
	} else {
		return $Path
	}
}

# Ouputs a string of exports that can be evaluated
function Import-EnvironmentVariables {
	return (Get-EnvironmentVariables | foreach { "export $_;" }) | Out-String
}

# Just escapes special characters
function Get-LinuxSafeValue {
	param (
		[Parameter(Mandatory=$true)]
		$Value
	)
	process {
		return $Value -replace "(\s|'|`"|\$|\#|&|!|~|``|\*|\?|\(|\)|\|)",'\$1';
	}
}
