function GetExeOutput ($exeOutput)
{
    $stderr = $exeOutput | ?{ $_ -is [System.Management.Automation.ErrorRecord] }
    $stdout = $exeOutput | ?{ $_ -isnot [System.Management.Automation.ErrorRecord] }

    If ($lastExitCode -eq "1" -Or ! [string]::IsNullOrWhiteSpace($stderr)) {
        Write-Host $stderr -ForegroundColor Red
        Read-Host -Prompt "`nPress any key to exit"
        Exit
    }

    return $stdout
}
