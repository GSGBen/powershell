<#
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
#>
function Read-ValidInput
{
    Param
    (
        [Parameter(Mandatory=$true)][string]$Prompt,
        [Parameter(Mandatory=$true)][string[]]$ValidInputs,
        [Parameter(Mandatory=$false)][int]$MaxRetries = -1,
        [Parameter(Mandatory=$false)][ConsoleColor]$ForegroundColor,
        [Parameter(Mandatory=$false)][ConsoleColor]$BackgroundColor,
        [Parameter(Mandatory=$false)][switch]$Commas,
        [Parameter(Mandatory=$false)][switch]$FormatWide,
        [Parameter(Mandatory=$false)][switch]$CaseSensitive
    )

    #No errors in this are worth continuing past
    $ErrorActionPreference = "Stop"

    #Prep the colour parameters. We'll only pass them if they've been set
    $ColorParameters = @{}
    if ($ForegroundColor) {$ColorParameters.add("ForegroundColor",$ForegroundColor)}
    if ($BackgroundColor) {$ColorParameters.add("BackgroundColor",$BackgroundColor)}

    #Prepare the options to show to the user. Hide * wildcards
    if ($Commas) {$JoinWith = ", "} else {$JoinWith = "/"}
    $OptionsString = $ValidInputs -join $JoinWith
    $OptionsString = $OptionsString.Replace("*","")

    #Start prompting after getting some variables ready to check
    $FoundMatch = $false
    $RetryCount = 0
    #do/while runs at least once and checks at the end
    do
    {
        #Notify if they've incorrectly entered and we're retrying
        if ($RetryCount -gt 0)
        {
            write-host #formatting. Separate retries

            write-host "Invalid input. " -NoNewline @ColorParameters
            
            #Different selection nudge based on formatting type
            if ($FormatWide)
            {
                write-host "Enter a valid option from the list." @ColorParameters
            }
            else
            {
                write-host "Enter a valid option from within the brackets." @ColorParameters
            }          
        }

        #The actual prompt
        if ($FormatWide) #wide formatting of options
        {
            #Prompt at the top to explain
            write-host "${Prompt}" -NoNewline @ColorParameters

            #Show the options. The last two pipes are for the colors
            $ValidInputs | format-wide {$_} -AutoSize -Force | out-string | write-host -NoNewline @ColorParameters

            #If it exists, mention the instruction underneath (where they'll be looking) again as well
            if ($RetryCount -gt 0)
            {
                write-host "Invalid input. Enter a valid option from the list." @ColorParameters
            }

            #Duplicate to where they'll be looking
            write-host "${Prompt}:" -NoNewline @ColorParameters
            
        }
        else
        {
            #${VariableName} instead of $VariableName is magic and explicity states the end of the variable name so you can type right after it
            write-host "${Prompt} (${OptionsString}):" -NoNewline @ColorParameters

        }
        
        #Get the input
        $Input = Read-Host

        #Check each validinput against the input for a match
        foreach ($Entry in $ValidInputs)
        {
            if ($CaseSensitive) #match, case sensitive
            {
                if ($Input -clike $Entry)
                {
                    #Found a match, stop checking
                    $FoundMatch = $true
                    break
                }
            }
            else #match, case insensitive
            {
                if ($Input -like $Entry)
                {
                    #Found a match, stop checking
                    $FoundMatch = $true
                    break
                }
            } 
        }
    }
    #Only reprompt if we haven't found a match, and if the next run will be within the retry count
    #++ before the variable increments the $RetryCount count here within the check, before using it
    #Finally, don't worry about the count if it's -1 (loop forever)
    while
    (
        (!$FoundMatch) -and 
        (
            (++$RetryCount -le $MaxRetries) -or
            ($MaxRetries -eq -1)
        )    
    )

    #Finally return the input if we found a match at all
    if ($FoundMatch) {$Input}

}
