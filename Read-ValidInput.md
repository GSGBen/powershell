
# Read-ValidInput

![Read-ValidInput screenshot](https://i.imgur.com/9YXYHyJ.png)

## SYNOPSIS
Offers the user options to select from and loops until they select a valid response.
Simple E.g.: $Choice = Read-ValidInput -prompt "Continue?" -ValidInputs "y*","n*"

## SYNTAX

```
Read-ValidInput [-Prompt] <String> [-ValidInputs] <String[]> [[-MaxRetries] <Int32>]
 [[-ForegroundColor] <ConsoleColor>] [[-BackgroundColor] <ConsoleColor>] [-Commas] [-FormatWide]
 [-CaseSensitive]
```

## DESCRIPTION
Prompts the user for input, and runs each of your valid inputs against it.
If any match, returns the user's input
Options for retry limits, colours and wildcards
E.g.
    proceed?
(y/n): a
    Invalid input.
    proceed?
(y/n): yes
    \<passes back "yes"\>

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Prompt
The instruction to the user
E.g.
input: "proceed?"

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValidInputs
An array of strings - the valid things a user can type.
If you put wildcards (*) here they will be respected and used, but not shown to the user
Is shown to the user
E.g.
input:  @(y*,n*)
If getting this from a hashtable, or something with columns, only pass through a single column (using .ColumnName)
    E.g.
$FolderContents = get-childitem
         Read-ValidInput -Prompt "Select the folder" -ValidInputs $FolderContents.Name

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxRetries
How many times the user will be reprompted.
Inclusive of the last try but not the first
-1 to retry forever
E.g.
input: 3
    results in an initial prompt, and then 3 prompts after that before exiting

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: -1
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForegroundColor
Same as write-host - text colour
E.g.
input: Cyan

```yaml
Type: ConsoleColor
Parameter Sets: (All)
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackgroundColor
Same as write-host - text background colour
E.g.
input: Black

```yaml
Type: ConsoleColor
Parameter Sets: (All)
Aliases: 
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Commas
Whether to separate the options shown to the user with commas (and spaces) instead of slashes
Without this switch it's slashes
E.g.
input: just specify it, its a switch.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatWide
For use with a large number of items.
If specified, this shows the options in a more separate, wider neater list

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CaseSensitive
Whether to only match input with the right case as well
Without this switch its case insensitive
E.g.
input: just specify it, its a switch

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES
Author: Ben Renninson
Email: ben@goldensyrupgames.com
From: https://github.com/GSGBen/powershell

## RELATED LINKS

