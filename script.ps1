param (
    [string]$Path = "."
)

$dirs = Get-ChildItem -Path $Path -Directory

$dirSizes = $dirs | ForEach-Object {
    $size = (Get-ChildItem -Path $_.FullName -Recurse -File | Measure-Object -Property Length -Sum).Sum
    [PSCustomObject]@{
        Directory = $_.FullName
        SizeKB    = [math]::Round($size / 1KB, 2) 
    }
}

$dirSizes | Sort-Object -Property SizeKB -Descending | Format-Table -AutoSize