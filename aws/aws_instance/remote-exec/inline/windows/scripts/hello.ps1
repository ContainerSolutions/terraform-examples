$hello = "Hello " + $env:COMPUTERNAME
Write-Host $hello

Set-Content "hello.txt" $hello -Force