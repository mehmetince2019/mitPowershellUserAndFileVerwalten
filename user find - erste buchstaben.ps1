

# Kullanıcıdan ilk harfi veya harfleri al
$prefix = Read-Host "İlk harfi veya harfleri girin"

# Yerel kullanıcıları al
$users = Get-LocalUser

# Girdiyle başlayan kullanıcıları filtrele
$filteredUsers = $users | Where-Object { $_.Name -like "$prefix*" }

# Kullanıcıları listele
if ($filteredUsers.Count -gt 0) {
    Write-Host "İlgili kullanıcılar:" -ForegroundColor Cyan
    foreach ($user in $filteredUsers) {
        # Kullanıcı adını ve tam adını al
        $username = $user.Name
        $fullName = $user.FullName
        
        # Ekrana yazdır (kullanıcı adı ve tam adı aynı satırda gösterir, kırmızı renkte)
        Write-Host "$username`t$fullName" -ForegroundColor Red
    }
} else {
    Write-Host "Belirtilen harfle başlayan kullanıcı bulunamadı." -ForegroundColor Yellow
}
