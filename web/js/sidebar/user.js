document.addEventListener('DOMContentLoaded', function() {
    // Lấy tất cả các mục lớn
    const mainItems = document.querySelectorAll('.main-item');
    let activeSubMenu = null;
    
    // Thêm các event listener cho mỗi mục lớn
    mainItems.forEach(function(item) {
        // Lấy submenu của mục này
        const subMenu = item.nextElementSibling;
        
        // Khi hover vào mục lớn
        item.addEventListener('mouseenter', function() {
            // Ẩn tất cả các submenu trước đó
            if (activeSubMenu && activeSubMenu !== subMenu) {
                activeSubMenu.style.display = 'none';
            }
            
            // Hiển thị submenu của mục này
            subMenu.style.display = 'block';
            activeSubMenu = subMenu;
        });
        
        // Khi rời khỏi mục lớn (nhưng không phải vào submenu)
        item.parentElement.addEventListener('mouseleave', function(event) {
            // Kiểm tra xem có phải đang hover vào submenu không
            if (!subMenu.contains(event.relatedTarget)) {
                subMenu.style.display = 'none';
            }
        });
        
        // Khi hover vào submenu
        subMenu.addEventListener('mouseenter', function() {
            // Giữ submenu hiển thị
            subMenu.style.display = 'block';
        });
        
        // Khi rời khỏi submenu
        subMenu.addEventListener('mouseleave', function() {
            subMenu.style.display = 'none';
        });
    });
});

// Hàm hiển thị nội dung khi click vào mục con
function showContent(contentId) {
    // Ẩn tất cả các panel
    const contentPanels = document.querySelectorAll('.content-panel');
    contentPanels.forEach(function(panel) {
        panel.classList.remove('active');
    });
    
    // Hiển thị panel được chọn
    document.getElementById(contentId).classList.add('active');
}