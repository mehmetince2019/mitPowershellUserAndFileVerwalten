

# İzinlerini görmek istediğiniz klasör

# Kullanıcıdan klasör yolunu al

#  tahmini yol . student yerine baska bir sey yazmak gerekebilir 

# C:\Users\Student\OneDrive1\Buchhaltung

$folderPath = Read-Host "İzinlerini görmek istediğiniz klasörün yolunu girin"

# Klasör var mı kontrol et
if (Test-Path $folderPath) {
    # Klasörün erişim kontrol listesini al
    $acl = Get-Acl -Path $folderPath
    
    # İzinlerin detaylarını yazdır
    Write-Host "Klasör: $folderPath izinleri" -ForegroundColor Cyan
    Write-Host "-------------------------------------"
    
    foreach ($access in $acl.Access) {
        # IdentityReference = Grup/Kullanıcı adı
        # FileSystemRights = Hangi haklar (okuma, yazma, değiştirme vb.)
        # AccessControlType = İzin tipi (Allow veya Deny)
        Write-Host "Grup/Kullanıcı: $($access.IdentityReference)"
        Write-Host "Yetkiler: $($access.FileSystemRights)"
        Write-Host "İzin Tipi: $($access.AccessControlType)"
        Write-Host "-------------------------------------"
    }
} else {
    Write-Host "Belirtilen yol geçerli bir klasör değil: $folderPath" -ForegroundColor Red
}
