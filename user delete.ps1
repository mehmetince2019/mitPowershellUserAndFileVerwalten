



# Silinecek kullanıcıyı al
$username = Read-Host "Silinecek kullanıcının adını girin"

# Kullanıcının var olup olmadığını kontrol et
$user = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
if (-not $user) {
    Write-Host "Kullanıcı bulunamadı: $username" -ForegroundColor Yellow
    exit
}

# Kullanıcıyı gruplardan çıkar
$groups = Get-LocalGroup | Where-Object { 
    (Get-LocalGroupMember -Group $_.Name -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq $username })
}

if ($groups.Count -gt 0) {
    foreach ($group in $groups) {
        Remove-LocalGroupMember -Group $group.Name -Member $username
        Write-Host "$username kullanıcısı $group grubundan çıkarıldı." -ForegroundColor Green
    }
} else {
    Write-Host "$username kullanıcısı hiçbir grupta değil." -ForegroundColor Yellow
}

# Kullanıcıyı tamamen sil
Remove-LocalUser -Name $username

# Kullanıcı silindi mesajı kırmızı renkte
Write-Host "Kullanıcı başarıyla silindi: $username" -ForegroundColor Red

# Özet
Write-Host ""
Write-Host "----- Kullanıcı Temizliği Tamamlandı -----" -ForegroundColor Cyan
Write-Host "silinen Kullanıcı adı: $username" -ForegroundColor Cyan
if ($groups.Count -gt 0) {
    Write-Host "Kaldırıldığı gruplar: $($groups.Name -join ', ')" -ForegroundColor Cyan
} else {
    Write-Host "Kullanıcı hiçbir grupta değildi." -ForegroundColor Cyan
}
Write-Host "----------------------------------------" -ForegroundColor Cyan
