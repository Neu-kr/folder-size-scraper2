# Folder Size Scraper
** 指定したpathのサブディレクトリのサイズを降順に並び替えて出力します。

### 代入する方
```bash
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
```

### あとから入力する方
```bash
$Path = Read-Host "データ量を調べるフォルダのパスを入力してください"

if (Test-Path $Path -PathType Container) {
    $dirs = Get-ChildItem -Path $Path -Directory

    $dirSizes = $dirs | ForEach-Object {
        $size = (Get-ChildItem -Path $_.FullName -Recurse -File | Measure-Object -Property Length -Sum).Sum
        [PSCustomObject]@{
            Directory = $_.FullName
            SizeKB    = [math]::Round($size / 1KB, 2)
        }
    }

    $dirSizes | Sort-Object -Property SizeKB -Descending | Format-Table -AutoSize
} else {
    Write-Host "指定されたパスが存在しません。" -ForegroundColor Red
}
```