if (Get-Process notepad -ErrorAction SilentlyContinue) {
	Stop-Process -Name "notepad"
}
$output_File = "C:\Users\User\Temp\Project_02\output_file.txt"
Add-Content -Path $output_File -Value "Hello World"
notepad $output_File