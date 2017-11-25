
# Read-ValidInput

![Read-ValidInput screenshot](https://i.imgur.com/9YXYHyJ.png)

```
.synopsis
    Offers the user options to select from and loops until they select a valid response.
    Simple E.g.: $Choice = Read-ValidInput -prompt "Continue?" -ValidInputs "y*","n*"
.description  
    Prompts the user for input, and runs each of your valid inputs against it. If any match, returns the user's input
    Options for retry limits, colours and wildcards
    E.g.
        proceed? (y/n): a
        Invalid input.
        proceed? (y/n): yes
        <passes back "yes">
.parameter Prompt
    The instruction to the user
    E.g. input: "proceed?"
.parameter ValidInputs
    An array of strings - the valid things a user can type.
    If you put wildcards (*) here they will be respected and used, but not shown to the user
    Is shown to the user
    E.g. input:  @(y*,n*)
    If getting this from a hashtable, or something with columns, only pass through a single column (using .ColumnName)
        E.g. $FolderContents = get-childitem
             Read-ValidInput -Prompt "Select the folder" -ValidInputs $FolderContents.Name
.parameter MaxRetries
    How many times the user will be reprompted. Inclusive of the last try but not the first
    -1 to retry forever
    E.g. input: 3
        results in an initial prompt, and then 3 prompts after that before exiting
.parameter ForegroundColor
    Same as write-host - text colour
    E.g. input: Cyan
.parameter BackgroundColor
    Same as write-host - text background colour
    E.g. input: Black
.parameter Commas
    Whether to separate the options shown to the user with commas (and spaces) instead of slashes
    Without this switch it's slashes
    E.g. input: just specify it, its a switch.
.parameter FormatWide
    For use with a large number of items.
    If specified, this shows the options in a more separate, wider neater list
.parameter CaseSensitive
    Whether to only match input with the right case as well
    Without this switch its case insensitive
    E.g. input: just specify it, its a switch   
.notes
    Author: Ben Renninson
    Email: ben@goldensyrupgames.com
    From: https://github.com/GSGBen/powershell
```    
