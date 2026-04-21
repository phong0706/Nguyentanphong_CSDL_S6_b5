-- 1. Giải pháp kiến trúc: Từ khóa CASE WHEN
-- Để thực hiện logic rẽ nhánh ngay trong câu lệnh SELECT và tạo ra một "cột ảo" (virtual column), chúng ta sử dụng cấu trúc CASE WHEN ... THEN ... ELSE ... END.
-- Nó hoạt động giống như cấu trúc if-else hoặc switch-case trong các ngôn ngữ lập trình (như JavaScript mà bạn đang học). Nó cho phép kiểm tra từng dòng dữ liệu, nếu thỏa mãn điều kiện thì trả về nhãn tương ứng
-- 2. Xử lý ngoại lệ: Bẫy dữ liệu NULL
-- Giá trị NULL trong SQL không phải là số 0, nó đại diện cho "không có dữ liệu". Nếu bạn so sánh NULL > 500, kết quả sẽ là Unknown chứ không phải False.

-- Cách xử lý an toàn nhất:

-- Phương án 1 (Dùng hàm): Sử dụng COALESCE(total_orders, 0). Hàm này sẽ lấy giá trị đầu tiên không null. Nếu total_orders bị null, nó sẽ tự coi là 0.
-- Phương án 2 (Logic ưu tiên): Đưa điều kiện IS NULL lên đầu tiên hoặc để nó rơi vào trường hợp ELSE cuối cùng để gán nhãn 'Bạc'

SELECT 
    user_name AS Ten_Khach_Hang,
    CASE 
        WHEN total_orders > 500 THEN 'Kim Cương'
        WHEN total_orders >= 100 THEN 'Vàng'
        WHEN total_orders < 100 OR total_orders IS NULL THEN 'Bạc'
        ELSE 'Bạc' -- Phòng hờ các trường hợp đặc biệt khác
    END AS Xep_Hang
FROM 
    Users;