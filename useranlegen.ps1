# Kullanıcı bilgilerini al
$firstName = Read-Host "Adı"
$lastName = Read-Host "Soyadı"
$username = ($firstName.Substring(0, 1) + $lastName).ToLower()

# Grup seçimi için menü
Write-Host "Grubu seçin: "
Write-Host "1. Verwaltung"
Write-Host "2. Buchhaltung"
$groupChoice = Read-Host "Seçiminiz (1 ya da 2)"

# Grup seçimini kontrol et
$group = ""
if ($groupChoice -eq "1") {
    $group = "Verwaltung"
} elseif ($groupChoice -eq "2") {
    $group = "Buchhaltung"
} else {
    Write-Host "Geçersiz seçim! Script durduruluyor."
    exit
}

# Kullanıcı oluşturma işlemi
if (-not (Get-LocalUser -Name $username -ErrorAction SilentlyContinue)) {
    $password = ConvertTo-SecureString "P@ssw0rd123" -AsPlainText -Force
    New-LocalUser -Name $username -FullName "$firstName $lastName" -Password $password -Description "$group Grubu Üyesi"
    Write-Host "Kullanıcı başarıyla oluşturuldu: $firstName $lastName ($username)"
} else {
    Write-Host "Kullanıcı zaten mevcut: $username"
}

# Grubu oluştur veya mevcutsa ekle
if (-not (Get-LocalGroup -Name $group -ErrorAction SilentlyContinue)) {
    New-LocalGroup -Name $group -Description "$group Grubu"
    Write-Host "Grup oluşturuldu: $group"
} else {
    Write-Host "Grup zaten mevcut: $group"
}

# Kullanıcıyı gruba ekle
Add-LocalGroupMember -Group $group -Member $username
Write-Host "$username kullanıcısı $group grubuna eklendi."

# Özet bilgilerini ekrana yazdır
Write-Host ""
Write-Host "----- Kullanıcı Bilgileri -----"
Write-Host "Adı: $firstName"
Write-Host "Soyadı: $lastName"
Write-Host "Kullanıcı Adı: $username"
Write-Host "Grup: $group"
Write-Host "-------------------------------"
