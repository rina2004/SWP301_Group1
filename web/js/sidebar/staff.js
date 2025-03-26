document.addEventListener('DOMContentLoaded', function() {
    // Lấy tất cả các mục chính
    const mainItems = document.querySelectorAll('.staff-sidebar-container > ul > li');
    let activeSubMenu = null;
    
    // Thêm các event listener cho mỗi mục chính
    mainItems.forEach(function(item) {
        // Chỉ xử lý các mục có submenu
        const subMenu = item.querySelector('ul');
        if (!subMenu) return;
        
        // Lấy liên kết của mục chính
        const mainLink = item.querySelector('a');
        
        // Khi hover vào mục chính
        item.addEventListener('mouseenter', function() {
            // Ẩn tất cả các submenu trước đó
            if (activeSubMenu && activeSubMenu !== subMenu) {
                activeSubMenu.style.display = 'none';
            }
            
            // Hiển thị submenu của mục này
            subMenu.style.display = 'block';
            activeSubMenu = subMenu;
        });
        
        // Khi rời khỏi mục chính
        item.addEventListener('mouseleave', function(event) {
            // Kiểm tra xem có phải đang hover vào submenu không
            if (!subMenu.contains(event.relatedTarget)) {
                subMenu.style.display = 'none';
            }
        });
        
        // Khi hover vào submenu
        if (subMenu) {
            subMenu.addEventListener('mouseenter', function() {
                // Giữ submenu hiển thị
                subMenu.style.display = 'block';
            });
            
            // Khi rời khỏi submenu
            subMenu.addEventListener('mouseleave', function() {
                subMenu.style.display = 'none';
            });
        }
    });
});