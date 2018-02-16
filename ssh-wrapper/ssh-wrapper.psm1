<#
.synopsis
  Exposes ssh from WSL by wrapping: bash -c "ssh $args". Requires Windows Subsystem for Linux on Windows 10.
.description
  - Exposes ssh from WSL by wrapping: bash -c "ssh $args". Requires Windows Subsystem for Linux on Windows 10.
  - Supports all arguments supported by the wrapped ssh.
.example
  ssh admin@192.168.1.1
.notes
  - Author: Ben Renninson
  - Email: ben@goldensyrupgames.com
  - From: https://github.com/GSGBen/powershell
  - Tags: Windows Subsystem for Linux, Ubuntu
#>
function ssh
{
	bash -c "ssh $args"	
}
