<#
.synopsis
  Exposes ssh from WSL by wrapping: bash -c "ssh $args"
.description
  Exposes ssh from WSL by wrapping: bash -c "ssh $args"
.parameter Param1EG
  Param1EG description
.notes
  Author: Ben Renninson
  Email: ben@goldensyrupgames.com
  From: https://github.com/GSGBen/powershell
  Tags: Windows Subsystem for Linux, Ubuntu
#>
function ssh
{
	bash -c "ssh $args"	
}
