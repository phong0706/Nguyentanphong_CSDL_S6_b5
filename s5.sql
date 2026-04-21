-- 1. Bẫy dữ liệu logic (NOT IN vs NULL)
-- Tại sao NOT IN lại trả về 0 kết quả nếu có dù chỉ một dòng NULL?
-- Về mặt toán học, phép toán x NOT IN (a, b, c) tương đương với:
-- x != a AND x != b AND x != c
-- Nếu trong danh sách có một giá trị NULL (ví dụ c = NULL), biểu thức trở thành:
-- x != a AND x != b AND x != NULL
-- Trong SQL, mọi phép so sánh với NULL đều trả về kết quả là UNKNOWN (Không xác định), chứ không phải TRUE hay FALSE.
-- Theo bảng chân trị của logic AND:
-- TRUE AND UNKNOWN = UNKNOWN
-- FALSE AND UNKNOWN = FALSE
-- Vì mệnh đề WHERE chỉ giữ lại những hàng có kết quả là TRUE, mà kết quả của phép toán trên luôn là UNKNOWN hoặc FALSE, nên toàn bộ truy vấn sẽ không trả về bất kỳ kết quả nào. Đây chính là "thảm họa" logic khiến bạn bỏ sót toàn bộ danh sách phòng chết.

-- 2. Thiết kế giải pháp an toàn
-- Để khắc phục, chúng ta có hai cách phổ biến:
-- Cách 1 (Sửa Subquery): Thêm điều kiện WHERE room_id IS NOT NULL vào câu lệnh lấy danh sách từ bảng Bookings.
-- Cách 2 (LEFT JOIN): Đây là cách tối ưu và trực quan nhất. Chúng ta nối bảng Rooms với Bookings. Những phòng nào không có đơn đặt sẽ có các cột của bảng Bookings mang giá trị NULL.

SELECT 
    r.room_id, 
    r.room_name
FROM 
    Rooms r
LEFT JOIN 
    Bookings b ON r.room_id = b.room_id
WHERE 
    b.room_id IS NULL;